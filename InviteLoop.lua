-- Author      : outroot
-- Create Date : 1/9/2015 3:08:41 PM

-- Globals Section
InviteLoop_Start = false;
InviteLoop_UpdateInterval = 10.0;
InviteLoop_InviteName = "";
InviteLoop_DoLog = false;

-- Functions Section
function InviteLoop_Log(msg)
  if InviteLoop_DoLog then
    DEFAULT_CHAT_FRAME:AddMessage(msg);
  end
end

function InviteLoop_OnUpdate(self, elapsed)
  if self.TimeSinceLastUpdate == nil then
    self.TimeSinceLastUpdate = 0.0;
  end
  
  self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed; 	

  if (self.TimeSinceLastUpdate > InviteLoop_UpdateInterval) then
    if InviteLoop_Start then
      InviteLoop_Log(string.format("|cff6CAEF5InviteLoop: Inviting %s|r", InviteLoop_InviteName));
      _G.InviteUnit(_G.Ambiguate(InviteLoop_InviteName, "none"));
	  end

    self.TimeSinceLastUpdate = 0;
  end
end

SLASH_INVITELOOP1 = '/inviteloop';
function SlashCmdList.INVITELOOP(msg, editbox)
	if InviteLoopFrame:IsShown() then
	  HideUIPanel(InviteLoopFrame);
	else
	  ShowUIPanel(InviteLoopFrame);
	end

 -- local command, rest = msg:match("^(%S*)%s*(.-)$");
 -- if command == 'set' then
 --   InviteLoop_InviteName = rest;
	--DEFAULT_CHAT_FRAME:AddMessage(string.format("Invite name set to \"%s\"", rest));
 -- elseif command == "start" then
 --   InviteLoop_Start = true;
	--DEFAULT_CHAT_FRAME:AddMessage("InviteLoop started");
 -- elseif command == "stop" then
 --   InviteLoop_Start = false;
	--DEFAULT_CHAT_FRAME:AddMessage("InviteLoop stopped");
 -- else
 --   DEFAULT_CHAT_FRAME:AddMessage("----------------");
 --   DEFAULT_CHAT_FRAME:AddMessage("/inviteloop set <name>");
 --   DEFAULT_CHAT_FRAME:AddMessage("/inviteloop start");
 --   DEFAULT_CHAT_FRAME:AddMessage("/inviteloop stop");
 --   DEFAULT_CHAT_FRAME:AddMessage("----------------");
 -- end
end

function StartButton_OnClick()
  if StartButton:GetText() == "Start" then
	  InviteLoop_InviteName = InviteeEditBox:GetText();
	  InviteLoop_UpdateInterval = IntervalEditBox:GetNumber() -- tonumber(IntervalEditBox:GetText());
    InviteLoop_Start = true;
    InviteLoop_DoLog = LogCheckButton:GetChecked()
    StartButton:SetText("Stop");
    InviteLoop_Log("|cff6CAEF5InviteLoop: Started.|r");
  else
    InviteLoop_Start = false;
    StartButton:SetText("Start");
    InviteLoop_Log("|cff6CAEF5InviteLoop: Stopped.|r");
  end
end

local __first_show_done = false;
function InviteLoopFrame_OnShow()
  if __first_show_done then
    return
  else
    __first_show_done = true
  end

  InviteeEditBox:SetText(InviteLoop_InviteName);
  IntervalEditBox:SetNumber(InviteLoop_UpdateInterval);
end

local f = CreateFrame("frame")
--f:RegisterEvent("ADDON_LOADED");
--function f:OnEvent(event, arg1)
--  if event == "ADDON_LOADED" then
--    --if InviteLoop_UpdateInterval == nil then
--	   -- InviteLoop_UpdateInterval = 10;
--    --end
--    --if InviteLoop_InviteName == nil then
--	   -- InviteLoop_InviteName = "";
--    --end

--    DEFAULT_CHAT_FRAME:AddMessage(arg1);
--  end
--end
--f:SetScript("OnEvent", f.OnEvent);
f:SetScript("OnUpdate", InviteLoop_OnUpdate);

StaticPopup1:HookScript("OnShow", function(self, button)
  if InviteLoop_Start then
    if not (string.find(StaticPopup1Text:GetText(), "You are queued for Ashran") == nil) then
      --StaticPopup1Button1:Click()
	  StaticPopup1:Hide()
	end
  end
end)
StaticPopup2:HookScript("OnShow", function(self, button)
  if InviteLoop_Start then
    if not (string.find(StaticPopup2Text:GetText(), "You are queued for Ashran") == nil) then
      StaticPopup2:Hide()
	end
  end
end)
StaticPopup3:HookScript("OnShow", function(self, button)
  if InviteLoop_Start then
    if not (string.find(StaticPopup3Text:GetText(), "You are queued for Ashran") == nil) then
      StaticPopup3:Hide()
	end
  end
end)
StaticPopup4:HookScript("OnShow", function(self, button)
  if InviteLoop_Start then
    if not (string.find(StaticPopup4Text:GetText(), "You are queued for Ashran") == nil) then
      StaticPopup4:Hide()
	end
  end
end)