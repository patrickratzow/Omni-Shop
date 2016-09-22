AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel(OmniShop.model);
	self:SetHullType(HULL_HUMAN);
	self:SetHullSizeNormal();
	self:SetNPCState(NPC_STATE_SCRIPT);
	self:SetSolid(SOLID_BBOX);
	self:CapabilitiesAdd(bit.bor(CAP_ANIMATEDFACE, CAP_TURN_HEAD));
	self:SetUseType(SIMPLE_USE);
	self:DropToFloor();
	self:SetMaxYawSpeed(90);
  OmniShop.saveConfig();
end

function ENT:OnRemove()
	timer.Simple(1.5, function() OmniShop.saveConfig() end);
end

function ENT:AcceptInput(name, activator, caller, data)
	if !(name == "Use" and IsValid(caller) and caller:IsPlayer()) then return; end
	net.Start("OmniShop_Menu");
    net.WriteEntity(self);
	net.Send(caller);
end

function ENT:OnPhysgunFreeze(weapon, phys, ent, ply)
	if(ply:IsSuperAdmin()) then
		OmniShop.saveConfig();
		ply:PrintMessage(HUD_PRINTTALK, "Saved OmniShop");
		return true;
	end
	return false;
end

function ENT:PhysgunPickup(ply, ent)
	return ply:IsSuperAdmin();
end
