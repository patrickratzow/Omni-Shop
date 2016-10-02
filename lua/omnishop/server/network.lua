util.AddNetworkString("OmniShop_Purchase");
util.AddNetworkString("OmniShop_Menu");
resource.AddFile("resources/fonts/montserrat.ttf");

net.Receive("OmniShop_Purchase", function(len, ply)
  local cat = net.ReadUInt(5);
  local id = net.ReadUInt(16);
  local npc = net.ReadEntity();
  local tbl = npc.config[cat][id];

  if (!OmniShop.withinRange(ply, npc)) then
    return false;
  end

  local userGroups = npc.vipGroups;
  local price = OmniShop.findPrice(ply, tbl.price, userGroups);

  if (ply:canAfford(price)) then
    if (tbl.vip && !OmniShop.isVIP(npc, ply)) then
      DarkRP.notify(ply, 1, 3, "You can't access that! You need to be a donator!");
      return false;
    end
    ply:addMoney(-price);
    DarkRP.notify(ply, 0, 3, "You purchased "..tbl.name.." for a price of "..DarkRP.formatMoney(price).."!");
    tbl.func(ply, tbl.reward);
  else
    DarkRP.notify(ply, 1, 3, "You can't afford that! You need "..DarkRP.formatMoney(price));
  end
end)
