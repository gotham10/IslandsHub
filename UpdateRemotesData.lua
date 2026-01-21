local swordPath = game:GetService("ReplicatedStorage").TS.tool.tools.sword
local cropPath = game:GetService("StarterPlayer").StarterPlayerScripts.TS.block.crop["crop-service"]
local invPath = game:GetService("StarterPlayer").StarterPlayerScripts.TS.ui.inventory["client-inventory-service"]
local blockPath = game:GetService("StarterPlayer").StarterPlayerScripts.TS.flame.controllers.block["block-controller"]
local axePath = game:GetService("ReplicatedStorage").TS.tool.tools.shared["axe-tool"]
local projPath = game:GetService("StarterPlayer").StarterPlayerScripts.TS.flame.controllers.combat["projectile-controller"]
local rodPath = game:GetService("ReplicatedStorage").TS.tool.tools["fishing-rod"]
local fishCtrlPath = game:GetService("StarterPlayer").StarterPlayerScripts.TS.flame.controllers.fishing["fishing-controller"]
local function getSource(p) local s, res = pcall(function() return decompile(p) end) return s and res or "" end
local srcSword = getSource(swordPath)
local m1, m2 = srcSword:match('%["hitUnit"%]%s*=%s*[^,]+,%s*%["([^"]+)"%]%s*=%s*"([^"]+)"')
local kn1 = srcSword:match('GetNamespace%("([^"]+)"%)')
local kn2 = srcSword:match(':Get%("([^"]+)"%):CallServerAsync')
local srcCrop = getSource(cropPath)
local c1, c2 = srcCrop:match('%["([^"]+)"%]%s*=%s*"([^"]+)",%s*%["player"%]')
local srcInv = getSource(invPath)
local p1, p2 = srcInv:match('%["tool"%]%s*=%s*[^,]+,%s*%["([^"]+)"%]%s*=%s*"([^"]+)"')
local srcBlock = getSource(blockPath)
local b1, b2 = srcBlock:match('%["blockType"%]%s*=%s*[^,]+,%s*%["([^"]+)"%]%s*=%s*"([^"]+)"')
local srcAxe = getSource(axePath)
local a1, a2 = srcAxe:match('%["norm"%]%s*=%s*[^,]+,%s*%["([^"]+)"%]%s*=%s*"([^"]+)"')
local srcProj = getSource(projPath)
local pr1, pr2 = srcProj:match('function%s+[^%s%(]+%.shootSpellProjectile.-%["([^"]+)"%]%s*=%s*"([^"]+)"')
local prns = srcProj:match('GetNamespace%("([^"]+)"%)')
local prbr = srcProj:match('%.shootSpell%s*=%s*[^%.]+%.remotes:Get%("([^"]+)"%)')
local srcRod = getSource(rodPath)
local rns = srcRod:match('GetNamespace%("([^"]+)"%)')
local rget = srcRod:match(':Get%("([^"]+)"%).-playerLocation')
local srcFishCtrl = getSource(fishCtrlPath)
local fcns = srcFishCtrl:match('GetNamespace%("([^"]+)"%)')
local fcget = srcFishCtrl:match(':Get%("([^"]+)"%):SendToServer')
local output = "return {\n"
output = output .. '    MotHitH1 = "' .. tostring(m1 or "") .. '",\n'
output = output .. '    MotHitH2 = "' .. tostring(m2 or "") .. '",\n'
output = output .. '    CropPlaceH1 = "' .. tostring(c1 or "") .. '",\n'
output = output .. '    CropPlaceH2 = "' .. tostring(c2 or "") .. '",\n'
output = output .. '    PickupH1 = "' .. tostring(p1 or "") .. '",\n'
output = output .. '    PickupH2 = "' .. tostring(p2 or "") .. '",\n'
output = output .. '    PlaceHASHName = "' .. tostring(b1 or "") .. '",\n'
output = output .. '    PlaceHASH = "' .. tostring(b2 or "") .. '",\n'
output = output .. '    BreakHASHName = "' .. tostring(a1 or "") .. '",\n'
output = output .. '    BreakHASH = "' .. tostring(a2 or "") .. '",\n'
output = output .. '    shootSpellName = "' .. tostring(pr1 or "") .. '",\n'
output = output .. '    shootSpellHashName = "' .. tostring(pr2 or "") .. '",\n'
output = output .. '    KillRemote = "' .. tostring(kn1 or "") .. "/" .. tostring(kn2 or "") .. '",\n'
output = output .. '    AngelRemote = "' .. tostring(rns or "") .. "/" .. tostring(rget or "") .. '",\n'
output = output .. '    FishFarmFinishRemote = "' .. tostring(fcns or "") .. "/" .. tostring(fcget or "") .. '",\n'
output = output .. '    shootSpellBookRemote = "' .. tostring(prns or "") .. "/" .. tostring(prbr or "") .. '",\n'
output = output .. '    SpiritRemote = ""\n'
output = output .. "}"
setclipboard(output)
