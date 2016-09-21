util.AddNetworkString("OmniShop_Purchase");

net.Receive("OmniShop_Purchase", function(len, ply)
  local cat = net.ReadUInt(5);
  local id = net.ReadUInt(16);
  local tbl = Omni.shop.config[cat][id];

  if (ply:canAfford(tbl.price)) then
    ply:addMoney(-tbl.price);
    DarkRP.notify(ply, 0, 3, "You purchased "..tbl.name.." for a price of "..DarkRP.formatMoney(tbl.price).."!");
    tbl.func(ply, tbl.reward);
  end
end)
