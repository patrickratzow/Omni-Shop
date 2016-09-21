
local tab = 1;
local speed = 900;
local function ui()
  local scrW, scrH = ScrW(), ScrH();
  local theme = Omni.theme;
  local frame = vgui.Create("DFrame");
  frame:SetSize(scrW * 0.5, scrH * 0.5);
  frame:Center();
  frame:DockPadding(0, 0, 0, 0);
  frame:SetTitle("");
  frame:ShowCloseButton(false);
  frame:MakePopup();
  frame.Paint = function(self, w, h)
    draw.RoundedBox(6, 0, 0, w, h, theme["Frame"].color);
  end

  local navbar = vgui.Create("DPanel", frame);
  navbar:Dock(TOP);
  navbar.Paint = function(self, w, h)
    draw.RoundedBoxEx(6, 0, 0, w, h, theme["Navbar"].color, true, true, false, false);
  end

  for i = 1, table.Count(Omni.shop.config) do
    Omni.shop.categories[i] = {};
    Omni.shop.categories[i].Button = vgui.Create("DButton", navbar);
    Omni.shop.categories[i].Panel = vgui.Create("DPanel", frame);
    local btn = Omni.shop.categories[i].Button;
    local pnl = Omni.shop.categories[i].Panel;

    btn:Dock(LEFT);
    btn.id = i;
    btn:SetFont("Omni_Tab")
    btn:SetText(Omni.shop.config[i].catName);
    btn.PerformLayout = function(self, w, h)
      DButton.PerformLayout(self, w, h)
      surface.SetFont("Omni_Tab");
      local tW, tX = surface.GetTextSize(self:GetText());
      self:SetWide(tW + 40);
    end
    btn.h = nil;
    btn.start = 0;
    btn.Paint = function(self, w, h)
      local hover = self:IsHovered();
      if (tab == self.id) then
        if (self.h == nil) then self.h = 2 end
        self.start = 2;
        self:SetTextColor(theme["Colors"].white);
      else
        if (self.h == nil) then self.h = 0; end
        self.start = 0;
        self:SetTextColor(Color(218, 222, 222));
      end

      if (hover) then
        self.h = math.Approach(self.h, h, RealFrameTime() * (speed/3));
      else
        self.h = math.Approach(self.h, btn.start, RealFrameTime() * (speed/3));
      end
      if (self.h >= h - 4 && self.id == 1) then
        draw.RoundedBoxEx(6, 0, h - self.h, w, self.h, theme["Colors"].blue, true, false, false, false);
      else
        draw.RoundedBox(0, 0, h - self.h, w, self.h, theme["Colors"].blue);
      end
    end
    btn.DoClick = function(self, w, h)
      tab = self.id;
      for i,v in pairs (Omni.shop.categories) do
        if (tab == i) then
          v.Panel:SetVisible(true);
        else
          v.Panel:SetVisible(false);
        end
      end
    end

    pnl:Dock(FILL);
    pnl.Paint = function() end

    local scroll = vgui.Create("DScrollPanel", pnl);
    scroll:Dock(FILL);
    local vbar = scroll:GetVBar();
    vbar.Paint = function(self, w, h)
      draw.RoundedBox(0, 0, 0, w, h, theme["Navbar"].color);
    end
    vbar.btnGrip.Paint = function(self, w, h)
      draw.RoundedBox(0, 0, 0, w, h, theme["Frame"].color);
    end
    vbar.btnUp.Paint = function(self, w, h)
      draw.RoundedBox(0, 0, 0, w, h, theme["Frame"].color);
    end
    vbar.btnDown.Paint = function(self, w, h)
      draw.RoundedBox(0, 0, 0, w, h, theme["Frame"].color);
    end

    local layout = vgui.Create("DListLayout", scroll);
    local texture = Material("gui/gradient_down.vtf");
    local changeColor = false;
    for _,v in pairs(Omni.shop.config[i]) do
      if (_ != "catName") then
        local panel = vgui.Create("DPanel");
        panel:Dock(FILL);
        panel.id = _;
        panel.color = Color(59, 75, 98);
        if (changeColor) then
          panel.color = Color(55, 67, 85);
        end
        changeColor = !changeColor;
        panel.Paint = function(self, w, h)
          draw.RoundedBox(0, 0, 0, w, h, self.color);
        end

        local mdl = vgui.Create("DModelPanel", panel);
        mdl:Dock(LEFT);
        mdl:DockMargin(5, 10, 10, 5);
        mdl:SetModel(v.model);
        mdl.LayoutEntity = function() end
        local mn, mx = mdl.Entity:GetRenderBounds()
        local size = 0
        size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
        size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
        size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )

        mdl:SetFOV( 45 )
        mdl:SetCamPos( Vector( size, size, size ) )
        mdl:SetLookAt( (mn + mx) * 0.5 )

        local name = vgui.Create("DLabel", panel);
        name:SetPos(95, 13.5);
        name:SetFont("Omni_ShopName");
        name:SetTextColor(theme["Colors"].whiteGrey);
        name:SetText(v.name or "no name");
        name:SetContentAlignment(5);
        name:SizeToContents();

        local desc = vgui.Create("DLabel", panel);
        desc:SetPos(95, name:GetTall() + 8.5);
        desc:SetFont("Omni_ShopDesc");
        desc:SetTextColor(theme["Colors"].whiteGrey);
        desc:SetText(v.desc or "LOREM IPSUM BBY");
        desc:SetContentAlignment(5);
        desc:SizeToContents();

        local buy = vgui.Create("DButton", panel);
        buy:Dock(RIGHT);
        buy:SetText("PURCHASE");
        buy:SetFont("Omni_ShopBuy");
        buy:DockMargin(0, 20, 20, 20);
        local buyColor;
        if (LocalPlayer():canAfford(v.price or math.random(20, 80))) then
          buyColor = theme["Colors"].green;
        else
          buyColor = theme["Colors"].red;
        end
        buy:AddGhostEffect(theme["Navbar"].color, buyColor,
        function(self, w, h, col, startCol, hover)
          local color;
          if (hover) then
            color = col;
          else
            color = startCol;
          end

          self:SetTextColor(color);
        end);
        buy.DoClick = function(self)
          net.Start("OmniShop_Purchase");
            net.WriteUInt(i, 5);
            net.WriteUInt(_, 16);
          net.SendToServer();
        end

        local price = vgui.Create("DLabel", panel);
        price:Dock(RIGHT);
        price:SetContentAlignment(6);
        price:DockMargin(0, 0, 10, 0);
        price:SetFont("Omni_ShopDollar");
        price:SetText(DarkRP.formatMoney(v.price));
        price:SetTextColor(theme["Colors"].white);
        price:SizeToContents();

        panel.PerformLayout = function(self, w, h)
          DPanel.PerformLayout(self, w, h);
          self:SetTall(80);
          mdl:SetSize(80, 80);
          buy:SetWide(100);
        end
        layout:Add(panel);
      end
    end
    local gradient = vgui.Create("DPanel", pnl);
    gradient.Paint = function(self, w, h)
      surface.SetMaterial(texture);
      surface.SetDrawColor(0, 0, 0, 120);
      surface.DrawTexturedRect(0, 0, w, h);
    end
    pnl.PerformLayout = function(self, w, h)
      DPanel.PerformLayout(self, w, h);
      layout:SetWide(scroll:GetWide());
      gradient:SetSize(w, 5);
    end

    for i,v in pairs (Omni.shop.categories) do
      if (IsValid(v.Panel)) then
        if (i == tab) then
          v.Panel:SetVisible(true);
        else
          v.Panel:SetVisible(false);
        end
      end
    end

  end

  local closeBtn = vgui.Create("DButton", navbar);
  closeBtn:Dock(RIGHT);
  closeBtn:SetText("");
  closeBtn:AddHoverEffect(theme["Navbar"].color, theme["Colors"].blue,
  function(self, w, h, col, startCol, hover)
    draw.NoTexture();
    if (hover) then
      surface.SetDrawColor(col.r, col.g, col.b);
    else
      surface.SetDrawColor(startCol.r, startCol.g, startCol.b);
    end
    surface.DrawTexturedRectRotated(w/2, h/2, 15, 2, 45);
    surface.DrawTexturedRectRotated(w/2, h/2, 15, 2, 135);
  end);
  closeBtn.DoClick = function(self)
    frame:Close();
  end

  frame.PerformLayout = function(self, w, h)
    DFrame.PerformLayout(self, w, h);
    navbar:SetTall(50);
    closeBtn:SetWide(50);
  end

end

concommand.Add("shop", ui)
