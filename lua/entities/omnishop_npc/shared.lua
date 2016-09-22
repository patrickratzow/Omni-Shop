ENT.Type = "anim";
ENT.Base = "base_ai";
ENT.Type = "ai";
ENT.PrintName = "OmniShop NPC";
ENT.Author = "Pat";

function ENT:SetAutomaticFrameAdvance(bUsingAnim)
	self.AutomaticFrameAdvance = bUsingAnim;
end
