-- Code created by Kwik - Copyright: kwiksher.com 
-- Version: 2.7.6b 
module(..., package.seeall) 

function new() 
    local numPages = 22 
    local menuGroup = display.newGroup() 
    local dispose 
    local _W = display.contentWidth; 
    local _H = display.contentHeight; 

    local drawScreen = function() 

       local curPage = 1 

       Navigation.new("page", { backColor = {255, 255, 255}, anim=1, timer=1,  totPages = numPages, curPage = curPage, thumbW = 200, thumbH = 125, alpha = 1, imageDir = imgDir, dire = "top", audio={} } ) 
       Navigation.hide() 

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

 
       -- Button names 
       local but_371

       -- Layer names 
       local meadow  
       local sun  
       local cloud  
       local plane  

       -- Added variables before layers render 
       _G.TakePhoto = false --  
       _G.IsTakePhoto = false --  

       -- (TOP) External code will render here 
       local widget = require( "widget" )

local function butIntro(event) 
    if (event.phase == "ended" or event.phase == "cancelled") then
        _G.CurrentPage = 2
        saveKwikVars({"CurrentPage",2}) 
        _G.GameStarted = true
        dispose(); director:changeScene( "page_2", "fade" )
    end
   return true 
end 

local function continueGame( event )
	-- body
	if (event.phase == "ended" or event.phase == "cancelled") then
        loadSettingGame( )
        dispose(); director:changeScene( "page_".._G.CurrentPage, "fade" ) 
    end
	
	return true
end

local function btnEtadistics( event )
    -- body
    if (event.phase == "ended" or event.phase == "cancelled") then
       _G.CurrentPage = 21
        dispose(); director:changeScene( "page_21", "fade" )  
    end
end

local continue = widget.newButton{
		width = 500,
    	height = 130,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Continuar",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 30,
    	onEvent = continueGame
}

continue.x = display.contentCenterX
continue.y = display.contentCenterY - 200

print( "Variable :" )
print( _G.GameStarted )
if (not _G.GameStarted) then
    continue.alpha = 0
else 
    continue.alpha = 1
end

local inicGame  = widget.newButton{
		width = 500,
    	height = 130,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Nueva Partida",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 30,
    	onEvent = butIntro
}

inicGame.x = display.contentCenterX
inicGame.y = display.contentCenterY

local statistics  = widget.newButton{
        width = 500,
        height = 130,
        defaultFile = imgDir.. "button.png",
        --overFile = imgDir.. "button.png",
        label = "Estadisticas",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
        fontSize = 30,
        onEvent = btnEtadistics
}

statistics.x = display.contentCenterX
statistics.y = display.contentCenterY + 200
 

       -- meadow positioning 
       meadow = display.newImageRect( imgDir.. "p1_meadow.png", 1280, 800 ); 
       meadow.x = 640; meadow.y = 400; meadow.alpha = 1; meadow.oldAlpha = 1 
       meadow.oriX = meadow.x; meadow.oriY = meadow.y 
       meadow.name = "meadow" 
       menuGroup:insert(meadow); menuGroup.meadow = meadow 

       -- sun positioning 
       sun = display.newImageRect( imgDir.. "p1_sun.png", 152, 139 ); 
       sun.x = 192; sun.y = 167; sun.alpha = 1; sun.oldAlpha = 1 
       sun.oriX = sun.x; sun.oriY = sun.y 
       sun.name = "sun" 
       menuGroup:insert(sun); menuGroup.sun = sun 

       -- cloud positioning 
       cloud = {} 
       local gp_cloud = display.newGroup() 
       local c_cloud = 0 
       local cloud_m_loop = 0 --1 plays multiplier forever 
       local cloud_m_counter = 3; cloud_m_restart = 3 
       function mt_cloud(counter) 
          cloud[counter] = display.newImageRect( imgDir.. "p1_cloud.png", 192, 63 ); 
          cloud[counter].x = math.random(0,1280)
          cloud[counter].y = math.random(120,200)
          cloud[counter].alpha = math.random(60,80) / 100 
          cloud[counter].oldAlpha = 1
          cloud[counter].xScale = math.random(50,100) / 100 
          cloud[counter].yScale = cloud[counter].xScale 
          cloud[counter].rotation = math.random(0,0)  
          cloud[counter].myName = "cloud"..counter 
          menuGroup:insert(cloud[counter]) 
          gp_cloud:insert(cloud[counter]) 
       end 

       local function ct_cloud() 
          c_cloud = c_cloud + 1 
          if mt_cloud ~= nil then 
             mt_cloud( c_cloud) 
          end 
          if (c_cloud == cloud_m_restart and cloud_m_loop == 1)  then 
             timerStash.mt = timer.performWithDelay( 0, ct_cloud, 3 )   
             cloud_m_restart = c_cloud + cloud_m_counter 
          end 
       end 
       local function multi_cloud()   
          timerStash.mt = timer.performWithDelay( 0, ct_cloud, 3 )   
       end   
       multi_cloud()   
       menuGroup:insert(gp_cloud) 

       -- Clean up memory for Multiplier set to forever 
       -- control variable to dispose kClean via kNavi 
       _G.disposeMultiplier = nil 
       local function kClean() 
          if _G.disposeMultiplier == 1 then 
             -- remove all past listeners 
             mt_cloud = nil; Runtime:removeEventListener("enterFrame", kClean)  
             _G.disposeMultiplier = nil 
          else 
             -- runs normal code 
             for i = 1, cloud_m_restart do  
                  if cloud[i] ~= nil then 
                       if cloud[i].y ~= nil then 
                         if  cloud[i].y > _H then 
                             display.remove(cloud[i]) 
                             cloud[i] = nil 
                         end 
                       end  
                  end 
             end  
          end  
       end 
       Runtime:addEventListener("enterFrame", kClean) 

       -- plane positioning 
       plane = display.newImageRect( imgDir.. "p1_plane.png", 226, 138 ); 
       plane.x = 1407; plane.y = 237; plane.alpha = 1; plane.oldAlpha = 1 
       plane.oriX = plane.x; plane.oriY = plane.y 
       plane.name = "plane" 
       menuGroup:insert(plane); menuGroup.plane = plane 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       --Animations
       gtStash.gt_animSun = gtween.new( sun, 3, {  x=192, y=194,  alpha=1, rotation=0, xScale=1, yScale=1,}, {ease = gtween.easing.linear, repeatCount = math.huge, reflect = true,  delay=0.1, ""}) 

       local onEnd_animPlane_811 = function() 
          plane.x = plane.oriX; plane.y = plane.oriY; 
          plane.xScale = 1;plane.yScale = 1; plane.alpha = plane.oldAlpha; plane.rotation = 0; plane.isVisible = true; 
       end --ends reStart for animPlane 
       gtStash.gt_animPlane = btween.new( plane, 3, { 
         { x = 1427, y = 173}, --regular curve
         { x = 1427, y = 173}, 
         { x = -65, y = -9}, 
         { x = -233, y = 72}, 

         { x = -233, y = 72}, 
         { x = -233, y = 72}, 
         { x = -233, y = 72}, 
         { x = -233, y = 72}, 
angle = 0       }, {ease = gtween.easing.linear, repeatCount = math.huge, reflect = false,  delay=0.1, onComplete=onEnd_animPlane_811, breadcrumb = true, breadAnchor = 6, breadShape = "circle", breadW = 10, breadH = 10, breadColor = {255,255,255}, breadInterval = 20, breadTimer = 1}, {  x=1407, y=237,  alpha=1, rotation=0, xScale=1, yScale=1, newAngle=180}) 


       -- Button event listeners 
       local function onmeadowEvent(event) 
          but_371(meadow) 
          return true 
       end 
       meadow:addEventListener("tap", onmeadowEvent ) 

       -- Button functions 
       function but_371(self) 
           if (kNavig.alpha == 0) then 
              Navigation.show() 
           else  
              Navigation.hide() 
           end 
       end 

 
       -- Page properties 
       menuGroup.xScale = 1; menuGroup.yScale = 1; 
       menuGroup.alpha = 1; 
 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTweens() 
          cancelAllTimers(); cancelAllTransitions() 
          mt_cloud = nil 
          Runtime:removeEventListener("enterFrame", kClean) 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
