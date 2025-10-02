
if mods and mods["distant-misfires"] and settings.startup["gtup-vanilla-plus4"] and settings.startup["gtup-vanilla-plus4"].value then
  local gt = data.raw["ammo-turret"] and data.raw["ammo-turret"]["gun-turret"]
  if gt then
    gt.attack_parameters = gt.attack_parameters or {}
    gt.attack_parameters.range = (gt.attack_parameters.range or 18) + 4
  end
end
