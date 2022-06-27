ESX = nil
local UnderProcess = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    if Config.BlipsEnable == true then
    for k,v in pairs(Config.Blips) do
        v.blip = AddBlipForCoord(v.Coords, v.Coords, v.Coords) --> Kordinat -- Cordinate <--
        SetBlipSprite(v.blip, v.ID) --> Şekil/Görünüş -- Form <--
        SetBlipAsShortRange(v.blip, true)
 	    BeginTextCommandSetBlipName("STRING")
        SetBlipColour(v.blip, v.Color) --> Reng -- Color <--
        SetBlipScale(v.blip, v.Scale) --> Boyut -- Size <--
        AddTextComponentString(v.Name) --> İsim -- Name <--
        EndTextCommandSetBlipName(v.blip)
        end
    end
end)

Citizen.CreateThread(function()
    if Config.NPC == true then
      for k,v in pairs(Config.Peds) do
        RequestModel(v.Hash)
        while not HasModelLoaded(v.Hash) do
            Wait(1)
        end
        CreateSellPed = CreatePed(1, v.Hash, v.x, v.y, v.z - 1, v.h, false, true)
        SetBlockingOfNonTemporaryEvents(CreateSellPed, true)
        SetPedDiesWhenInjured(CreateSellPed, false)
        SetPedCanPlayAmbientAnims(CreateSellPed, true)
        SetPedCanRagdollFromPlayerImpact(CreateSellPed, false)
        SetEntityInvincible(CreateSellPed, true)
        FreezeEntityPosition(CreateSellPed, true)
        TaskStartScenarioInPlace(CreateSellPed, v.Anim, 0, true);
    end
  end
end)

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 425
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 125)
    ClearDrawOrigin()
end

RegisterNUICallback("close", function(data, cb) 
    SetNuiFocus(0, 0)
    UnderProcess = false
    ClearPedTasksImmediately(PlayerPedId())
    
    TriggerServerEvent('oph3z-orange:GiveOrange', src)
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function playerAnim()
	loadAnimDict( "mp_safehouselost@" )
    TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local playerCoords = GetEntityCoords(PlayerPedId())
        for i = 1, #Config.Settings, 1 do
            for j = 1, #Config.Settings[i].Coords, 1 do
                local dst = GetDistanceBetweenCoords(playerCoords, Config.Settings[i].Coords[j].Pos, true)
                if dst < Config.DrawDistance and UnderProcess == false then
                    sleep = 4
                    DrawMarker(2, Config.Settings[i].Coords[j].Pos[1],  Config.Settings[i].Coords[j].Pos[2],  Config.Settings[i].Coords[j].Pos[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                    if  dst < 5 and UnderProcess == false then
                        DrawText3D( Config.Settings[i].Coords[j].Pos[1],  Config.Settings[i].Coords[j].Pos[2],  Config.Settings[i].Coords[j].Pos[3], _U('pick_oranges'))
                        sleep = 3
                        if IsControlJustPressed(0, 38) then
                            UnderProcess = true
                            SendNUIMessage({ action = "load" }) 
                            SetNuiFocus(1, 1)
                            playAnim("random@mugging5", "001445_01_gangintimidation_1_female_idle_b", 1000000)
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local Player = PlayerPedId()
        local PlayerCoords = GetEntityCoords(Player)
        local dst = GetDistanceBetweenCoords(PlayerCoords, Config.PartTwoCoords.x, Config.PartTwoCoords.y, Config.PartTwoCoords.z, true)
        if dst < 10 and UnderProcess == false then
            sleep = 4
            DrawMarker(2, Config.PartTwoCoords.x, Config.PartTwoCoords.y, Config.PartTwoCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst < 5 and UnderProcess == false then
                sleep = 4
                DrawText3D( Config.PartTwoCoords.x, Config.PartTwoCoords.y, Config.PartTwoCoords.z, _U('process_orange'))
                if IsControlJustPressed(0, 38) then
                    UnderProcess = true
                    exports['mythic_progbar']:Progress({
                        name = "oph3z-orange",
                        duration = 5000,
                        label = _U('processing'),
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "mp_car_bomb",
                            anim = "car_bomb_mechanic",
                            flags = 49,
                        },
                        -- prop = {
                        --     model = "prop_tool_pickaxe",
                        -- },
                    }, function(cancelled)
                        if not cancelled then
                            TriggerServerEvent("oph3z-orange:ProcessOrange")
                            UnderProcess = false
                        else
                            exports['mythic_notify']:SendAlert('error', _U('progressbar_cancel'), 5000)
                        end
                    end)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local Player = PlayerPedId()
        local PlayerCoords = GetEntityCoords(Player)
        local dst = GetDistanceBetweenCoords(PlayerCoords, Config.SellCoords.x, Config.SellCoords.y, Config.SellCoords.z, true)
        if dst < 5 then
            sleep = 3
            DrawText3D(Config.SellCoords.x, Config.SellCoords.y, Config.SellCoords.z, _U('sell_orange'))
            if IsControlJustPressed(0, 38) then
                playerAnim()
                TriggerServerEvent('oph3z-orange:SellOrange')
            end
        end
        Citizen.Wait(sleep)
    end
end)
