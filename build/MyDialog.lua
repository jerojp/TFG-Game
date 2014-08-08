local widget = require( "widget" )

local function nothingTouch( event )
	-- body
	return true
end

local function nothingTap( event )
	-- body
	return true
end

function createMyDialog ( labelPr, labelSec, listenerC, listenerD)
	-- body
	local mygroup = display.newGroup( )

	local rectangleHiddle = display.newRect( 0, 0, display.contentWidth, display.contentHeight)
	rectangleHiddle.alpha = 0.01
	rectangleHiddle:addEventListener( "touch", nothingTouch )
	rectangleHiddle:addEventListener( "tap", nothingTap )
	mygroup:insert( rectangleHiddle )

	local rect = display.newRoundedRect( display.contentCenterX-300, display.contentCenterY-200, 600, 300, 10 )
	rect:setFillColor( 100, 100, 100 )
	mygroup:insert( rect )

	local textPr = display.newText( labelPr, display.contentCenterX, display.contentCenterY-180, native.systemFontBold, 38 )
	textPr.x = display.contentCenterX
	mygroup:insert( textPr )

	local textSec = display.newText( labelSec, display.contentCenterX, display.contentCenterY-120 , rect.width-30, 80, native.systemFont, 32 )
	textSec.x = display.contentCenterX
	mygroup:insert( textSec )

	local continue = widget.newButton{
		width = 150,
    	height = 80,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Confirmar",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 25,
    	onEvent = listenerC,
	}

	continue.x = display.contentCenterX - 150
	continue.y = display.contentCenterY + 45
	mygroup:insert( continue )

	local cancel = widget.newButton{
		width = 150,
    	height = 80,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Cancelar",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 25,
    	onEvent = listenerD,
	}

	cancel.x = display.contentCenterX + 150
	cancel.y = display.contentCenterY + 45
	mygroup:insert( cancel )

	return mygroup
end

function deleteMyDialog ( mygroup )
	print( "Dialog borrado" )
	-- body
	display.remove( mygroup )
	mygroup = nil
end