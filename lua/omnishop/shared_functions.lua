function OmniShop.getUserGroup(ply)
  local usergroup = "user";

  if (istable(evolve)) then -- Evolve
    usergroup = ply:EV_GetRank();
  elseif (istable(serverguard)) then -- Serverguard
    usergroup = serverguard.player:GetRank();
  else -- assume everything else (ULX uses this too)
    usergroup = ply:GetUserGroup();
  end

  return usergroup;
end

function OmniShop.isVIP(npc, ply)
  local vipGroups = npc.vipGroups;
  local userGroup = vipGroups[OmniShop.getUserGroup(ply)];

  if (userGroup == nil) then
    return false;
  end

  return userGroup.vip;
end

function OmniShop.findPrice(ply, money, tbl)
  local price = money;
  local group = tbl[OmniShop.getUserGroup(ply)];

  if (group != nil) then
    price = price * group.modifier;
  end

  return price;
end
