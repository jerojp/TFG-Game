local widget = require( "widget" )
local myGroup

function createPanelOptions( )
    -- body
myGroup = display.newGroup( )

local selDif
local selSubt
local selAuto

--_G.DifficultLevel = event.target.id
          --print( object.id )
local function changeDifficult( event )
	-- body
	local object = event.target
	if event.phase == "began" then

        --display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
        	selDif.x = object.x - 3
        	_G.DifficultLevel = object.difficulty
            print( _G.DifficultLevel )
			--display.getCurrentStage():setFocus( nil )
			object.isFocus = false
        end
    end
	return true
end

local function changeStateSubtitles( event )
    -- body
    local object = event.target
    if event.phase == "began" then

        --display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
            selSubt.x = object.x - 3
            _G.Subtitle = object.subtitle
            if (_G.MyCurrentSubtitle) then
                if (_G.Subtitle) then
                    _G.MyCurrentSubtitle.alpha = 1
                else
                    _G.MyCurrentSubtitle.alpha = 0
                end
            end
            print( _G.Subtitle )
            --display.getCurrentStage():setFocus( nil )
            object.isFocus = false
        end
    end
    return true
end

local function changeAdvance( event )
    -- body
    local object = event.target
    if event.phase == "began" then

        --display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
            selAuto.x = object.x - 3
            _G.AutoNextPage = object.auto
            print( _G.AutoNextPage )
            --display.getCurrentStage():setFocus( nil )
            object.isFocus = false
        end
    end
    return true
end

local function confirmOptions( event )
    -- body
   local object = event.target
    if event.phase == "began" then

        --display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
            removePanelOptions( )
            --display.getCurrentStage():setFocus( nil )
            object.isFocus = false
        end
    end
    return true 
end

local background = display.newRect( 0, 0, display.contentWidth, display.contentHeight)
background:setFillColor( 237, 216, 197 )
myGroup:insert(background)

local options = 
		{
    		text = "Dificultad",     
    		x = 100,
    		y = 70,
    		fontSize = 32,
		}	
local textDif = display.newText( options )
textDif:setFillColor( 0 )
myGroup:insert( textDif )

local rectDif = display.newRoundedRect( 120, textDif.y+50, 700, 60, 25 )
rectDif:setFillColor( 217, 210, 187 )
myGroup:insert( rectDif )

selDif = display.newRoundedRect( 655, textDif.y+60, 110, 38, 7 )
selDif:setFillColor( 150 )
myGroup:insert( selDif )
if (_G.DifficultLevel == 1) then
	selDif.x = 225
elseif (_G.DifficultLevel == 2) then
	selDif.x = 480
elseif (_G.DifficultLevel == 3) then
	selDif.x = 710
end

local easyBut = display.newText( "Fácil", 200, textDif.y+65, native.systemFont, 25 )
easyBut:setFillColor( 100 )
easyBut.difficulty = 1
easyBut:addEventListener( "touch", changeDifficult )
myGroup:insert( easyBut )

local normalBut = display.newText( "Normal", 440, textDif.y+65, native.systemFont, 25 )
normalBut:setFillColor( 100 )
normalBut.difficulty = 2
normalBut:addEventListener( "touch", changeDifficult )
myGroup:insert( normalBut )

local hardBut = display.newText( "Dificil", 680, textDif.y+65, native.systemFont, 25 )
hardBut:setFillColor( 100 )
hardBut.difficulty = 3
hardBut:addEventListener( "touch", changeDifficult )
myGroup:insert( hardBut )

local textSubt = display.newText( "Subtítulos", 100, 260, native.systemFont, 32 )
textSubt:setFillColor( 0 )
myGroup:insert( textSubt )

local rectSub = display.newRoundedRect( 120, textSubt.y+50, 700, 60, 25 )
rectSub:setFillColor( 217, 210, 187 )
myGroup:insert( rectSub )

selSubt = display.newRoundedRect( 680, textSubt.y+60, 65, 38, 7 )
selSubt:setFillColor( 150 )
myGroup:insert( selSubt )
if ( _G.Subtitle ) then
	selSubt.x = 323
else
	selSubt.x = 605
end

local yesSub = display.newText( "Si", 310, textSubt.y+65, native.systemFont, 25 )
yesSub:setFillColor( 100 )
yesSub.subtitle = true
yesSub:addEventListener( "touch", changeStateSubtitles )
myGroup:insert( yesSub )

local noSub = display.newText( "No", 590, textSubt.y+65, native.systemFont, 25 )
noSub:setFillColor( 100 )
noSub.subtitle = false
noSub:addEventListener( "touch", changeStateSubtitles )
myGroup:insert( noSub )

local textAuto = display.newText( "Avance Automático", 100, 470, native.systemFont, 32 )
textAuto:setFillColor( 0 )
myGroup:insert( textAuto )

local rectAuto = display.newRoundedRect( 120, textAuto.y+50, 700, 60, 25 )
rectAuto:setFillColor( 217, 210, 187 )
myGroup:insert( rectAuto )

selAuto = display.newRoundedRect( 290, textAuto.y+60, 65, 38, 7 )
selAuto:setFillColor( 150 )
myGroup:insert( selAuto )
if ( _G.AutoNextPage ) then
	selAuto.x = 323
else
	selAuto.x = 605
end

local yesAuto = display.newText( "Si", 310, textAuto.y+65, native.systemFont, 25 )
yesAuto:setFillColor( 100 )
yesAuto.auto = true
yesAuto:addEventListener( "touch", changeAdvance )
myGroup:insert( yesAuto )

local noAuto = display.newText( "No", 590, textAuto.y+65, native.systemFont, 25 )
noAuto:setFillColor( 100 )
noAuto.auto = false
noAuto:addEventListener( "touch", changeAdvance )
myGroup:insert( noAuto )

local btnConfim = widget.newButton{
        width = 140,
        height = 50,
        defaultFile = imgDir.."button.png",
        --overFile = imgDir.. "button.png",
        label = "Confimar",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
        fontSize = 25,
        onEvent = confirmOptions
}
btnConfim.x = display.contentCenterX-250
btnConfim.y = rectAuto.y + 140
myGroup:insert( btnConfim )
end

function removePanelOptions( )
    -- body
    display.remove( myGroup )
    myGroup = nil
end

--[[widget.newButton{
			width = 120,
    		height = 40,
    		defaultFile = "button.png",
    		--overFile = "FlechaMapa.png",
    		label = "Facil",
    		id = 1,
    		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    		fontSize = 20,
    		onEvent = changeDifficult
		}
easyBut.x = textDif.x + 100
easyBut.y = textDif.y + 75
myGroup:insert( easyBut )

local normalBut = widget.newButton{
			width = 120,
    		height = 40,
    		defaultFile = "button.png",
    		--overFile = imgDir.. "button.png",
    		label = "Normal",
    		id = 2,
    		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    		fontSize = 20,
    		onEvent = changeDifficult
		}
normalBut.x = textDif.x + 400
normalBut.y = textDif.y + 75
myGroup:insert( normalBut )

local hardBut = widget.newButton{
			width = 120,
    		height = 40,
    		defaultFile = "button.png",
    		--overFile = imgDir.. "button.png",
    		label = "Dificil",
    		id = 3,
    		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    		fontSize = 20,
    		onEvent = changeDifficult
		}
hardBut.x = textDif.x + 700
hardBut.y = textDif.y + 75
myGroup:insert( hardBut )]]--