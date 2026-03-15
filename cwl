local UnionScriptLoader = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Uistroke = Instance.new("UIStroke")
local Main = Instance.new("TextLabel")
local Man = Instance.new("TextLabel")
local QQ = Instance.new("TextLabel")
local Message = Instance.new("TextLabel")
local Loading = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")



local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")



local API_URL = "https://unionscriptmanager.zuohongjian.workers.dev"


local verificationComplete = false


local function getPlayerInfo()
    local player = game:GetService("Players").LocalPlayer
    return {
        username = player.Name,
        userId = tostring(player.UserId),
        displayName = player.DisplayName,
        accountAge = player.AccountAge,
        scriptId = getgenv().SCRIPT_ID
    }
end


local function checkWhitelist()
    local requestFunc = syn and syn.request or http_request or request
    if not requestFunc then
        return false
    end
    
    local success, result = pcall(function()
        local playerInfo = getPlayerInfo()
        
        
        local response = requestFunc({
            Url = API_URL .. "/api/check",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(playerInfo)
        })
        
        if response and response.StatusCode == 200 then
            local body = response.Body or ""
            
            
            if string.find(body, "whitelisted") and string.find(body, "true") then
                
                return true
            else
                
                return false
            end
        else
            return false
        end
    end)
    
    return success and result == true
end


local function playEndAnimation()
    verificationComplete = true
    
    
    for _, tween in ipairs(TweenService:GetChildren()) do
        if tween:IsA("Tween") then
            tween:Cancel()
        end
    end
    
    
    Loading.Size = UDim2.new(0.838062584, 0, 0.0189999994, 0)
    
    
    task.wait(2)
    
    
    local labels = {Main, Man, QQ, Message}
    local fadeOutTweens = {}
    
    for _, label in ipairs(labels) do
        local fadeOut = TweenService:Create(
            label,
            TweenInfo.new(0.3, Enum.EasingStyle.Linear),
            {TextTransparency = 1}
        )
        table.insert(fadeOutTweens, fadeOut)
        fadeOut:Play()
    end
    
    
    local loadingFadeOut = TweenService:Create(
        Loading,
        TweenInfo.new(0.3, Enum.EasingStyle.Linear),
        {BackgroundTransparency = 1}
    )
    loadingFadeOut:Play()
    
    
    task.wait(0.3)
    
    
    local shrinkHeight = TweenService:Create(
        MainFrame,
        TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Size = UDim2.new(0.85, 0, 0.05, 0)}
    )
    shrinkHeight:Play()
    
    shrinkHeight.Completed:Connect(function()
        local shrinkWidth = TweenService:Create(
            MainFrame,
            TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0.05, 0)}
        )
        shrinkWidth:Play()
        
        shrinkWidth.Completed:Connect(function()
            
            UnionScriptLoader:Destroy()
        end)
    end)
end


UnionScriptLoader.Name = "UnionScriptLoader"
UnionScriptLoader.Parent = game:GetService("CoreGui")
UnionScriptLoader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UnionScriptLoader.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = UnionScriptLoader
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 55, 65)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 0, 0.05, 0)  
MainFrame.ClipsDescendants = true  

UICorner.CornerRadius = UDim.new(0.0199999996, 0)
UICorner.Parent = MainFrame

Uistroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
Uistroke.Thickness = 0.005
Uistroke.Parent = MainFrame

Main.Name = "Main"
Main.Parent = MainFrame
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.BackgroundTransparency = 1.000
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, 0, 0.200000003, 0)
Main.Size = UDim2.new(1, 0, 0.25, 0)
Main.Font = Enum.Font.SourceSans
Main.Text = "联邦脚本管理器"
Main.TextColor3 = Color3.fromRGB(255, 255, 255)
Main.TextScaled = true
Main.TextSize = 14.000
Main.TextStrokeTransparency = 0.000
Main.TextWrapped = true
Main.TextXAlignment = Enum.TextXAlignment.Left
Main.TextTransparency = 1

Man.Name = "Man"
Man.Parent = MainFrame
Man.AnchorPoint = Vector2.new(0.5, 0.5)
Man.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Man.BackgroundTransparency = 1.000
Man.BorderColor3 = Color3.fromRGB(0, 0, 0)
Man.BorderSizePixel = 0
Man.Position = UDim2.new(0.5, 0, 0.4481785, 0)
Man.Size = UDim2.new(1, 0, 0.25, 0)
Man.Font = Enum.Font.SourceSans
Man.Text = "作者:zuohongjian"
Man.TextColor3 = Color3.fromRGB(255, 255, 255)
Man.TextScaled = true
Man.TextSize = 14.000
Man.TextStrokeTransparency = 0.000
Man.TextWrapped = true
Man.TextXAlignment = Enum.TextXAlignment.Left
Man.TextTransparency = 1

QQ.Name = "QQ"
QQ.Parent = MainFrame
QQ.AnchorPoint = Vector2.new(0.5, 0.5)
QQ.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
QQ.BackgroundTransparency = 1.000
QQ.BorderColor3 = Color3.fromRGB(0, 0, 0)
QQ.BorderSizePixel = 0
QQ.Position = UDim2.new(0.5, 0, 0.669034719, 0)
QQ.Size = UDim2.new(1, 0, 0.19171235, 0)
QQ.Font = Enum.Font.SourceSans
QQ.Text = "QQ群: 1040279174"
QQ.TextColor3 = Color3.fromRGB(255, 255, 255)
QQ.TextScaled = true
QQ.TextSize = 14.000
QQ.TextStrokeTransparency = 0.000
QQ.TextWrapped = true
QQ.TextXAlignment = Enum.TextXAlignment.Left
QQ.TextTransparency = 1

Message.Name = "Message"
Message.Parent = MainFrame
Message.AnchorPoint = Vector2.new(0.5, 0.5)
Message.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Message.BackgroundTransparency = 1.000
Message.BorderColor3 = Color3.fromRGB(0, 0, 0)
Message.BorderSizePixel = 0
Message.Position = UDim2.new(0.5, 0, 0.805646658, 0)
Message.Size = UDim2.new(1, 0, 0.0815117955, 0)
Message.Font = Enum.Font.SourceSans
Message.Text = "验证中..."  
Message.TextColor3 = Color3.fromRGB(255, 255, 255)
Message.TextScaled = true
Message.TextSize = 14.000
Message.TextStrokeTransparency = 0.000
Message.TextWrapped = true
Message.TextXAlignment = Enum.TextXAlignment.Left
Message.TextTransparency = 1

Loading.Name = "Loading"
Loading.Parent = UnionScriptLoader
Loading.BackgroundColor3 = Color3.fromRGB(55, 255, 0)
Loading.BorderColor3 = Color3.fromRGB(0, 0, 0)
Loading.BorderSizePixel = 0
Loading.Position = UDim2.new(0.0809689462, 0, 0.714936256, 0)
Loading.Size = UDim2.new(0, 0, 0.0189999994, 0)
Loading.BackgroundTransparency = 1

UICorner_2.Parent = Loading


task.wait(0.1)

local tweenInfo1 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local goal1 = { Size = UDim2.new(0.85, 0, 0.05, 0) }
local tween1 = TweenService:Create(MainFrame, tweenInfo1, goal1)
tween1:Play()

tween1.Completed:Connect(function()
    local tweenInfo2 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local goal2 = { Size = UDim2.new(0.85, 0, 0.5, 0) }
    local tween2 = TweenService:Create(MainFrame, tweenInfo2, goal2)
    tween2:Play()

    tween2.Completed:Connect(function()
        
        local tweenInfo3 = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
        local labels = {Main, Man, QQ, Message}
        
        for _, label in ipairs(labels) do
            local goal3 = {TextTransparency = 0}
            local tween3 = TweenService:Create(label, tweenInfo3, goal3)
            tween3:Play()
        end
        
        
        local loadingFadeIn = TweenService:Create(
            Loading,
            TweenInfo.new(0.3, Enum.EasingStyle.Linear),
            {BackgroundTransparency = 0}
        )
        loadingFadeIn:Play()
        
        Message.Text = "验证中..."
        
        
        local currentTween = nil
        local targetWidths = {0.1, 0.15, 0.22, 0.28, 0.35, 0.4, 0.48, 0.52, 0.6, 0.65, 0.7, 0.75, 0.8, 0.82, 0.85, 0.88, 0.838062584}
        local currentIndex = 1
        
        local function nextStep()
            if verificationComplete then
                return 
            end
            
            if currentIndex <= #targetWidths then
                task.wait(0.1 + math.random() * 0.2)
                
                if verificationComplete then
                    return 
                end
                
                currentTween = TweenService:Create(
                    Loading,
                    TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.new(targetWidths[currentIndex], 0, 0.0189999994, 0)}
                )
                currentTween:Play()
                
                currentIndex = currentIndex + 1
                coroutine.wrap(nextStep)()
            end
        end
        coroutine.wrap(nextStep)()
        
        
        coroutine.wrap(function()
            task.wait(1) 
            
            local whitelisted = checkWhitelist()
            
            
            verificationComplete = true
            
            
            if currentTween then
                currentTween:Cancel()
            end
            
            
            local finishTween = TweenService:Create(
                Loading,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0.838062584, 0, 0.0189999994, 0)}  
            )
            finishTween:Play()
            
            if whitelisted then
                Message.Text = "验证通过！欢迎使用"
                Message.TextColor3 = Color3.fromRGB(0, 255, 0)
                
                local successColor = TweenService:Create(
                    Loading,
                    TweenInfo.new(0.3),
                    {BackgroundColor3 = Color3.fromRGB(0, 255, 0)}
                )
                successColor:Play()
                
                
                
                
                playEndAnimation()
                task.wait(0.3)
            else
                Message.Text = "验证失败: 不在白名单中"
                Message.TextColor3 = Color3.fromRGB(255, 0, 0)
                
                local failColor = TweenService:Create(
                    Loading,
                    TweenInfo.new(0.3),
                    {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}
                )
                failColor:Play()
                
                
                game:GetService("Players").LocalPlayer:Kick("您不在白名单中，无法使用此脚本")
            end
        end)()
    end)
end)
