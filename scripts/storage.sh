#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jq envsubst

isDigit() {
    if ! [[ $1 =~ ^[0-9]+$ ]]; then
        echo "Please enter a number."
        return 1
    else
        return 0
    fi
}

STORAGE_FILE="$HOME/.dotfiles/nix/modules/hardware/storage.nix"
DRIVERS=""

if [[ -f "$STORAGE_FILE" ]]; then
    echo "storage.nix exists"
else
    echo "storage.nix not found, generating..."
fi

declare -a DRIVES
count=0

while true; do
    if (("$count" > 0)); then
        echo "Mount another driver?"
    else
        echo "Mount driver?"
    fi
    echo "1) Yes"
    echo "2) No"
    echo -n "> "
    read -r MOUNT

    case "$MOUNT" in
    1) MOUNT="true" ;;
    2)
        MOUNT="false"
        break
        ;;
    *)
        echo "Invalid choice."
        continue
        ;;
    esac

    if [[ "$MOUNT" == "true" ]] && (("$count" < 1)); then
        DRIVE_LIST="$(lsblk -J -o NAME,SIZE,UUID,LABEL,TYPE,FSTYPE,MOUNTPOINT,PARTTYPENAME |
            jq -r '.blockdevices[] | if (.children // [] | length) > 0 then (.children[] | select(.mountpoint == null and .parttypename != "Microsoft reserved" and .parttypename != "EFI System" and .parttypename != "Windows recovery environment")) else select(.mountpoint == null and .parttypename != "Microsoft reserved" and .parttypename != "EFI System" and .parttypename != "Windows recovery environment") end | "\(.name)\t\(.uuid // "-")\t\(.label // "-")\t\(.size // "-")\t\(.type // "-")\t\(.fstype // "-")\t\(.parttypename)"')"

        while IFS= read -r line; do
            DRIVES+=("$line")
        done <<<"$DRIVE_LIST"

        if (("${#DRIVES[@]}" == 0)); then
            echo "No unmounted valid partitions found."
            exit 1
        fi
    fi

    {
        for key in "${!DRIVES[@]}"; do
            echo "$((key + 1))) ${DRIVES[$key]}"
        done
    } | column -t -s $'\t'

    while true; do
        echo -n "> "

        read -r SELECTED_DRIVE

        # SELECTED_DRIVE=$((SELECTED_DRIVE + 1))
        if ! isDigit "$SELECTED_DRIVE"; then
            continue
        fi

        if (($SELECTED_DRIVE < 1 || SELECTED_DRIVE > "${#DRIVES[@]}")); then
            echo "Invalid drive."
            continue
        fi

        break
    done

    read -r NAME UUID LABEL SIZE TYPE FSTYPE _ <<<"${DRIVES[$((SELECTED_DRIVE - 1))]}"

    DEVICE="$UUID"

    # PROMPT Mountpoint
    echo "Select Mountpoint? [relative to your home dir, e.g. work]"

    while true; do
        echo -n "> "
        read -r MOUNTPOINT

        if [[ -z "$MOUNTPOINT" ]]; then
            MOUNTPOINT="$HOME/$NAME"
        fi

        if grep -Fq "fileSystems.\"$MOUNTPOINT\"" "$STORAGE_FILE"; then
            echo "Mountpoint already exists."
            continue
        fi

        break
    done

    if [[ "$FSTYPE" == "ntfs" ]]; then
        FSTYPE="ntfs-3g"
        uid=$(id -u)
        OPTIONS="\"defaults\" \"nofail\" \"uid=$uid\" \"umask=022\""
    else
        OPTIONS='"defaults" "nofail"'
    fi

    export MOUNTPOINT DEVICE FSTYPE OPTIONS

    DRIVERS+=$(envsubst '$MOUNTPOINT, $DEVICE, $FSTYPE, $OPTIONS' <$HOME/.dotfiles/scripts/lib/driver.template)
    DRIVERS+=$'\n\n'

    # INSERT new mounts to existing storage.nix
    unset DRIVES[$((SELECTED_DRIVE - 1))]
    count=$((count + 1))
done

awk -v drivers="$DRIVERS" '
/# DO NOT REMOVE THIS LINE/ {
    printf "%s", drivers
}
{ print }
' "$STORAGE_FILE" >"$STORAGE_FILE.tmp" &&
    mv "$STORAGE_FILE.tmp" "$STORAGE_FILE"

echo "Drivers successfully mounted"
