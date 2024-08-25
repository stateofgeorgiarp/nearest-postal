
local nearestPostal = {}
local postals = {}

function markPostal(code)
    for i = 1, #postals do
        local postal = postals[i]
        if postal.code == code then
            SetNewWaypoint(postal.coords.x, postal.coords.y)
            return
        end
    end
end

function getPostal()
    return nearestPostal.code, nearestPostal
end

RegisterCommand("postal", function(source, args, rawCommand)
    if not args[1] then return end
    markPostal(args[1])
end, false)

RegisterCommand("p", function(source, args, rawCommand)
    if not args[1] then return end
    markPostal(args[1])
end, false)

TriggerEvent("chat:addSuggestion", "/postal", "Mark a postal on the map", {{name="postal", help="The postal code"}})
TriggerEvent("chat:addSuggestion", "/p", "Mark a postal on the map", {{name="postal", help="The postal code"}})

CreateThread(function()
    postals = json.decode(LoadResourceFile(GetCurrentResourceName(), "postals.json"))
    
    for i = 1, #postals do
        local postal = postals[i]
        postals[i] = {
            coords = vec(postal.x, postal.y),
            code = postal.code
        }
    end
end)

CreateThread(function()
    local totalPostals = #postals
    while true do
        ped = PlayerPedId()
        pedCoords = GetEntityCoords(ped)
        local nearestDist = nil
        local nearestIndex = nil
        local coords = vec(pedCoords.x, pedCoords.y)

        for i = 1, totalPostals do
            local dist = #(coords - postals[i].coords)
            if not nearestDist or dist < nearestDist then
                nearestDist = dist
                nearestIndex = i
            end
        end

        nearestPostal = postals[nearestIndex]
        Wait(1000)
    end
end)
