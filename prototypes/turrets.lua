
local dm_active = mods and mods["distant-misfires"]
local RANGE_BONUS_DM = dm_active and 4 or 0

local base = table.deepcopy(data.raw["ammo-turret"]["gun-turret"])
data.raw["ammo-turret"]["gun-turret"].next_upgrade = "gun-turret-mk2"
local base_item = table.deepcopy(data.raw.item["gun-turret"])

local ap = base.attack_parameters or {}
local base_range = (ap.range or 18)
local base_cooldown = ap.cooldown or 6
local base_sps = 60 / base_cooldown

local function make_mk(n, prev_name, extra_ingredients, total_range_over_base, prev_sps, next_tier)
  local name = "gun-turret-mk"..n
  -- ENTITY
  local ent = table.deepcopy(base)
  ent.name = name
  ent.minable = {mining_time = 0.5, result = name}
  ent.fast_replaceable_group = "gun-turret"
  if next_tier then
    ent.next_upgrade = "gun-turret-mk" .. next_tier
  else
    ent.next_upgrade = nil
  end
  ent.icons = {
    {icon="__base__/graphics/icons/gun-turret.png", icon_size=64, icon_mipmaps=4},
    {icon="__gun-turret-upgrade-pack__/graphics/icons/mk"..n.."-overlay.png", icon_size=64, scale=1.0}
  }
  ent.attack_parameters = ent.attack_parameters or {}
  ent.attack_parameters.range = base_range + total_range_over_base + RANGE_BONUS_DM

  local this_sps = (prev_sps or base_sps) + 2
  ent.attack_parameters.cooldown = math.max(1, math.floor(60 / this_sps + 0.5))

  -- ITEM
  local item = table.deepcopy(base_item)
  item.name = name
  item.icons = {
    {icon="__base__/graphics/icons/gun-turret.png", icon_size=64, icon_mipmaps=4},
    {icon="__gun-turret-upgrade-pack__/graphics/icons/mk"..n.."-overlay.png", icon_size=64, scale=1.0}
  }
  item.place_result = name
  item.order = (base_item.order or "b[turret]-a[gun-turret]").."-mk"..n

  -- RECIPE (explicit results + main_product for Quality)
  local rec = {
    type = "recipe",
    name = name,
    enabled = false,
    energy_required = 15,
    ingredients = {{type="item", name=prev_name, amount=1}},
    results = {{type="item", name=name, amount=1}},
    main_product = name
  }
  for _, ing in ipairs(extra_ingredients) do table.insert(rec.ingredients, ing) end

  data:extend({ent, item, rec})
  return name, this_sps
end

-- MK2
local mk2_name, mk2_sps = make_mk(2, "gun-turret", {
  {type="item", name="steel-plate", amount=20},
  {type="item", name="electronic-circuit", amount=20}
}, 2, base_sps, 3)

-- MK3
local mk3_name, mk3_sps = make_mk(3, mk2_name, {
  {type="item", name="electric-engine-unit", amount=10},
  {type="item", name="advanced-circuit", amount=20}
}, 4, mk2_sps,4)

-- MK4
local mk4_name, mk4_sps = make_mk(4, mk3_name, {
  {type="item", name="battery", amount=20},
  {type="item", name="electric-engine-unit", amount=20},
  {type="item", name="electronic-circuit", amount=40}
}, 6, mk3_sps,5)

-- MK5
local mk5_name, mk5_sps = make_mk(5, mk4_name, {
  {type="item", name="processing-unit", amount=20},
  {type="item", name="copper-cable", amount=100},
  {type="item", name="low-density-structure", amount=20}
}, 8, mk4_sps, nil)
