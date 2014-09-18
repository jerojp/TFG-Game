-- Code created by Kwik - Copyright: kwiksher.com 
-- Version: 2.7.6b 
module(..., package.seeall) 

function new() 
    local numPages = 65 
    local menuGroup = display.newGroup() 
    local dispose 
    local _W = display.contentWidth; 
    local _H = display.contentHeight; 

    local drawScreen = function() 

       local curPage = 2 
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

 
       -- Layer names 
       local Seleccione_la_d  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
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
 

       -- Seleccione_la_d positioning 
       Seleccione_la_d = display.newImageRect( imgDir.. "p2_seleccione_la_d.png", 724, 45 ); 
       Seleccione_la_d.x = 672; Seleccione_la_d.y = 59; Seleccione_la_d.alpha = 1; Seleccione_la_d.oldAlpha = 1 
       Seleccione_la_d.oriX = Seleccione_la_d.x; Seleccione_la_d.oriY = Seleccione_la_d.y 
       Seleccione_la_d.name = "Seleccione_la_d" 
       menuGroup:insert(1,Seleccione_la_d); menuGroup.Seleccione_la_d = Seleccione_la_d 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
