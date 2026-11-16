--[[
  Fusion anti-lag (maisons et arbres)
  Réduit le lag : fusionne les pièces d'un modèle (maison, arbre) par groupe de matériau + couleur avec UnionAsync. L'apparence est conservée. A fait passer l'île de 25 451 à 8 768 pièces.

  Emplacement : ServerStorage > FusionMaison (ModuleScript)
  Statut      : Terminé  |  Auteur : Claude Code  |  Date : 2026-11-13
  (Fichier généré depuis scripts.json - modifier scripts.json puis relancer tools/sync-scripts.ps1)
]]
-- Fusionne les pièces d'une maison par groupe (matériau + couleur) pour réduire le lag
return function(house)
	local groups = {}
	for _, p in ipairs(house:GetChildren()) do
		if p.ClassName == "Part" then
			local key = p.Material.Name .. "|" .. p.Color:ToHex() .. "|" .. p.Transparency .. "|" .. p.Reflectance
			groups[key] = groups[key] or {}
			table.insert(groups[key], p)
		end
	end
	local before, after = 0, 0
	for _, list in pairs(groups) do
		before += #list
		if #list > 1 then
			local first = table.remove(list, 1)
			local ok, u = pcall(function() return first:UnionAsync(list) end)
			if ok and u then
				u.UsePartColor = true
				u.Color = first.Color
				u.Material = first.Material
				u.Reflectance = first.Reflectance
				u.Transparency = first.Transparency
				u.CollisionFidelity = Enum.CollisionFidelity.Box
				u.Anchored = true
				u.CastShadow = first.Material ~= Enum.Material.Wood and first.Material ~= Enum.Material.Glass
				u.Name = first.Material.Name
				u.Parent = house
				first:Destroy()
				for _, p in ipairs(list) do p:Destroy() end
				after += 1
			else
				after += #list + 1
			end
		else
			after += 1
		end
	end
	return before, after
end
