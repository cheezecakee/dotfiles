#!/usr/bin/env bash

./mount

echo "Hello, welcome to Nix Setup"

# TODO insert boot storage selection, this goes in init.sh
# echo "Select boot drive [Warning this will erase all data in selected storage]"
# TODO pipe lsblk 
# CREATE a root mount 
# RUN nixos-enter --root /mnt/[mount]
running=true

while true; do
    # PROMPT DEFAULT 
    echo "Set generic profile?"
    echo "1) Yes"
    echo "2) No"
    echo -n "> "
    read -r DEFAULT_MODE

    case "$DEFAULT_MODE" in 
        1) GENERIC="yes" ;;
        2) GENERIC="no" ;;
    esac


    if [[ "$DEFAULT_MODE" == 1 ]]; then  
        # TODO add generic vairables and jump straight to the end
        HOSTNAME="host"
        USERNAME="host"
        MACHINE="notebook" #default to notebook, safer choice
        GPU="none"
        POWERMODE="balanced"
        AUTOLOGIN="no"
        MOUNT="no"
    else 
        # PROMPT HOSTNAME 
        echo "Hostname? [Default = Host]"
        echo -n "> "
        read -r HOSTNAME

        if [[ -z "${HOSTNAME}" ]]; then 
            HOSTNAME="host"
        fi

        echo "Hostname set: "$HOSTNAME""

        # PROMPT USERNAME 
        echo "Username [Default: Host]"
        echo -n "> "
        read -r USERNAME

        if [[ -z "${USERNAME}" ]]; then 
            USERNAME="host"
        fi

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
            2) GPU="amd" ;;
            3) GPU="intel" ;;
            *) GPU="none" ;;
        esac

        # PROMPT POWERMODE
        echo "Select power mode [Default: balanced]"
        echo "1) Balanced"
        echo "2) Perfomance"
        echo "3) Powersave"
        echo -n "> "
        read -r POWER_TYPE

        case "$POWER_TYPE" in
            1) POWERMODE="balanced" ;;
            2) POWERMODE="perfomance" ;;
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
            1) AUTOLOGIN="yes";;
            2) AUTOLOGIN="no" ;;
            *) AUTOLOGIN="no" ;;
        esac

        # PROMPT STORAGE (TODO different script, storage.sh)
        echo "Mount drives? [Default: No]"
        echo "1) Yes"
        echo "2) No"
        echo -n "> "
        read -r MOUNT_DRIVES

        case "$MOUNT_DRIVES" in 
            1) MOUNT="yes";;
            2) MOUNT="no" ;;
            *) MOUNT="no" ;;
        esac

        if [[ "$MOUNT" == "yes" ]]; then 
            # TODO if statement to call storage.sh to mount the drives
            :
        fi

    fi

    # SAVE all results to their respective variables 
    echo "CONFIRM RESULTS"
    echo "Hostname: $HOSTNAME"
    echo "Machine: $MACHINE"
    echo "GPU: $GPU"
    echo "Powermode: $POWERMODE"
    echo "Username: $USERNAME"
    echo "Autologin: $AUTOLOGIN"
    echo "Mounted drives: $MOUNT"
    echo "1) Yes"
    echo "2) No"
    echo -n "> "
    read -r CONFIRMATION

    case $CONFIRMATION in
        1) CONFIRMATION="yes" ;;
        2) CONFIRMATION="no"  ;;
    esac

    if [[ "$CONFIRMATION" == "yes" ]] ; then 
        export HOSTNAME
        export USERNAME
        export MACHINE
        export GPU
        export POWERMODE
        export AUTOLOGIN
        running=false
        break
    fi
done

echo "Generating config..."
# PROMPT CONFIRMATION
 
echo "Config generated in ../nix/host"

# CALL templates.sh to inject the variables to the files 
echo "Generating Hardware-configuration..."
# GENERATE hardware-config and copy it to host dir 

echo "Hardware-configuration generated in ../nix/host"

echo "Verifying build..."
# TODO RUN nix rebuild check 

# IF successful run actual rebuild 
echo "Verified successfully"
echo "Starting rebuild"

echo "Rebuild successful"

echo "Reboot system now?"
echo "1) Yes"
echo "2) No"
echo -n "> "
read -r REBOOT

case "$REBOOT" in 
    1) REBOOT="yes" ;;
    2) REBOOT="no" ;;
esac

# REBOOT 
if [[ "$REBOOT" == "yes" ]]; then 
    echo "System rebooting..."
    sleep 5
    reboot
fi
