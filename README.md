# 9Bi UI Library

> A beautiful, fast, and lightweight Roblox UI Library optimized for **Mobile** and **PC**.

The **9Bi UI** is a simple yet stylish user interface library built for exploit developers. It features tabbed navigation, clean design, and full customization for toggles, buttons, textboxes, and more — all optimized to look and feel smooth on both phones and desktops.

---

## 🌟 Features

- 💡 Clean tabbed layout
- 📱 Fully mobile & PC compatible
- 🎨 Rounded design with modern aesthetics
- 🔘 Easy to use UI elements: buttons, toggles, labels, and textboxes
- ⚡ Lightweight and easy to integrate
- 🧱 Dynamic element stacking with `UIListLayout`
- 💾 No config saving (yet) – keep it lightweight

---

## 📦 How to Use

```lua
local Library = loadstring(game:HttpGet("https://your.cdn/9Bi/source.lua"))()

local Window = Library:CreateWindow({
    Title = "My Hub",
    Subtitle = "Made with 9Bi"
})

local Tab = Window:CreateTab("Main")

Tab:CreateButton("Click me", function()
    print("Button clicked!")
end)

Tab:CreateToggle("Enable Option", false, function(state)
    print("Toggle state:", state)
end)

Tab:CreateTextbox("Enter something...", function(input)
    print("User input:", input)
end)

Tab:CreateLabel("This is a label.")
