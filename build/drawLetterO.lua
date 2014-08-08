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