local widget = require( "widget" )
local function changeDif( event )
	-- body
    local object = event.target

    if event.phase == "began" then
        display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
            display.getCurrentStage():setFocus( nil )
            object.isFocus = false
            _G.DifficultLevel = object.dif
            dispose(); director:changeScene( "page_3", "fade" )
        end
    end
    return true
end

local myFontSize = 35
local rectangle = display.newRoundedRect( 0, 0, display.contentWidth , display.contentHeight , 10 )
rectangle:setFillColor(  255,189,99 )
menuGroup:insert(rectangle)

local textPr = display.newText( "Selecciona la dificultad para el juego", display.contentCenterX, 50, native.systemFontBold, 38 )
textPr.x = display.contentCenterX
textPr:setFillColor( 0 )
menuGroup:insert( textPr )

local btnEasy = widget.newButton{
	width = 430,
    height = 120,
    defaultFile = imgDir.. "button.png",
    --overFile = imgDir.. "button.png",
    label = "Fácil",
    labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    fontSize = myFontSize,
    onEvent = changeDif
}

btnEasy.x = display.contentCenterX
btnEasy.y = display.contentCenterY - 200
btnEasy.dif = 1
menuGroup:insert(btnEasy)

local btnNormal = widget.newButton{
    width = 430,
    height = 120,
    defaultFile = imgDir.. "button.png",
    --overFile = imgDir.. "button.png",
    label = "Normal",
    labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    fontSize = myFontSize,
    onEvent = changeDif
}

btnNormal.x = display.contentCenterX
btnNormal.y = display.contentCenterY
btnNormal.dif = 2
menuGroup:insert(btnNormal)

local btnHard = widget.newButton{
    width = 430,
    height = 120,
    defaultFile = imgDir.. "button.png",
    --overFile = imgDir.. "button.png",
    label = "Difícil",
    labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    fontSize = myFontSize,
    onEvent = changeDif
}

btnHard.x = display.contentCenterX
btnHard.y = display.contentCenterY + 200
btnHard.dif = 3
menuGroup:insert(btnHard)
