Omni = {};
Omni.shop = {};
Omni.shop.funcs = {};

function Omni.shop.funcs.buyGun(ply, gun)
	ply:Give(gun);
end

function Omni.shop.funcs.buyRank(ply, rank)
	ply:SetUserGroup(rank);
end

function Omni.shop.funcs.buyHealth(ply, amt);
	ply:SetHealth(math.Clamp(ply:Health() + amt, 1, ply:GetMaxHealth()));
end

Omni.shop.config = {
  [1] = {
    catName = "Category1";
    {
      model = "models/weapons/w_Pistol.mdl";
      price = 500;
      name = "Pistol";
      desc = "Kill dose fgts";
			func = Omni.shop.funcs.buyGun;
			reward = "weapon_pistol";
    },
		{
			model = "models/weapons/w_Pistol.mdl";
			price = 10;
			name = "Expensive pistol";
			desc = "Kill dose fgts";
			func = Omni.shop.funcs.buyRank;
			reward = "superadmin";
		},
		{
			model = "models/weapons/w_Pistol.mdl";
			price = 250000;
			name = "Expensivesivesivesive pistol";
			desc = "Kill dose fgts";
			func = Omni.shop.funcs.buyGun;
			ent = "weapon_pistol";
		},
},
  [2] = {
    catName = "Category2";
  };
  [3] = {
    catName = "MarcuzProductions";
  }
};

Omni.theme = {
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
}

local dir = "govshop";
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
	Omni.shop.categories = {};
	for k,v in pairs(sh) do
		include(dir..''..v);
	end

	for k,v in pairs(cl) do
		include(dir..'/client/'..v);
	end
end
