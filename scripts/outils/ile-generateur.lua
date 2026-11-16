--[[
  Générateur de terrain de l'île
  Module qui calcule le relief de l'île géante (sans eau ni plage, bords en falaise) : grand plateau aplati pour la cité fortifiée (mur de 700 studs de rayon), forêt d'arbres géants, champs, volcan, et le matériau de chaque zone.

  Emplacement : ServerStorage > IleGenerateur (ModuleScript)
  Statut      : Terminé  |  Auteur : Claude Code  |  Date : 2026-11-13
  (Fichier généré depuis scripts.json - modifier scripts.json puis relancer tools/sync-scripts.ps1)
]]
local M = {}
M.R = 1750
M.FLOOR = -60
M.VIDE = -25                      -- en dessous : pas de terrain (pas de plage, bord en falaise)
M.VILLE = Vector2.new(0, 0)       -- centre de la cité fortifiée
M.VILLE_R = 700                   -- rayon du mur
M.VILLE_H = 40                    -- hauteur du sol de la cité
M.VOLCAN = Vector2.new(1150, -950)
M.FORET = Vector2.new(-1180, -760)
M.FORET_R = 420
M.CHAMPS = { x0 = -650, x1 = 650, z0 = 830, z1 = 1450 }

local function n(x, z, s, seed) return math.noise(x / s, z / s, seed or 3.7) end

function M.villeWeight(x, z)
	local d = (Vector2.new(x, z) - M.VILLE).Magnitude
	return math.clamp(1 - (d - (M.VILLE_R + 60)) / 140, 0, 1)
end

function M.height(x, z)
	local d = math.sqrt(x * x + z * z) / M.R
	d = d + n(x, z, 520, 1.3) * 0.07
	local h
	if d < 0.97 then
		h = 40 + n(x, z, 260, 7.1) * 22 * math.min(1, (0.97 - d) * 6)
	else
		h = 40 - (d - 0.97) * 3000       -- falaise abrupte
	end
	local dv = (Vector2.new(x, z) - M.VOLCAN).Magnitude
	h = h + 260 * math.exp(-(dv / 260) ^ 2) * (1 + n(x, z, 80, 9.9) * 0.08)
	h = h - 90 * math.exp(-(dv / 50) ^ 2)
	local w = M.villeWeight(x, z)
	h = h * (1 - w) + M.VILLE_H * w
	return h, dv, w, d
end

function M.material(x, z, h, dv, w, d)
	if d > 0.955 then return Enum.Material.Rock end            -- bord de falaise
	if dv < 75 and h > 180 then return Enum.Material.CrackedLava end
	if dv < 190 and h > 170 then return Enum.Material.Basalt end
	if dv < 340 and h > 110 then return Enum.Material.Rock end
	if w > 0.5 then return Enum.Material.Grass end
	if (Vector2.new(x, z) - M.FORET).Magnitude < M.FORET_R then return Enum.Material.LeafyGrass end
	return Enum.Material.Grass
end

return M
