--[[
  Bâtiments style SNK (maisons à colombages + église)
  Module qui construit des maisons médiévales à colombages (rez-de-chaussée en pierre, étages en torchis, toits pentus, cheminées) et une église avec clocher. Utilisé pour la cité fortifiée et les fermes.

  Emplacement : ServerStorage > Batiments (ModuleScript)
  Statut      : Terminé  |  Auteur : Claude Code  |  Date : 2026-11-13
  (Fichier généré depuis scripts.json - modifier scripts.json puis relancer tools/sync-scripts.ps1)
]]
local O = require(script.Parent.IleOutils)
local B = {}
local PLASTER = { Color3.fromRGB(236, 226, 200), Color3.fromRGB(226, 214, 186), Color3.fromRGB(240, 232, 214), Color3.fromRGB(214, 200, 170) }
local ROOF = { Color3.fromRGB(168, 72, 48), Color3.fromRGB(150, 60, 42), Color3.fromRGB(120, 70, 50), Color3.fromRGB(180, 95, 60), Color3.fromRGB(95, 85, 80) }
local TIMBER = Color3.fromRGB(66, 44, 30)
local STONEB = Color3.fromRGB(150, 145, 135)
local GLASS = Color3.fromRGB(60, 80, 100)
local FH = 10 -- hauteur d'étage

-- cf : centre au sol, face avant vers -Z (la rue)
function B.maison(cf, w, d, floors, rng, parent)
	local mdl = Instance.new("Model"); mdl.Name = "Maison"
	local function P(c, size, props)
		props = props or {}
		props.CFrame = cf * c; props.Size = size; props.Parent = mdl
		return O.part(props)
	end
	local plaster = PLASTER[rng:NextInteger(1, #PLASTER)]
	local H = floors * FH
	-- rez-de-chaussée en pierre, étages en torchis
	P(CFrame.new(0, FH / 2 - 0.5, 0), Vector3.new(w, FH + 1, d), { Material = Enum.Material.Slate, Color = STONEB })
	if floors > 1 then
		P(CFrame.new(0, FH + (H - FH) / 2, 0), Vector3.new(w + 1, H - FH, d + 1), { Material = Enum.Material.Plaster, Color = plaster })
	end
	-- colombages (côté rue uniquement, pour alléger les 800+ maisons)
	for _, side in ipairs({ -1 }) do
		local zf = side * ((d + 1) / 2 + 0.25)
		for f = 1, floors - 1 do
			local y0 = FH * f
			P(CFrame.new(0, y0 + 0.4, zf), Vector3.new(w + 1.6, 0.8, 0.6), { Material = Enum.Material.Wood, Color = TIMBER })
			P(CFrame.new(0, y0 + FH - 0.4, zf), Vector3.new(w + 1.6, 0.8, 0.6), { Material = Enum.Material.Wood, Color = TIMBER })
			local nPosts = math.max(2, math.floor(w / 5))
			for k = 0, nPosts do
				local x = -w / 2 - 0.2 + k * (w + 0.4) / nPosts
				P(CFrame.new(x, y0 + FH / 2, zf), Vector3.new(0.8, FH, 0.6), { Material = Enum.Material.Wood, Color = TIMBER })
			end
			-- croix de Saint-André sur un panneau
			local cx = -w / 2 + (w / nPosts) / 2
			local diag = math.sqrt((w / nPosts) ^ 2 + FH ^ 2)
			local ang = math.atan2(FH, w / nPosts)
			P(CFrame.new(cx, y0 + FH / 2, zf) * CFrame.Angles(0, 0, ang), Vector3.new(diag - 1, 0.6, 0.5), { Material = Enum.Material.Wood, Color = TIMBER })
			P(CFrame.new(cx, y0 + FH / 2, zf) * CFrame.Angles(0, 0, -ang), Vector3.new(diag - 1, 0.6, 0.5), { Material = Enum.Material.Wood, Color = TIMBER })
			-- fenêtres
			for k = 1, nPosts - 1 do
				local x = -w / 2 - 0.2 + (k + 0.5) * (w + 0.4) / nPosts
				if x < w / 2 - 1 then
					P(CFrame.new(x, y0 + FH / 2 + 0.5, zf), Vector3.new(2.2, 3.4, 0.4), { Material = Enum.Material.Glass, Color = GLASS, Reflectance = 0.2 })
				end
			end
		end
	end
	-- porte
	P(CFrame.new(rng:NextNumber(-w / 4, w / 4), 3.5, -d / 2 - 0.3), Vector3.new(3.5, 7, 0.6), { Material = Enum.Material.WoodPlanks, Color = Color3.fromRGB(90, 55, 35) })
	-- toit à pignon, pente raide
	local rh = w * rng:NextNumber(0.65, 0.85)
	local rc = ROOF[rng:NextInteger(1, #ROOF)]
	local half = (w + 3) / 2
	P(CFrame.new(-half / 2, H + rh / 2, 0) * CFrame.Angles(0, math.rad(90), 0), Vector3.new(d + 3, rh, half), { Class = "WedgePart", Material = Enum.Material.Slate, Color = rc })
	P(CFrame.new(half / 2, H + rh / 2, 0) * CFrame.Angles(0, math.rad(-90), 0), Vector3.new(d + 3, rh, half), { Class = "WedgePart", Material = Enum.Material.Slate, Color = rc })
	-- cheminée
	if rng:NextNumber() < 0.7 then
		P(CFrame.new(rng:NextNumber(-w / 4, w / 4), H + rh * 0.7, rng:NextNumber(-d / 4, d / 4)), Vector3.new(2.4, rh * 0.8, 2.4), { Material = Enum.Material.Brick, Color = Color3.fromRGB(130, 80, 60) })
	end
	mdl.Parent = parent
	return mdl
end

-- Clocher / église
function B.eglise(cf, parent)
	local mdl = Instance.new("Model"); mdl.Name = "Eglise"
	local function P(c, size, props)
		props = props or {}
		props.CFrame = cf * c; props.Size = size; props.Parent = mdl
		props.Material = props.Material or Enum.Material.Slate
		props.Color = props.Color or Color3.fromRGB(190, 180, 160)
		return O.part(props)
	end
	-- nef
	P(CFrame.new(0, 14, 20), Vector3.new(30, 28, 50))
	P(CFrame.new(-8.5, 28 + 9, 20) * CFrame.Angles(0, math.rad(90), 0), Vector3.new(52, 18, 17), { Class = "WedgePart", Color = Color3.fromRGB(70, 75, 85) })
	P(CFrame.new(8.5, 28 + 9, 20) * CFrame.Angles(0, math.rad(-90), 0), Vector3.new(52, 18, 17), { Class = "WedgePart", Color = Color3.fromRGB(70, 75, 85) })
	-- vitraux
	for k = -1, 1 do
		for _, s in ipairs({ -15.3, 15.3 }) do
			P(CFrame.new(s, 16, 20 + k * 14), Vector3.new(0.6, 12, 4), { Material = Enum.Material.Glass, Color = Color3.fromRGB(80, 110, 170), Reflectance = 0.2 })
		end
	end
	-- tour
	P(CFrame.new(0, 40, -12), Vector3.new(18, 80, 18))
	P(CFrame.new(0, 80.75, -12), Vector3.new(21, 1.5, 21), { Color = Color3.fromRGB(150, 140, 122) })
	-- ouvertures du beffroi
	for _, c in ipairs({ CFrame.new(0, 70, -21.2), CFrame.new(0, 70, -2.8), CFrame.new(-9.2, 70, -12) * CFrame.Angles(0, math.rad(90), 0), CFrame.new(9.2, 70, -12) * CFrame.Angles(0, math.rad(90), 0) }) do
		P(c, Vector3.new(6, 10, 0.6), { Material = Enum.Material.SmoothPlastic, Color = Color3.fromRGB(25, 25, 28) })
	end
	-- cloche
	P(CFrame.new(0, 69, -12), Vector3.new(5, 5, 5), { Shape = Enum.PartType.Ball, Material = Enum.Material.Metal, Color = Color3.fromRGB(180, 140, 60) })
	-- flèche en escalier
	local y, s = 81.5, 16
	for i = 1, 7 do
		local h = 6
		P(CFrame.new(0, y + h / 2, -12), Vector3.new(s, h, s), { Color = Color3.fromRGB(70, 75, 85) })
		y += h; s -= 2.1
	end
	P(CFrame.new(0, y + 3, -12), Vector3.new(0.6, 6, 0.6), { Material = Enum.Material.Metal, Color = Color3.fromRGB(180, 150, 70) })
	P(CFrame.new(0, y + 4.5, -12), Vector3.new(3, 0.6, 0.6), { Material = Enum.Material.Metal, Color = Color3.fromRGB(180, 150, 70) })
	mdl.Parent = parent
	return mdl
end

return B
