util.AddNetworkString("OmniShop_Purchase");
util.AddNetworkString("OmniShop_Menu");
resource.AddFile("resources/fonts/montserrat.ttf");

net.Receive("OmniShop_Purchase", function(len, ply)
  local cat = net.ReadUInt(5);
  local id = net.ReadUInt(16);
  local npc = net.ReadEntity();
  local tbl = npc.config[cat][id];
  local plyLevel = OmniShop.levelSystemTable[OmniShop.levelSystem]["level"].get(ply);
  if (plyLevel == nil) then
    plyLevel = 0;
  end
  local level = tbl.level;
  if (level == nil) then
    level = -1;
  end
  local plyWrongTeam = false;
  if (tbl.allowedTeams != nil) then
    if (!table.HasValue(tbl.allowedTeams, ply:Team())) then
      plyWrongTeam = true;
    end
  end

  if (!OmniShop.withinRange(ply, npc)) then
    return false;
  end

  local userGroups = npc.vipGroups;
  local price = OmniShop.findPrice(ply, tbl.price, userGroups);

  if (ply:canAfford(price)) then
    if (tbl.vip && !OmniShop.isVIP(npc, ply)) then
      DarkRP.notify(ply, 1, 3, "You can't access that! You need to be a donator!");
      return false;
    elseif (level > plyLevel) then
      DarkRP.notify(ply, 1, 3, "You can't access that! You need to be level "..level.." or higher!");
      return false;
    elseif (plyWrongTeam) then
      DarkRP.notify(ply, 1, 3, "You can't access that! "..tbl.wrongTeamMsg);
      return false;
    end
    ply:addMoney(-price);
    DarkRP.notify(ply, 0, 3, "You purchased "..tbl.name.." for a price of "..DarkRP.formatMoney(price).."!");
    tbl.func(ply, tbl, npc);
  else
    DarkRP.notify(ply, 1, 3, "You can't afford that! You need "..DarkRP.formatMoney(price));
  end
end)
