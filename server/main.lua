local postals = {}

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

function getPostal(source)
    local ped = GetPlayerPed(source)
    local pedCoords = GetEntityCoords(ped)
    local coords = vec(pedCoords.x, pedCoords.y)
    local nearestPostal = nil
    local nearestDist = nil
    local nearestIndex = nil

    for i = 1, #postals do
        local dist = #(coords - postals[i].coords)
        if not nearestDist or dist < nearestDist then
            nearestIndex = i
            nearestDist = dist
        end
    end
    nearestPostal = postals[nearestIndex]

    return nearestPostal.code, nearestPostal
end
