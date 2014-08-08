      require("extraDraw");
      
      local gp_line = display.newGroup()
      local gp_letter = display.newGroup()
      local gp_point = display.newGroup()
      local color = 220
      local colorPoint = color - 20
      local radius = 100
      local radiusPoint = 24
      local n_div = 30
      local an
      local line
      
      local rectLeft = display.newRoundedRect( display.contentCenterX - radius, display.contentCenterY-50, 55, 319, 12 )
      rectLeft:setFillColor( color, color, color )
      local rectRight = display.newRoundedRect( display.contentCenterX + radius, display.contentCenterY-50, 55, 319, 12 )
      rectRight:setFillColor( color, color, color )
      
      for i=0,n_div do
            an = (math.pi/n_div)*i;
            line = display.newCircle( radius*math.cos(an), radius*math.sin(an), 28 )
            line:setFillColor( color, color, color )
            gp_line:insert(line)
      end

      --gp_line:translate( display.contentCenterX, display.contentCenterY )
      gp_line.x = display.contentCenterX+28
      gp_line.y = display.contentCenterY+265
      
      gp_letter:insert( gp_line )
      gp_letter:insert(rectLeft)
      gp_letter:insert( rectRight )       
      gp_letter.x = -10
      gp_letter.y = -280
      
      local pointTopLeft = display.newCircle( 1-radius, -285, radiusPoint )
      pointTopLeft:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointTopLeft )
      
      local pointTopRight = display.newCircle( radius+1, -285, radiusPoint )
      pointTopRight:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointTopRight )

      local pointMiddleLeft = display.newCircle( -radius+1, -185, radiusPoint )
      pointMiddleLeft:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointMiddleLeft )
      
      local pointMiddleRight = display.newCircle( radius+1, -185, radiusPoint )
      pointMiddleRight:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointMiddleRight )
      
      local pointBelowLeft = display.newCircle( -radius+1, -85, radiusPoint )
      pointBelowLeft:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointBelowLeft )
      
      local pointBelowRight = display.newCircle( radius+1, -85, radiusPoint )
      pointBelowRight:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointBelowRight )

      n_div = 5
      for i=0,n_div do
            an = (math.pi/n_div)*i;
            line = display.newCircle( radius*math.cos(an), radius*math.sin(an), radiusPoint )
            line:setFillColor( color-20, color-20, color-20 )
            gp_point:insert(line)
      end
      gp_point.x = display.contentCenterX + 18
      gp_point.y = display.contentCenterY - 15

      gp_point.anchorChildren = true
      gp_letter.anchorChildren = true
      
      addExtra( menuGroup, gp_letter, gp_point, 5 )  

      menuGroup:insert( gp_letter ) 
      menuGroup:insert( gp_point )