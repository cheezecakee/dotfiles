hl.monitor({
    output = "DP-1",
    mode = "1366x768@60.00",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "auto",
    scale = 1,
    mirror = "DP-1",
})
