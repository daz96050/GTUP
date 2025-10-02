
local function tech(name, overlay, packs, prereq, effects)
  local t = {
    type = "technology",
    name = name,
    icons = {
      {icon="__base__/graphics/technology/gun-turret.png", icon_size=256, icon_mipmaps=4},
      {icon="__gun-turret-upgrade-pack__/graphics/technology/"..overlay, icon_size=256, scale=1.0}
    },
    effects = effects,
    prerequisites = prereq,
    unit = { count = 200, time = 30, ingredients = packs },
    upgrade = true
  }
  data:extend({t})
end

local packs2 = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"military-science-pack", 1}}
local packs3 = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"military-science-pack", 1}, {"chemical-science-pack", 1}}
local packs4 = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"military-science-pack", 1}, {"chemical-science-pack", 1}, {"production-science-pack", 1}}
local packs5 = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"military-science-pack", 1}, {"chemical-science-pack", 1}, {"production-science-pack", 1}, {"utility-science-pack", 1}}

tech("gun-turret-mk2-tech", "mk2-overlay.png", packs2, {"military-2"}, {{type="unlock-recipe", recipe="gun-turret-mk2"}})
tech("gun-turret-mk3-tech", "mk3-overlay.png", packs3, {"gun-turret-mk2-tech"}, {{type="unlock-recipe", recipe="gun-turret-mk3"}})
tech("gun-turret-mk4-tech", "mk4-overlay.png", packs4, {"gun-turret-mk3-tech"}, {{type="unlock-recipe", recipe="gun-turret-mk4"}})
tech("gun-turret-mk5-tech", "mk5-overlay.png", packs5, {"gun-turret-mk4-tech"}, {{type="unlock-recipe", recipe="gun-turret-mk5"}})
