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

       local curPage = 38 

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
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

       -- Capa_1 positioning 
       Capa_1 = display.newImageRect( imgDir.. "p38_capa_1.png", 0, 0 ); 
       Capa_1.x = 0; Capa_1.y = 0; Capa_1.alpha = 1; Capa_1.oldAlpha = 1 
       Capa_1.oriX = Capa_1.x; Capa_1.oriY = Capa_1.y 
       Capa_1.name = "Capa_1" 
       menuGroup:insert(1,Capa_1); menuGroup.Capa_1 = Capa_1 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
             require("extraDraw");
      local gp_letter = display.newGroup()
      local gp_point = display.newGroup()
      local gp_totalLetter = display.newGroup( )
      local rectTop
      local rectBelow
      local rectVert
      local color = 220
      local colorPoint = color - 20
      local radius = 24 
      local imgBack
      local textImg

       -- (TOP) External code will render here 
      if (_G.Phase == 1) then
            imgBack = display.newImageRect( imgDir.."objeto331.png", 528, 497 )
            imgBack.x = 250; imgBack.y = 300
            imgBack.name = "Iglú"
            imgBack:scale( 0.8, 0.8 )
      else
            imgBack = display.newImageRect( imgDir.."indio.png", 187, 184 )
            imgBack.x = 300; imgBack.y = 350
            imgBack.name = "Indio"
            imgBack:scale( 1.2, 1.2 )
      end
      imgBack.alpha = 0.75
      textImg = display.newText( imgBack.name, imgBack.x, imgBack.y, native.systemFontBold, 55)
      textImg.x = imgBack.x
      textImg.y = imgBack.y + imgBack.contentHeight/2 + 50
      textImg:setFillColor( 80 )
      textImg.alpha = imgBack.alpha
      
      rectTop = display.newRoundedRect( display.contentCenterX-120, display.contentCenterY-275, 250, 55, 12 )
      rectTop:setFillColor( color, color, color )
      rectBelow = display.newRoundedRect( display.contentCenterX-120, 429, 250, 55, 12 )
      rectBelow:setFillColor( color, color, color )
      rectVert = display.newRoundedRect( display.contentCenterX-30, 127, 75, 319, 12 )
      rectVert:setFillColor( color, color, color )

      gp_letter:insert( rectTop )
      gp_letter:insert( rectBelow )
      gp_letter:insert( rectVert )

      local pointTopLeft = display.newCircle( display.contentCenterX-90, display.contentCenterY-250, radius )
      pointTopLeft:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointTopLeft )

      local pointVertTop = display.newCircle( display.contentCenterX+8, display.contentCenterY-245, radius )
      pointVertTop:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointVertTop )
      
      local pointVertMiddle = display.newCircle( display.contentCenterX+8, display.contentCenterY-100, radius )
      pointVertMiddle:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointVertMiddle )

      local pointVertBelow = display.newCircle( display.contentCenterX+8, display.contentCenterY+53, radius )
      pointVertBelow:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointVertBelow )

      local pointVertMidTop = display.newCircle( display.contentCenterX+8, display.contentCenterY-175, radius )
      pointVertMidTop:setFillColor( colorPoint, colorPoint, colorPoint )
      pointVertMidTop.alpha = 0.1
      gp_point:insert( pointVertMidTop )

      local pointVertMidBelow = display.newCircle( display.contentCenterX+8, display.contentCenterY-20, radius )
      pointVertMidBelow:setFillColor( colorPoint, colorPoint, colorPoint )
      pointVertMidBelow.alpha = 0.1
      gp_point:insert( pointVertMidBelow )

      local pointBelowLeft = display.newCircle( display.contentCenterX-90, display.contentCenterY+53, radius )
      pointBelowLeft:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointBelowLeft )

      local pointBelowRight= display.newCircle( display.contentCenterX+100, display.contentCenterY+53, radius )
      pointBelowRight:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointBelowRight )

      local pointTopRight= display.newCircle( display.contentCenterX+100, display.contentCenterY-250, radius )
      pointTopRight:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointTopRight )

      local arrow = display.newImageRect( imgDir.."flechaRoja.png", 40, 60 )
      arrow.x = pointTopLeft.x - arrow.contentWidth - 20; arrow.y = pointTopLeft.y;
      arrow.alpha = 1
      arrow:rotate( -90 )
      arrow:scale( 1.2, 1.2 )

      gp_totalLetter:insert( gp_letter ) 
      gp_totalLetter:insert( gp_point )
      gp_totalLetter:insert( arrow )

      gp_totalLetter.anchorChildren = true

      addExtra( menuGroup, gp_letter, gp_point, radius, arrow, gp_totalLetter )   

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
