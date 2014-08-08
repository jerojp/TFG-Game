      require("extraDraw");
      local gp_letter = display.newGroup()
      local gp_point = display.newGroup()
      local rectRight
      local rectLeft
      local rectMiddle
      local color = 220
      local colorPoint = color - 20
      local angle = 23
      local radius = 24 

       -- (TOP) External code will render here 

      
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

      local pointTop = display.newCircle( display.contentCenterX+27, display.contentCenterY-245, radius )
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
      gp_point:insert( pointMiddleRightTop )
      
      local pointMiddleLeftTop= display.newCircle( display.contentCenterX-30, display.contentCenterY-165, radius )
      pointMiddleLeftTop:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointMiddleLeftTop )
      
      local pointMiddleRightBelow = display.newCircle( display.contentCenterX+150, display.contentCenterY-13, radius )
      pointMiddleRightBelow:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointMiddleRightBelow )
      
      local pointMiddleLeftBelow= display.newCircle( display.contentCenterX-95, display.contentCenterY-13, radius )
      pointMiddleLeftBelow:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointMiddleLeftBelow )

      gp_point.anchorChildren = true
      gp_letter.anchorChildren = true

      gp_letter.y = -65

      addExtra( menuGroup, gp_letter, gp_point, radius )   
      menuGroup:insert( gp_letter ) 
      menuGroup:insert( gp_point )