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

       local curPage = 57 

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
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level] = curPage 

       -- Capa_1 positioning 
       Capa_1 = display.newImageRect( imgDir.. "p57_capa_1.png", 0, 0 ); 
       Capa_1.x = 0; Capa_1.y = 0; Capa_1.alpha = 1; Capa_1.oldAlpha = 1 
       Capa_1.oriX = Capa_1.x; Capa_1.oriY = Capa_1.y 
       Capa_1.name = "Capa_1" 
       menuGroup:insert(1,Capa_1); menuGroup.Capa_1 = Capa_1 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
             require("extraDraw");
      
      local gp_line = display.newGroup()
      local gp_letter = display.newGroup()
      local gp_point = display.newGroup()
      local gp_totalLetter = display.newGroup( )
      local color = 220
      local colorPoint = color - 20
      local radius = 100
      local radiusPoint = 24
      local n_div = 30
      local an
      local line
      local imgBack

      if (_G.Phase == 1) then
            imgBack = display.newImageRect( imgDir.."universo.jpg", 1280, 600 )
            imgBack.x = 640; imgBack.y = 300
      else
            imgBack = display.newImageRect( imgDir.."objeto552.png", 499, 350 )
            imgBack.x = 200; imgBack.y = 350
      end
      imgBack.alpha = 0.75
      
      local rectLeft = display.newRoundedRect( display.contentCenterX - radius, display.contentCenterY-15, 55, 220, 12 )
      rectLeft:setFillColor( color, color, color )
      local rectRight = display.newRoundedRect( display.contentCenterX + radius, display.contentCenterY-15, 55, 220, 12 )
      rectRight:setFillColor( color, color, color )
      
      for i=0,n_div do
            an = (math.pi/n_div)*i;
            line = display.newCircle( radius*math.cos(an), radius*math.sin(an), 28 )
            line:setFillColor( color, color, color )
            gp_line:insert(line)
      end

      --gp_line:translate( display.contentCenterX, display.contentCenterY )
      gp_line.x = display.contentCenterX+28
      gp_line.y = display.contentCenterY+200
      
      gp_letter:insert( gp_line )
      gp_letter:insert(rectLeft)
      gp_letter:insert( rectRight )       
      gp_letter.x = -10
      gp_letter.y = -280
      
      local pointTopLeft = display.newCircle( 1-radius, -185, radiusPoint )
      pointTopLeft:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointTopLeft )
      
      local pointTopRight = display.newCircle( radius+1, -185, radiusPoint )
      pointTopRight:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointTopRight )

      local pointMiddleLeft = display.newCircle( -radius+1, -125, radiusPoint )
      pointMiddleLeft:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointMiddleLeft )
      
      local pointMiddleRight = display.newCircle( radius+1, -125, radiusPoint )
      pointMiddleRight:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointMiddleRight )
      
      local pointBelowLeft = display.newCircle( -radius+1, -65, radiusPoint )
      pointBelowLeft:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointBelowLeft )
      
      local pointBelowRight = display.newCircle( radius+1, -65, radiusPoint )
      pointBelowRight:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointBelowRight )

      n_div = 5
      for i=0,n_div do
            an = (math.pi/n_div)*i;
            line = display.newCircle( radius*math.cos(an), radius*math.sin(an), radiusPoint )
            line:setFillColor(color-20, color-20, color-20)
            gp_point:insert(line)
      end
      gp_point.x = display.contentCenterX + 18
      gp_point.y = display.contentCenterY - 80

      local arrow = display.newImageRect( imgDir.."flechaRoja.png", 40, 60 )
      arrow.x = rectLeft.x - 10 ; arrow.y = 65 ;
      arrow:scale( 1.2, 1.2 )
      
      gp_totalLetter:insert( gp_letter )
      gp_totalLetter:insert( gp_point )
      gp_totalLetter:insert( arrow )

      --gp_point.anchorChildren = true
      gp_totalLetter.anchorChildren = true
      
      menuGroup:insert( imgBack )
      addExtra( menuGroup, gp_letter, gp_point, 5 , arrow, gp_totalLetter)    

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
