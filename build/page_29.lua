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

       local curPage = 29 
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
       Capa_1 = display.newImageRect( imgDir.. "p29_capa_1.png", 0, 0 ); 
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
      local rectRight
      local rectLeft
      local rectMiddle
      local color = 220
      local colorPoint = color - 20
      local angle = 23
      local radius = 24 
      local imgBack
      local textImg
       -- (TOP) External code will render here 
      if (_G.Phase == 1) then
            imgBack = display.newImageRect( imgDir.."p1_plane.png", 271, 165 )
            imgBack.x = 260; imgBack.y = 200
            imgBack.name ="Avión"
            imgBack:rotate( 15 )
      else
            imgBack = display.newImageRect( imgDir.."objeto141.png", 226, 138 )
            imgBack.x = 300; imgBack.y = 200
            imgBack.name ="Abeja"
      end
      imgBack.alpha = 0.75
      textImg = display.newText( imgBack.name, imgBack.x, imgBack.y, native.systemFontBold, 55)
      textImg.x = imgBack.x
      textImg.y = imgBack.y + imgBack.contentHeight/2 + 50
      textImg:setFillColor( 80 )
      textImg.alpha = imgBack.alpha
      
      rectRight = display.newRoundedRect( display.contentCenterX-90, display.contentCenterY-200, 55, 350, 12)
      rectRight:setFillColor( color, color, color )
      rectRight:rotate( angle )
      rectMiddle = display.newRoundedRect( display.contentCenterX-60, display.contentCenterY-30, 210, 55, 12 )
      rectMiddle:setFillColor( color, color, color )
      rectTop = display.newRoundedRect( display.contentCenterX-17, display.contentCenterY-205, 89, 55, 12 )
      rectTop:setFillColor( color, color, color )
      rectLeft = display.newRoundedRect( display.contentCenterX+90, display.contentCenterY-200, 55, 350, 12 )
      rectLeft:setFillColor( color, color, color )
      rectLeft:rotate( -angle )
      gp_letter:insert( rectLeft )
      gp_letter:insert( rectMiddle )
      gp_letter:insert( rectRight )
      gp_letter:insert( rectTop )

      local pointTop = display.newCircle( display.contentCenterX+27, display.contentCenterY-240, radius )
      pointTop:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointTop )
      
      local pointMiddle = display.newCircle( display.contentCenterX+27, display.contentCenterY-68, radius )
      pointMiddle:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointMiddle )
      
      local pointLeftMiddle = display.newCircle( display.contentCenterX-72, display.contentCenterY-68, radius )
      pointLeftMiddle:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointLeftMiddle )
      
      local pointRightMiddle = display.newCircle( display.contentCenterX+128, display.contentCenterY-68, radius )
      pointRightMiddle:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointRightMiddle )
      
      local pointRightBelow = display.newCircle( display.contentCenterX+173, display.contentCenterY+40, radius )
      pointRightBelow:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointRightBelow )
      
      local pointLeftBelow= display.newCircle( display.contentCenterX-120, display.contentCenterY+40, radius )
      pointLeftBelow:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointLeftBelow )

      --Point Middle
      local pointMiddleRightTop = display.newCircle( display.contentCenterX+85, display.contentCenterY-165, radius )
      pointMiddleRightTop:setFillColor( colorPoint, colorPoint, colorPoint )
      pointMiddleRightTop.alpha = 0.1
      gp_point:insert( pointMiddleRightTop )
      
      local pointMiddleLeftTop= display.newCircle( display.contentCenterX-30, display.contentCenterY-165, radius )
      pointMiddleLeftTop:setFillColor( colorPoint, colorPoint, colorPoint )
      pointMiddleLeftTop.alpha = 0.1
      gp_point:insert( pointMiddleLeftTop )
      
      local pointMiddleRightBelow = display.newCircle( display.contentCenterX+150, display.contentCenterY-13, radius )
      pointMiddleRightBelow:setFillColor( colorPoint, colorPoint, colorPoint )
      pointMiddleRightBelow.alpha = 0.1
      gp_point:insert( pointMiddleRightBelow )
      
      local pointMiddleLeftBelow= display.newCircle( display.contentCenterX-95, display.contentCenterY-13, radius )
      pointMiddleLeftBelow:setFillColor( colorPoint, colorPoint, colorPoint )
      pointMiddleLeftBelow.alpha = 0.1
      gp_point:insert( pointMiddleLeftBelow )

      local arrow = display.newImageRect( imgDir.."flechaRoja.png", 40, 60 )
      arrow.x = pointTop.x; arrow.y = pointTop.y - arrow.contentHeight + 5;
      arrow:scale( 1.2, 1.2 )

      gp_letter.y = -65

      gp_totalLetter:insert( gp_letter ) 
      gp_totalLetter:insert( gp_point )
      gp_totalLetter:insert( arrow )

      gp_totalLetter.anchorChildren = true

      addExtra( menuGroup, gp_letter, gp_point, radius, arrow , gp_totalLetter)

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
