hs.hotkey.bind({"cmd", "alt"}, "T", function()
  hs.alert.show(os.date("%H:%M"), {
    textSize = 192,
    textColor = {red = 1, green = 0.2, blue = 0.6, alpha = 1},
    fillColor = {red = 0, green = 0, blue = 0, alpha = 0.75},
    strokeColor = {alpha = 0},
    radius = 16,
  }, 2)
end)

hs.hotkey.bind({"cmd", "alt"}, "J", function()
  hs.alert.show(os.date("%A %d %B"), {
    textSize = 96,
    textColor = {red = 1, green = 0.2, blue = 0.6, alpha = 1},
    fillColor = {red = 0, green = 0, blue = 0, alpha = 0.75},
    strokeColor = {alpha = 0},
    radius = 16,
  }, 2)
end)
