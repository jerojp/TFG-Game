--[[
Refactorizar para quitar el nombre del archivo saveGame. Añadir la opcion de resetear juego al modulo de guardar estado cuando se cree.
]]
local btween = require("btween")
local widget = require( "widget" )
require( "viewOptions" )

local function butIntro(event) 
    if (event.phase == "ended" or event.phase == "cancelled") then
        print( "Boton DE INICIO" )
        local destDir = system.DocumentsDirectory  -- where the file is stored
        local results, reason = os.remove( system.pathForFile( "saveGame.json", destDir  ) )
        if results then
            print( "file removed" )
        else
            print( "file does not exist", reason )
        end
        loadSettingGame( )
        _G.CurrentPage = 2 
        _G.GameStarted = true
        dispose(); director:changeScene( "page_2", "fade" )
    end
   return true 
end 

local function continueGame( event )
	-- body
	if (event.phase == "ended" or event.phase == "cancelled") then
        loadSettingGame( )
        dispose(); director:changeScene( "page_".._G.LastPage, "fade" ) 
    end
	
	return true
end

local function btnEtadistics( event )
    -- body
    if (event.phase == "ended" or event.phase == "cancelled") then
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
        dispose(); director:changeScene( "page_65", "fade" ) 
       --[[local parameters = {nameToy="Elefante", pathToy="objeto241.png", costToy="300", widthToy = 233*1.5 , heightToy = 168*1.5}
        dispose(); director:changeScene( parameters, "viewNewToy", "fade" ) ]]--
    end
end

local plane = display.newImageRect( imgDir.. "p1_plane.png", 226, 138 ); 
plane.x = 1407; plane.y = 237; plane.alpha = 1; plane.oldAlpha = 1 
plane.oriX = plane.x; plane.oriY = plane.y 
plane.name = "plane" 
menuGroup:insert(2, plane); menuGroup.plane = plane 
local onEnd_animPlane_855 = function() 
    plane.x = plane.oriX; plane.y = plane.oriY; 
    plane.xScale = 1;plane.yScale = 1; plane.alpha = plane.oldAlpha; plane.rotation = 0; plane.isVisible = true; 
end --ends reStart for animPlane 
gtStash.gt_animPlane = btween.new( plane, 3, { 
         { x = 1427, y = 173}, --regular curve
         { x = 1427, y = 173}, 
         { x = -65, y = -9}, 
         { x = -233, y = 150}, 

         { x = -233, y = 150}, 
         { x = -233, y = 150}, 
         { x = -233, y = 150}, 
         { x = -233, y = 150}, 
angle = 0       }, {ease = gtween.easing.linear, repeatCount = math.huge, reflect = false,  delay=0.1, onComplete=onEnd_animPlane_855}, {  x=1407, y=237,  alpha=1, rotation=0, xScale=1, yScale=1, newAngle=180})        

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
    print( "Hacia delante otra vez" )
    transitionStash["cloud1"] = transition.to( obj, {  time=obj.timeSpeed, x = obj.x+150, onComplete=onCompleteTransitionForward}  )
    cont = cont + 1
end


onCompleteTransitionForward = function( obj )
    -- body
    obj.timeSpeed = math.random(3000,12000)
    transitionStash["cloud2"] = transition.to( obj, {  time=obj.timeSpeed, x = obj.x-150, onComplete=onCompleteTransitionBackWard}  )
    cont = cont + 1
end

for i=1,gp_cloud.numChildren do
    gp_cloud[i].timeSpeed = math.random(3000,12000)
    transitionStash["cloud1"] = transition.to( gp_cloud[i], {  time=gp_cloud[i].timeSpeed, x = gp_cloud[i].x+100, onComplete=onCompleteTransitionForward}  )
end

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
menuGroup:insert(continue)

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
menuGroup:insert(inicGame)

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
menuGroup:insert(options)

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
menuGroup:insert(storeToys)

local statistics  = widget.newButton{
        width = 500,
        height = 100,
        defaultFile = imgDir.. "button.png",
        --overFile = imgDir.. "button.png",
        label = "Estadisticas",
        labelColor = { default={ 255, 255, 255 }, over={ 0, 0, 210 } },
        fontSize = 30,
        onEvent = btnEtadistics
}

statistics.x = display.contentCenterX
statistics.y = display.contentCenterY + 300
statistics:setFillColor( 241,0,38)
menuGroup:insert(statistics)