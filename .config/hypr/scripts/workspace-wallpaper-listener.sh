#!/usr/bin/env bash

# SWWW workspace wallpaper listener for Hyprland
# Better transitions than hyprpaper

# Configuration
readonly WALLPAPER_BASE_DIR="$HOME/Pictures/backgrounds"
readonly LOG_FILE="$HOME/.cache/hypr-wallpaper.log"
readonly TRANSITION_TYPE="grow"  # Perfect for space theme - like expanding stars/galaxies
readonly TRANSITION_DURATION="0.8"  # Slightly longer for dramatic effect
readonly TRANSITION_POS="0.5,0.5"   # Center point for grow animation

# Logging function
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Function to change wallpaper with smooth transition
change_workspace_wallpaper() {
    local workspace_id="$1"
    local wallpaper_path="${WALLPAPER_BASE_DIR}/workspace-${workspace_id}.png"
    
    # Check if wallpaper file exists
    if [[ ! -f "$wallpaper_path" ]]; then
        log_message "WARNING: Wallpaper not found: $wallpaper_path"
        return 1
    fi
    
    # Change wallpaper with smooth transition
    if swww img "$wallpaper_path" \
        --transition-type "$TRANSITION_TYPE" \
        --transition-duration "$TRANSITION_DURATION" \
        --transition-pos "$TRANSITION_POS" \
        --transition-fps 60 2>/dev/null; then
        log_message "SUCCESS: Changed wallpaper to workspace $workspace_id with $TRANSITION_TYPE transition"
    else
        log_message "ERROR: Failed to change wallpaper to workspace $workspace_id"
    fi
}

# Function to get current workspace
get_current_workspace() {
    hyprctl activeworkspace -j | jq -r '.id' 2>/dev/null || echo "1"
}

# Initialize swww daemon and set initial wallpaper
init_swww() {
    # Start swww daemon if not running
    if ! pgrep -x "swww-daemon" >/dev/null; then
        log_message "INFO: Starting swww daemon..."
        swww-daemon &
        sleep 2
    fi
    
    local current_workspace
    current_workspace=$(get_current_workspace)
    log_message "INFO: Initializing swww wallpaper listener for workspace $current_workspace"
    change_workspace_wallpaper "$current_workspace"
}

# Main event listener function
listen_workspace_events() {
    log_message "INFO: Starting workspace wallpaper listener with swww..."
    
    # Listen to Hyprland events using socat
    socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r event; do
        # Parse workspace change events
        if [[ "$event" =~ ^workspace\>\>([0-9]+) ]]; then
            local new_workspace="${BASH_REMATCH[1]}"
            log_message "INFO: Workspace changed to $new_workspace"
            change_workspace_wallpaper "$new_workspace"
        fi
    done
}

# Error handling and cleanup
cleanup() {
    log_message "INFO: Workspace wallpaper listener stopped"
    exit 0
}

# Set up signal handlers
trap cleanup SIGTERM SIGINT

# Check dependencies
check_dependencies() {
    local missing_deps=()
    
    command -v hyprctl >/dev/null || missing_deps+=("hyprctl")
    command -v socat >/dev/null || missing_deps+=("socat")
    command -v jq >/dev/null || missing_deps+=("jq")
    command -v swww >/dev/null || missing_deps+=("swww")
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log_message "ERROR: Missing dependencies: ${missing_deps[*]}"
        echo "Error: Missing required dependencies: ${missing_deps[*]}" >&2
        echo "Install swww with: yay -S swww  # or your package manager" >&2
        exit 1
    fi
}

# Main execution
main() {
    # Ensure log directory exists
    mkdir -p "$(dirname "$LOG_FILE")"
    
    # Check for required tools
    check_dependencies
    
    # Wait for Hyprland to be ready
    sleep 2
    
    # Initialize swww and wallpaper
    init_swww
    
    # Start listening for events
    listen_workspace_events
}

# Run main function
main "$@"
