      require("extraDraw");
      
      local gp_line = display.newGroup()
      local gp_letter = display.newGroup()
      local gp_point = display.newGroup()
      local gp_totalLetter = display.newGroup( )
      local color = 220
      local colorPoint = color - 20
      local radius = 100
      local radiusPoint = 24
      local n_div = 30
      local an
      local line
      local imgBack
      local textImg

      if (_G.Phase == 1) then
            imgBack = display.newImageRect( imgDir.."universo.jpg", 350, 250 )
            imgBack.x = 250; imgBack.y = 350
            imgBack.name = "Universo"
      else
            imgBack = display.newImageRect( imgDir.."objeto552.png", 400, 300 )
            imgBack.x = 250; imgBack.y = 350
            imgBack.name = "Unicornio"
      end
      imgBack.alpha = 0.75
      textImg = display.newText( imgBack.name, imgBack.x, imgBack.y, native.systemFontBold, 55)
      textImg.x = imgBack.x
      textImg.y = imgBack.y + imgBack.contentHeight/2 + 50
      textImg:setFillColor( 80 )
      textImg.alpha = imgBack.alpha
      
      local rectLeft = display.newRoundedRect( display.contentCenterX - radius, display.contentCenterY-15, 55, 220, 12 )
      rectLeft:setFillColor( color, color, color )
      local rectRight = display.newRoundedRect( display.contentCenterX + radius, display.contentCenterY-15, 55, 220, 12 )
      rectRight:setFillColor( color, color, color )
      
      for i=0,n_div do
            an = (math.pi/n_div)*i;
            line = display.newCircle( radius*math.cos(an), radius*math.sin(an), 28 )
            line:setFillColor( color, color, color )
            gp_line:insert(line)
      end

      --gp_line:translate( display.contentCenterX, display.contentCenterY )
      gp_line.x = display.contentCenterX+28
      gp_line.y = display.contentCenterY+200
      
      gp_letter:insert( gp_line )
      gp_letter:insert(rectLeft)
      gp_letter:insert( rectRight )       
      gp_letter.x = -10
      gp_letter.y = -280
      
      local pointTopLeft = display.newCircle( 1-radius, -185, radiusPoint )
      pointTopLeft:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointTopLeft )
      
      local pointTopRight = display.newCircle( radius+1, -185, radiusPoint )
      pointTopRight:setFillColor( colorPoint, colorPoint, colorPoint )
      gp_point:insert( pointTopRight )

      local pointMiddleLeft = display.newCircle( -radius+1, -125, radiusPoint )
      pointMiddleLeft:setFillColor( colorPoint, colorPoint, colorPoint )
      pointMiddleLeft.alpha = 0.1
      gp_point:insert( pointMiddleLeft )
      
      local pointMiddleRight = display.newCircle( radius+1, -125, radiusPoint )
      pointMiddleRight:setFillColor( colorPoint, colorPoint, colorPoint )
      pointMiddleRight.alpha = 0.1
      gp_point:insert( pointMiddleRight )
      
      local pointBelowLeft = display.newCircle( -radius+1, -65, radiusPoint )
      pointBelowLeft:setFillColor( colorPoint, colorPoint, colorPoint )
      pointBelowLeft.alpha = 0.1
      gp_point:insert( pointBelowLeft )
      
      local pointBelowRight = display.newCircle( radius+1, -65, radiusPoint )
      pointBelowRight:setFillColor( colorPoint, colorPoint, colorPoint )
      pointBelowRight.alpha = 0.1
      gp_point:insert( pointBelowRight )

      n_div = 4
      for i=0,n_div do
            an = (math.pi/n_div)*i;
            line = display.newCircle( radius*math.cos(an), radius*math.sin(an), radiusPoint )
            line:setFillColor(color-20, color-20, color-20)
            if ( i ~= 0 and i ~= n_div/2 and i ~= n_div ) then
                line.alpha = 0.1  
            end
            gp_point:insert(line)
      end
      gp_point.x = display.contentCenterX + 18
      gp_point.y = display.contentCenterY - 80

      local arrow = display.newImageRect( imgDir.."flechaRoja.png", 40, 60 )
      arrow.x = rectLeft.x - 10 ; arrow.y = 65 ;
      arrow:scale( 1.2, 1.2 )
      
      gp_totalLetter:insert( gp_letter )
      gp_totalLetter:insert( gp_point )
      gp_totalLetter:insert( arrow )

      --gp_point.anchorChildren = true
      gp_totalLetter.anchorChildren = true
      
      addExtra( menuGroup, gp_letter, gp_point, 5 , arrow, gp_totalLetter)   
      menuGroup:insert( imgBack )