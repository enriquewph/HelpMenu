
--HelpMenu
--script version 1.0
--Made by: quique18c
--Steam: https://steamcommunity.com/id/quique18c


util.AddNetworkString( "helpMenuShow" )
util.AddNetworkString( "helpMenuBug" )
util.AddNetworkString( "helpMenuBugRx" )


local report_path = function(id) return helpconfig.logFolder .."/" .. string.lower(game.GetMap()) .. "/" .. id .. ".txt" end

function helpMenuLoad()
    if helpconfig.drawLogo then  resource.AddFile( helpconfig.pngLogo ) end --Add server logo material

    if not file.Exists(helpconfig.logFolder, "DATA") then
		file.CreateDir(helpconfig.logFolder)
    end
    
    if not file.Exists(helpconfig.logFolder .. "/" .. string.lower(game.GetMap()), "DATA") then
		file.CreateDir(helpconfig.logFolder .. "/" .. string.lower(game.GetMap()))
    end

    print("------------------------------------------------------")
    print("----               HELP MENU LOADED               ----")
    print("----             SCRIPT BY: QUIQUE18C             ----")
    print("------------------------------------------------------")
end

function helpMenuBug(len, ply)

    --Spam protection:
    if ply.lastBugReportTime then
        if ((os.clock() - ply.lastBugReportTime) < helpconfig.antiSpam ) then --Spamming!
            ply:PrintMessage(HUD_PRINTTALK, helpconfig.loc.spamChatText)
            return
        end
    end
    ply.lastBugReportTime = os.clock()

    --If you so desire, you can add extra info here!
    packet = {}
    packet.player = {}
    packet.player.name = ply:Name()
    packet.player.pos = ply:GetPos()
    packet.player.angles = ply:GetAngles()
    packet.player.ping = ply:Ping()
    packet.player.accountid = ply:AccountID()
    packet.player.alive = ply:Alive()
    packet.player.health = ply:Health()
    packet.player.armor = ply:Armor()
    packet.player.deaths = ply:Deaths()
    packet.player.activeweapon = ply:GetActiveWeapon()
    packet.action = net.ReadString()
    packet.conlog = net.ReadString()

    local logId = os.time() .. "-" .. packet.player.accountid
    
    file.Write(report_path(logId), util.TableToJSON(packet))

    ply:PrintMessage(HUD_PRINTTALK, helpconfig.loc.sentChatText .. logId)
    
    net.Start("helpMenuBugRx")
    net.WriteString(logId)
	net.Send(ply)
end


hook.Add("PlayerSay", "helpMenu_show", function(ply, text)
    if text == helpconfig.chatCmd then
        net.Start("helpMenuShow")
	    net.Send(ply)
    end
end)

hook.Add("InitPostEntity", "helpMenuLoad", function() timer.Simple(3, helpMenuLoad) end)

net.Receive( "helpMenuBug", helpMenuBug )