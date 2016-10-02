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

function OmniShop.funcs.buyVrondakisLevel(ply, amt)
	ply:addLevel(amt);
end
