-- Globals Section
updateInterval = 1.0; -- How often the OnUpdate code will run (in seconds)
TimeSinceLastUpdate = 0.0;

-- Functions Section
function vTrakr_OnUpdate(self, elapsed)
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed; 	

	if (TimeSinceLastUpdate > updateInterval) then
		--print("im trackin dat v"); 

		if(IsInRaid() == true) then
			--print("sup im in raid");
			for i = 1, GetNumGroupMembers() do 
				--print(UnitName("raid"..i));
				if(checkIfTank("raid"..i) == true) then
					print("found a tank: ".."raid"..i);
				end
			end
		end


		TimeSinceLastUpdate = 0;
	end
end


function vTrakr_OnLoad(self)
	self:RegisterForDrag("LeftButton");
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
	local guid = UnitGUID(uidName);
	local id = GetInspectSpecialization(guid);
	print("guid of "..uidName.." is "..guid);
	print("specinfo of guid: "..guid.. " "..id);

	return true;
end