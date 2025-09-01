-- 🟢 Load UI Lib
loadstring(game:HttpGet(("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua")))()

-- 🟢 Tạo Window chính
local Window = MakeWindow({
    Hub = {
        Title = "Lý Nam Cường script",
        Animation = "Cường mê gái vó tu script"
    },
    Key = {
        KeySystem = false,
        Title = "Key System",
        Description = "",
        KeyLink = "",
        Keys = {"1234"},
        Notifi = {
            Notifications = true,
            CorrectKey = "Running the Script...",
            Incorrectkey = "The key is incorrect",
            CopyKeyLink = "Copied to Clipboard"
        }
    }
})

-- 🟢 Nút thu nhỏ UI
MinimizeButton({
    Image = "http://www.roblox.com/asset/?id=72939512240078",
    Size = {60, 60},
    Color = Color3.fromRGB(10, 10, 10),
    Corner = true,
    Stroke = false,
    StrokeColor = Color3.fromRGB(255, 0, 0)
})

-- 🟢 Tạo Tab AutoBuy
local Tab1 = MakeTab({
    Name = "AutoBuy",
    Icon = "rbxassetid://3926305904",
    Color = Color3.fromRGB(255, 100, 100)
})

-- Danh sách Seeds và Gears
local seeds = {"Wheat", "Corn", "Carrot", "Tomato", "Potato", "Pumpkin", "Strawberry"}
local gears = {"Hoe", "WateringCan", "Shovel", "Scythe", "Bucket"}

-- 🟢 Từng toggle Seed
for _, seed in ipairs(seeds) do
    AddToggle(Tab1, {
        Name = "AutoBuy " .. seed,
        Default = false,
        Callback = function(value)
            _G["AutoBuy"..seed] = value
            while _G["AutoBuy"..seed] do
                task.wait(1)
                game:GetService("ReplicatedStorage").BuySeedEvent:FireServer(seed)
            end
        end
    })
end

-- 🟢 Từng toggle Gear
for _, gear in ipairs(gears) do
    AddToggle(Tab1, {
        Name = "AutoBuy " .. gear,
        Default = false,
        Callback = function(value)
            _G["AutoBuy"..gear] = value
            while _G["AutoBuy"..gear] do
                task.wait(2)
                game:GetService("ReplicatedStorage").BuyGearEvent:FireServer(gear)
            end
        end
    })
end

-- 🟢 AutoBuy ALL Seeds
AddToggle(Tab1, {
    Name = "AutoBuy ALL Seeds",
    Default = false,
    Callback = function(value)
        _G.AutoBuyAllSeeds = value
        while _G.AutoBuyAllSeeds do
            task.wait(1)
            for _, seed in ipairs(seeds) do
                game:GetService("ReplicatedStorage").BuySeedEvent:FireServer(seed)
            end
        end
    end
})

-- 🟢 AutoBuy ALL Gears
AddToggle(Tab1, {
    Name = "AutoBuy ALL Gears",
    Default = false,
    Callback = function(value)
        _G.AutoBuyAllGears = value
        while _G.AutoBuyAllGears do
            task.wait(2)
            for _, gear in ipairs(gears) do
                game:GetService("ReplicatedStorage").BuyGearEvent:FireServer(gear)
            end
        end
    end
})