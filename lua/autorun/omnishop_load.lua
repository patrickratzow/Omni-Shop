OmniShop = {};
OmniShop.funcs = {};

--[[
	function OmniShop.funcs.buyYourFunction(PLAYER, REWARD)
		your code
	end
]]

function OmniShop.funcs.buyGun(ply, gun)
	ply:Give(gun);
end

function OmniShop.funcs.buyRank(ply, rank)
	ply:SetUserGroup(rank);
end

function OmniShop.funcs.buyHealth(ply, amt)
	ply:SetHealth(math.Clamp(ply:Health() + amt, 1, ply:GetMaxHealth()));
end

function OmniShop.funcs.buyArmor(ply, amt)
	ply:SetArmor(math.Clamp(ply:Health() + amt, 1, 100));
end

function OmniShop.funcs.buyPS1Points(ply, amt)
	ply:PS_GivePoints(amt);
end

function OmniShop.funcs.buyPS1Item(ply, item)
	ply:PS_GiveItem(item);
end

function OmniShop.funcs.buyPS2StandardPoints(ply, amt)
	ply:PS2_AddStandardPoints(amt);
end

function OmniShop.funcs.buyPS2PremiumPoints(ply, amt)
	ply:PS2_AddPremiumPoints(amt);
end

function OmniShop.funcs.buyPS2Item(ply, item)
	ply:PS2_EasyAddItem(item);
end

function OmniShop.funcs.buyVrondakisExperience(ply, amt)
	ply:addXP(amt);
end

-- What model do you want the NPC to be?
OmniShop.model = "models/Humans/Group03/Male_04.mdl";
--[[
[categoryId (ONLY NUMBERS)] = {
	catName = "Category" -- category name
	{ -- start of new item
		model = true, -- if true then we use a model, otherwise we use a image (material)
		img = "path", -- if model is true then we use a model path, otherwise we use a material path.
		price = 10, -- how much does it cost to buy?
		name = "name", -- name of item
		desc = "desc", -- description for the item
		func = function, -- refer to a OmniShop.funcs function.
		reward = "reward", -- what reward? Either a "string" or a number.
		vip = true, -- true/false. VIP (donator) item or not
	}, -- end of item
},

Default funcs you can refer to is
OmniShop.funcs.buyGun
OmniShop.funcs.buyRank
OmniShop.funcs.buyHealth
OmniShop.funcs.buyArmor
OmniShop.funcs.buyPS1Points
OmniShop.funcs.buyPS1Item
OmniShop.funcs.buyPS2StandardPoints
OmniShop.funcs.buyPS2PremiumPoints
OmniShop.funcs.buyPS2Item
OmniShop.funcs.buyVrondakisExperience
]]
OmniShop.config = {
  [1] = {
    catName = "Misc";
		{
			model = true;
			img = "models/weapons/w_Pistol.mdl";
			price = 10;
			name = "Pistol";
			desc = "Kill dose fgts";
			func = OmniShop.funcs.buyGun;
			reward = "weapon_pistol";
		},
		{
			model = true;
			img = "models/weapons/w_smg1.mdl";
			price = 25000;
			name = "SMG";
			desc = "AUTOMATIC M8";
			func = OmniShop.funcs.buyGun;
			reward = "weapon_smg1";
			vip = true;
		},
},
  [2] = {
    catName = "Donator";
		{
			model = true;
			img = "models/weapons/w_Pistol.mdl";
			price = 500;
			name = "Pistol";
			desc = "Kill dose fgts";
			func = OmniShop.funcs.buyGun;
			reward = "weapon_pistol";
			vip = true;
		},
  };
};
-- VIP groups.
-- The first group written down here is the rank that the will error message will show.
OmniShop.vipGroups = {
	"donator",
	"superdonator",
};
-- Theme
OmniShop.theme = {
  ["Navbar"] = {
    color = Color(62, 79, 104);
  },
  ["Frame"] = {
    color = Color(55, 67, 85);
  },
  ["Colors"] = {
    blue = Color(0, 130, 213);
    red = Color(224, 65, 72);
    green = Color(62, 210, 71);
    white = Color(235, 239, 241);
    black = Color(29, 31, 33);
  }
};

-- No need for you to touch this, it's loading files here
local dir = "omnishop";
local sh = file.Find(dir..'/*.lua', "LUA");
local cl = file.Find(dir..'/client/*.lua', "LUA");

if (SERVER) then
	local sv = file.Find(dir..'/server/*.lua', "LUA");

	for k,v in pairs(sh) do
		AddCSLuaFile(dir..''..v);
		include(dir..''..v);
	end

	for k,v in pairs(sv) do
		include(dir..'/server/'..v);
	end

	for k,v in pairs(cl) do
		AddCSLuaFile(dir..'/client/'..v);
	end
end

if (CLIENT) then
	OmniShop.categories = {};
	for k,v in pairs(sh) do
		include(dir..''..v);
	end

	for k,v in pairs(cl) do
		include(dir..'/client/'..v);
	end
end
