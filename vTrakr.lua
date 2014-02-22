-- Globals Section
updateInterval = 1.0; -- How often the OnUpdate code will run (in seconds)

-- Functions Section
function vTrakr_OnUpdate(self, elapsed)
  self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed; 	

  if (self.TimeSinceLastUpdate > updateInterval) then
    print("im trackin dat v"); 

    self.TimeSinceLastUpdate = 0;
  end
end


function vTrakr_OnLoad() 
  print("vTrakr Loaded"); 
end