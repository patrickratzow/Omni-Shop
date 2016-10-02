function OmniShop.withinRange(ply, npc)
  if (npc:GetPos():Distance(ply:GetPos()) >= 200) then
    return false;
  end

  return true;
end

function OmniShop.saveConfig()
  local tbl = {};
  for _,data in pairs(ents.GetAll()) do
    if (string.StartWith(data:GetClass(), "omnishop_npc") && data:GetClass() != "omnishop_npcbase") then
      table.insert(tbl, { ent = data:GetClass(), pos = data:GetPos(), angle = data:GetAngles() });
    end
  end
  file.Write("omni/shop/npc2.txt", util.TableToJSON(tbl));
end

hook.Add("InitPostEntity", "OmniShop_InitPostEntity", function()
  if (!file.Exists("omni/shop/npc2.txt")) then return; end

  local tbl = util.JSONToTable(file.Read("omni/shop/npc2.txt", "DATA"));
  for _,v in pairs(tbl) do
    local ent = ents.Create(v.ent);
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

concommand.Add("omni_spawnshop", function(ply, cmd, args)
  if (!args[1]) then
    ply:PrintMessage(HUD_PRINTCONSOLE, "\n\nYou need an argument to use this command! Use it like this:");
    ply:PrintMessage(HUD_PRINTCONSOLE, "omni_spawnshop entity\n");
    ply:PrintMessage(HUD_PRINTCONSOLE, "An example is this:");
    ply:PrintMessage(HUD_PRINTCONSOLE, "omni_spawnshop omnishop_npc\n\n");
    return false;
  end

  if (ply:IsSuperAdmin()) then
    local ent = ents.Create(args[1]);
    if (!IsValid(ent)) then
      ply:PrintMessage(HUD_PRINTCONSOLE, "Invalid entity! "..tostring(ent));
      return;
    end
    local tbl = ply:FindPlayerTrace();
    local ang = ply:GetAngles();
    ent:SetPos(tbl.HitPos);
    ent:Spawn();
    ent:Activate();
  else
    ply:PrintMessage(HUD_PRINTCONSOLE, "Only superadmins can use this command!");
  end
end)

local plyMeta = FindMetaTable("Player");

function plyMeta:FindPlayerTrace()
	local pos = self:GetShootPos();
	local ang = self:GetAimVector();

	local tracedata = {};
	tracedata.start = pos;
	tracedata.endpos = pos + (ang * 100);
	tracedata.filter = self;

	local trace = util.TraceLine(tracedata);

	return trace;
end
