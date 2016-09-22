util.AddNetworkString("OmniShop_Purchase");
util.AddNetworkString("OmniShop_Menu");

net.Receive("OmniShop_Purchase", function(len, ply)
  local cat = net.ReadUInt(5);
  local id = net.ReadUInt(16);
  local npc = net.ReadEntity();
  local tbl = OmniShop.config[cat][id];

  if (!OmniShop.withinRange(ply, npc)) then
    return false;
  end

  if (ply:canAfford(tbl.price)) then
    if (tbl.vip && !table.HasValue(OmniShop.vipGroups, ply:GetUserGroup())) then
      DarkRP.notify(ply, 1, 3, "You can't access that! You need to be at least rank '"..OmniShop.vipGroups[1].."'");
      return false;
    end
    ply:addMoney(-tbl.price);
    DarkRP.notify(ply, 0, 3, "You purchased "..tbl.name.." for a price of "..DarkRP.formatMoney(tbl.price).."!");
    tbl.func(ply, tbl.reward);
  else
    DarkRP.notify(ply, 1, 3, "You can't afford that! You need "..DarkRP.formatMoney(tbl.price));
  end
end)

function OmniShop.withinRange(ply, npc)
  if (npc:GetPos():Distance(ply:GetPos()) >= 200) then
    return false;
  end
  return true;
end

function OmniShop.saveConfig()
  local tbl = {};
  for _,data in pairs(ents.FindByClass("omnishop_npc")) do
    table.insert(tbl, { pos = data:GetPos(), angle = data:GetAngles() });
  end
  file.Write("omni/shop/npc.txt", util.TableToJSON(tbl));
end

hook.Add("InitPostEntity", "OmniShop_InitPostEntity", function()
  local tbl = util.JSONToTable(file.Read("omni/shop/npc.txt", "DATA"));
  for _,v in pairs(tbl) do
    local ent = ents.Create("omnishop_npc");
    ent:SetPos(v.pos);
    ent:SetAngles(v.angle);
    ent:Spawn();
    ent:Activate();
  end
end)

hook.Add("Initialize", "OmniShop_Initialize", function()
  if (!file.IsDir("omni/shop", "DATA")) then
    file.CreateDir("omni/shop");
  end
end)
