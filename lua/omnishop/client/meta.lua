local function findColorDifference(b,c)local d,e,f=b.r,b.g,b.b;local g,h,i=c.r,c.g,c.b;local j;local k;local l;if d>=g then j=g;l=d;k=g else j=d;l=g;k=d end;local m;local n;local o;if e>=h then m=h;o=e;n=h else m=e;o=h;n=e end;local p;local q;local r;if f>=i then p=i;r=f;q=i else p=f;r=i;q=i end;return j,k,l,m,n,o,p,q,r end
-- minified and lost the orginial version lol. I'll explain it even through its not hard to read.
-- basically finds a min and max for math.Approach for 2 colors :P

local pnlMeta = FindMetaTable("Panel");
local speed = 900;

function pnlMeta:AddHoverEffect(prevCol, nextCol, func)
  local r2,g2,b2 = nextCol.r, nextCol.g, nextCol.b;
  local alpha = 0;
  local r,rLe,rMax,g,gLe,gMax,b,bLe,bMax = findColorDifference(Color(r2, g2, b2), Color(prevCol.r, prevCol.g, prevCol.b));
  local haveTouchedHover = false;

  self.Paint = function(self, w, h)
    local hover = self:IsHovered();

    if (!hover && alpha >= 1) then
      alpha = math.Approach(0, 255, alpha - (RealFrameTime()*speed) );
      r = math.Approach(rLe, rMax, r - (RealFrameTime()*speed) );
      g = math.Approach(gLe, gMax, g - (RealFrameTime()*speed) );
      b = math.Approach(bLe, bMax, b - (RealFrameTime()*speed) );
      if (alpha <= 8) then
        alpha = 0;
      end
    elseif (hover && alpha <= 255) then
      alpha = math.Approach(0, 255, alpha + (RealFrameTime()*speed) );
      r = math.Approach(rLe, prevCol.r, r + (RealFrameTime()*speed) );
      g = math.Approach(gLe, prevCol.g,  g + (RealFrameTime()*speed) );
      b = math.Approach(bLe, prevCol.b, b + (RealFrameTime()*speed) );
      haveTouchedHover = true;
    end

    draw.RoundedBoxEx(6, 0, 0, w, h, Color(r2, g2, b2,alpha), false, true, false, false);

    if (func) then
      func(self, w, h, Color(r, g, b, alpha), Color(r2, g2, b2, alpha), haveTouchedHover)
    end
  end

end

function pnlMeta:AddGhostEffect(prevCol, nextCol, func)
  local r2,g2,b2 = nextCol.r, nextCol.g, nextCol.b;
  local alpha = 0;
  local r,rLe,rMax,g,gLe,gMax,b,bLe,bMax = findColorDifference(Color(r2, g2, b2), Color(prevCol.r, prevCol.g, prevCol.b));
  local haveTouchedHover = false;

  self.Paint = function(self, w, h)
    local hover = self:IsHovered();

    if (!hover && alpha >= 1) then
      alpha = math.Approach(0, 255, alpha - (RealFrameTime()*speed) );
      r = math.Approach(rLe, rMax, r - (RealFrameTime()*speed) );
      g = math.Approach(gLe, gMax, g - (RealFrameTime()*speed) );
      b = math.Approach(bLe, bMax, b - (RealFrameTime()*speed) );
      if (alpha <= 8) then
        alpha = 0;
      end
    elseif (hover && alpha <= 255) then
      alpha = math.Approach(0, 255, alpha + (RealFrameTime()*speed) );
      r = math.Approach(rLe, prevCol.r, r + (RealFrameTime()*speed) );
      g = math.Approach(gLe, prevCol.g,  g + (RealFrameTime()*speed) );
      b = math.Approach(bLe, prevCol.b, b + (RealFrameTime()*speed) );
      haveTouchedHover = true;
    end

    draw.RoundedBox(0, 0, 0, w, 2, Color(r2, g2, b2));
    draw.RoundedBox(0, 0, 2, 2, h - 2, Color(r2, g2, b2));
    draw.RoundedBox(0, 2, h - 2, w - 4, 2, Color(r2, g2, b2));
    draw.RoundedBox(0, w - 2, 2, 2, h - 2, Color(r2, g2, b2));
    draw.RoundedBox(0, 0, 0, w, h, Color(r2, g2, b2, alpha));

    if (func) then
      func(self, w, h, Color(r, g, b), Color(r2, g2, b2), haveTouchedHover)
    end
  end
end

function pnlMeta:AddFadeEffect(prevCol, nextCol, func)
  local r2,g2,b2 = nextCol.r, nextCol.g, nextCol.b;
  local alpha = 0;
  local r,rLe,rMax,g,gLe,gMax,b,bLe,bMax = findColorDifference(Color(r2, g2, b2), Color(prevCol.r, prevCol.g, prevCol.b));
  local haveTouchedHover = false;

  self.Paint = function(self, w, h)
    local hover = self:IsHovered();

    if (!hover && alpha >= 1) then
      alpha = math.Approach(0, 255, alpha - (RealFrameTime()*speed) );
      r = math.Approach(rLe, rMax, r - (RealFrameTime()*speed) );
      g = math.Approach(gLe, gMax, g - (RealFrameTime()*speed) );
      b = math.Approach(bLe, bMax, b - (RealFrameTime()*speed) );
      if (alpha <= 8) then
        alpha = 0;
      end
    elseif (hover && alpha <= 255) then
      alpha = math.Approach(0, 255, alpha + (RealFrameTime()*speed) );
      r = math.Approach(rLe, prevCol.r, r + (RealFrameTime()*speed) );
      g = math.Approach(gLe, prevCol.g,  g + (RealFrameTime()*speed) );
      b = math.Approach(bLe, prevCol.b, b + (RealFrameTime()*speed) );
      haveTouchedHover = true;
    end

    if (func) then
      func(self, w, h, Color(r, g, b, alpha), Color(r2, g2, b2, alpha), haveTouchedHover)
    end
  end
end
