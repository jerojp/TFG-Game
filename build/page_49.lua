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
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

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
      local gp_letter = display.newGroup()
      local gp_totalLetter = display.newGroup( )
      local color = 220
      local radius = 140
      local n_div = 80
      local an
      local line
      local radiusPoint = 24
      local imgBack
      local textImg

      if (_G.Phase == 1) then
            imgBack = display.newImageRect( imgDir.."osopeluche.png", 300, 290 )
            imgBack.x = 200; imgBack.y = 300
            imgBack.name = "Osito"
      else
            imgBack = display.newImageRect( imgDir.."oveja.png", 263, 163 )
            imgBack.x = 200; imgBack.y = 350
            imgBack.name = "Oveja"
      end
      imgBack.alpha = 0.75
      textImg = display.newText( imgBack.name, imgBack.x, imgBack.y, native.systemFontBold, 55)
      textImg.x = imgBack.x
      textImg.y = imgBack.y + imgBack.contentHeight/2 + 50
      textImg:setFillColor( 80 )
      textImg.alpha = imgBack.alpha
  
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
            an = (2*math.pi/n_div)*i - math.pi/2;
            line = display.newCircle( radius*math.cos(an), radius*math.sin(an), radiusPoint )
            line:setFillColor( color-20, color-20, color-20 )
            if ( math.fmod( i, 2 ) ~= 0 ) then
                line.alpha = 0.1  
            end
            gp_point:insert(line)
      end

      gp_point.x = display.contentCenterX+20
      gp_point.y = display.contentCenterY-100

      local arrow = display.newImageRect( imgDir.."flechaRoja.png", 40, 60 )
      arrow.x = gp_point.x; arrow.y = gp_point.y - arrow.contentHeight - radius ;
      arrow:scale( 1.2, 1.2 )
      
      gp_totalLetter:insert( gp_letter ) 
      gp_totalLetter:insert( gp_point )
      gp_totalLetter:insert( arrow )

      gp_totalLetter.anchorChildren = true

      gp_totalLetter.y = gp_totalLetter.y - 20
      addExtra( menuGroup, gp_letter, gp_point, 5, arrow, gp_totalLetter ) 

      menuGroup:insert(imgBack)    

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
