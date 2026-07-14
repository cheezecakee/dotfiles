#!/usr/bin/env nix-shell
#!nix-shell -i bash -p envsubst

echo "Hello, welcome to Nix Setup"

# TODO insert boot storage selection, this goes in init.sh
# echo "Select boot drive [Warning this will erase all data in selected storage]"
# TODO pipe lsblk
# CREATE a root mount
# RUN nixos-enter --root /mnt/[mount]
while true; do
    # PROMPT DEFAULT
    echo "Set generic profile?"
    echo "1) Yes"
    echo "2) No"
    echo -n "> "
    read -r DEFAULT_MODE

    case "$DEFAULT_MODE" in
    1) GENERIC="true" ;;
    2) GENERIC="false" ;;
    esac

    if [[ "$DEFAULT_MODE" == 1 ]]; then
        HOSTNAME="host"
        USERNAME="host"
        MACHINE="notebook" #default to notebook, safer choice
        SECUREBOOT="false"
        GPU="none"
        POWERMODE="balanced"
        AUTOLOGIN=false
        MOUNT="false"
    else
        # PROMPT HOSTNAME
        echo "Hostname? [Default = Host]"
        echo -n "> "
        read -r HOSTNAME

        if [[ -z "${HOSTNAME}" ]]; then
            HOSTNAME="host"
        fi

        echo "Hostname set: "$HOSTNAME""

        # TODO move this to init.sh
        # PROMPT USERNAME
        # echo "Username [Default: Host]"
        # echo -n "> "
        # read -r USERNAME
        #
        # if [[ -z "${USERNAME}" ]]; then
        #     USERNAME="host"
        # fi

        # PROMPT MACHINETYPE
        echo "Select machine type?"
        echo "1) Desktop"
        echo "2) Notebook"
        echo -n "> "
        read -r MACHINE_TYPE

        case "$MACHINE_TYPE" in
        1) MACHINE="desktop" ;;
        2) MACHINE="notebook" ;;
        esac

        # PROMPT SECUREBOOT (Actually skip this one for now and return false)
        # TODO
        SECUREBOOT="false"

        # PROMPT GPU (only nvidia none for now)
        echo "Select GPU? [Default: None]"
        echo "1) Nvidia"
        echo "2) AMD"
        echo "3) Intel"
        echo "4) None"
        echo -n "> "
        read -r GPU_TYPE

        case "$GPU_TYPE" in
        1) GPU="nvidia" ;;
        2) GPU="amdgpu" ;;
        3) GPU="intel" ;;
        *) GPU="none" ;;
        esac

        # PROMPT POWERMODE
        echo "Select power mode [Default: balanced]"
        echo "1) Balanced"
        echo "2) Performance"
        echo "3) Powersave"
        echo -n "> "
        read -r POWER_TYPE

        case "$POWER_TYPE" in
        1) POWERMODE="balanced" ;;
        2) POWERMODE="performance" ;;
        3) POWERMODE="powersave" ;;
        *) POWERMODE="balanced" ;;
        esac

        # PROMPT PASSWORD
        # TODO skip for now

        # PROMPT AUTOLOGIN
        echo "Autologin? [Default: No]"
        echo "1) Yes"
        echo "2) No"
        echo -n "> "
        read -r AUTOLOGIN

        case "$AUTOLOGIN" in
        1) AUTOLOGIN="true" ;;
        2) AUTOLOGIN="false" ;;
        *) AUTOLOGIN="false" ;;
        esac

        # PROMPT STORAGE
        echo "Mount drives? [Default: No]"
        echo "1) Yes"
        echo "2) No"
        echo -n "> "
        read -r MOUNT_DRIVES

        case "$MOUNT_DRIVES" in
        1) MOUNT="true" ;;
        2) MOUNT="false" ;;
        *) MOUNT="false" ;;
        esac

        if [[ "$MOUNT" == "true" ]]; then
            bash ./storage.sh
            # TODO if statement to call storage.sh to mount the drives
            :
        fi

    fi

    # PROMPT CONFIRMATION
    # SAVE all results to their respective variables
    echo "CONFIRM RESULTS"
    echo "Hostname: $HOSTNAME"
    echo "Machine: $MACHINE"
    echo "GPU: $GPU"
    echo "Powermode: $POWERMODE"
    # echo "Username: $USERNAME"
    echo "Autologin: $AUTOLOGIN"
    echo "Mounted drives: $MOUNT"
    echo "1) Yes"
    echo "2) No"
    echo -n "> "
    read -r CONFIRMATION

    case $CONFIRMATION in
    1) CONFIRMATION="true" ;;
    2) CONFIRMATION="false" ;;
    esac

    if [[ "$CONFIRMATION" == "true" ]]; then
        export HOSTNAME
        # export USERNAME
        export MACHINE
        export GPU
        export POWERMODE
        export AUTOLOGIN
        export SECUREBOOT
        break
    fi
done

# GENERATE config
echo "Generating config..."
bash $HOME/.dotfiles/scripts/lib/_template.sh

echo "Verifying build..."

cd ../nix
if nix flake check; then
    echo "Verified successfully"

    # IF successful run actual rebuild
    echo "Starting rebuild"
    if nixos-rebuild switch --flake ".#$HOSTNAME"; then
        echo "Rebuild successful"
    else
        echo "Rebuild failed"
        exit 1
    fi
else
    echo "Flake check failed"
    exit 1
fi

echo "Reboot system now?"
echo "1) Yes"
echo "2) No"
echo -n "> "
read -r REBOOT

case "$REBOOT" in
1) REBOOT="true" ;;
2) REBOOT="false" ;;
esac

# REBOOT
if [[ "$REBOOT" == "true" ]]; then
    echo "System rebooting..."
    sleep 5
    reboot
fi
