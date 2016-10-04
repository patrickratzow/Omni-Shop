OmniShop.levelSystemTable = {
  ["vrondakis"] = {
    ["xp"] = {
      get = function(ply) ply:getXP(); end,
      set = function(ply, amt) ply:setXP(amt); end,
      add = function(ply, amt) ply:addXP(amt); end
    },
    ["level"] = {
      get = function(ply) ply:getLevel(); end,
      set = function(ply, amt) ply:setLevel(amt); end,
      add = function(ply, amt) ply:addLevel(ply, amt); end,
    },
  },
}
