-- DO NOT TOUCH THIS SHIT??
ENT.Type = "anim";
ENT.Base = "omnishop_npcbase";
ENT.Type = "ai";
ENT.PrintName = "OmniShop NPC";
ENT.Author = "Pat";
-- You can touch now

-- Config
-- What model do you want the NPC to be?
ENT.model = "models/Humans/Group03/Male_04.mdl";

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
OmniShop.funcs.buyVrondakisLevel

To create more functions go to:
garrysmod/addons/omni_shop/lua/omnishop/item_functions.lua
]]
local cops = {
  TEAM_CITIZEN;
}

ENT.config = {
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
      level = 4;
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
ENT.vipGroups = {
  ["admin"] = { vip = false, modifier = 2 }; -- CUZ YOU HATE YOUR ADMINS!
	["donator"] = { vip =  true, modifier = 0.90 };
	["superdonator"] = { vip = true, modifier = 0.75 };
  ["superadmin"] = { vip = true, modifier = 0.50 };
};
