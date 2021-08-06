local helpMenuTab = {}   --Base table, ignore.
helpMenuTab.tabList = {} --Base table, ignore.

--HelpMenu
--script version 1.0
--Made by: quique18c
--Steam: https://steamcommunity.com/id/quique18c

--You can change these too!!
surface.CreateFont("helpMenu_titleFont", {
    font = "Roboto",
    size = 24
})
surface.CreateFont("helpMenu_buttonFont", {
    font = "Roboto",
    size = 26
})
surface.CreateFont("helpMenu_txtInpFont", { --Same as CLOSE BUTTON
    font = "Roboto",
    size = 20
})

function helpMenu()
    local frame = qlibui_createwindow({
        width = ScrW() - 200,
        height = ScrH() - 200,
        title = helpconfig.loc.windowTitle,
        icon = false,
        topColor = helpconfig.mainColor,
        backColor = helpconfig.backColor,
        titleColor = helpconfig.textColor,
        titleFont = "helpMenu_titleFont",
        closeButtonFont = "helpMenu_txtInpFont",
        anim = true
    })
    
    local sidepanel = qlibui_addSidePanel({
        parent = frame,
        pos = "left",
        width = helpconfig.sideBarWidth,
        spacing = 4,
        gripColor = helpconfig.mainColor,
        backColor = helpconfig.backColor
    })
    
    local spacer
    if helpconfig.drawLogo then
        spacer = sidepanel.addPanel(sidepanel:GetWide())
        spacer.Paint = function(self, w, h)
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(Material(helpconfig.pngLogo))
            surface.DrawTexturedRect(w / 2 - helpconfig.logoSize / 2, h / 2 - helpconfig.logoSize / 2, helpconfig.logoSize, helpconfig.logoSize)
        end
    else
        spacer = sidepanel.addPanel(32) --32 pixels tall
        spacer.Paint = function(self, w, h)
            --Nothing here....
        end
    end

    for tabNumber, v in pairs(helpconfig.tab) do
        if (v.type == "URL") then
            helpMenu_AddURLTab(v.text, v.color, v.url, sidepanel, v.external, v.default)
        elseif (v.type == "CMD") then
            helpMenu_AddConCommandTab(v.text, v.color, v.cmd, sidepanel, frame, v.closeOnRun)
        elseif (v.type == "BUG") then
            helpMenu_AddBugReportTab(v.text, v.color, sidepanel, frame, v.default)
        elseif (v.type == "CLOSE") then
            helpMenu_AddCloseButtonTab(v.text, v.color, sidepanel, frame)
        end

    end
end

function helpMenu_AddCloseButtonTab(name, buttColor, parent, frame)
    default = default or false

    local CloseButton = helpMenu_AddButton(name, parent)
    CloseButton.DoClick = function()
        frame:Close()
    end
end

function helpMenu_AddConCommandTab(name, buttColor, cmd, parent, frame, exit)
    exit = exit or false
    default = default or false

    local ConButton = helpMenu_AddButton(name, parent)
    ConButton.DoClick = function()
        LocalPlayer():ConCommand(cmd)
        if exit then frame:Close() end
    end
end

function helpMenu_AddURLTab(name, buttColor, url, parent, external, default)
    default = default or false

    local URLButton = helpMenu_AddButton(name, parent)
    URLButton.DoClick = function()
        if not external then helpMenuTab.show(name) else
            gui.OpenURL(url)
        end
    end

    if not external then
        helpMenuTab.tabList[name] = vgui.Create("HTML", parent.getChildPanel())
        helpMenuTab.tabList[name]:SetSize(parent.getChildPanel():GetWide(), parent.getChildPanel():GetTall())
        helpMenuTab.tabList[name]:SetPos(0, 0)
        helpMenuTab.tabList[name]:SetVisible(default) -- POR DEFECTO
        helpMenuTab.tabList[name]:OpenURL(url)
    end
end

function helpMenu_AddBugReportTab(name, buttColor, parent, frame, default)
    default = default or false

    local BugReportButton = helpMenu_AddButton(name, parent)
    BugReportButton.DoClick = function()
        helpMenuTab.show(name)
    end

    helpMenuTab.tabList[name] = vgui.Create("DPanel", parent.getChildPanel())
    helpMenuTab.tabList[name]:SetSize(parent.getChildPanel():GetWide(), parent.getChildPanel():GetTall())
    helpMenuTab.tabList[name]:SetPos(0, 0)
    helpMenuTab.tabList[name]:SetVisible(default)

    local margin = 32

    local wide = helpMenuTab.tabList[name]:GetWide()
    local tall = helpMenuTab.tabList[name]:GetTall()

    local textBoxSizeX = wide - margin * 2
    local textBoxSizeY = tall / 2 - 64 - 40
    local textBoxPosX = margin
    local textBoxPosY = margin + 24

    local textBox2SizeX = textBoxSizeX
    local textBox2SizeY = textBoxSizeY
    local textBox2PosX = margin
    local textBox2PosY = textBoxSizeY + textBoxPosY + margin * 2

    helpMenuTab.tabList[name].Paint = function(self, w, h)
        --draw.RoundedBox(0, 0, 0, w, h, Color(255, 0, 0))
        draw.DrawText(helpconfig.loc.bugReport1, "helpMenu_titleFont", 16, 16, helpconfig.textColor, TEXT_ALIGN_LEFT)
        qlibui_drawrect(0, textBoxPosX, textBoxPosY, textBoxSizeX, textBoxSizeY, Color(48, 48, 48))
        draw.DrawText(helpconfig.loc.bugReport2, "helpMenu_titleFont", 16, margin - 8 + textBoxSizeY + textBoxPosY, helpconfig.textColor, TEXT_ALIGN_LEFT)
        qlibui_drawrect(0, textBox2PosX, textBox2PosY, textBox2SizeX, textBox2SizeY, Color(48, 48, 48))
    end

    local textBox = vgui.Create("DTextEntry", helpMenuTab.tabList[name])
    textBox:SetSize(textBoxSizeX, textBoxSizeY)
    textBox:SetPos(textBoxPosX, textBoxPosY)
    textBox:SetMultiline(true)
    textBox:SetFont( "helpMenu_txtInpFont" )
    textBox:SetTextColor(helpconfig.textColor)
    textBox:SetCursorColor(helpconfig.textColor)
    textBox:SetHighlightColor(helpconfig.mainColor)
    textBox:SetPaintBackground(false)

    
    local textBox2 = vgui.Create("DTextEntry", helpMenuTab.tabList[name])
    textBox2:SetSize(textBox2SizeX, textBox2SizeY)
    textBox2:SetPos(textBox2PosX, textBox2PosY)
    textBox2:SetMultiline(true)
    textBox2:SetFont( "helpMenu_txtInpFont" )
    textBox2:SetTextColor(helpconfig.textColor)
    textBox2:SetCursorColor(helpconfig.textColor)
    textBox2:SetHighlightColor(helpconfig.mainColor)
    textBox2:SetPaintBackground(false)

    local SendButton = qlibui_addButton({
        parent = helpMenuTab.tabList[name],
        tall = 40,
        width = helpMenuTab.tabList[name]:GetWide() - 2 * margin,
        posY = helpMenuTab.tabList[name]:GetTall() - 40 - margin,
        posX = margin,
        text = helpconfig.loc.sendButton,
        color = helpconfig.mainColor,
        backColor = helpconfig.backColor,
        textColor = helpconfig.textColor,
        textFont = "helpMenu_buttonFont",
        textFontSize = 26
    })
    SendButton.DoClick = function()
        --Create bug packet

        local packet = {}
        packet.action = tostring(textBox:GetValue())
        packet.conlog = tostring(textBox2:GetValue())

        local str_maxsize = 32000

        if string.len(packet.action) == 0 or string.len(packet.conlog) == 0 then 
            Derma_Message(helpconfig.loc.sendFail_incomplete, helpconfig.loc.sendFail_title, helpconfig.loc.sendFail_acceptButton)
            return
        end --Not allowed

        if string.len(packet.action) > str_maxsize or string.len(packet.conlog) > str_maxsize then 
            Derma_Message(helpconfig.loc.sendFail_tooLarge, helpconfig.loc.sendFail_title, helpconfig.loc.sendFail_acceptButton)
            return
        end --Not allowed

        net.Start("helpMenuBug")
        net.WriteString( packet.action )
        net.WriteString( packet.conlog )
        net.SendToServer()

        frame:Close()
    end

end

function helpMenu_AddButton(name, parent)
    local but = parent.addButton({
        tall = 40,
        text = name,
        color = buttColor,
        backColor = helpconfig.backColor,
        textColor = helpconfig.textColor,
        textFont = "helpMenu_buttonFont"
    })

    return but
end

function helpMenuTab.show(tabName)

    if helpMenuTab.tabList[tabName]:IsVisible() == true then return end

    for t,v in pairs(helpMenuTab.tabList) do
        helpMenuTab.tabList[t]:SetVisible(false)
    end

    helpMenuTab.tabList[tabName]:SetVisible(true)
end

--Ui Drawing:

function qlibui_addSidePanel(param)
    --needed: param.parent
    param.pos = param.pos or "left" --"left" or "right"
    param.width = param.width  or 150
    param.gripWidth = param.gripWidth or 2
    param.grip = param.grip or false
    param.spacing = param.spacing or 5
    param.addTopSpacer = param.addTopSpacer or false
    param.backColor = param.backColor or Color(32, 32, 32)
    param.gripColor = param.gripColor or Color(228, 100, 75)

    local pnl = vgui.Create("DPanel", param.parent)

    pnl:SetSize(param.width, param.parent:GetTall() - (param.parent.topBarSize + 1))

    if (param.pos == "left") then
        pnl:SetPos(1, param.parent.topBarSize)
    else
        pnl:SetPos(param.parent:GetWide() - param.width - 1, param.parent.topBarSize)
    end
    pnl.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, param.backColor)
    end

    
    local gripPanel = vgui.Create("DPanel", param.parent)

    gripPanel:SetSize(param.gripWidth, param.parent:GetTall() - (param.parent.topBarSize + 1))
    
    if (param.pos == "left") then
        gripPanel:SetPos(1 + param.width, param.parent.topBarSize)
    else
        gripPanel:SetPos(param.parent:GetWide() - param.width - 1, param.parent.topBarSize)
    end

    gripPanel.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, param.gripColor)
    end

    local item_list = vgui.Create("DPanelList", pnl)

    item_list:SetPos(0, 0)
    item_list:SetSize(pnl:GetWide(), pnl:GetTall())
    item_list:EnableVerticalScrollbar(true)
    item_list:SetSpacing(param.spacing)

    pnl.addPanel = function(height)
        local pan = vgui.Create("DPanel")
        pan:SetHeight(height)
        pan.Paint = function(self, w, h)
        end

        item_list:AddItem(pan)

        return pan
    end

    if (param.addTopSpacer) then
        pnl.addSpacer(0)
    end

    pnl.getItemList = function()
        return item_list
    end

    pnl.addButton = function(param)
        param.parent = item_list
        local ret = qlibui_addButton(param)
        item_list:AddItem(ret)
        return ret
    end

    --Create child frame to ease the positioning of the remaining panels

    childPanel = vgui.Create("DPanel", param.parent)

    childPanel:SetSize(param.parent:GetWide() - param.width - 2 - param.gripWidth, param.parent:GetTall() - (param.parent.topBarSize + 1))
    
    if (param.pos == "left") then
        childPanel:SetPos(1 + param.gripWidth + param.width, param.parent.topBarSize)
    else
        childPanel:SetPos(1, param.parent.topBarSize)
    end

    childPanel.Paint = function(self, w, h)
    end

    pnl.getChildPanel = function()
        return childPanel
    end


    return pnl
end

function qlibui_createwindow(param)
    local frame = vgui.Create("DFrame")

    param.topColor = param.topColor or Color(228, 100, 75)
    param.backColor = param.backColor or Color(32, 32, 32)
    param.title = param.title or "set me"
    param.titleColor = param.titleColor or Color(255, 255, 255)
    param.titleFontSize = param.titleFontSize or 24
    param.titleHeight = param.titleHeight or 5
    frame.topBarSize = param.topBarSize or 32
    param.icon = param.icon or false
    if param.icon then
        param.iconMat = param.iconMat or Material("icon16/cake.png")
        param.iconSize = param.iconSize or frame.topBarSize
        iconPos = math.floor((frame.topBarSize - param.iconSize) / 2)
    end

    
    if not param.titleFont then
        surface.CreateFont("ui_titleFont", {
            font = "Roboto",
            size = 24
        })
        param.titleFont = "ui_titleFont"
    end

    frame:ShowCloseButton(false)
    frame:SetTitle("")
    frame:SetSize(param.width, param.height)
    if param.anim then

        --frame:SetPos((ScrW() / 2 - param.width / 2), (ScrH() / 2 - param.height / 2) + ScrH())
        --frame:MoveTo(ScrW() / 2 - param.width / 2, ScrH() / 2 - param.height / 2, 0.6, 0.1, 0.6)

        frame:SetPos((ScrW() / 2 - param.width / 2) - ScrW(), (ScrH() / 2 - param.height / 2))
        frame:MoveTo(ScrW() / 2 - param.width / 2, ScrH() / 2 - param.height / 2, 0.6, 0.1, 0.6)
    else
        frame:Center()
    end
    frame:SetVisible(true)
    frame:SetSizable(false)
    frame:SetDraggable(true)
    frame:MakePopup()

    frame.Paint = function(self, w, h)
        qlibui_drawrect(0, 0, 0, w, h, param.backColor)
        qlibui_drawrect(0, 0, 0, w, frame.topBarSize, param.topColor)
        surface.SetFont(param.titleFont)
        surface.SetTextColor(param.titleColor.r, param.titleColor.g, param.titleColor.b)
        
        if param.icon then
            surface.SetDrawColor(255,255,255)
            surface.SetMaterial(param.iconMat)
            surface.DrawTexturedRect(iconPos, iconPos, param.iconSize, param.iconSize)
            surface.SetTextPos(frame.topBarSize + 3, param.titleHeight)
        else
            surface.SetTextPos(param.titleHeight + 2, param.titleHeight)
        end

        surface.DrawText(param.title)
    end

    local unload = qlibui_addFrameTopButton({
        parent = frame,
        text = "X",
        textFont = param.closeButtonFont or "DermaDefault"
    })
    unload.DoClick = function()
        frame:Close()
    end
    return frame
end

function qlibui_addFrameTopButton(param)
    --needed param.parent
    param.width = param.width or 46
    param.sep = param.sep or 0
    param.text = param.text or "set me"
    param.textColor = param.textColor or Color(255, 255, 255)
    param.hoverColor = param.hoverColor or Color(211, 47, 47)

    if not param.textFont then
        surface.CreateFont("ui_topFramButFont", {
            font = "Roboto",
            size = 20
        })
        param.textFont = "ui_topFramButFont"
    end
    
    local button = vgui.Create('DButton', param.parent)

    local animValue = 0

    button:SetSize(param.width, param.parent.topBarSize - 2)
    button:SetPos(param.parent:GetWide() - button:GetWide() - 1 - param.sep, 1)
    button:SetText(param.text)
    button:SetFont(param.textFont)
    button:SetTextColor(param.textColor)
    button.Paint = function(self, w, h)
        if button:IsHovered() then
            animValue = Lerp(0.05, animValue, 255)
        else
            animValue = Lerp(0.05, animValue, 0)
        end
        draw.RoundedBox(0, 0, 0, w, h, Color(param.hoverColor.r, param.hoverColor.g, param.hoverColor.b, animValue))
    end

    return button
end

function qlibui_addButton(param)
    --needed param.parent
    local but = vgui.Create("DButton", param.parent)

    param.posX = param.posX or 0
    param.posY = param.posY or 0
    param.width = param.width or param.parent:GetWide()
    param.tall = param.tall or 32
    param.text = param.text or "set me"
    param.textColor = param.textColor or Color(255, 255, 255)
    param.textHeight = param.textHeight or 4
    param.color = param.color or Color(228, 100, 75)
    param.backColor = param.backColor or Color(64, 64, 64)

    if not param.textFont then
        surface.CreateFont("ui_buttonFont", {
            font = "Roboto",
            size = 16
        })
        param.textFont = "ui_buttonFont"
    end

    local animValue = 0

    but:SetSize(param.width, param.tall)
    but:SetPos(param.posX, param.posY)
    but:SetText("")

    but.Paint = function(self, w, h)
        if but:IsHovered() then
            animValue = Lerp(0.1, animValue, w - 1)
        else
            animValue = Lerp(0.1, animValue, 1)
        end
        qlibui_drawrect(0, 0, 0, w, h, param.backColor)
        draw.RoundedBox(0, 1, 1, 2, h - 2, param.color)
        draw.RoundedBox(0, 1, 1, animValue, h - 2, param.color)
        draw.DrawText(param.text, param.textFont, w / 2, param.textHeight, param.textColor, TEXT_ALIGN_CENTER)
    end

    return but
end

function qlibui_drawrect(r, x, y, l, h, color)
    draw.RoundedBox(r, x, y, l, h, Color(0, 0, 0))
    draw.RoundedBox(r, x + 1, y + 1, l - 2, h - 2, color)
end



net.Receive("helpMenuShow", function()
    helpMenu()
end)

net.Receive("helpMenuBugRx", function()
    local logId = net.ReadString()
    LocalPlayer():ConCommand("say \"".. helpconfig.loc.bugReportSent_01 .. logId .. "\"")
end)

concommand.Add(helpconfig.consoleCmd, function(ply)
    helpMenu()
end)

hook.Add("PlayerBindPress", "helpMenuShowOnKey", function(ply, bind, pressed) --bind key to F1
	if helpconfig.bindKeyEnabled and helpconfig.bindKey and bind == helpconfig.bindKey then
		helpMenu()
    end
end)

hook.Add("InitPostEntity","helpMenuShowOnJoin", function()
    if helpconfig.showOnJoin then 
        helpMenu() 
    end
end)