      require("extraDraw");
      local gp_letter = display.newGroup()
      local gp_point = display.newGroup()
      local rectTop
      local rectBelow
      local rectVert
      local color = 220
      local colorPoint = color - 20
      local radius = 24 

       -- (TOP) External code will render here 

      
      rectTop = display.newRoundedRect( display.contentCenterX-100, display.contentCenterY-275, 250, 55, 12 )
      rectTop:setFillColor( color, color, color )
      rectBelow = display.newRoundedRect( display.contentCenterX-100, 429, 250, 55, 12 )
      rectBelow:setFillColor( color, color, color )
      rectVert = display.newRoundedRect( display.contentCenterX, 127, 55, 319, 12 )
      rectVert:setFillColor( color, color, color )

      gp_letter:insert( rectTop )
      gp_letter:insert( rectBelow )
      gp_letter:insert( rectVert )

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

      local pointTopLeft = display.newCircle( display.contentCenterX-90, display.contentCenterY-250, radius )
      pointTopLeft:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointTopLeft )

      local pointTopRight= display.newCircle( display.contentCenterX+100, display.contentCenterY-250, radius )
      pointTopRight:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointTopRight )

      gp_point.anchorChildren = true
      gp_letter.anchorChildren = true
      gp_letter.x = -20

      addExtra( menuGroup, gp_letter, gp_point, radius )   
      menuGroup:insert( gp_letter ) 
      menuGroup:insert( gp_point )