function createHollowRectangle( posX, posY, width, height )
	-- body
	local groupRect = display.newGroup( )
	local lineWidth = 20

	local line = display.newLine( 0, 0, width, 0 )
	line:setStrokeColor( 255, 0, 0 )
	line.strokeWidth = lineWidth
	groupRect:insert( line )

	line = display.newLine( 0, 0, 0, height )
	line:setStrokeColor( 255, 0, 0 )
	line.strokeWidth = lineWidth
	groupRect:insert( line )

	line = display.newLine( width, 0, width, height )
	line:setStrokeColor( 255, 0, 0 )
	line.strokeWidth = lineWidth
	groupRect:insert( line )

	line = display.newLine( 0, height, width, height )
	line:setStrokeColor( 255, 0, 0 )
	line.strokeWidth = lineWidth
	groupRect:insert( line )

	groupRect.anchorChildre = true
	groupRect:translate( posX, posY )
	--groupRect.x = posX
	--groupRect.y = posY

	return groupRect
end

function createHollowCircle( posX, posY, radius )
	-- body
	local gpCircle = display.newGroup()
	local n_div = 200
	local an
	local line

	for i=0,n_div do
        an = (2*math.pi/n_div)*i;
        line = display.newCircle( radius*math.cos(an), radius*math.sin(an), 10 )
        line:setFillColor( 255, 0, 0 )
        gpCircle:insert(line)
  	end
  	gpCircle.x = posX
    gpCircle.y = posY

  	return gpCircle
end