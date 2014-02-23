local updateInterval = 1.0; 
local TimeSinceLastUpdate = 0.0;
local unitCounter=0;
-- 1d array of bar frames to draw
local vBars = {}
-- set of vengeance values; key = player name, value = (vengeance, currentRaidID)
local vTable = {}

local function sortVfunction(a, b)
	return vTable[a][0] > vTable[b][0]
end

-- mapping of spec name onto id
local specs=
{
 [250]="Blood", [251]="Frost", [252]="Unholy", [102]="Balance", [103]="Feral",
 [104]="Guardian", [105]="Restoration", [253]="Beast Mastery", [254]="Marksmanship",
 [255]="Survival", [62]="Arcane", [63]="Fire", [64]="Frost", [268]="Brewmaster",
 [270]="Mistweaver", [269]="Windwalker", [65]="Holy", [66]="Protection",
 [67]="Retribution", [256]="Discipline", [257]="Holy", [258]="Shadow",
 [259]="Assassination", [260]="Combat", [261]="Subtlety", [262]="Elemental",
 [263]="Enhancement", [264]="Restoration", [265]="Affliction", [266]="Demonology",
 [267]="Destruction", [71]="Arms", [72]="Fury", [73]="Protection",
 [0]="Unknown Spec"
}
local VENGEANCE_SPELL_ID = 93099;
-- Functions Section
function vTrakr_OnUpdate(self, elapsed)
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed; 	

	if (TimeSinceLastUpdate > updateInterval) then
		--print("im trackin dat v"); 
		--NotifyInspect(actualUnit(unitCounter))
		if(IsInRaid() == true) then
			--print("sup im in raid");
			
			-- reset vengeance table
			ResetVengeance();
			-- update vengeance
			UpdateVengeance();

			sort(vTable, sortVfunction);

			-- clear bars
			ClearAll();
			-- add bars
			DrawBars(self);
	
		end

		TimeSinceLastUpdate = 0;
	end
end

function DrawBars(self)
	local i=0;
	for j,k in pairs(vTable) do
 		--print(j, k[0], k[1]);
 		
 		local fontString = self:CreateFontString(nil, "OVERLAY", "GameTooltipText");
		fontString:SetPoint("TOPLEFT", 0, 0 - i*10);
		fontString:SetText(j.." "..k[0].." "..k[1]);

		vBars[i] = fontString;
		i=i+1;

 	end

end

function ResetVengeance()
	for j,k in pairs(vTable) do
 		vTable[j] = nil;
 	end
end

-- reset all graphical bars
function ClearAll()
	for key, item in pairs(vBars) do
		vBars[key]:Hide();
		vBars[key] = nil;
	end
end
-- I would like to update this functionality to keep bars if possible, and only update what needs updating
-- instead of clearing everything then rebuilding it
function UpdateVengeance()

	for i = 1, GetNumGroupMembers() do
		if(checkIfTank("raid"..i) == true) then
			--print("found a tank: ".."raid"..i);
			--print(UnitName("raid"..i));
			local playerName = select(1,UnitName("raid"..i));
			local raidUnit = "raid"..i;
			local Vengeance = select(15, UnitBuff(raidUnit, "Vengeance"));
			local value = Vengeance or 0;
			local updateUnit = {};

			updateUnit[0] = value;
			updateUnit[1] = playerName;

		 	vTable[raidUnit] = updateUnit;

			--print("vengeance of "..playerName.." is: "..value);
			--local fontString = self:CreateFontString(nil, "OVERLAY", "GameTooltipText");
			--fontString:SetPoint("TOPLEFT", 0, 0 - i*10);
			--fontString:SetText("gooby");

		end
	end
end



function vTrakr_OnLoad(self)

	self.text = self:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	self:RegisterForDrag("LeftButton");
	--self:RegisterEvent("INSPECT_READY");
	self.unit=0;
	TimeSinceLastUpdate = 0.0;
	print("vTrakr Loaded"); 
	print(TimeSinceLastUpdate);
	self:RegisterEvent("GROUP_ROSTER_CHANGED");
	self:RegisterEvent("PARTY_MEMBERS_CHANGED");
	self:RegisterEvent("RAID_ROSTER_UPDATE");
	self:RegisterEvent("GROUP_ROSTER_UPDATE");
	self.BarList = CreateFrame("Frame", "vBarList", self.Anchor);
	self.BarList.barsShown = 0;

end

function vTrakr_OnDragStart(self, button)
	self:StartMoving();
end

function vTrakr_OnDragStop(self, button)
	self:StopMovingOrSizing();
end

function checkIfTank(uidName)
	local role = UnitGroupRolesAssigned(uidName);
	if(role == "TANK") then
		return true;
	else 
		return false;
	end
end



function vTrakr_OnEvent(self,event,...)
	print("event logged: "..event);
	-- loop through indexes 
	

	
end



