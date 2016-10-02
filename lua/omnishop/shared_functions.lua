function OmniShop.getUserGroup(ply)
  -- todo: add support for shit that doesn't use admin shit that overwrites PLAYER:GetUserGroup()
  -- aka shit admin mods
  local usergroup = nil;
  usergroup = ply:GetUserGroup();

  return usergroup;
end

function OmniShop.isVIP(npc, ply)
  local userGroups = npc.vipGroups;
  local userGroup = userGroups[OmniShop.getUserGroup(ply)];
  
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
