-- Code created by Kwik - Copyright: kwiksher.com 
-- Version: 2.7.6b 
module(..., package.seeall) 

function new() 
    local numPages = 64 
    local menuGroup = display.newGroup() 
    local dispose 
    local _W = display.contentWidth; 
    local _H = display.contentHeight; 

    local drawScreen = function() 

       local curPage = 24 

       Navigation.new("page", { backColor = {255, 255, 255}, anim=1, timer=1,  totPages = numPages, curPage = curPage, thumbW = 200, thumbH = 125, alpha = 1, imageDir = imgDir, dire = "top", audio={} } ) 
       Navigation.hide() 

       if (tonumber(kBookmark) == 1) then 
          local path = system.pathForFile( "book.txt", system.DocumentsDirectory ) 
          local file = io.open( path, "w+" ) 
          file:write ( curPage.."\n1" ) 
          io.close( file ) 
       end 

       math.randomseed(os.time()) 

       if (tonumber(_G.kAutoPlay) > 0) then 
          local function act_autoPlay(event) 
             if(curPage < numPages) then 
                if(kBidi == false) then  
                   dispose(); director:changeScene( "page_"..curPage+1, "moveFromRight" ) 
                else  
                   dispose(); director:changeScene( "page_"..curPage-1, "moveFromLeft" ) 
                end  
             end 
          end 
          timerStash.timer_AP = timer.performWithDelay( _G.kAutoPlay*1000, act_autoPlay, 1 ) 
       end 

 
       -- Action names 
       local act_190 

       -- Layer names 
       local Capa_1  

       -- (TOP) External code will render here 
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
	local object = event.target
	if event.phase == "began" then
        display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
			display.getCurrentStage():setFocus( nil )
			object.isFocus = false
			cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
			director:changeScene("page_23")
        end
    end
	return true
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
       _G.CurrentPage = curPage 

       -- Capa_1 positioning 
       Capa_1 = display.newImageRect( imgDir.. "p24_capa_1.png", 0, 0 ); 
       Capa_1.x = 0; Capa_1.y = 0; Capa_1.alpha = 1; Capa_1.oldAlpha = 1 
       Capa_1.oriX = Capa_1.x; Capa_1.oriY = Capa_1.y 
       Capa_1.name = "Capa_1" 
       menuGroup:insert(1,Capa_1); menuGroup.Capa_1 = Capa_1 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
 
       -- Actions (functions) 
       function act_190(event) 
         if (TakePhoto == true) then 
           _G.IsTakePhoto = true
          saveKwikVars({"IsTakePhoto",true}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_23", "fade" ) 
            end 
            timerStash.newTimer_980 = timer.performWithDelay(0, myClosure_switch, 1) 
         end 
       end 

 
      --End Actions (functions) 

 
       -- Timers 
       timerStash.timer_664 = timer.performWithDelay( 100, act_190, 1 ) 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
