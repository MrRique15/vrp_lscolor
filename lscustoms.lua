local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("vrp_lscolor")

local inside = false
local currentpos = nil
local currentgarage = 0

local garages = { 
	--[1] = { locked = false, camera = { x = 936.52, y = -973.89, z = 39.76, heading = 206.36 }, driveout = { x = 938.38, y = -977.67, z = 39.16, heading = 3.70 }, drivein = { x = 938.38, y = -977.67, z = 39.16, heading = 3.70 }, outside = { x = 938.38, y = -977.67, z = 39.16, heading = 3.70 }, inside = { x = 0, y = 0, z = 0, heading = 3.70 }},
	--[2] = { locked = false, camera = { x = 939.11, y = -965.67, z = 39.76, heading = 31.84 }, driveout = { x = 937.2, y = -962.06, z = 39.16, heading = 183.66 }, drivein = { x = 937.2, y = -962.06, z = 39.16, heading = 183.66 }, outside = { x = 937.2, y = -962.06, z = 39.16, heading = 183.66 }, inside = { x = 937.2, y = -962.06, z = 39.16, heading = 183.66 }},
	--[3] = { locked = false, camera = { x = 934.54, y = -968.41, z = 39.8, heading = 120.84 }, driveout = { x = 930.72, y = -970.31, z = 39.16, heading = 273.10 }, drivein = { x = 930.72, y = -970.31, z = 39.16, heading = 273.10 }, outside = { x = 930.72, y = -970.31, z = 39.16, heading = 273.10 }, inside = { x = 930.72, y = -970.31, z = 39.16, heading = 273.10 }},
	--[4] = { locked = false, camera = { x = 960.18, y = -972.98, z = 39.76, heading = 134.97 }, driveout = { x = 957.68, y = -975.37, z = 39.3, heading = 302.10 }, drivein = { x = 957.68, y = -975.37, z = 39.3, heading = 302.10 }, outside = { x = 957.68, y = -975.37, z = 39.3, heading = 302.10 }, inside = { x = 957.68, y = -975.37, z = 39.3, heading = 302.10 }},
	--[5] = { locked = false, camera = { x = 115.75, y = 6624.31, z = 31.8, heading = 74.49 }, driveout = { x = 111.02, y = 6626.27, z = 31.19, heading = 224.40 }, drivein = { x = 111.02, y = 6626.27, z = 31.19, heading = 224.40 }, outside = { x = 111.02, y = 6626.27, z = 31.19, heading = 224.40 }, inside = { x = 111.02, y = 6626.27, z = 31.19, heading = 224.40 }},
	--[6] = { locked = false, camera = { x = -1163.51, y = -1712.92, z = 4.45, heading = 245.31 }, driveout = { x = -1158.71, y = -1715.5, z = 3.93, heading = 35.83 }, drivein = { x = -1158.71, y = -1715.5, z = 3.93, heading = 35.83 }, outside = { x = -1158.71, y = -1715.5, z = 3.93, heading = 35.83 }, inside = { x = -1158.71, y = -1715.5, z = 3.93, heading = 35.83 }},
	--[7] = { locked = false, camera = { x = -1163.56, y = -1693.21, z = 4.45, heading = 326.79 }, driveout = { x = -1160.21, y = -1688.53, z = 3.93, heading = 123.86 }, drivein = { x = -1160.21, y = -1688.53, z = 3.93, heading = 123.86 }, outside = { x = -1160.21, y = -1688.53, z = 3.93, heading = 123.86 }, inside = { x = -1160.21, y = -1688.53, z = 3.93, heading = 123.86 }},
	[1] = { locked = false, camera = { x = -227.28, y = -1327.96, z = 30.89, heading = 89.70 }, driveout = { x = -222.50, y = -1329.67, z = 30.89, heading = 89.70 }, drivein = { x = -222.50, y = -1329.67, z = 30.89, heading = 89.70 }, outside = { x = -222.50, y = -1329.67, z = 30.89, heading = 89.70 }, inside = { x = -222.50, y = -1329.67, z = 30.89, heading = 89.70 }},
	[2] = { locked = false, camera = { x = -227.10, y = -1321.01, z = 30.89, heading = 89.70 }, driveout = { x = -222.66, y = -1323.13, z = 30.89, heading = 89.70 }, drivein = { x = -222.66, y = -1323.13, z = 30.89, heading = 89.70 }, outside = { x = -222.66, y = -1323.13, z = 30.89, heading = 89.70 }, inside = { x = -222.66, y = -1323.13, z = 30.89, heading = 89.70 }},
	[3] = { locked = false, camera = { x = -216.10, y = -1326.76, z = 30.89, heading = 180.23 }, driveout = { x = -213.42, y = -1319.66, z = 30.89, heading = 180.23 }, drivein = { x = -213.42, y = -1319.66, z = 30.89, heading = 180.23 }, outside = { x = -213.42, y = -1319.66, z = 30.89, heading = 180.23 }, inside = { x = -213.42, y = -1319.66, z = 30.89, heading = 180.23 }}
	--[11] = { locked = false, camera = { x = 1534.04, y = 3534.90, z = 34.93, heading = 33.57 }, driveout = { x = 1534.04, y = 3534.90, z = 34.93, heading = 33.57 }, drivein = { x = 1534.04, y = 3534.90, z = 34.93, heading = 33.57 }, outside = { x = 1534.04, y = 3534.90, z = 34.93, heading = 33.57 }, inside = { x = 1534.04, y = 3534.90, z = 34.93, heading = 33.57 }},
	--[12] = { locked = false, camera = { x = 1579.13, y = 3540.19, z = 35.38, heading = 294.29 }, driveout = { x = 1579.13, y = 3540.19, z = 35.38, heading = 294.29 }, drivein = { x = 1579.13, y = 3540.19, z = 35.38, heading = 294.29 }, outside = { x = 1579.13, y = 3540.19, z = 35.38, heading = 294.29 }, inside = { x = 1579.13, y = 3540.19, z = 35.38, heading = 294.29 }}
}
--[11] = { locked = false, camera = { x = 1534.04, y = 3534.90, z = 34.93, heading = 33.57 }, driveout = { x = 1533.58, y = 3535.48, z = 34.94, heading = 33.57 }, drivein = { x = 1534.82, y = 3533.45, z = 34.96, heading = 33.57 }, outside = { x = 1534.38, y = 3535.35, z = 34.93, heading = 33.57 }, inside = { x = 1533.91, y = 3534.60, z = 34.97, heading = 33.57 }}


local Menu = SetMenu()
local myveh = {}

local gameplaycam = nil
local cam = nil

local function f(n)
	return (n+0.00001)
end

local function round(num,idp)
	if idp and idp > 0 then
		local mult = 10^idp
		return math.floor(num*mult+0.5)/mult
	end
	return math.floor(num+0.5)
end

local LSCOLORMenu = Menu.new("United Color","CATEGORIES",0.16,0.13,0.24,0.36,0,{255,255,255,255})
LSCOLORMenu.config.pcontrol = false

local function AddMod(mod,parent,header,name,info,stock)
	local veh = myveh.vehicle
	SetVehicleModKit(veh,0)
	local desconto = emP.AmamosOAga()
	if (GetNumVehicleMods(veh,mod) ~= nil and GetNumVehicleMods(veh,mod) > 0) or mod == 18 or mod == 22 then
		local m = parent:addSubMenu(header,name,info,true)
		if stock then
			local btn = m:addPurchase("Stock")
			btn.modtype = mod
			btn.mod = -1
		end
		if LSCOLOR_Config.prices.mods[mod].startprice then
			local price = LSCOLOR_Config.prices.mods[mod].startprice
			for i = 0, tonumber(GetNumVehicleMods(veh,mod)) -1 do
				local lbl = GetModTextLabel(veh,mod,i)
				if lbl ~= nil then
					local mname = tostring(GetLabelText(lbl))
					if mname ~= "NULL" then
						local btn = m:addPurchase(mname,parseInt((price - (price*desconto))))
						btn.modtype = mod
						btn.mod = i
						price = price + LSCOLOR_Config.prices.mods[mod].increaseby
					end
				end
			end
		else
			for n, v in pairs(LSCOLOR_Config.prices.mods[mod]) do
				btn = m:addPurchase(v.name,parseInt((v.price - (v.price*desconto))))
				btn.modtype = mod
				btn.mod = v.mod
			end
		end
	end
end

local function SetupInsideCam()
	local coords = currentpos.camera
	cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true,2)
	SetCamCoord(cam,coords.x,coords.y,coords.z+1.0)
	coords = currentpos.inside
	PointCamAtCoord(cam,coords.x,coords.y,coords.z)
	SetCamActive(cam,true)
	RenderScriptCams(1,0,cam,0,0)
end

local function DriveInGarage()
	TriggerServerEvent('lockGarage',true,currentgarage)
	SetPlayerControl(PlayerId(),false,256)

	local desconto = emP.AmamosOAga()
	local pos = currentpos
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	LSCOLORMenu.buttons = {}

	if DoesEntityExist(veh) then
		LSCOLORMenu:setTitle("Bennys Body Shop")
		--LSCOLORMenu.title_sprite = "shopui_title_supermod"

		LSCOLORMenu.config.controls = LSCOLOR_Config.menu.controls
		SetIbuttons({
			{GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_back, 0),"Voltar"},
			{GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_select, 0),"Selecionar"},
			{GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_up, 0),"Subir"},
			{GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_down, 0),"Descer"},
			{GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_left, 0),"Esquerda"},
			{GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_right, 0),"Direita"},
		},0)

		LSCOLORMenu:setMaxButtons(LSCOLOR_Config.menu.maxbuttons)
		LSCOLORMenu.config.size.width = f(LSCOLOR_Config.menu.width) or 0.24;
		LSCOLORMenu.config.size.height = f(LSCOLOR_Config.menu.height) or 0.36;

		if type(LSCOLOR_Config.menu.position) == 'table' then
			LSCOLORMenu.config.position = { x = LSCOLOR_Config.menu.position.x, y = LSCOLOR_Config.menu.position.y }
		elseif type(LSCOLOR_Config.menu.position) == 'string' then
			if LSCOLOR_Config.menu.position == "left" then
				LSCOLORMenu.config.position = { x = 0.16, y = 0.13 }
			elseif  LSCOLOR_Config.menu.position == "right" then
				LSCOLORMenu.config.position = { x = 1-0.16, y = 0.13 }
			end
		end

		if type(LSCOLOR_Config.menu.theme) == "table" then
			LSCOLORMenu:setColors(LSCOLOR_Config.menu.theme.text_color,LSCOLOR_Config.menu.theme.stext_color,LSCOLOR_Config.menu.theme.bg_color,LSCOLOR_Config.menu.theme.sbg_color)
		elseif	type(LSCOLOR_Config.menu.theme) == "string" then
			if LSCOLOR_Config.menu.theme == "light" then
				LSCOLORMenu:setColors({ r = 255, g = 255, b = 255, a = 255 },{ r = 0, g = 0, b = 0, a = 255 },{ r = 0, g = 0, b = 0, a = 155 },{ r = 255, g = 255, b = 255, a = 255 })
			elseif LSCOLOR_Config.menu.theme == "darkred" then
				LSCOLORMenu:setColors({ r = 255, g = 255, b = 255, a = 255 },{ r = 0, g = 0, b = 0, a = 255 },{ r = 0, g = 0, b = 0, a = 155 },{ r = 200, g = 15, b = 15, a = 200 })
			elseif LSCOLOR_Config.menu.theme == "bluish" then	
				LSCOLORMenu:setColors({ r = 255, g = 255, b = 255, a = 255 },{ r = 255, g = 255, b = 255, a = 255 },{ r = 0, g = 0, b = 0, a = 100 },{ r = 0, g = 100, b = 255, a = 200 })
			elseif LSCOLOR_Config.menu.theme == "greenish" then	
				LSCOLORMenu:setColors({ r = 255, g = 255, b = 255, a = 255 },{ r = 0, g = 0, b = 0, a = 255 },{ r = 0, g = 0, b = 0, a = 100 },{ r = 0, g = 200, b = 0, a = 200 })
			end
		end

		LSCOLORMenu:addSubMenu("CATEGORIES","categories",nil,false)
		LSCOLORMenu.categories.buttons = {}
		local maxvehhp = 1000
		local damage = 0
		damage = (maxvehhp - GetVehicleBodyHealth(veh))/100
		LSCOLORMenu:addPurchase("Reparar",round(250+150*damage,0),nil)

		SetVehicleModKit(veh,0)	
		myveh.vehicle = veh
		myveh.model = GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()
		myveh.color =  table.pack(GetVehicleColours(veh))
		myveh.extracolor = table.pack(GetVehicleExtraColours(veh))
		myveh.neoncolor = table.pack(GetVehicleNeonLightsColour(veh))
		myveh.smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))
		myveh.plateindex = GetVehicleNumberPlateTextIndex(veh)
		myveh.mods = {}
		for i = 0, 48 do
			myveh.mods[i] = { mod = nil }
		end
		for i,t in pairs(myveh.mods) do 
			if i == 22 or i == 18 then
				if IsToggleModOn(veh,i) then
				t.mod = 1
				else
				t.mod = 0
				end
			elseif i == 23 or i == 24 then
				t.mod = GetVehicleMod(veh,i)
				t.variation = GetVehicleModVariation(veh, i)
			else
				t.mod = GetVehicleMod(veh,i)
			end
		end
		if GetVehicleWindowTint(veh) == -1 or GetVehicleWindowTint(veh) == 0 then
			myveh.windowtint = false
		else
			myveh.windowtint = GetVehicleWindowTint(veh)
		end
		myveh.wheeltype = GetVehicleWheelType(veh)
		myveh.bulletProofTyres = GetVehicleTyresCanBurst(veh)
		local chassis,interior,bumper,fbumper,rbumper = false,false,false,false
		
		for i = 0,48 do
			if GetNumVehicleMods(veh,i) ~= nil and GetNumVehicleMods(veh,i) ~= false and GetNumVehicleMods(veh,i) > 0 then
				if i == 1 then
					bumper = true
					fbumper = true
				elseif i == 2 then
					bumper = true
					rbumper = true
				elseif (i >= 42 and i <= 46) or i == 5 then
					chassis = true
				elseif i >= 27 and i <= 37 then
					interior = true
				end
			end
		end
		
		AddMod(0,LSCOLORMenu.categories,"SPOILER","Spoiler",nil,true)
		AddMod(3,LSCOLORMenu.categories,"SKIRTS","Skirts",nil,true)
		--AddMod(4,LSCOLORMenu.categories,"EXHAUST","Exhausts",nil,true)
		AddMod(6,LSCOLORMenu.categories,"GRILLE","Grille",nil,true)
		AddMod(7,LSCOLORMenu.categories,"HOOD","Hood",nil,true)
		AddMod(8,LSCOLORMenu.categories,"FENDERS","Fenders",nil,true)
		AddMod(10,LSCOLORMenu.categories,"ROOF","Roof",nil,true)
		--AddMod(12,LSCOLORMenu.categories,"BRAKES","Brakes",nil,true)
		--AddMod(13,LSCOLORMenu.categories,"TRANSMISSION","Transmission",nil,true)
		--AddMod(14,LSCOLORMenu.categories,"HORN", "Horn",nil,true)
		--AddMod(15,LSCOLORMenu.categories,"SUSPENSION","Suspension",nil,true)
		--AddMod(16,LSCOLORMenu.categories,"ARMOR","Armor",nil,true)
		--AddMod(18, LSCOLORMenu.categories,"TURBO","Turbo",nil,true)
		
		if chassis then
			LSCOLORMenu.categories:addSubMenu("CHASSIS","Chassis",nil,true)
			AddMod(42, LSCOLORMenu.categories.Chassis,"ARCH COVER","Arch cover",nil,true)
			AddMod(43, LSCOLORMenu.categories.Chassis,"AERIALS","Aerials",nil,true)
			AddMod(44, LSCOLORMenu.categories.Chassis,"ROOF SCOOPS","Roof Scoops",nil,true)
			AddMod(45, LSCOLORMenu.categories.Chassis,"Tank","Tank",nil,true)
			AddMod(46, LSCOLORMenu.categories.Chassis,"DOORS","Doors",nil,true)
			AddMod(5,LSCOLORMenu.categories.Chassis,"ROLL CAGE","Roll cage",nil,true)
		end

		--[[LSCOLORMenu.categories:addSubMenu("ENGINE","Engine",nil,true)
		AddMod(39, LSCOLORMenu.categories.Engine,"ENGINE BLOCK","Engine Block",nil,true)
		AddMod(40, LSCOLORMenu.categories.Engine,"CAM COVER","Cam Cover",nil,true)
		AddMod(41, LSCOLORMenu.categories.Engine,"STRUT BRACE","Strut Brace",nil,true)
		AddMod(11,LSCOLORMenu.categories.Engine,"ENGINE TUNES","Engine Tunes",nil,true)]]

		if interior then
			LSCOLORMenu.categories:addSubMenu("INTERIOR","Interior",nil,true)
			AddMod(27, LSCOLORMenu.categories.Interior,"TRIM DESIGN","Trim Design",nil,true)
			AddMod(28, LSCOLORMenu.categories.Interior,"ORNAMENTS","Ornaments",nil,true)
			AddMod(29, LSCOLORMenu.categories.Interior,"DASHBOARD","Dashboard",nil,true)
			AddMod(30, LSCOLORMenu.categories.Interior,"DIAL DESIGN","Dials",nil,true)
			AddMod(31, LSCOLORMenu.categories.Interior,"DOORS","Doors",nil,true)
			AddMod(32, LSCOLORMenu.categories.Interior,"SEATS","Seats",nil,true)
			AddMod(33, LSCOLORMenu.categories.Interior,"STEERING WHEELS","Steering Wheels",nil,true)
			AddMod(34, LSCOLORMenu.categories.Interior,"Shifter leavers","Shifter leavers",nil,true)
			AddMod(35, LSCOLORMenu.categories.Interior,"Plaques","Plaques",nil,true)
			AddMod(36, LSCOLORMenu.categories.Interior,"Speakers","Speakers",nil,true)
			AddMod(37, LSCOLORMenu.categories.Interior,"Trunk","Trunk",nil,true)
		end

		LSCOLORMenu.categories:addSubMenu("PLATES","Plates",nil,true)
		LSCOLORMenu.categories.Plates:addSubMenu("LICENSE","License",nil,true)
		for n, mod in pairs(LSCOLOR_Config.prices.plates) do
			local btn = LSCOLORMenu.categories.Plates.License:addPurchase(mod.name,parseInt((mod.price- (mod.price*desconto))))
			btn.plateindex = mod.plateindex
		end																

		AddMod(25, LSCOLORMenu.categories.Plates,"Plate holder","Plate holder",nil,true)
		AddMod(26, LSCOLORMenu.categories.Plates,"Vanity plates","Vanity plates",nil,true)
		AddMod(38,LSCOLORMenu.categories,"HYDRAULICS","Hydraulics",nil,true)
		AddMod(48,LSCOLORMenu.categories,"Liveries","Liveries",nil,true)

		if bumper then
			LSCOLORMenu.categories:addSubMenu("BUMPERS","Bumpers",nil,true)
			if fbumper then
				AddMod(1,LSCOLORMenu.categories.Bumpers,"FRONT BUMPERS","Front bumpers",nil,true)
			end
			if rbumper then
				AddMod(2,LSCOLORMenu.categories.Bumpers,"REAR BUMPERS","Rear bumpers",nil,true)
			end
		end

		local m = LSCOLORMenu.categories:addSubMenu("LIGHTS","Lights",nil,true)
		AddMod(22,LSCOLORMenu.categories.Lights,"HEADLIGHTS","Headlights",nil,false)
		if not IsThisModelABike(GetEntityModel(veh)) then
			m = m:addSubMenu("NEON KITS","Neon kits",nil,true)
			m:addSubMenu("NEON LAYOUT","Neon layout",nil,true)
			local btn = m["Neon layout"]:addPurchase("None")
			for n, mod in pairs(LSCOLOR_Config.prices.neonlayout) do
				local btn = m["Neon layout"]:addPurchase(mod.name,parseInt((mod.price - (mod.price*desconto))))
			end

			m = m:addSubMenu("NEON COLOR","Neon color",nil,true)
			for n, mod in pairs(LSCOLOR_Config.prices.neoncolor) do
				local btn = m:addPurchase(mod.name,parseInt((mod.price - (mod.price*desconto))))
				btn.neon = mod.neon
			end
		end
		
		respray = LSCOLORMenu.categories:addSubMenu("RESPRAY","Respray",nil,true)
		pcol = respray:addSubMenu("PRIMARY COLORS","Primary color",nil,true)
		pcol:addSubMenu("CHROME","Chrome",nil,true)
		for n, c in pairs(LSCOLOR_Config.prices.chrome.colors) do
			local btn = pcol.Chrome:addPurchase(c.name,parseInt(LSCOLOR_Config.prices.chrome.price - ((LSCOLOR_Config.prices.chrome.price* desconto))))
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[1] then
				btn.purchased = true
			end
		end
		pcol:addSubMenu("CLASSIC","Classic",nil,true)
		for n, c in pairs(LSCOLOR_Config.prices.classic.colors) do
			local btn = pcol.Classic:addPurchase(c.name,parseInt((LSCOLOR_Config.prices.classic.price - (LSCOLOR_Config.prices.classic.price * desconto))))
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[1] then
				btn.purchased = true
			end
		end
		pcol:addSubMenu("MATTE","Matte",nil,true)
		for n, c in pairs(LSCOLOR_Config.prices.matte.colors) do
			local btn = pcol.Matte:addPurchase(c.name,parseInt((LSCOLOR_Config.prices.matte.price - (LSCOLOR_Config.prices.matte.price * desconto))))
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[1] then
				btn.purchased = true
			end
		end
		pcol:addSubMenu("METALLIC","Metallic",nil,true)
		for n, c in pairs(LSCOLOR_Config.prices.metallic.colors) do
			local btn = pcol.Metallic:addPurchase(c.name,parseInt((LSCOLOR_Config.prices.metallic.price - (LSCOLOR_Config.prices.metallic.price * desconto))))
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[1] and myveh.extracolor[1] == myveh.color[2] then
				btn.purchased = true
			end
		end
		pcol:addSubMenu("METALS","Metals",nil,true)
		for n, c in pairs(LSCOLOR_Config.prices.metal.colors) do
			local btn = pcol.Metals:addPurchase(c.name,parseInt((LSCOLOR_Config.prices.metal.price - (LSCOLOR_Config.prices.metal.price * desconto))))
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[1] then
				btn.purchased = true
			end
		end
		scol = respray:addSubMenu("SECONDARY COLORS","Secondary color",nil,true)
		scol:addSubMenu("CHROME","Chrome",nil,true)
		for n, c in pairs(LSCOLOR_Config.prices.chrome2.colors) do
			local btn = scol.Chrome:addPurchase(c.name,parseInt((LSCOLOR_Config.prices.chrome2.price - (LSCOLOR_Config.prices.chrome2.price * desconto))))
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[2] then
				btn.purchased = true
			end
		end
		scol:addSubMenu("CLASSIC","Classic",nil,true)
		for n, c in pairs(LSCOLOR_Config.prices.classic2.colors) do
			local btn = scol.Classic:addPurchase(c.name,parseInt((LSCOLOR_Config.prices.classic2.price - (LSCOLOR_Config.prices.classic2.price * desconto))))
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[2] then
				btn.purchased = true
			end
		end
		scol:addSubMenu("MATTE","Matte",nil,true)
		for n, c in pairs(LSCOLOR_Config.prices.chrome2.colors) do
			local btn = scol.Matte:addPurchase(c.name,parseInt((LSCOLOR_Config.prices.matte2.price - ( LSCOLOR_Config.prices.matte2.price * desconto))))
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[2] then
				btn.purchased = true
			end
		end
		scol:addSubMenu("METALLIC","Metallic",nil,true)
		for n, c in pairs(LSCOLOR_Config.prices.metallic2.colors) do
			local btn = scol.Metallic:addPurchase(c.name,parseInt((LSCOLOR_Config.prices.metallic2.price - (LSCOLOR_Config.prices.metallic2.price*desconto))))
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[2] and myveh.extracolor[1] == btn.colorindex then
				btn.purchased = true
			end
		end
		scol:addSubMenu("METALS","Metals",nil,true)
		for n, c in pairs(LSCOLOR_Config.prices.metal2.colors) do
			local btn = scol.Metals:addPurchase(c.name,parseInt((LSCOLOR_Config.prices.metal2.price - (LSCOLOR_Config.prices.metal2.price*desconto))))
			btn.colorindex = c.colorindex
			if btn.colorindex == myveh.color[2] then
				btn.purchased = true
			end															
		end

		LSCOLORMenu.categories:addSubMenu("WHEELS","Wheels",nil,true)
		wtype = LSCOLORMenu.categories.Wheels:addSubMenu("WHEEL TYPE","Wheel type",nil,true)
		if IsThisModelABike(GetEntityModel(veh)) then
			fwheels = wtype:addSubMenu("FRONT WHEEL","Front wheel",nil,true)
			for n, w in pairs(LSCOLOR_Config.prices.frontwheel) do
				btn = fwheels:addPurchase(w.name,parseInt((w.price - (w.price*desconto))))
				btn.wtype = w.wtype 
				btn.modtype = 23 
				btn.mod = w.mod
			end
			bwheels = wtype:addSubMenu("BACK WHEEL","Back wheel",nil,true)
			for n, w in pairs(LSCOLOR_Config.prices.backwheel) do
				btn = bwheels:addPurchase(w.name,parseInt((w.price - (w.price*desconto))))
				btn.wtype = w.wtype 
				btn.modtype = 24 
				btn.mod = w.mod
			end
		else
			sportw = wtype:addSubMenu("SPORT WHEELS","Sport",nil,true)
			for n, w in pairs(LSCOLOR_Config.prices.sportwheels) do
				local btn = sportw:addPurchase(w.name,parseInt((w.price - (w.price*desconto))))
				btn.wtype = w.wtype 
				btn.modtype = 23 
				btn.mod = w.mod
			end
			musclew = wtype:addSubMenu("MUSCLE WHEELS","Muscle",nil,true)
			for n, w in pairs(LSCOLOR_Config.prices.musclewheels) do
				local btn = musclew:addPurchase(w.name,parseInt((w.price - (w.price*desconto))))
				btn.wtype =  w.wtype 
				btn.modtype = 23 
				btn.mod = w.mod
			end
			lowriderw = wtype:addSubMenu("LOWRIDER WHEELS","Lowrider",nil,true)
			for n, w in pairs(LSCOLOR_Config.prices.lowriderwheels) do
				local btn = lowriderw:addPurchase(w.name,parseInt((w.price - (w.price*desconto))))
				btn.wtype =  w.wtype 
				btn.modtype = 23 
				btn.mod = w.mod
			end
			suvw = wtype:addSubMenu("SUV WHEELS","Suv",nil,true)
			for n, w in pairs(LSCOLOR_Config.prices.suvwheels) do
				local btn = suvw:addPurchase(w.name,parseInt((w.price - (w.price*desconto))))
				btn.wtype = w.wtype 
				btn.modtype = 23 
				btn.mod = w.mod
			end
			offroadw = wtype:addSubMenu("OFFROAD WHEELS","Offroad",nil,true)
			for n, w in pairs(LSCOLOR_Config.prices.offroadwheels) do
				local btn = offroadw:addPurchase(w.name,parseInt((w.price - (w.price*desconto))))
				btn.wtype = w.wtype 
				btn.modtype = 23 
				btn.mod = w.mod
			end
			tunerw = wtype:addSubMenu("TUNER WHEELS","Tuner",nil,true)
			for n, w in pairs(LSCOLOR_Config.prices.tunerwheels) do
				local btn = tunerw:addPurchase(w.name,parseInt((w.price - (w.price*desconto))))
				btn.wtype = w.wtype 
				btn.modtype = 23 
				btn.mod = w.mod
			end
			hughendw = wtype:addSubMenu("HIGHEND WHEELS","Highend",nil,true)
			for n, w in pairs(LSCOLOR_Config.prices.highendwheels) do
				local btn = hughendw:addPurchase(w.name,parseInt((w.price - (w.price*desconto))))
				btn.wtype = w.wtype 
				btn.modtype = 23 
				btn.mod = w.mod
			end
			importw = wtype:addSubMenu("IMPORT WHEELS","Import",nil,true)
			for n, w in pairs(LSCOLOR_Config.prices.importwheels) do
				local btn = importw:addPurchase(w.name,parseInt((w.price - (w.price*desconto))))
				btn.wtype = w.wtype 
				btn.modtype = 23 
				btn.mod = w.mod
			end
		end

		m = LSCOLORMenu.categories.Wheels:addSubMenu("WHEEL COLOR","Wheel color",nil,true)
		for n, c in pairs(LSCOLOR_Config.prices.wheelcolor.colors) do
			local btn = m:addPurchase(c.name,parseInt((LSCOLOR_Config.prices.wheelcolor.price - ( LSCOLOR_Config.prices.wheelcolor.price * desconto))))
			btn.colorindex = c.colorindex
		end				
		
		m = LSCOLORMenu.categories.Wheels:addSubMenu("WHEEL ACCESSORIES","Wheel accessories",nil,true)
		for n, mod in pairs(LSCOLOR_Config.prices.wheelaccessories) do
			local btn = m:addPurchase(mod.name,parseInt((mod.price - (mod.price*desconto))))
			btn.smokecolor = mod.smokecolor
		end

		m = LSCOLORMenu.categories:addSubMenu("WINDOWS","Windows",nil,true)
		btn = m:addPurchase("None")btn.tint = false
		for n, tint in pairs(LSCOLOR_Config.prices.windowtint) do
			btn = m:addPurchase(tint.name,parseInt((tint.price - (tint.price * desconto))))
			btn.tint = tint.tint
		end

		Citizen.CreateThread(function()
			SetEntityCoordsNoOffset(veh,pos.drivein.x,pos.drivein.y,pos.drivein.z)
			SetEntityHeading(veh,pos.drivein.heading)
			SetVehicleOnGroundProperly(veh)
			SetVehicleLights(veh,2)
			SetVehicleInteriorlight(veh, true)
			SetVehicleDoorsLocked(veh,4)
			SetPlayerInvincible(GetPlayerIndex(),false)--MQCU
			SetEntityInvincible(veh,true)
			SetVehRadioStation(veh,255)

			gameplaycam = GetRenderingCam()
			SetupInsideCam()
			Citizen.Wait(50)

			TaskVehicleDriveToCoord(ped,veh,pos.inside.x,pos.inside.y,pos.inside.z,f(3),f(1),GetEntityModel(veh),16777216,f(0.1),true)
			Citizen.Wait(3000)

			local c = 0
			while not IsVehicleStopped(veh) do
				Citizen.Wait(1)
				c = c + 1
				if c > 5000 then
					ClearPedTasks(ped)
					break
				end
			end

			Citizen.Wait(100)
			SetCamCoord(cam,GetGameplayCamCoords())
			SetCamRot(cam,GetGameplayCamRot(2),2)
			RenderScriptCams(1,1,0,0,0)
			RenderScriptCams(0,1,1000,0,0)
			SetCamActive(gameplaycam,true)
			EnableGameplayCam(true)
			SetCamActive(cam,false)

			--if IsVehicleDamaged(veh) then
				--LSCOLORMenu:Open("main")
			--else
				LSCOLORMenu:Open("categories")
			--end

			FreezeEntityPosition(veh,true)
			--SetEntityCollision(veh,false,false)
			SetPlayerControl(PlayerId(),true)
		end)
	end
end

local function DriveOutOfGarage(pos)
	Citizen.CreateThread(function()
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsUsing(ped)

		pos = currentpos
		TaskVehicleDriveToCoord(ped,veh,pos.outside.x,pos.outside.y,pos.outside.z,f(5),f(0.1),GetEntityModel(veh),16777216,f(0.1),true)

		pos = currentpos.driveout
		TriggerServerEvent("LSCOLOR:finished",myveh)

		SetEntityCollision(veh,true,true)
		FreezeEntityPosition(ped,false)
		FreezeEntityPosition(veh,false)
		SetEntityCoords(veh,pos.x,pos.y,pos.z,1,0,0,1)
		SetEntityHeading(veh,pos.heading)
		SetVehicleOnGroundProperly(veh)
		SetVehicleDoorsLocked(veh,0)
		SetPlayerInvincible(GetPlayerIndex(),false)
		SetEntityInvincible(veh,false)
		SetVehicleLights(veh,0)
		inside = false

		TriggerServerEvent('lockGarage',false,currentgarage)
		SetPlayerControl(PlayerId(),true)
		currentgarage = 0
	end)
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

local function tableContains(t,val)
	for k,v in pairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if inside == false then
			local ped = PlayerPedId()
			if IsPedSittingInAnyVehicle(ped) then
				local veh = GetVehiclePedIsUsing(ped)
				if DoesEntityExist(veh) and GetPedInVehicleSeat(veh,-1) == ped and (IsThisModelACar(GetEntityModel(veh)) or IsThisModelABike(GetEntityModel(veh))) then
					for i,pos in ipairs(garages) do
						outside = pos.drivein
						if LSCOLOR_Config.oldenter then
							if GetDistanceBetweenCoords(outside.x,outside.y,outside.z,GetEntityCoords(ped)) <= f(1) then
								if not tableContains(LSCOLOR_Config.ModelBlacklist,GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()) then
									if pos.locked then
										if not LSCOLOR_Config.lock then
											if IsControlJustPressed(1,38) then
												if emP.checkPermission() then
													if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("polmp4")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiasilverado")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiabmwr1200")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiatahoe")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiataurus")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiavictoria")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiamustanggt")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiacharger2018")) then
														TriggerEvent("Notify","negado","Viaturas não podem ser modificadas!.",8000)
													else
														inside = true
														currentpos = pos
														currentgarage = i
														DriveInGarage()
													end
												else
													TriggerEvent("Notify","negado","Apenas <b>Mecânicos</b> podem modificar os veículos.",8000)
												end
											else
												drawTxt("PRESSIONE  ~r~E~w~  PARA ACESSAR A ~y~BENNYS",4,0.5,0.90,0.50,255,255,255,180)
											end
										else
											drawTxt("~y~BENNYS~w~ OCUPADA NO MOMENTO",4,0.5,0.93,0.50,255,255,255,180)
										end
									else
										if IsControlJustPressed(1,38) then
											if emP.checkPermission() then
												if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("polmp4")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiasilverado")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiabmwr1200")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiatahoe")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiataurus")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiavictoria")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiamustanggt")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiacharger2018")) then
													TriggerEvent("Notify","negado","Viaturas não podem ser modificadas!.",8000)
												else
													inside = true
													currentpos = pos
													currentgarage = i
													DriveInGarage()
												end
											else
												TriggerEvent("Notify","negado","Apenas <b>Mecânicos</b> podem modificar os veículos.",8000)
											end
										else
											drawTxt("PRESSIONE  ~r~E~w~  PARA ACESSAR A ~y~BENNYS",4,0.5,0.90,0.50,255,255,255,180)
										end
									end
								else
									drawTxt("~y~BENNYS~w~ OCUPADA NO MOMENTO",4,0.5,0.93,0.50,255,255,255,180)
								end
							end
						else
							if math.abs(GetEntityHeading(veh)-outside.heading) <= 90 and IsVehicleStopped(veh) and GetDistanceBetweenCoords(outside.x,outside.y,outside.z,GetEntityCoords(ped)) <= f(5) then
								if not tableContains(LSCOLOR_Config.ModelBlacklist,GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()) then
									if pos.locked then
										if not LSCOLOR_Config.lock then
											if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("polmp4")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiasilverado")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiabmwr1200")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiatahoe")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiataurus")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiavictoria")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiamustanggt")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiacharger2018")) then
												TriggerEvent("Notify","negado","Viaturas não podem ser modificadas!.",8000)
											else
												inside = true
												currentpos = pos
												currentgarage = i
												DriveInGarage()
											end
										else
											drawTxt("~y~BENNYS~w~ OCUPADA NO MOMENTO",4,0.5,0.93,0.50,255,255,255,180)
										end
									else
										if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("polmp4")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiasilverado")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiabmwr1200")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiatahoe")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiataurus")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiavictoria")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiamustanggt")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiacharger2018")) then
											TriggerEvent("Notify","negado","Viaturas não podem ser modificadas!.",8000)
										else
											inside = true
											currentpos = pos
											currentgarage = i
											DriveInGarage()
										end
									end
								else
									drawTxt("~y~BENNYS~w~ OCUPADA NO MOMENTO",4,0.5,0.93,0.50,255,255,255,180)
								end
							end
						end
					end
				end
			end
		end
	end
end)

function LSCOLORMenu:OnMenuClose(m)
	DriveOutOfGarage(currentpos.outside)
end

function LSCOLORMenu:onSelectedIndexChanged(name,button)
	name = name:lower()
	local m = LSCOLORMenu.currentmenu
	local price = button.price or 0
	local veh = myveh.vehicle
	p = m.parent or self.name
	if m == "main" then
		m = self
	end
	CheckPurchases(m)
	m = m.name:lower()
	p = p:lower()
	if m == "chrome" or m ==  "classic" or m ==  "matte" or m ==  "metals" then
		if p == "primary color" then
			SetVehicleColours(veh,button.colorindex,myveh.color[2])
		else
			SetVehicleColours(veh,myveh.color[1],button.colorindex)	
		end
	elseif m == "metallic" then
		if p == "primary color" then
			SetVehicleColours(veh,button.colorindex,myveh.color[2])
			SetVehicleExtraColours(veh,myveh.color[2],myveh.extracolor[2])
		else
			SetVehicleColours(veh,myveh.color[1],button.colorindex)
			SetVehicleExtraColours(veh,button.colorindex,myveh.extracolor[2])				
		end
	elseif m == "wheel color" then
		SetVehicleExtraColours(veh,myveh.extracolor[1],button.colorindex)
	elseif button.modtype and button.mod then
		if button.modtype ~= 18 and button.modtype ~= 22 then
			if button.wtype then
				SetVehicleWheelType(veh,button.wtype)
			end
			SetVehicleMod(veh,button.modtype,button.mod)	
		elseif button.modtype == 22 then
			ToggleVehicleMod(veh,button.modtype,button.mod)
		elseif button.modtype == 18 then
		end
	elseif m == "license" then
		SetVehicleNumberPlateTextIndex(veh,button.plateindex)
	elseif m == "neon color" then
		SetVehicleNeonLightsColour(veh,button.neon[1],button.neon[2],button.neon[3])
	elseif m == "windows" then
		SetVehicleWindowTint(veh, button.tint)
	else
	end
	if m == "horn" then
		OverrideVehHorn(veh,false,0)
		if IsHornActive(veh) or IsControlPressed(1,86) then
			StartVehicleHorn(veh,10000,"HELDDOWN",1)
		end
	end
end


function LSCOLORMenu:OnMenuOpen(menu)

end

function LSCOLORMenu:onButtonSelected(name,button)
	TriggerServerEvent("LSCOLOR:buttonSelected",name,button)
end

RegisterNetEvent("LSCOLOR:buttonSelected")
AddEventHandler("LSCOLOR:buttonSelected",function(name,button,canpurchase)
	name = name:lower()
	local m = LSCOLORMenu.currentmenu
	local price = button.price or 0
	local veh = myveh.vehicle
	if m == "main" then
		m = LSCOLORMenu
	end
	mname = m.name:lower()
	if mname == "chrome" or mname ==  "classic" or mname == "matte" or mname == "metals" then
		if m.parent == "Primary color" then
			if button.name == "Stock" or button.purchased or CanPurchase(price,canpurchase) then
				myveh.color[1] = button.colorindex
			end
		else
			if button.name == "Stock" or button.purchased or CanPurchase(price,canpurchase) then
				myveh.color[2] = button.colorindex
			end
		end
	elseif mname == "metallic" then
		if m.parent == "Primary color" then
			if button.name == "Stock" or button.purchased or CanPurchase(price,canpurchase)then
				myveh.color[1] = button.colorindex
				myveh.extracolor[1] = myveh.color[2]
			end
		else
			if button.name == "Stock" or button.purchased or CanPurchase(price,canpurchase)then
				myveh.extracolor[1] = button.colorindex
				myveh.color[2] = button.colorindex
			end
		end
	elseif mname == "liveries" or mname == "hydraulics" or mname == "horn" or mname == "tank" or mname == "ornaments" or  mname == "arch cover" or mname == "aerials" or mname == "roof scoops" or mname == "doors" or mname == "roll cage" or mname == "engine block" or mname == "cam cover" or mname == "strut brace" or mname == "trim design" or mname == "ormnametns" or mname == "dashboard" or mname == "dials" or mname == "seats" or mname == "steering wheels" or mname == "plate holder" or mname == "vanity plates" or mname == "shifter leavers" or mname == "plaques" or mname == "speakers" or mname == "trunk" or mname == "armor" or mname == "suspension" or mname == "transmission" or mname == "brakes" or mname == "engine tunes" or mname == "roof" or mname == "hood" or mname == "grille" or mname == "roll cage" or mname == "exhausts" or mname == "skirts" or mname == "rear bumpers" or mname == "front bumpers" or mname == "spoiler" then
		if button.name == "Stock" or button.purchased or CanPurchase(price,canpurchase)then
			myveh.mods[button.modtype].mod = button.mod
			SetVehicleMod(veh,button.modtype,button.mod)
		end
	elseif mname == "fenders" then
		if button.name == "Stock" or button.purchased or CanPurchase(price,canpurchase)then
			if button.name == "Stock" then
				myveh.mods[8].mod = button.mod
				myveh.mods[9].mod = button.mod
				SetVehicleMod(veh,9,button.mod)
				SetVehicleMod(veh,8,button.mod)
			else
				myveh.mods[button.modtype].mod = button.mod
				SetVehicleMod(veh,button.modtype,button.mod)
			end
		end
	elseif mname == "turbo" or mname == "headlights" then
		if button.name == "None" or button.name == "Stock Lights" or button.purchased or CanPurchase(price,canpurchase) then
			myveh.mods[button.modtype].mod = button.mod
			ToggleVehicleMod(veh,button.modtype,button.mod)
		end
	elseif mname == "neon layout" then
		if button.name == "None" then
			SetVehicleNeonLightEnabled(veh,0,false)
			SetVehicleNeonLightEnabled(veh,1,false)
			SetVehicleNeonLightEnabled(veh,2,false)
			SetVehicleNeonLightEnabled(veh,3,false)
			myveh.neoncolor[1] = 255
			myveh.neoncolor[2] = 255
			myveh.neoncolor[3] = 255
			myveh.neon = false
			SetVehicleNeonLightsColour(veh,255,255,255)
		elseif button.purchased or CanPurchase(price,canpurchase) then
			if not myveh.neoncolor[1] then
				myveh.neoncolor[1] = 255
				myveh.neoncolor[2] = 255
				myveh.neoncolor[3] = 255
			end
			myveh.neon = true
			SetVehicleNeonLightsColour(veh,myveh.neoncolor[1],myveh.neoncolor[2],myveh.neoncolor[3])
			SetVehicleNeonLightEnabled(veh,0,true)
			SetVehicleNeonLightEnabled(veh,1,true)
			SetVehicleNeonLightEnabled(veh,2,true)
			SetVehicleNeonLightEnabled(veh,3,true)
		end
	elseif mname == "neon color" then
		if button.purchased or CanPurchase(price,canpurchase) then
			myveh.neoncolor[1] = button.neon[1]
			myveh.neoncolor[2] = button.neon[2]
			myveh.neoncolor[3] = button.neon[3]
			SetVehicleNeonLightsColour(veh,button.neon[1],button.neon[2],button.neon[3])
		end
	elseif mname == "windows" then
		if button.name == "None" or button.purchased or CanPurchase(price,canpurchase) then
			myveh.windowtint = button.tint
			SetVehicleWindowTint(veh, button.tint)
		end
	elseif mname == "sport" or mname == "muscle" or mname == "lowrider" or mname == "back wheel" or mname == "front wheel" or mname == "highend" or mname == "suv" or mname == "offroad" or mname == "tuner" or mname == "import" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.wheeltype = button.wtype
			myveh.mods[button.modtype].mod = button.mod
			SetVehicleWheelType(veh,button.wtype)
			SetVehicleMod(veh,button.modtype,button.mod)
		end
	elseif mname == "wheel color" then
		if button.purchased or CanPurchase(price,canpurchase) then
			myveh.extracolor[2] = button.colorindex
			SetVehicleExtraColours(veh, myveh.extracolor[1], button.colorindex)
		end
	elseif mname == "wheel accessories" then
		if button.name == "Stock Tires" then
			SetVehicleModKit(veh,0)
			SetVehicleMod(veh,23,myveh.mods[23].mod,false)
			myveh.mods[23].variation = false
			if IsThisModelABike(GetEntityModel(veh)) then
				SetVehicleModKit(veh,0)
				SetVehicleMod(veh,24,myveh.mods[24].mod,false)
				myveh.mods[24].variation = false
			end
		elseif button.name == "Custom Tires" and (button.purchased or CanPurchase(price,canpurchase)) then
			SetVehicleModKit(veh,0)
			SetVehicleMod(veh,23,myveh.mods[23].mod,true)
			myveh.mods[23].variation = true
			if IsThisModelABike(GetEntityModel(veh)) then
				SetVehicleModKit(veh,0)
				SetVehicleMod(veh,24,myveh.mods[24].mod,true)
				myveh.mods[24].variation = true
			end
		--[[elseif button.name == "Bulletproof Tires" and (button.purchased or CanPurchase(price,canpurchase)) then
			if GetVehicleTyresCanBurst(myveh.vehicle) then
				myveh.bulletProofTyres = false
				SetVehicleTyresCanBurst(veh,false)
			else
				myveh.bulletProofTyres = true
				SetVehicleTyresCanBurst(veh,true)
			end]]
		elseif button.smokecolor ~= nil  and  (button.purchased or CanPurchase(price, canpurchase)) then
			SetVehicleModKit(veh,0)
			myveh.mods[20].mod = true
			ToggleVehicleMod(veh,20,true)
			myveh.smokecolor = button.smokecolor
			SetVehicleTyreSmokeColor(veh,button.smokecolor[1],button.smokecolor[2],button.smokecolor[3])
		end
	elseif mname == "license" then
		if button.purchased or CanPurchase(price, canpurchase) then
			myveh.plateindex = button.plateindex
			SetVehicleNumberPlateTextIndex(veh,button.plateindex)
		end
	elseif mname == "main" then
		if name == "reparar" then
			if CanPurchase(price,canpurchase) then 
				SetVehicleFixed(myveh.vehicle)
				LSCOLORMenu:ChangeMenu("categories")
			end
		end
	end
	CheckPurchases(m)
end)

local function PointCamAtBone(bone,ox,oy,oz)
	SetIbuttons({
		{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_back, 0),"Voltar" },
		{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_select, 0),"Selecionar" },
		{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_up, 0),"Subir" },
		{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_down, 0),"Descer" },
		{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_left, 0),"Esquerda" },
		{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_right, 0),"Direita" },
		{ GetControlInstructionalButton(1,0,0),"Livre"}
	 },0)
	SetCamActive(cam,true)
	local veh = myveh.vehicle
	local b = GetEntityBoneIndexByName(veh,bone)
	local bx,by,bz = table.unpack(GetWorldPositionOfEntityBone(veh,b))
	local ox2,oy2,oz2 = table.unpack(GetOffsetFromEntityGivenWorldCoords(veh,bx,by,bz))
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(veh,ox2+f(ox),oy2+f(oy),oz2+f(oz)))
	SetCamCoord(cam,x,y,z)
	PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh,0,oy2,oz2))
	RenderScriptCams(1,1,1000,0,0)
end

local function MoveVehCam(pos,x,y,z)
	SetIbuttons({
		{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_back,0),"Voltar" },
		{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_select,0),"Selecionar" },
		{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_up,0),"Subir" },
		{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_down,0),"Descer" },
		{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_left,0),"Esquerda" },
		{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_right,0),"Direita" },
		{ GetControlInstructionalButton(1,0, 0),"Livre"}
	 },0)
	SetCamActive(cam,true)
	local veh = myveh.vehicle
	local vx,vy,vz = table.unpack(GetEntityCoords(veh))
	local d = GetModelDimensions(GetEntityModel(veh))
	local length,width,height = d.y*-2,d.x*-2,d.z*-2
	local ox,oy,oz
	if pos == 'front' then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),(length/2)+f(y),f(z)))
	elseif pos == "front-top" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),(length/2)+f(y),(height)+f(z)))
	elseif pos == "back" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),-(length/2)+f(y),f(z)))
	elseif pos == "back-top" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),-(length/2)+f(y),(height/2)+f(z)))
	elseif pos == "left" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,-(width/2)+f(x),f(y),f(z)))
	elseif pos == "right" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,(width/2)+f(x),f(y),f(z)))
	elseif pos == "middle" then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh,f(x),f(y),(height/2)+f(z)))
	end
	SetCamCoord(cam,ox,oy,oz)
	PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh,0,0,f(0)))
	RenderScriptCams(1,1,1000,0,0)
end

function LSCOLORMenu:OnMenuChange(last,current)
	UnfakeVeh()
	if last == "main" then
		last = self
	end
	if last.name == "categories" and current.name == "main" then
		LSCOLORMenu:Close()
	end	
	c = current.name:lower()
	if c == "front bumpers" then
		MoveVehCam('front',-0.6,1.5,0.4)
	elseif  c == "rear bumpers" then
		MoveVehCam('back',-0.5,-1.5,0.2)
	elseif c == "Engine Tunes" then
	elseif c == "exhausts" then
	elseif c == "hood" then
		MoveVehCam('front-top',-0.5,1.3,1.0)
	elseif c == "headlights" then
		MoveVehCam('front',-0.6,1.3,0.6)
	elseif c == "license" or c == "plate holder" then
		MoveVehCam('back',0,-1,0.2)
	elseif c == "vanity plates" then
		MoveVehCam('front',-0.3,0.8,0.3)
	elseif c == "roof" then
	elseif c == "fenders" then
		MoveVehCam('left',-1.8,-1.3,0.7)
	elseif c == "grille" then
	elseif c == "skirts" then
		MoveVehCam('left',-1.8,-1.3,0.7)
	elseif c == "spoiler" then
		MoveVehCam('back',0.5,-1.6,1.3)
	elseif c == "back wheel" then
		PointCamAtBone("wheel_lr",-1.4,0,0.3)
	elseif c == "front wheel" or c == "wheel accessories" or  c == "wheel color" or c == "sport" or c == "muscle" or c == "lowrider"  or c == "highend" or c == "suv" or c == "offroad" or c == "tuner" or c == "import" then
		PointCamAtBone("wheel_lf",-1.4,0,0.3)
	elseif c == "neon color" then
		PointCamAtBone("neon_l",-2.0,2.0,0.4)
	elseif c == "shifter leavers" or c == "trim design" or c == "ornaments" or c == "dashboard" or c == "dials" or c == "seats" or c =="steering wheels" then
		SetFollowVehicleCamViewMode(4)
	elseif c == "doors" and last.name:lower() == "interior" then
		SetVehicleDoorOpen(myveh.vehicle,0,0,0)
		SetVehicleDoorOpen(myveh.vehicle,1,0,0)
	elseif c == "trunk" then
		SetVehicleDoorOpen(myveh.vehicle,5,0,0)
	elseif c == "speakers" or  c == "engine block" or c == "air filter" or c == "strut brace" or c == "cam cover" then
		SetVehicleDoorOpen(myveh.vehicle,5,0,0)
		SetVehicleDoorOpen(myveh.vehicle,4,0,0)
	elseif IsCamActive(cam) then
		SetCamCoord(cam,GetGameplayCamCoords())
		SetCamRot(cam, GetGameplayCamRot(2),2)
		RenderScriptCams(1,1,0,0,0)
		RenderScriptCams(0,1,1000,0,0)
		SetCamActive(gameplaycam,true)
		EnableGameplayCam(true)
		SetCamActive(cam,false)
		SetIbuttons({
			{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_back,0),"Voltar" },
			{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_select,0),"Selecionar" },
			{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_up,0),"Subir" },
			{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_down,0),"Descer" },
			{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_left,0),"Esquerda" },
			{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_right,0),"Direita" }
		},0)
	else
		SetVehicleDoorShut(myveh.vehicle,0,0)
		SetVehicleDoorShut(myveh.vehicle,1,0)
		SetVehicleDoorShut(myveh.vehicle,4,0)
		SetVehicleDoorShut(myveh.vehicle,5,0)
		SetFollowVehicleCamViewMode(0)
	end
end

function CheckPurchases(m)
	name = m.name:lower()
	if name == "chrome" or name ==  "classic" or name ==  "matte" or name == "metals" then
		if m.parent == "Primary color" then
			for i,b in pairs(m.buttons) do
				if b.purchased and b.colorindex ~= myveh.color[1] then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[1] then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		else
			for i,b in pairs(m.buttons) do
				if b.purchased and (b.colorindex ~= myveh.color[1] or myveh.extracolor[1] ~= myveh.color[2]) then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[1] and myveh.extracolor[1] == myveh.color[2] then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		end
	elseif name == "metallic" then
		if m.parent == "Primary color" then
			for i,b in pairs(m.buttons) do
				if b.purchased and b.colorindex ~= myveh.color[1] then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[1] then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		else
			for i,b in pairs(m.buttons) do
				if b.purchased and (b.colorindex ~= myveh.color[2] or myveh.extracolor[1] ~= b.colorindex) then
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				elseif b.purchased == false and b.colorindex == myveh.color[2] and myveh.extracolor[1] == b.colorindex then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				end
			end
		end
	elseif name == "armor" or name == "suspension" or name == "transmission" or name == "brakes" or name == "engine tunes" or name == "roof" or name == "fenders" or name == "hood" or name == "grille" or name == "roll cage" or name == "exhausts" or name == "skirts" or name == "rear bumpers" or name == "front bumpers" or name == "spoiler" then
		for i,b in pairs(m.buttons) do
			if b.mod == -1  then
				if myveh.mods[b.modtype].mod == -1 then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			elseif b.mod == 0 or b.mod == false then
				if myveh.mods[b.modtype].mod == false or myveh.mods[b.modtype].mod == 0 then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			else
				if myveh.mods[b.modtype].mod == b.mod then
					if b.purchased ~= nil then b.purchased = true end
					b.sprite = "garage"
				else
					if b.purchased ~= nil then b.purchased = false end
					b.sprite = nil
				end
			end
		end
	elseif name == "neon layout" then
		for i,b in pairs(m.buttons) do
			if b.name == "None" then
				if IsVehicleNeonLightEnabled(myveh.vehicle,0) == false and IsVehicleNeonLightEnabled(myveh.vehicle,1) == false and IsVehicleNeonLightEnabled(myveh.vehicle,2) == false and IsVehicleNeonLightEnabled(myveh.vehicle,3) == false then
					b.sprite = "garage"
				else
					b.sprite =  nil
				end
			elseif b.name == "Front,Back and Sides" then
				if IsVehicleNeonLightEnabled(myveh.vehicle,0)  and IsVehicleNeonLightEnabled(myveh.vehicle,1)  and IsVehicleNeonLightEnabled(myveh.vehicle,2)  and IsVehicleNeonLightEnabled(myveh.vehicle,3)  then
					b.sprite = "garage"
				else
					b.sprite =  nil
				end
			end		
		end
	elseif name == "neon color" then
		for i,b in pairs(m.buttons) do
			if b.neon[1] == myveh.neoncolor[1] and b.neon[2] == myveh.neoncolor[2] and b.neon[3] == myveh.neoncolor[3] then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "windows" then
		for i,b in pairs(m.buttons) do
			if myveh.windowtint == b.tint then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "sport" or name == "muscle" or name == "lowrider" or name == "back wheel" or name == "front wheel" or name == "highend" or name == "suv" or name == "offroad" or name == "tuner" or name == "import" then
		for i,b in pairs(m.buttons) do
			if myveh.mods[b.modtype].mod == b.mod and myveh.wheeltype == b.wtype then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "wheel color" then
		for i,b in pairs(m.buttons) do
			if b.colorindex == myveh.extracolor[2] then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "wheel accessories" then
		for i,b in pairs(m.buttons) do
			if b.name == "Stock Tires" then
				if GetVehicleModVariation(myveh.vehicle,23) == false then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			elseif b.name == "Custom Tires" then
				if GetVehicleModVariation(myveh.vehicle,23) then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			--[[elseif b.name == "Bulletproof Tires" then
				if GetVehicleTyresCanBurst(myveh.vehicle) == false then
					b.sprite = "garage"
				else
					b.sprite = nil
				end]]
			elseif b.smokecolor ~= nil then
				local col = table.pack(GetVehicleTyreSmokeColor(myveh.vehicle))
				if col[1] == b.smokecolor[1] and col[2] == b.smokecolor[2] and col[3] == b.smokecolor[3] then
					b.sprite = "garage"
				else
					b.sprite = nil
				end
			end
		end
	elseif name == "license" then
		for i,b in pairs(m.buttons) do
			if myveh.plateindex == b.plateindex then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	elseif name == "tank" or name == "ornaments" or name == "arch cover" or name == "aerials" or name == "roof scoops" or name == "doors" or name == "roll cage" or name == "engine block" or name == "cam cover" or name == "strut brace" or name == "trim design" or name == "ornametns" or name == "dashboard" or name == "dials" or name == "seats" or name == "steering wheels" or name == "plate holder" or name == "vanity plates" or name == "shifter leavers" or name == "plaques" or name == "speakers" or name == "trunk" or name == "headlights" or name == "turbo" or  name == "hydraulics" or name == "liveries" or name == "horn" then
		for i,b in pairs(m.buttons) do
			if myveh.mods[b.modtype].mod == b.mod then
				b.sprite = "garage"
			else
				b.sprite = nil
			end
		end
	end
end

function CanPurchase(price,canpurchase)
	if canpurchase then
		if LSCOLORMenu.currentmenu == "main" then
			LSCOLORMenu:showNotification("Reparado.")
		else
			TriggerEvent("Notify","sucesso","Modificação aplicada.",8000)
			--LSCOLORMenu:showNotification("Modificação aplicada.")
		end
		return true
	else
		TriggerEvent("Notify","negado","Dinheiro insuficiente.",8000)
		--LSCOLORMenu:showNotification("~r~Dinheiro insuficiente.")
		return false
	end
end

function UnfakeVeh()
	local veh = myveh.vehicle
	SetVehicleModKit(veh,0)
	SetVehicleWheelType(veh,myveh.wheeltype)
	for i,m in pairs(myveh.mods) do
		if i == 22 or i == 18 then
			ToggleVehicleMod(veh,i,m.mod)
		elseif i == 23 or i == 24 then
			SetVehicleMod(veh,i,m.mod,m.variation)
		else
			SetVehicleMod(veh,i,m.mod)
		end
	end
	SetVehicleColours(veh,myveh.color[1],myveh.color[2])
	SetVehicleExtraColours(veh,myveh.extracolor[1],myveh.extracolor[2])
	SetVehicleNeonLightsColour(veh,myveh.neoncolor[1],myveh.neoncolor[2],myveh.neoncolor[3])
	SetVehicleNumberPlateTextIndex(veh,myveh.plateindex)
	SetVehicleWindowTint(veh,myveh.windowtint)
end

AddEventHandler('playerSpawned',function()
	TriggerServerEvent('getGarageInfo')
end)

RegisterNetEvent('lockGarage')
AddEventHandler('lockGarage',function(tbl,current)
	for i,garage in ipairs(tbl) do
		garages[i].locked = garage.locked
	end
end)

local Ibuttons = nil
function SetIbuttons(buttons,layout)
	Citizen.CreateThread(function()
		if not HasScaleformMovieLoaded(Ibuttons) then
			Ibuttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(Ibuttons) do
				Citizen.Wait(1)
			end
		else
			Ibuttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(Ibuttons) do
				Citizen.Wait(1)
			end
		end
		local sf = Ibuttons
		local w,h = GetScreenResolution()
		PushScaleformMovieFunction(sf,"CLEAR_ALL")
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf,"SET_DISPLAY_CONFIG")
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PushScaleformMovieFunctionParameterFloat(0.03)
		PushScaleformMovieFunctionParameterFloat(0.98)
		PushScaleformMovieFunctionParameterFloat(0.01)
		PushScaleformMovieFunctionParameterFloat(0.95)
		PushScaleformMovieFunctionParameterBool(true)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterBool(false)
		PushScaleformMovieFunctionParameterInt(w)
		PushScaleformMovieFunctionParameterInt(h)
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(sf,"SET_MAX_WIDTH")
		PushScaleformMovieFunctionParameterInt(1)
		PopScaleformMovieFunction()
		
		for i,btn in pairs(buttons) do
			PushScaleformMovieFunction(sf,"SET_DATA_SLOT")
			PushScaleformMovieFunctionParameterInt(i-1)
			PushScaleformMovieFunctionParameterString(btn[1])
			PushScaleformMovieFunctionParameterString(btn[2])
			PopScaleformMovieFunction()
		end

		if layout ~= 1 then
			PushScaleformMovieFunction(sf,"SET_PADDING")
			PushScaleformMovieFunctionParameterInt(10)
			PopScaleformMovieFunction()
		end

		PushScaleformMovieFunction(sf,"DRAW_INSTRUCTIONAL_BUTTONS")
		PushScaleformMovieFunctionParameterInt(layout)
		PopScaleformMovieFunction()
	end)
end

function DrawIbuttons()
	if HasScaleformMovieLoaded(Ibuttons) then
		DrawScaleformMovie(Ibuttons,0.5,0.5,1.0,1.0,255,255,255,255)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if LSCOLORMenu:isVisible() then
			DrawIbuttons()
			if IsDisabledControlJustPressed(1,0) or IsControlJustPressed(1,0) then
				if cam and IsCamActive(cam) then
					SetCamCoord(cam,GetGameplayCamCoords())
					SetCamRot(cam,GetGameplayCamRot(2), 2)
					RenderScriptCams(1,1,0,0,0)
					RenderScriptCams(0,1,1000,0,0)
					SetCamActive(gameplaycam,true)
					EnableGameplayCam(true)
					SetCamActive(cam,false)
					SetIbuttons({
						{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_back, 0),"Voltar" },
						{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_select, 0),"Selecionar" },
						{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_up, 0),"Subir" },
						{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_down, 0),"Descer" },
						{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_left, 0),"Esquerda" },
						{ GetControlInstructionalButton(1,LSCOLORMenu.config.controls.menu_right, 0),"Direita" }
					},0)
				end
			end
		end
	end
end)