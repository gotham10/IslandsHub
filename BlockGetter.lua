local HttpService = game:GetService("HttpService")
local Islands = game:GetService("Workspace").Islands
local islandFolder = nil

for _, folder in pairs(Islands:GetChildren()) do
    if folder.Name:match("-island$") then
        islandFolder = folder
        break
    end
end

if islandFolder and islandFolder:FindFirstChild("Blocks") then
    local blocksFolder = islandFolder.Blocks
    local data = {Size = {"0, 0, 0"},Blocks = {}}
    local min, max = Vector3.new(math.huge, math.huge, math.huge), Vector3.new(-math.huge, -math.huge, -math.huge)
    local foundParts = false
    local targetIgnoreCFrame = CFrame.new(-3494, 39, -3665, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    for _, v in pairs(blocksFolder:GetChildren()) do
        if v:IsA("BasePart") then
            if v.Name == "portalToSpawn" then
                continue
            end
            if v.CFrame == targetIgnoreCFrame then
                continue
            end
            foundParts = true
            min = Vector3.new(math.min(min.X, v.Position.X), math.min(min.Y, v.Position.Y), math.min(min.Z, v.Position.Z))
            max = Vector3.new(math.max(max.X, v.Position.X), math.max(max.Y, v.Position.Y), math.max(max.Z, v.Position.Z))
            local name = v.Name
            if not data.Blocks[name] then
                data.Blocks[name] = {}
            end
            table.insert(data.Blocks[name], {C = {v.CFrame:GetComponents()}})
        end
    end
    if foundParts then
        data.Size = {tostring(max - min)}
    end
    local dataString = HttpService:JSONEncode(data)
    setclipboard(dataString)
end
