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

       -- (TOP) External code will render here 
      if (_G.Phase == 1) then
            imgBack = display.newImageRect( imgDir.."objeto331.png", 528, 497 )
            imgBack.x = 250; imgBack.y = 300
            imgBack:scale( 0.8, 0.8 )
      else
            imgBack = display.newImageRect( imgDir.."indio.png", 187, 184 )
            imgBack.x = 300; imgBack.y = 350
            imgBack:scale( 1.2, 1.2 )
      end
      imgBack.alpha = 0.75
      
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
      gp_point:insert( pointVertMidTop )

      local pointVertMidBelow = display.newCircle( display.contentCenterX+8, display.contentCenterY-20, radius )
      pointVertMidBelow:setFillColor( colorPoint, colorPoint, colorPoint )
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