OmniShop.levelSystemTable = {
  ["vrondakis"] = {
    ["xp"] = {
      get = function(ply) return ply:getDarkRPVar("xp"); end,
      set = function(ply, amt) ply:setXP(amt); end,
      add = function(ply, amt) ply:addXP(amt); end
    },
    ["level"] = {
      get = function(ply) return ply:getDarkRPVar("level"); end,
      set = function(ply, amt) ply:setLevel(amt); end,
      add = function(ply, amt) ply:addLevels(amt); end
    },
  },
}
