-- Code created by Kwik - Copyright: kwiksher.com 
-- Version: 2.7.6b 
module(..., package.seeall) 

function new() 
    local numPages = 65 
    local menuGroup = display.newGroup() 
    local dispose 
    local _W = display.contentWidth; 
    local _H = display.contentHeight; 

    local drawScreen = function() 

       local curPage = 1 
       if (tonumber(kBookmark) == 1) then 
          local path = system.pathForFile( "book.txt", system.DocumentsDirectory ) 
          local file = io.open( path, "w+" ) 
          file:write ( curPage.."\n1" ) 
          io.close( file ) 
       end 

       math.randomseed(os.time()) 

       if (tonumber(_G.kAutoPlay) > 0) then 
          local function act_autoPlay(event) 
             if(curPage < numPages) then 
                if(kBidi == false) then  
                   dispose(); director:changeScene( "page_"..curPage+1, "moveFromRight" ) 
                else  
                   dispose(); director:changeScene( "page_"..curPage-1, "moveFromLeft" ) 
                end  
             end 
          end 
          timerStash.timer_AP = timer.performWithDelay( _G.kAutoPlay*1000, act_autoPlay, 1 ) 
       end 

 
       -- Layer names 
       local meadow  
       local sun  

       -- Added variables before layers render 
       _G.TakePhoto = false --  
       _G.IsTakePhoto = false --  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 

       -- meadow positioning 
       meadow = display.newImageRect( imgDir.. "p1_meadow.png", 1280, 800 ); 
       meadow.x = 640; meadow.y = 400; meadow.alpha = 1; meadow.oldAlpha = 1 
       meadow.oriX = meadow.x; meadow.oriY = meadow.y 
       meadow.name = "meadow" 
       menuGroup:insert(1,meadow); menuGroup.meadow = meadow 

       -- sun positioning 
       sun = display.newImageRect( imgDir.. "p1_sun.png", 152, 139 ); 
       sun.x = 192; sun.y = 167; sun.alpha = 1; sun.oldAlpha = 1 
       sun.oriX = sun.x; sun.oriY = sun.y 
       sun.name = "sun" 
       menuGroup:insert(sun); menuGroup.sun = sun 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       --Animations
       gtStash.gt_animSun = gtween.new( sun, 3, {  x=192, y=194,  alpha=1, rotation=0, xScale=1, yScale=1,}, {ease = gtween.easing.linear, repeatCount = math.huge, reflect = true,  delay=0.1, ""}) 

 
       -- Page properties 
       menuGroup.xScale = 1; menuGroup.yScale = 1; 
       menuGroup.alpha = 1; 
 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTweens() 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 
       --[[
Refactorizar para quitar el nombre del archivo saveGame. Añadir la opcion de resetear juego al modulo de guardar estado cuando se cree.
]]
local btween = require("btween")
local widget = require( "widget" )
require( "viewOptions" )
local groupPlane = display.newGroup( )
local groupButtons = display.newGroup( )
local text2
local ch = 1
local audioHandle

local function removeStatitics(  )
  -- body
  local results
  local reason
  --Exercise Draw
  for i=1,5 do
    results, reason = os.remove( system.pathForFile( "screen"..i.."1.jpg", system.DocumentsDirectory  ) )
      results, reason = os.remove( system.pathForFile( "screen"..i.."2.jpg", system.DocumentsDirectory  ) )     
  end
  
  for i=1,5 do
      results, reason = os.remove( system.pathForFile( "audioExLet"..i.."1.wav", system.DocumentsDirectory  ) )
      
      results, reason = os.remove( system.pathForFile( "audioExLet"..i.."2.wav", system.DocumentsDirectory  ) )
  end
end

local function butIntro(event) 
    if (event.phase == "ended" or event.phase == "cancelled") then
        local destDir = system.DocumentsDirectory  -- where the file is stored
        local results, reason = os.remove( system.pathForFile( "saveGame.json", destDir  ) )
        
        display.remove( gp_cloud )
        gp_cloud = nil
        loadSettingGame( )
        removeStatitics(  )
        _G.CurrentPage = 2 
        _G.GameStarted = true
        dispose(); director:changeScene( "page_2", "fade" )
    end
    return true 
end 

local function continueGame( event )
-- body
if (event.phase == "ended" or event.phase == "cancelled") then
    display.remove( gp_cloud )
    gp_cloud = nil
    --loadSettingGame( )
    dispose(); director:changeScene( "page_".._G.LastPage, "fade" ) 
end

return true
end

local function btnEtadistics( event )
    -- body
    if (event.phase == "ended" or event.phase == "cancelled") then
        display.remove( gp_cloud )
        gp_cloud = nil
       _G.CurrentPage = 21
        dispose(); director:changeScene( "page_23", "fade" )  
    end
end

local function btnOptions( event )
-- body
    if (event.phase == "ended" or event.phase == "cancelled") then
       createPanelOptions( )  
    end
end

local function btnStoreToys( event )
-- body
    if (event.phase == "ended" or event.phase == "cancelled") then
        display.remove( gp_cloud )
        gp_cloud = nil
        dispose(); director:changeScene( "page_65", "fade" ) 
       --[[local parameters = {nameToy="Elefante", pathToy="objeto241.png", costToy="300", widthToy = 233*1.5 , heightToy = 168*1.5}
        dispose(); director:changeScene( parameters, "viewNewToy", "fade" ) ]]--
    end
end

local function createButtons( )
-- body
    local plane = display.newImageRect( imgDir.. "p1_plane.png", 226, 138 ); 
    plane.x = 1407; plane.y = 237; plane.alpha = 1; plane.oldAlpha = 1 
    plane.oriX = plane.x; plane.oriY = plane.y 
    plane.name = "plane" 
    menuGroup:insert(2, plane); menuGroup.plane = plane 
    local onEnd_animPlane_855 = function() 
        plane.x = plane.oriX; plane.y = plane.oriY; 
        plane.xScale = 1;plane.yScale = 1; plane.alpha = plane.oldAlpha; plane.rotation = 0; plane.isVisible = true; 
    end --ends reStart for animPlane 
    gtStash.gt_animPlane = btween.new( plane, 4, { 
         { x = 1427, y = 173}, --regular curve
         { x = 1427, y = 173}, 
         { x = -65, y = -9}, 
         { x = -233, y = 150}, 

         { x = -233, y = 150}, 
         { x = -233, y = 150}, 
         { x = -233, y = 150}, 
         { x = -233, y = 150}, 
    angle = 0       }, {ease = gtween.easing.linear, repeatCount = math.huge, reflect = false,  delay=2, onComplete=onEnd_animPlane_855}, {  x=1407, y=237,  alpha=1, rotation=0, xScale=1, yScale=1, newAngle=180})        

    local continue = widget.newButton{
            width = 500,
            height = 100,
            defaultFile = imgDir.. "button.png",
            --overFile = imgDir.. "button.png",
            label = "Continuar",
            labelColor = { default={ 255, 255, 255 }, over={ 0, 0, 210 } },
            fontSize = 30,
            onEvent = continueGame
    }

    continue.x = display.contentCenterX
    continue.y = display.contentCenterY - 300
    continue:setFillColor( 228,89,145)
    groupButtons:insert(continue)

    if (not _G.GameStarted) then
        continue.alpha = 0
    else 
        continue.alpha = 1
    end

    local inicGame  = widget.newButton{
            width = 500,
            height = 100,
            defaultFile = imgDir.. "button.png",
            --overFile = imgDir.. "button.png",
            label = "Nueva Partida",
            labelColor = { default={ 255, 255, 255 }, over={ 0, 0, 210 } },
            fontSize = 30,
            onEvent = butIntro
    }

    inicGame.x = display.contentCenterX
    inicGame.y = display.contentCenterY - 150
    inicGame:setFillColor( 3,137,156 )
    groupButtons:insert(inicGame)

    local options  = widget.newButton{
            width = 500,
            height = 100,
            defaultFile = imgDir.. "button.png",
            --overFile = imgDir.. "button.png",
            label = "Opciones",
            labelColor = { default={ 255, 255, 255 }, over={ 0, 0, 210 } },
            fontSize = 30,
            onEvent = btnOptions
    }

    options.x = display.contentCenterX
    options.y = display.contentCenterY
    options:setFillColor( 0,191,50 )
    groupButtons:insert(options)

    local storeToys  = widget.newButton{
            width = 500,
            height = 100,
            defaultFile = imgDir.. "button.png",
            --overFile = imgDir.. "button.png",
            label = "Juguetes",
            labelColor = { default={ 255, 255, 255 }, over={ 0, 0, 210 } },
            fontSize = 30,
            onEvent = btnStoreToys
    }

    storeToys.x = display.contentCenterX
    storeToys.y = display.contentCenterY + 150
    storeToys:setFillColor( 255,135,0 )
    groupButtons:insert(storeToys)

    local statistics  = widget.newButton{
            width = 500,
            height = 100,
            defaultFile = imgDir.. "button.png",
            --overFile = imgDir.. "button.png",
            label = "Estadísticas",
            labelColor = { default={ 255, 255, 255 }, over={ 0, 0, 210 } },
            fontSize = 30,
            onEvent = btnEtadistics
    }

    statistics.x = display.contentCenterX
    statistics.y = display.contentCenterY + 300
    statistics:setFillColor( 241,0,38)
    groupButtons:insert(statistics)

    if (_G.EnterGame) then
       groupButtons.alpha = 0 
    end
    menuGroup:insert(groupButtons)
end

local function onCompleteEndPlane( obj )
    -- body
    local function onCompleteText2( )
        -- body
        text2:removeSelf( )
        text2=nil
        display.remove( groupPlane )
        groupPlane = nil
        createButtons()
        transition.to( groupButtons, {timer = 2000, alpha = 1} )
        _G.EnterGame = false
    end
    local function onCompleteTimer( event )
        -- body
        transition.to( text2, {timer = 1000, alpha = 0, onComplete = onCompleteText2} )
    end
    timerStash.timBut = timer.performWithDelay( 2000, onCompleteTimer )
end

local function onCompleteLetter1 (obj)
    localX, localY = obj:localToContent( 0, 0 )

    local options = {
          text = "REISE\nEl viaje de las vocales",     
          x = obj.x,
          y = obj.y,
          width = 700,     --required for multi-line and alignment
          font = native.systemFontBold,   
          fontSize = 65,
          align = "center"  --new alignment parameter
    }
    text2 = display.newText(options)
    text2.x = localX; text2.y = localY - text2.contentHeight/2
    text2:setFillColor( 0 )
    --menuGroup:insert(text2)
    obj.alpha = 0
    --[[audioHandle = audio.loadSound( audioDir.."airplane.mp3")
    audio.play( audioHandle , {channel = ch, duration = 2000 , onComplete = onCompleteSoundPlane})--]]
    transition.to( groupPlane, {time = 2000, x = -display.contentWidth - groupPlane.contentWidth, onComplete=onCompleteEndPlane} )
end

local function onCompleteTran1( obj )
    -- body
    transition.to( obj[3], {time = 500, y = obj[3].y-obj[3].contentHeight/2-10, yScale = 0, onComplete=onCompleteLetter1} )
end

local function onCompleteSoundPlane( event )
    -- body
    audio.dispose( audioHandle )
    audioHandle = nil
end

local cloud 
local gp_cloud = display.newGroup() 
local num_cloud = 3
local afterX = -100

for i=1,num_cloud do
    cloud= display.newImageRect( imgDir.. "cloud.png", 192, 63 ); 
    cloud.x = math.random(0,1280)
    if (cloud.x >= afterX-cloud.contentWidth/2 and cloud.x <= afterX+cloud.contentWidth/2) then
        cloud.x = cloud.x + cloud.contentWidth + 100
    end
    afterX = cloud.x
    cloud.y = math.random(cloud.contentHeight ,230)
    cloud.alpha = math.random(60,80) / 100 
    cloud.oldAlpha = 1
    gp_cloud:insert(cloud) 
end 
menuGroup:insert(gp_cloud) 

local onCompleteTransitionBackWard
local onCompleteTransitionForward
local cont = 0

onCompleteTransitionBackWard = function( obj )
-- body
    transitionStash[obj.name] = transition.to( obj, {  time=obj.timeSpeed, x = obj.x+150, onComplete=onCompleteTransitionForward}  )
    cont = cont + 1
end


onCompleteTransitionForward = function( obj )
-- body
    transitionStash[obj.name] = transition.to( obj, {  time=obj.timeSpeed, x = obj.x-150, onComplete=onCompleteTransitionBackWard}  )
    cont = cont + 1
end

for i=1,gp_cloud.numChildren do
    gp_cloud[i].timeSpeed = math.random(3000,18000)
    gp_cloud[i].name = "cloud"..i
    transitionStash[gp_cloud[i].name] = transition.to( gp_cloud[i], {  time=gp_cloud[i].timeSpeed, x = gp_cloud[i].x+100, onComplete=onCompleteTransitionForward}  )
end

if (_G.EnterGame) then
    local planeIntro = display.newImageRect( imgDir.. "p1_plane.png", 226, 138 ); 
    planeIntro.x = display.contentWidth + planeIntro.contentWidth/2; planeIntro.y = display.contentCenterY;

    local panel = display.newImageRect( imgDir.. "pancarta.png", 462, 87 ); 
    panel.x = planeIntro.x+planeIntro.contentWidth/2+panel.contentWidth/2-50 ; panel.y = display.contentCenterY - 8
    groupPlane:insert( panel )
    groupPlane:insert( planeIntro )

    local options = {
          text = "REISE\nEl viaje de las vocales",     
          x = panel.x,
          y = panel.y,
          width = 400,     --required for multi-line and alignment
          font = native.systemFontBold,   
          fontSize = 22,
          align = "center"  --new alignment parameter
    }
    local textPanel = display.newText(options)
    textPanel.x = panel.x+55; textPanel.y = panel.y
    textPanel:setFillColor( 0 )
    groupPlane:insert( textPanel )
    --menuGroup:insert( groupPlane )
    groupPlane.anchorChildren = true
    --groupPlane:translate( -display.contentCenterX, 0 )
    --[[audioHandle = audio.loadSound( audioDir.."airplane.mp3")
    audio.play( audioHandle , {channel = ch, duration = 3000 , onComplete = onCompleteSoundPlane})--]]
    transitionStash.groupPlane = transition.to( groupPlane, {time = 3000, delay = 2000, x = -display.contentCenterX - groupPlane.contentWidth/2 - 100, transition=easing.outQuad, onComplete = onCompleteTran1} )
else
    createButtons( )
end 


    end 
    drawScreen() 

    return menuGroup 
end 
