--[[
	function OmniShop.funcs.buyYourFunction(PLAYER, CONFIG TABLE, NPC)
		your code
	end
]]

function OmniShop.funcs.buyGun(ply, tbl)
	if (!OmniShop.coffeeInventory) then
		ply:Give(tbl.reward);
	else
		ply:addItem(tbl.reward, tbl.img, 1, {});
	end
end

function OmniShop.funcs.buyRank(ply, tbl)
	ply:SetUserGroup(tbl.reward);
end

function OmniShop.funcs.buyHealth(ply, tbl)
	ply:SetHealth(math.Clamp(ply:Health() + tbl.reward, 1, ply:GetMaxHealth()));
end

function OmniShop.funcs.buyArmor(ply, tbl)
	ply:SetArmor(math.Clamp(ply:Health() + tbl.reward, 1, 100));
end

function OmniShop.funcs.buyPS1Points(ply, tbl)
	ply:PS_GivePoints(tbl.reward);
end

function OmniShop.funcs.buyPS1Item(ply, item)
	ply:PS_GiveItem(tbl.reward);
end

function OmniShop.funcs.buyPS2StandardPoints(ply, tbl)
	ply:PS2_AddStandardPoints(tbl.reward);
end

function OmniShop.funcs.buyPS2PremiumPoints(ply, tbl)
	ply:PS2_AddPremiumPoints(tbl.reward);
end

function OmniShop.funcs.buyPS2Item(ply, tbl)
	ply:PS2_EasyAddItem(tbl.reward);
end

function OmniShop.funcs.buyExperience(ply, tbl)
	OmniShop.levelSystemTable[OmniShop.levelSystem]["xp"].add(ply, tbl.reward);
end

function OmniShop.funcs.buyLevel(ply, tbl)
	OmniShop.levelSystemTable[OmniShop.levelSystem]["level"].add(ply, tbl.reward);
end

function OmniShop.funcs.buyFood(ply, tbl, npc)
	local energy = tbl.energy or 20;
	if (!OmniShop.coffeeInventory) then
		local ent = ents.Create("omnishop_spawned_food");
		local pos = npc:LocalToWorld(Vector(0, 0, 60));
		ent:SetModel(tbl.reward);
		ent:SetPos(pos);
		ent.energy = energy;
		ent:Spawn();
	else
		ply:addItem(tbl.reward, tbl.img, 1, { ["energy"] = energy });
	end
end

function OmniShop.funcs.buyProp(ply, tbl, npc)
	local ent = ents.Create("prop_physics");
	local pos = npc:LocalToWorld(Vector(20, 0, 80));
	ent:SetModel(tbl.reward);
	ent:SetPos(pos);
	ent:Spawn();
	ent:Activate();
	if (CPPI) then -- Prop protection interface
		ent:CPPISetOwner(ply);
	end
end

function OmniShop.funcs.buyEntity(ply, tbl, npc)
	local ent = ents.Create(tbl.reward);
	local pos = npc:LocalToWorld(Vector(20, 0, 80));
	ent:SetPos(pos);
	ent:Spawn();
	if (ent.Getowning_ent) then -- DarkRP
		ent:Setowning_ent(ply);
	end
end
