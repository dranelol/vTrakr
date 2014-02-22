-- Globals Section
updateInterval = 1.0; -- How often the OnUpdate code will run (in seconds)
TimeSinceLastUpdate = 0.0;

-- Functions Section
function vTrakr_OnUpdate(self, elapsed)
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed; 	

	if (TimeSinceLastUpdate > updateInterval) then
		print("im trackin dat v"); 

		if(IsInRaid() == true)
			for i = 1, GetNumRaidMembers() do 
				print(UnitName("raid"..i));
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