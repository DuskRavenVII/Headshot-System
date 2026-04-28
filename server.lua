addEvent("headshot", true)
addEventHandler("headshot", root, function(attacker, weapon, bodypart)
    local victim = source

    killPed(victim, attacker, weapon, bodypart)

    triggerClientEvent(root, "onPlayerHeadshot", root, victim, attacker, weapon)
end)
