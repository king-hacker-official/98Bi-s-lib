local Lib = {}

function Lib:CreateWindow(config)
    local CoreGui = game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")

    local Gui = Instance.new("ScreenGui")
    Gui.Name = "9Bi_UI"
    Gui.ResetOnSpawn = false
    Gui.Parent = CoreGui

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Parent = Gui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = Main

    if config.Title then
        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0, 40)
        Title.BackgroundTransparency = 1
        Title.Text = config.Title
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 20
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Parent = Main
    end

    if config.Subtitle then
        local Subtitle = Instance.new("TextLabel")
        Subtitle.Size = UDim2.new(1, 0, 0, 30)
        Subtitle.Position = UDim2.new(0, 0, 0, 35)
        Subtitle.BackgroundTransparency = 1
        Subtitle.Text = config.Subtitle
        Subtitle.Font = Enum.Font.Gotham
        Subtitle.TextSize = 14
        Subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
        Subtitle.Parent = Main
    end

    local TabContainer = Instance.new("Frame")
    TabContainer.Position = UDim2.new(0, 0, 0, (config.Subtitle and 65) or (config.Title and 45) or 0)
    TabContainer.Size = UDim2.new(0, 130, 1, -((config.Subtitle and 65) or (config.Title and 45) or 0))
    TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = Main

    local TabContainerCorner = Instance.new("UICorner")
    TabContainerCorner.CornerRadius = UDim.new(0, 10)
    TabContainerCorner.Parent = TabContainer

    local Pages = Instance.new("Frame")
    Pages.Position = UDim2.new(0, 130, 0, (config.Subtitle and 65) or (config.Title and 45) or 0)
    Pages.Size = UDim2.new(1, -130, 1, -((config.Subtitle and 65) or (config.Title and 45) or 0))
    Pages.BackgroundTransparency = 1
    Pages.Parent = Main

    local Window = {}
    Window._tabs = {}
    Window._currentTab = nil

    function Window:CreateTab(tabName)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, -10, 0, 40)
        Button.LayoutOrder = #TabContainer:GetChildren()
        Button.Position = UDim2.new(0, 5, 0, (#TabContainer:GetChildren() - 0) * 45)
        Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Button.Text = tabName
        Button.Font = Enum.Font.Gotham
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 14
        Button.BorderSizePixel = 0
        Button.AutoButtonColor = false
        Button.Parent = TabContainer

        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 6)
        ButtonCorner.Parent = Button

        local Page = Instance.new("ScrollingFrame")
        Page.Name = tabName .. "_Page"
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.Position = UDim2.new(0, 0, 0, 0)
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.ScrollBarThickness = 6
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.Visible = false
        Page.Parent = Pages

        local UIList = Instance.new("UIListLayout")
        UIList.Padding = UDim.new(0, 8)
        UIList.SortOrder = Enum.SortOrder.LayoutOrder
        UIList.Parent = Page

        UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
        end)

        Button.MouseButton1Click:Connect(function()
            for _, child in pairs(Pages:GetChildren()) do
                if child:IsA("ScrollingFrame") then
                    child.Visible = false
                end
            end
            Page.Visible = true
            Window._currentTab = Page
        end)

        if #Window._tabs == 0 then
            Page.Visible = true
            Window._currentTab = Page
        end

        local TabObj = {}

        function TabObj:CreateButton(name, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, -10, 0, 40)
            Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Btn.Text = name
            Btn.Font = Enum.Font.Gotham
            Btn.TextColor3 = Color3.new(1, 1, 1)
            Btn.TextSize = 14
            Btn.LayoutOrder = #Page:GetChildren()
            Btn.BorderSizePixel = 0
            Btn.Parent = Page

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Btn

            Btn.MouseButton1Click:Connect(function()
                if callback then
                    callback()
                end
            end)
        end

        function TabObj:CreateToggle(name, default, callback)
            local Container = Instance.new("Frame")
            Container.Size = UDim2.new(1, -10, 0, 40)
            Container.BackgroundTransparency = 1
            Container.LayoutOrder = #Page:GetChildren()
            Container.Parent = Page

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(0.6, 0, 1, 0)
            Label.BackgroundTransparency = 1
            Label.Text = name
            Label.Font = Enum.Font.Gotham
            Label.TextColor3 = Color3.new(1, 1, 1)
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Container

            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Size = UDim2.new(0, 60, 0, 24)
            ToggleBtn.Position = UDim2.new(1, -70, 0.5, -12)
            ToggleBtn.BackgroundColor3 = default and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(100, 100, 100)
            ToggleBtn.Text = default and "ON" or "OFF"
            ToggleBtn.Font = Enum.Font.Gotham
            ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
            ToggleBtn.TextSize = 12
            ToggleBtn.BorderSizePixel = 0
            ToggleBtn.Parent = Container

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = ToggleBtn

            local state = default

            ToggleBtn.MouseButton1Click:Connect(function()
                state = not state
                ToggleBtn.BackgroundColor3 = state and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(100, 100, 100)
                ToggleBtn.Text = state and "ON" or "OFF"
                if callback then
                    callback(state)
                end
            end)
        end

        function TabObj:CreateLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -10, 0, 30)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.Font = Enum.Font.Gotham
            Label.TextColor3 = Color3.new(1, 1, 1)
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.LayoutOrder = #Page:GetChildren()
            Label.Parent = Page
        end

        function TabObj:CreateTextbox(placeholder, callback)
            local Box = Instance.new("TextBox")
            Box.Size = UDim2.new(1, -10, 0, 30)
            Box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Box.PlaceholderText = placeholder or ""
            Box.Text = ""
            Box.Font = Enum.Font.Gotham
            Box.TextColor3 = Color3.new(1, 1, 1)
            Box.TextSize = 14
            Box.BorderSizePixel = 0
            Box.LayoutOrder = #Page:GetChildren()
            Box.Parent = Page

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Box

            Box.FocusLost:Connect(function(enterPressed)
                if callback and enterPressed then
                    callback(Box.Text)
                end
            end)
        end

        table.insert(Window._tabs, TabObj)
        return TabObj
    end

    return Window
end

return Lib
