
--HelpMenu
--script version 1.0
--Made by: quique18c
--Steam: https://steamcommunity.com/id/quique18c

helpconfig = {} --Base table, ignore.

--Where should we save the bug reports? (folder inside DATA directory)
helpconfig.logFolder = "bugreports"
--Delay time between reports to prevent spaming.
helpconfig.antiSpam = 10


--Show on join (like a MOTD)
helpconfig.showOnJoin = true --Open the window when a user joins the server.

--Console and chat command
helpconfig.consoleCmd = "helpmenu_show"
helpconfig.chatCmd = "/help" --!help, !Help, /Help , /wtf, /motd, !motd        use whatever you like!

--Key binding
helpconfig.bindKeyEnabled = true
helpconfig.bindKey = "gm_showhelp"   --F1 KEY (DEFAULT) (REMEMBER TO DISABLE F1MENU IF YOU USE DARKRP)
--                    gm_showhelp    --F1
--                    gm_showteam    --F2
--                    gm_showspare1  --F3
--                    gm_showspare2  --F4

--UI Settings
helpconfig.sideBarWidth = 300
helpconfig.drawLogo = true --You can also disable the logo feature.
helpconfig.logoSize = 256 --Change as you please.
helpconfig.pngLogo = "materials/helpmenu/serverlogo.png" --Use your own server logo!
helpconfig.mainColor = Color(228, 100, 75)  --Remember set text color if you change this!
helpconfig.textColor = Color(255, 255, 255)
helpconfig.backColor = Color(32, 32, 32)
helpconfig.backColor2 = Color(48, 48, 48)


--Tab settings
helpconfig.tab = {} --Base table, ignore.

helpconfig.tab[0] = { --Respect numeration to show the tabs in the order you want.
    text = "Rules", --Tab Button text
    type = "URL", --Website
    color = helpconfig.mainColor, --Tab Button color -- Color(228, 100, 75)
    url = "https://www.google.com/", --URL of the website
    external = false, -- Should draw on the window, or open with steam web browser?
    default = true -- Only add one tab with the default = true!!!
}
helpconfig.tab[1] = {
    text = "Forum",
    type = "URL",
    color = helpconfig.mainColor, 
    url = "https://www.mistforums.com/",
    external = false,
    default = false
}
helpconfig.tab[2] = {
    text = "Support us!",
    type = "URL",
    color = helpconfig.mainColor, 
    url = "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    external = true,
    default = false
}
helpconfig.tab[3] = {
    text = "Server contents",
    type = "URL",
    color = helpconfig.mainColor, 
    url = "https://steamcommunity.com/workshop/about/?l=spanish&appid=4000",
    external = true,
    default = false
}
helpconfig.tab[4] = {
    text = "Discord",
    type = "URL",
    color = helpconfig.mainColor, 
    url = "https://discord.com/",
    external = true,
    default = false
}
helpconfig.tab[5] = {
    text = "Request Help",
    type = "CMD", --Console command (run on client only) this cant be the default option.
    cmd = "say \"@ I need help from a staff member!\"",
    color = helpconfig.mainColor,
    closeOnRun = true --Should the window close when this button is pressed?
}
helpconfig.tab[6] = {
    text = "Report a bug",
    type = "BUG", --Console command (run on client only)
    color = helpconfig.mainColor,
    default = false --Should the window close when this button is pressed?
}
helpconfig.tab[7] = { --Recommended position: Last
    text = "Close",
    type = "CLOSE", --This button will close the form.
    color = helpconfig.mainColor
}

--Language settings
helpconfig.loc = {} --Base table, ignore.


--English Translations
helpconfig.loc.windowTitle = "YOUR SERVER NAME" --Window title
helpconfig.loc.bugReport1 = "1. Tell us what you were doing" --1st step
helpconfig.loc.bugReport2 = "2. Copy and paste the error from your console" --2nd step
helpconfig.loc.sendButton = "Send" --The send button text
helpconfig.loc.sendFail_title = "Could not send the report" --The menu title when the report fails
helpconfig.loc.sendFail_acceptButton = "Accept" --The accept button, when the report fails
helpconfig.loc.sendFail_incomplete = "You must complete the form!" --When the user does not fill the entire form
helpconfig.loc.sendFail_tooLarge = "You have entered too much text, please do not copy the ENTIRE console output." --When the user writes too much text
helpconfig.loc.bugReportSent_01 = "@ I made a bug report with the following ID: " --Tell admins that the user made a report.
helpconfig.loc.spamChatText = "You already sent a report not long ago." --When an user spams the "Send" button, this message appears on chat.
helpconfig.loc.sentChatText = "Thank You!, You sent a bug report with the ID: " --To inform the user the report has been sent.


--Spanish translations
--[[
helpconfig.loc.windowTitle = "NOMBRE DEL SERVIDOR" --Window title
helpconfig.loc.bugReport1 = "1. Describa que estaba haciendo" --1st step
helpconfig.loc.bugReport2 = "2. Copie y pegue el error de la consola" --2nd step
helpconfig.loc.sendButton = "Enviar" --The send button text
helpconfig.loc.sendFail_title = "No se pudo enviar el reporte" --The menu title when the report fails
helpconfig.loc.sendFail_acceptButton = "Aceptar" --The accept button, when the report fails
helpconfig.loc.sendFail_incomplete = "Debes completar el formulario!" --When the user does not fill the entire form
helpconfig.loc.sendFail_tooLarge = "El texto ingresado es muy largo, no incluyas TODOS los logs." --When the user writes too much text
helpconfig.loc.bugReportSent_01 = "@ Acabe de reportar un BUG con el ID: " --Tell admins that the user made a report.
helpconfig.loc.spamChatText = "Ya enviaste un reporte hace poco tiempo." --When an user spams the "Send" button, this message appears on chat.
helpconfig.loc.sentChatText = "Enviaste un reporte de bug con el ID: " --To inform the user the report has been sent.
--]]
