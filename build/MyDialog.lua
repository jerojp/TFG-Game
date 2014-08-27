local widget = require( "widget" )

local function nothingTouch( event )
	-- body
	return true
end

local function nothingTap( event )
	-- body
	return true
end

function createMyDialog ( labelPr, labelSec, color, labelC, listenerC, labelD, listenerD)
	-- body
	local mygroup = display.newGroup( )

	local rectangleHiddle = display.newRect( 0, 0, display.contentWidth, display.contentHeight)
	rectangleHiddle.alpha = 0.01
	rectangleHiddle:addEventListener( "touch", nothingTouch )
	rectangleHiddle:addEventListener( "tap", nothingTap )
	mygroup:insert( rectangleHiddle )

	local rect = display.newRoundedRect( display.contentCenterX-300, display.contentCenterY-200, 600, 300, 42 )
	if (color) then
		rect:setFillColor( color.R, color.G, color.B )
	else
		rect:setFillColor( 255,154,88 )
	end
	mygroup:insert( rect )

	local textPr = display.newText( labelPr, display.contentCenterX, display.contentCenterY-180, native.systemFontBold, 40 )
	textPr.x = display.contentCenterX
	mygroup:insert( textPr )

	local textSec = display.newText( labelSec, display.contentCenterX, display.contentCenterY-120 , rect.width-30, 80, native.systemFont, 32 )
	textSec.x = display.contentCenterX
	mygroup:insert( textSec )

	local colorLabelBtn = {R=10, G=25, B=106}
	
	local continue = widget.newButton{
		width = 150,
    	height = 60,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = labelC,
    	labelColor = { default={ colorLabelBtn.R, colorLabelBtn.G, colorLabelBtn.B }, over={ 0, 0, 210 } },
    	fontSize = 25,
    	onEvent = listenerC,
	}
	continue.y = display.contentCenterY + 45
	continue:setFillColor(  255,248,143 )
	mygroup:insert( continue )

	if (listenerD) then
		continue.x = display.contentCenterX - 150

		local cancel = widget.newButton{
			width = 150,
    		height = 60,
    		defaultFile = imgDir.. "button.png",
    		--overFile = imgDir.. "button.png",
    		label = labelD,
    		labelColor = { default={ colorLabelBtn.R, colorLabelBtn.G, colorLabelBtn.B }, over={ 0, 0, 210 } },
    		fontSize = 25,
    		onEvent = listenerD,
		}

		cancel.x = display.contentCenterX + 150
		cancel.y = display.contentCenterY + 45
		cancel:setFillColor( 253,87,110 )
		mygroup:insert( cancel )

	else
		continue.x = display.contentCenterX
	end
	print( "CREADO DIALOG" )
	return mygroup
end

function deleteMyDialog ( mygroup )
	print( "Dialog borrado" )
	-- body
	display.remove( mygroup )
	mygroup = nil
end