-- Globals Section
updateInterval = 1.0; -- How often the OnUpdate code will run (in seconds)

-- Functions Section
function vTrakr_OnUpdate(self, elapsed)
  local time = GetTime();
  -- self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed; 	

  if (self.TimeSinceLastUpdate < time) then
    print("im trackin dat v"); 

    self.TimeSinceLastUpdate = time + updateInterval;
  end
end


function vTrakr_OnLoad() 
  self.TimeSinceLastUpdate = 0;
  self.RegisterForDrag("LeftButton");

  print("vTrakr Loaded"); 
end