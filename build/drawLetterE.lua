      require("extraDraw");
      local gp_point = display.newGroup()
      local gp_letter = display.newGroup()
      local rectTop
      local rectBelow
      local rectMiddle
      local rectVert
      local color = 220
      local kwkbuttonconfir 
      local radius = 24 

       -- (TOP) External code will render here 

      
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
      local pointMiddle = display.newCircle( display.contentCenterX+121, 298, radius )
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

      gp_letter.anchorChildren = true

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

      gp_point.anchorChildren = true

      addExtra( menuGroup, gp_letter, gp_point, radius )   
      menuGroup:insert(gp_letter)
      menuGroup:insert(gp_point)