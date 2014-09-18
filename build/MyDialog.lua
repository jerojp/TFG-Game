local widget = require( "widget" )

local function nothingTouch( event )
	-- body
	return true
end

local function nothingTap( event )
	-- body
	return true
end

function createMyDialog ( labelPr, labelSec, color, labelC, listenerC, labelD, listenerD, sizeLabelSec)
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

	local textPr = display.newText( labelPr, display.contentCenterX, rect.y-rect.contentHeight/2+10 , native.systemFontBold, 35 )
	textPr.x = rect.x
	mygroup:insert( textPr )

	local textSec = display.newText( labelSec, display.contentCenterX, textPr.y+textPr.contentHeight/2+10 , rect.width-30, rect.contentHeight/4 * 2, native.systemFont, 24 )
	textSec.x = rect.x
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
	continue.y = textSec.y+textSec.contentHeight/2 + 45
	continue:setFillColor(  255,248,143 )
	mygroup:insert( continue )

	if (listenerD) then
		continue.x = rect.x - 150

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

		cancel.x = rect.x + 150
		cancel.y = continue.y
		cancel:setFillColor( 253,87,110 )
		mygroup:insert( cancel )

	else
		continue.x = rect.x
	end

	return mygroup
end

function deleteMyDialog ( mygroup )
	-- body
	display.remove( mygroup )
	mygroup = nil
end