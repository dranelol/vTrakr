-- Globals Section
updateInterval = 1.0; -- How often the OnUpdate code will run (in seconds)
TimeSinceLastUpdate = 0.0;
unitCounter=0;
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
			for i = 1, GetNumGroupMembers() do 
				--
				if(checkIfTank("raid"..i) == true) then
					--print("found a tank: ".."raid"..i);
					--print(UnitName("raid"..i));
					local playerName = select(1,UnitName("raid"..i));
					local raidUnit = "raid"..i;
					local Vengeance = select(15, UnitBuff(raidUnit, "Vengeance"));
					local value = Vengeance or 0;
					
					print("vengeance of "..playerName.." is: "..value);
					local helloFS = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
					helloFS:SetPoint("CENTER");
					helloFS:SetText("gooby");

				end
			end
		end


		TimeSinceLastUpdate = 0;
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



function vTrakr_OnEvent(self,...)

end


