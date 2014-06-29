local widget = require( "widget" )
local storyboard = require "storyboard"
local myGroup = display.newGroup()
local background
local tableEst
local imageError
local imageSuccess
local upArrow
local textIntroLevel
local textIntroPhase
local textLevelInic
local textLevelFinish
local textLevel
local contInic
local contEnd
local cont
local myObject
local fail
local textFail
local success
local textSuccess

background = display.newRect( 0, 0, display.contentWidth, display.contentHeight)
background:setFillColor( 237, 216, 197 )
myGroup:insert(background)

tableEst = display.newImageRect( imgDir.. "tablaEstadisticaNivel.png", 879, 403 ); -- 727
tableEst.x = 640; tableEst.y = 400;
myGroup:insert(tableEst) 

textIntroLevel = display.newText( "Estadisticas Nivel :  "..math.ceil(_G.IndexStat/2), 300, 100, native.systemFont, 25 )
textIntroLevel:setFillColor( 117, 76, 36 )
myGroup:insert(textIntroLevel)

textIntroPhase = display.newText( "Fase :  "..math.fmod(_G.IndexStat, 2), 640, 100, native.systemFont, 25 )
textIntroPhase:setFillColor( 117, 76, 36 )
myGroup:insert(textIntroPhase)

textLevelInic = display.newText( "Nivel inicial:", 300, 140, native.systemFont, 25 )
textLevelInic:setFillColor( 117, 76, 36 )
myGroup:insert(textLevelInic)

textLevelFinish = display.newText( "Nivel final:", 600, 140, native.systemFont, 25 )
textLevelFinish:setFillColor( 117, 76, 36 )
myGroup:insert(textLevelFinish)

for i=1,10 do
	textLevel = display.newText( i, 330, 240 + 38*(i-1) - i*1.34, native.systemFontBolt, 28 )
	myGroup:insert(textLevel)
	if(i==10) then
		textLevel.x = textLevel.x - 10
	end
	textLevel:setFillColor( 0, 0, 0 )
end

for i=1,10 do
	cont =  _G.Results[_G.IndexStat][i]
	for j=0, cont do
		if (cont ~= -1) then
			if (j==cont) then
				myObject = display.newImageRect( imgDir.. "ralladoAcierto.png", 75,  43);
			else
				myObject = display.newImageRect( imgDir.. "cruzError.png", 75,  43);
			end
			myObject.x = 412 + (75*j); myObject.y = 257 + (32*(i-1)) + i*3.5;
			myGroup:insert(myObject)
		end
	end
end

for i=1,10 do
	myObject = display.newText( _G.TimerResults[_G.IndexStat][i], 926, 240 + (32*(i-1)) + i*3.5, native.systemFont, 25 )
	myObject:setFillColor( 0, 0, 0 )
	myGroup:insert(myObject)
	myObject = display.newText( "seg", 1005, 240 + (32*(i-1)) + i*3.5, native.systemFont, 25 )
	myObject:setFillColor( 0, 0, 0 )
	myGroup:insert(myObject)
end

success = display.newImageRect( imgDir.. "ralladoAcierto.png", 75,  43);
success.x = 100 ; success.y = 700
myGroup:insert(success)
textSuccess = display.newText( " indica que se ha acertado", 180, 680, native.systemFont, 25 )
textSuccess:setFillColor( 117, 76, 36 )
myGroup:insert(textSuccess)

fail = display.newImageRect( imgDir.. "cruzError.png", 75,  43);
fail.x = 100 ; fail.y = 750
myGroup:insert(fail)
textFail = display.newText( " indica que se cometio un error", 180, 730, native.systemFont, 25 )
textFail:setFillColor( 117, 76, 36 )
myGroup:insert(textFail)

local function buttonBackListener( event )
	-- body
	print( "-----Cambio a escena 21-----" )
	director:changeScene("page_21")
end

local buttonBack = widget.newButton{
    	width = 200,
    	height = 80,
    	defaultFile = imgDir.. "button.png",
    	label = "Atras",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 25,
    	onEvent = buttonBackListener
	}
buttonBack.x = 800
buttonBack.y = 750

myGroup:insert(buttonBack)
menuGroup:insert( myGroup )

if (_G.TakePhoto) then
	local screenCap = display.captureScreen( false )
	display.save( screenCap, { filename="screenME"..math.ceil(_G.IndexStat/2)..math.fmod(_G.IndexStat, 2)..".jpg", baseDir=system.DocumentsDirectory, isFullResolution=true } ) -- ME = matching exercise
	_G.IsTakePhoto = true
end