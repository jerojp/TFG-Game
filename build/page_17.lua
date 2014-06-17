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

       local curPage = 17 

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

 
       -- Layer names 
       local Capa_1  

       -- (TOP) External code will render here 

       -- Capa_1 positioning 
       Capa_1 = display.newImageRect( imgDir.. "p17_capa_1.png", 0, 0 ); 
       Capa_1.x = 0; Capa_1.y = 0; Capa_1.alpha = 1; Capa_1.oldAlpha = 1 
       Capa_1.oriX = Capa_1.x; Capa_1.oriY = Capa_1.y 
       Capa_1.name = "Capa_1" 
       menuGroup:insert(1,Capa_1); menuGroup.Capa_1 = Capa_1 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
             require("extraDraw");
      local widget = require "widget"
      local gp_point = display.newGroup()
      local gp_letter = display.newGroup()
      local rectTop
      local rectBelow
      local rectMiddle
      local rectVert
      local color = 220
      local kwkbuttonconfir 
      local radius = 24 

       -- (TOP) External code will render here 

      
      rectTop = display.newRoundedRect( display.contentCenterX-100, 127, 280, 55, 12 )
      rectTop:setFillColor( color, color, color )
      rectMiddle = display.newRoundedRect( display.contentCenterX-100, 269, 250, 55, 12 )
      rectMiddle:setFillColor( color, color, color )
      rectBelow = display.newRoundedRect( display.contentCenterX-100, 429, 280, 55, 12 )
      rectBelow:setFillColor( color, color, color )
      rectVert = display.newRoundedRect( display.contentCenterX-100, 127, 80, 319, 12 )
      rectVert:setFillColor( color, color, color )

      local pointTop = display.newCircle( display.contentCenterX+140, 155, radius )
      pointTop:setFillColor( color-20, color-20, color-20 )
      pointTop.name = "pointTop"
      local pointMiddle = display.newCircle( display.contentCenterX+121, 298, radius )
      pointMiddle:setFillColor( color-20, color-20, color-20 )
      pointMiddle.name = "pointMiddle"
      local pointBelow = display.newCircle( display.contentCenterX+140, 456, radius )
      pointBelow:setFillColor( color-20, color-20, color-20 )
      pointBelow.name = "pointBelow"
      local pointVertTop = display.newCircle( display.contentCenterX-60, 155, radius )
      pointVertTop:setFillColor( color-20, color-20, color-20 )
      pointVertTop.name = "pointVertTop"
      local pointVertBelow = display.newCircle( display.contentCenterX-60, 456, radius )
      pointVertBelow:setFillColor( color-20, color-20, color-20 )
      pointVertBelow.name = "pointVertBelow"
      local pointVertMiddle = display.newCircle( display.contentCenterX-60, 298, radius )
      pointVertMiddle:setFillColor( color-20, color-20, color-20 )
      pointVertMiddle.name = "pointVertMiddle"

      --point Hidden
      local pointHiddenTop = display.newCircle( display.contentCenterX+40, 155, radius )
      pointHiddenTop.alpha = 0.01
      local pointHiddenMiddle = display.newCircle( display.contentCenterX+30, 298, radius )
      pointHiddenMiddle.alpha = 0.01
      local pointHiddenBelow = display.newCircle( display.contentCenterX+40, 456, radius )
      pointHiddenBelow.alpha = 0.01
      local pointVertHiddenTop = display.newCircle( display.contentCenterX-60, 226, radius )
      pointVertHiddenTop.alpha = 0.01
      local pointVertHiddenBelow = display.newCircle( display.contentCenterX-60, 377, radius )
      pointVertHiddenBelow.alpha = 0.01

      gp_letter:insert( rectTop )
      gp_letter:insert( rectBelow )
      gp_letter:insert( rectMiddle )
      gp_letter:insert( rectVert )

      gp_letter.anchorChildren = true

      gp_point:insert( pointTop )
      gp_point:insert( pointVertTop )
      gp_point:insert( pointVertMiddle )
      gp_point:insert( pointVertBelow )
      gp_point:insert( pointMiddle )
      gp_point:insert( pointBelow )
      gp_point:insert( pointHiddenTop )
      gp_point:insert( pointHiddenMiddle )
      gp_point:insert( pointHiddenBelow )
      gp_point:insert( pointVertHiddenTop )
      gp_point:insert( pointVertHiddenBelow )

      gp_point.anchorChildren = true

      if(DifficultLevel == 1) then  -- Easy
        gp_letter:scale( 1.5, 1.5 )
        gp_point:scale( 1.5, 1.5 )
        radius = radius * 1.5
      elseif (DifficultLevel == 3) then  -- Hard
        gp_letter:scale( 0.7, 0.7 )      
        gp_point:scale( 0.7, 0.7 )
        radius = radius * 0.7
      end

      addExtra( menuGroup, gp_letter, gp_point, radius )   
      menuGroup:insert(gp_letter)
      menuGroup:insert(gp_point) 
 
       -- Page properties 
       menuGroup.xScale = 1; menuGroup.yScale = 1; 
       menuGroup.alpha = 1; 
 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 