OmniShop = {};
OmniShop.funcs = {};

local dir = "omnishop";
local sh = file.Find(dir..'/*.lua', "LUA");
local cl = file.Find(dir..'/client/*.lua', "LUA");

if (SERVER) then
	local sv = file.Find(dir..'/server/*.lua', "LUA");

	for k,v in pairs(sh) do
		AddCSLuaFile(dir..'/'..v);
		include(dir..'/'..v);
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
		include(dir..'/'..v);
	end

	for k,v in pairs(cl) do
		include(dir..'/client/'..v);
	end
end 
