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

       local curPage = 49 

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

       -- Capa_1 positioning 
       Capa_1 = display.newImageRect( imgDir.. "p49_capa_1.png", 0, 0 ); 
       Capa_1.x = 0; Capa_1.y = 0; Capa_1.alpha = 1; Capa_1.oldAlpha = 1 
       Capa_1.oriX = Capa_1.x; Capa_1.oriY = Capa_1.y 
       Capa_1.name = "Capa_1" 
       menuGroup:insert(1,Capa_1); menuGroup.Capa_1 = Capa_1 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
             require("extraDraw");

      local gp_point = display.newGroup()
      local gp_line = display.newGroup()
      local gp_letter = display.newGroup()
      local color = 220
      local radius = 140
      local n_div = 80
      local an
      local line
      local radiusPoint = 24
  
      for i=0,n_div do
            an = (2*math.pi/n_div)*i;
            line = display.newCircle( radius*math.cos(an), radius*math.sin(an), 36 )
            line:setFillColor( color, color, color )
            gp_letter:insert(line)
      end

      gp_letter.x = display.contentCenterX+20
      gp_letter.y = display.contentCenterY-100  

      n_div = 10
      
      for i=0,n_div do
            an = (2*math.pi/n_div)*i;
            line = display.newCircle( radius*math.cos(an), radius*math.sin(an), radiusPoint )
            line:setFillColor( color-20, color-20, color-20 )
            gp_point:insert(line)
      end

      gp_point.x = display.contentCenterX+20
      gp_point.y = display.contentCenterY-100

      gp_point.anchorChildren = true
      gp_letter.anchorChildren = true
      
      addExtra( menuGroup, gp_letter, gp_point, 5 )  

      menuGroup:insert( gp_letter ) 
      menuGroup:insert( gp_point ) 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
