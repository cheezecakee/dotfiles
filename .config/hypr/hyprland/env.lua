local home_dir = os.getenv("HOME")

-- Wayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Themes
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
