local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Naik Gunung - Aldytoi",
    LoadingTitle = "Naik Gunung - Aldytoi",
    LoadingSubtitle = "by AldyToi",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "NaikGunungConfig"
    }
})

local Tab = Window:CreateTab("Main")

-- WalkSpeed Slider
Tab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 250},
    Increment = 1,
    Suffix = "speed",
    CurrentValue = 16,
    Flag = "walkspeed",
    Callback = function(value)
        local plr = game.Players.LocalPlayer
        if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = value
        end
    end
})

-- JumpPower Slider
Tab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 250},
    Increment = 1,
    Suffix = "power",
    CurrentValue = 50,
    Flag = "jumppower",
    Callback = function(value)
        local plr = game.Players.LocalPlayer
        if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.JumpPower = value
        end
    end
})

-- Infinite Health Toggle
Tab:CreateToggle({
    Name = "Infinite Health",
    CurrentValue = false,
    Flag = "infinitehealth",
    Callback = function(value)
        local plr = game.Players.LocalPlayer
        if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            local humanoid = plr.Character.Humanoid
            if value then
                task.spawn(function()
                    while value do
                        humanoid.Health = humanoid.MaxHealth
                        task.wait(0.1)
                    end
                end)
            end
        end
    end
})

-- Disable Health (Lock Health) Toggle
Tab:CreateToggle({
    Name = "Disable Health (Lock Health) Beta",
    CurrentValue = false,
    Flag = "disablehealth",
    Callback = function(enabled)
        local plr = game.Players.LocalPlayer
        if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            local humanoid = plr.Character.Humanoid
            if enabled then
                if _G.disableHealthConnection then _G.disableHealthConnection:Disconnect() end
                _G.disableHealthConnection = humanoid.HealthChanged:Connect(function(health)
                    if health < humanoid.MaxHealth then
                        humanoid.Health = humanoid.MaxHealth
                    end
                end)
            else
                if _G.disableHealthConnection then
                    _G.disableHealthConnection:Disconnect()
                    _G.disableHealthConnection = nil
                end
            end
        end
    end
})

-- Infinity Jump Toggle
Tab:CreateToggle({
    Name = "Infinity Jump",
    CurrentValue = false,
    Flag = "infinityjump",
    Callback = function(enabled)
        local plr = game.Players.LocalPlayer
        local UserInputService = game:GetService("UserInputService")
        if enabled then
            if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                local humanoid = plr.Character.Humanoid
                if _G.infinityJumpConnection then _G.infinityJumpConnection:Disconnect() end
                _G.infinityJumpConnection = UserInputService.JumpRequest:Connect(function()
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
            end
        else
            if _G.infinityJumpConnection then
                _G.infinityJumpConnection:Disconnect()
                _G.infinityJumpConnection = nil
            end
        end
    end
})

-- No Damage Toggle!
Tab:CreateToggle({
    Name = "No Damage (Beta),
    CurrentValue = false,
    Flag = "nodamage",
    Callback = function(enabled)
        local plr = game.Players.LocalPlayer
        if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            local humanoid = plr.Character.Humanoid
            if enabled then
                if _G.noDamageConnection then _G.noDamageConnection:Disconnect() end
                _G.noDamageConnection = humanoid.HealthChanged:Connect(function(health)
                    if health < humanoid.MaxHealth then
                        humanoid.Health = humanoid.MaxHealth
                    end
                end)
            else
                if _G.noDamageConnection then
                    _G.noDamageConnection:Disconnect()
                    _G.noDamageConnection = nil
                end
            end
        end
    end
})

-- Always Day Toggle (pakai RenderStepped supaya siang terus terang)
Tab:CreateToggle({
    Name = "Always Day",
    CurrentValue = false,
    Flag = "alwaysday",
    Callback = function(enabled)
        local Lighting = game:GetService("Lighting")
        local RunService = game:GetService("RunService")

        if enabled then
            if _G.alwaysDayConnection then return end
            _G.alwaysDayConnection = RunService.RenderStepped:Connect(function()
                Lighting.TimeOfDay = "12:00:00"
                Lighting.ClockTime = 12
                Lighting.Brightness = 2
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            end)
        else
            if _G.alwaysDayConnection then
                _G.alwaysDayConnection:Disconnect()
                _G.alwaysDayConnection = nil
            end
            Lighting.TimeOfDay = "14:00:00"
            Lighting.ClockTime = 14
            Lighting.Brightness = 1
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        end
    end
})

local function disableAllFallDamage()
    for _, model in pairs(workspace:GetChildren()) do
        local fallDamage = model:FindFirstChild("FallDamage")
        if fallDamage then
            if fallDamage:FindFirstChild("Enabled") then
                fallDamage.Enabled = false
            elseif fallDamage:FindFirstChild("Disabled") then
                fallDamage.Disabled = true
            elseif fallDamage.Enabled ~= nil then
                fallDamage.Enabled = false
            elseif fallDamage.Disabled ~= nil then
                fallDamage.Disabled = true
            else
                local success, err = pcall(function()
                    fallDamage.Enabled = false
                end)
                if not success then
                    pcall(function()
                        fallDamage.Disabled = true
                    end)
                end
            end
        end
    end
end
disableAllFallDamage()

-- Teleport Button ke Kawah
Tab:CreateButton({
    Name = "Teleport ke Merapi",
    Callback = function()
        local plr = game.Players.LocalPlayer
        if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(4501.5967, 2920.2239, 905.3193) + Vector3.new(0,5,0)
        end
    end
})
