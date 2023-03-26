local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local api_endpoint = "http://speemies.pythonanywhere.com"

-- Get the local player's name
local player = Players.LocalPlayer
local username = player.Name

-- Periodically check if the game is still open and update the player's online status accordingly
while wait(5) do
    if game:IsLoaded() then
        local isOnline = true
        local payload = {
            username = username,
            status = isOnline
        }
        local success, response = pcall(function()
            return HttpService:PostAsync(api_endpoint .. "/app.py/notify", HttpService:JSONEncode(payload))
        end)
        if not success then
            warn("Failed to notify server: " .. tostring(response))
        end
    else
        local isOnline = false
        local payload = {
            username = username,
            status = isOnline
        }
        local success, response = pcall(function()
            return HttpService:PostAsync(api_endpoint .. "/app.py/notify", HttpService:JSONEncode(payload))
        end)
        if not success then
            warn("Failed to notify server: " .. tostring(response))
        end
        break
    end
end
