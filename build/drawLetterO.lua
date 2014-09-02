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

      if (_G.Phase == 1) then
            imgBack = display.newImageRect( imgDir.."osopeluche.png", 500, 490 )
            imgBack.x = 250; imgBack.y = 300
      else
            imgBack = display.newImageRect( imgDir.."oveja.png", 233, 133 )
            imgBack.x = 300; imgBack.y = 350
      end
      imgBack.alpha = 0.75
  
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