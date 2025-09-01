-- 🟢 Load UI Lib
loadstring(game:HttpGet(("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua")))()

-- 🟢 Tạo Window chính
local Window = MakeWindow({
    Hub = {
        Title = "Lý Nam Cường script",
        Animation = "Cường mê gái vó tu script"
    },
    Key = {
        KeySystem = false
    }
})

-- 🟢 Nút thu nhỏ UI
MinimizeButton({
    Image = "http://www.roblox.com/asset/?id=72939512240078",
    Size = {60, 60},
    Color = Color3.fromRGB(10, 10, 10),
    Corner = true
})

-- 🟢 Tạo Tab AutoBuy
local Tab1 = MakeTab({
    Name = "AutoBuy",
    Icon = "rbxassetid://3926305904",
    Color = Color3.fromRGB(255, 100, 100)
})

-- 🟢 RemoteEvents (Grow a Garden dùng Remotes folder)
local RS = game:GetService("ReplicatedStorage")
local Remotes = RS:WaitForChild("Remotes")

local buySeedEvent = Remotes:WaitForChild("BuySeedEvent")
local buyGearEvent = Remotes:WaitForChild("BuyGearEvent")

-- Danh sách Seeds và Gears
local seeds = {"Wheat", "Corn", "Carrot", "Tomato", "Potato", "Pumpkin", "Strawberry"}
local gears = {"Hoe", "WateringCan", "Shovel", "Scythe", "Bucket"}

-- 🟢 Hàm tạo vòng lặp AutoBuy
local function startLoop(flagName, delay, callback)
    task.spawn(function()
        while _G[flagName] do
            task.wait(delay)
            pcall(callback)
        end
    end)
end

-- 🟢 Từng toggle Seed
for _, seed in ipairs(seeds) do
    AddToggle(Tab1, {
        Name = "AutoBuy " .. seed,
        Default = false,
        Callback = function(value)
            _G["AutoBuy"..seed] = value
            if value then
                startLoop("AutoBuy"..seed, 1, function()
                    buySeedEvent:FireServer(seed)
                end)
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
            if value then
                startLoop("AutoBuy"..gear, 2, function()
                    buyGearEvent:FireServer(gear)
                end)
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
        if value then
            startLoop("AutoBuyAllSeeds", 1, function()
                for _, seed in ipairs(seeds) do
                    buySeedEvent:FireServer(seed)
                end
            end)
        end
    end
})

-- 🟢 AutoBuy ALL Gears
AddToggle(Tab1, {
    Name = "AutoBuy ALL Gears",
    Default = false,
    Callback = function(value)
        _G.AutoBuyAllGears = value
        if value then
            startLoop("AutoBuyAllGears", 2, function()
                for _, gear in ipairs(gears) do
                    buyGearEvent:FireServer(gear)
                end
            end)
        end
    end
})