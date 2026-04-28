function drawHeadshot(attacker, weapon, bodypart, loss)
    if not attacker then return end
    if bodypart == 9 then
        triggerServerEvent("headshot", localPlayer, attacker, weapon, bodypart)
    end
end
addEventHandler("onClientPlayerDamage", getLocalPlayer(), drawHeadshot)

local headshotIconVisible = false
local headshotIconAlpha = 0
local headshotIconTimer = nil

function showHeadshotIcon()
    if headshotIconTimer then
        killTimer(headshotIconTimer)
    end
    
    headshotIconVisible = true
    headshotIconAlpha = 1.0  

    headshotIconTimer = setTimer(function()
        headshotIconAlpha = 0
        headshotIconVisible = false
    end, 600, 1)
end

function drawHeadshotIcon()
    if not headshotIconVisible then return end
    
    local screenW, screenH = guiGetScreenSize()
    local iconW, iconH = 128, 128
    local posX = screenW/2 - iconW/2
    local posY = screenH/2 - iconH/2   
    
    local texture = dxCreateTexture("images/headshot.png")
    if texture then
        dxDrawImage(posX, posY, iconW, iconH, texture, 0, 0, 0, tocolor(255, 255, 255, 255 * headshotIconAlpha))
    else
        dxDrawText("HEADSHOT!", posX, posY, posX+iconW, posY+iconH, 
            tocolor(255, 50, 50, 255 * headshotIconAlpha), 2.5, "bankgothic", "center", "center")
    end
end
addEventHandler("onClientRender", root, drawHeadshotIcon)

addEvent("onPlayerHeadshot", true)
addEventHandler("onPlayerHeadshot", root, function(source, victim, attacker, weapon)

    if victim == localPlayer then
        playSoundFrontEnd(41) 
    else
        local x, y, z = getElementPosition(victim)
        local fx = createEffect("blood_fountain", x, y, z + 0.8)
        if fx then
            setEffectSpeed(fx, 1.2)
            setTimer(destroyElement, 1500, 1, fx)
        end
        playSound3D("sound/headshot.mp3", x, y, z, false)
    end
    
    if attacker == localPlayer then
        showHeadshotIcon()
    end
    
end)