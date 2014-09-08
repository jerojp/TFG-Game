      require("extraDraw");
      local gp_point = display.newGroup()
      local gp_letter = display.newGroup()
      local gp_totalLetter = display.newGroup( )
      local rectTop
      local rectBelow
      local rectMiddle
      local rectVert
      local color = 220
      local kwkbuttonconfir 
      local radius = 24 
      local imgBack
      local textImg

       -- (TOP) External code will render here 
      if (_G.Phase == 1) then
            imgBack = display.newImageRect( imgDir.."enano.png", 474, 1177 )
            imgBack.x = 250; imgBack.y = 300
            imgBack.name = "Enano"
            imgBack:scale( 0.4, 0.4 )
      else
            imgBack = display.newImageRect( imgDir.."objeto241.png", 604, 594 )
            imgBack.x = 200; imgBack.y = 350
            imgBack.name = "Elefante"
            imgBack:scale( 0.5, 0.5 )
      end
      imgBack.alpha = 0.75
      textImg = display.newText( imgBack.name, imgBack.x, imgBack.y, native.systemFontBold, 55)
      textImg.x = imgBack.x
      textImg.y = imgBack.y + imgBack.contentHeight/2 + 40
      textImg:setFillColor( 80 )
      textImg.alpha = imgBack.alpha
      
      rectTop = display.newRoundedRect( display.contentCenterX-100, 127, 280, 55, 12 )
      rectTop:setFillColor( color, color, color )
      rectMiddle = display.newRoundedRect( display.contentCenterX-100, 269, 250, 55, 12 )
      rectMiddle:setFillColor( color, color, color )
      rectBelow = display.newRoundedRect( display.contentCenterX-100, 429, 280, 55, 12 )
      rectBelow:setFillColor( color, color, color )
      rectVert = display.newRoundedRect( display.contentCenterX-100, 127, 80, 319, 12 )
      rectVert:setFillColor( color, color, color )

      local pointTop = display.newCircle( display.contentCenterX+140, 155, radius )
      pointTop:setFillColor( color-20, color-20, color-20 )
      pointTop.name = "pointTop"
      local pointMiddle = display.newCircle( display.contentCenterX+115, 298, radius )
      pointMiddle:setFillColor( color-20, color-20, color-20 )
      pointMiddle.name = "pointMiddle"
      local pointBelow = display.newCircle( display.contentCenterX+140, 456, radius )
      pointBelow:setFillColor( color-20, color-20, color-20 )
      pointBelow.name = "pointBelow"
      local pointVertTop = display.newCircle( display.contentCenterX-60, 155, radius )
      pointVertTop:setFillColor( color-20, color-20, color-20 )
      pointVertTop.name = "pointVertTop"
      local pointVertBelow = display.newCircle( display.contentCenterX-60, 456, radius )
      pointVertBelow:setFillColor( color-20, color-20, color-20 )
      pointVertBelow.name = "pointVertBelow"
      local pointVertMiddle = display.newCircle( display.contentCenterX-60, 298, radius )
      pointVertMiddle:setFillColor( color-20, color-20, color-20 )
      pointVertMiddle.name = "pointVertMiddle"

      --point Hidden
      local pointHiddenTop = display.newCircle( display.contentCenterX+40, 155, radius )
      pointHiddenTop.alpha = 0.01
      local pointHiddenMiddle = display.newCircle( display.contentCenterX+30, 298, radius )
      pointHiddenMiddle.alpha = 0.01
      local pointHiddenBelow = display.newCircle( display.contentCenterX+40, 456, radius )
      pointHiddenBelow.alpha = 0.01
      local pointVertHiddenTop = display.newCircle( display.contentCenterX-60, 226, radius )
      pointVertHiddenTop.alpha = 0.01
      local pointVertHiddenBelow = display.newCircle( display.contentCenterX-60, 377, radius )
      pointVertHiddenBelow.alpha = 0.01

      gp_letter:insert( rectTop )
      gp_letter:insert( rectBelow )
      gp_letter:insert( rectMiddle )
      gp_letter:insert( rectVert )

      gp_point:insert( pointTop )
      gp_point:insert( pointVertTop )
      gp_point:insert( pointVertMiddle )
      gp_point:insert( pointVertBelow )
      gp_point:insert( pointMiddle )
      gp_point:insert( pointBelow )
      gp_point:insert( pointHiddenTop )
      gp_point:insert( pointHiddenMiddle )
      gp_point:insert( pointHiddenBelow )
      gp_point:insert( pointVertHiddenTop )
      gp_point:insert( pointVertHiddenBelow )

      local arrow = display.newImageRect( imgDir.."flechaRoja.png", 40, 60 )
      arrow.x = pointTop.x + arrow.contentWidth + 40 ; arrow.y = pointTop.y;
      arrow:rotate( 90 )
      arrow:scale( 1.2, 1.2 )
      
      gp_totalLetter:insert(gp_letter)
      gp_totalLetter:insert(gp_point)
      gp_totalLetter:insert( arrow )

      gp_totalLetter.anchorChildren = true

      addExtra( menuGroup, gp_letter, gp_point, radius, arrow, gp_totalLetter )   

      menuGroup:insert(imgBack)   