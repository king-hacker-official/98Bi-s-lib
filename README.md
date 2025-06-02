# 9Bi UI Library

> A beautiful, fast, and lightweight Roblox UI Library optimized for **Mobile** and **PC**.

**9Bi UI** is a sleek and easy-to-use interface library designed for exploit developers. Inspired by popular UIs like Rayfield and Kavo, it delivers responsive, modern GUI elements across all devices.

---

## 🌟 Features

- ✨ Clean and minimal tabbed layout  
- 📱 Mobile and PC compatible  
- 🟣 Modern design with rounded corners  
- 🧩 Elements: Buttons, Toggles, Labels, Textboxes  
- ⚡ Lightweight and easy to integrate  
- 📚 Auto-stacked elements using `UIListLayout`  
- ❌ No configuration saving (yet) for simplicity  

---

## 🧭 Step-by-Step Guide

### 1️⃣ Load the Library

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/king-hacker-official/98Bi-s-lib/main/Source-lib.lua"))()
```


### 2️⃣ Create a Window

```
local Window = Library:CreateWindow({
    Title = "My Hub",       -- Main title at the top
    Subtitle = "Made with 9Bi" -- Subtitle (optional)
})
```
3️⃣ Add a Tab
```
local Tab = Window:CreateTab("Main") -- The name that appears on the tab button
```
4️⃣ Add Elements to the Tab
```
-- Button
Tab:CreateButton("Click me", function()
    print("Button clicked!")
end)

-- Toggle
Tab:CreateToggle("Enable Option", false, function(state)
    print("Toggle state:", state)
end)

-- Textbox
Tab:CreateTextbox("Enter something...", function(input)
    print("Input received:", input)
end)

-- Label
Tab:CreateLabel("This is a label.")
