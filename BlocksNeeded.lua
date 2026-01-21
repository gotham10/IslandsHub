local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Islands = game:GetService("Workspace").Islands
local toolsFolder = ReplicatedStorage:FindFirstChild("Tools")
local islandFolder = nil

for _, folder in pairs(Islands:GetChildren()) do
    if folder.Name:match("-island$") then
        islandFolder = folder
        break
    end
end

if islandFolder and islandFolder:FindFirstChild("Blocks") and toolsFolder then
    local blocksFolder = islandFolder.Blocks
    local counts = {}
    local totalBlocks = 0
    for _, v in pairs(blocksFolder:GetChildren()) do
        if v:IsA("BasePart") then
            local name = v.Name
            local lowerName = name:lower()
            if lowerName == "bedrock" then
                continue
            end
            if lowerName:find("portal") and lowerName:find("tospawn") then
                continue
            end
            counts[name] = (counts[name] or 0) + 1
            totalBlocks = totalBlocks + 1
        end
    end
    local output = ""
    for internalName, count in pairs(counts) do
        local displayName = internalName
        local tool = toolsFolder:FindFirstChild(internalName)
        if tool then
            local dv = tool:FindFirstChild("DisplayName")
            if dv and dv:IsA("StringValue") then
                displayName = dv.Value
            end
        end
        output = output .. displayName .. "(" .. internalName .. "):" .. tostring(count) .. "\n"
    end
    output = output .. "------------------------------\n"
    output = output .. "Total Blocks: " .. tostring(totalBlocks)
    setclipboard(output)
end
