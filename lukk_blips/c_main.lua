local blipLegend = {
    -- {ID blipu, "popisek"}
    {6, "Testovací blip"},
    
}

local blips = {
    --  {ID blipu, X, Y, Z, R, G, B, VELIKOST, VZDÁLENOST VIDĚNÍ}
    {6, 0, 0, 0, 255, 255, 255, 2, 99999}
}   

local screenW, screenH = guiGetScreenSize()
local blipsCount = 0
local blipsOffset = 0
local legendCount = 0

function showBlips(res)
    local secondRowBlips = false

    for i, v in ipairs(blips) do
        blipsCount = blipsCount + 1
        createBlip(v[2], v[3], v[4], v[1], v[8], v[5], v[6], v[7], 255, 0, v[9])
    end
    outputDebugString(getResourceName(res)..": Načteno "..blipsCount.." blipů")

    for i, v in ipairs(blipLegend) do
        legendCount = legendCount + 1
        
        if legendCount > 37 then
            if not secondRowBlips then
                blipsOffset = 0
                secondRowBlips = true
            end

            createBlip(4058.775390625, 1014.17578125 - blipsOffset, 82.293807983398, v[1], 1, 255, 255, 255, 255, 0, 0)
        else
            createBlip(3058.775390625, 1014.17578125 - blipsOffset, 82.293807983398, v[1], 1, 255, 255, 255, 255, 0, 0)
        end
        blipsOffset = blipsOffset + 110
    end
end
addEventHandler ("onClientResourceStart", resourceRoot, showBlips )


addEventHandler("onClientRender", root,
function()
    if isPlayerMapVisible() then
        local posY = screenH * 0.3253
        local posW =  screenW * 0.7926
        local labelOffset = 0
        local labelCount = 0
        local labelSecondRow = false

        for i, v in ipairs(blipLegend) do
            if labelCount > 36 then
                if not labelSecondRow then
                    labelSecondRow = true
                    posY = screenH * 0.3253
                    posW =  screenW * 0.887
                end

                dxDrawText(v[2], posW, posY, screenW * 0.8677, screenH * 0.3324, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
                posY = posY + 19.8 
                labelCount = labelCount + 1
            else
                dxDrawText(v[2], posW, posY, screenW * 0.8677, screenH * 0.3324, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
                posY = posY + 19.8 
                labelCount = labelCount + 1
            end
        end
    end
end)

