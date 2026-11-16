--[[
  Lave mortelle
  Élimine tout joueur qui touche la lave du cratère du volcan.

  Emplacement : Workspace > Ile > Volcan > Lave > LaveMortelle (Script)
  Statut      : Terminé  |  Auteur : Claude Code  |  Date : 2026-11-13
  (Fichier généré depuis scripts.json - modifier scripts.json puis relancer tools/sync-scripts.ps1)
]]
-- Lave mortelle : tout joueur qui touche la lave est éliminé
local lave = script.Parent

lave.Touched:Connect(function(hit)
	local humanoid = hit.Parent and hit.Parent:FindFirstChildOfClass("Humanoid")
	if humanoid and humanoid.Health > 0 then
		humanoid.Health = 0
	end
end)
