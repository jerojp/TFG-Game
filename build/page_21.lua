-- Code created by Kwik - Copyright: kwiksher.com 
-- Version: 2.7.6b 
module(..., package.seeall) 

function new() 
    local numPages = 22 
    local menuGroup = display.newGroup() 
    local dispose 
    local _W = display.contentWidth; 
    local _H = display.contentHeight; 

    local drawScreen = function() 

       local curPage = 21 

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

 
       -- Layer names 
       local kwkRectangleOra  

       -- (TOP) External code will render here 
       local widget = require( "widget" )
-- Groups
local groupImage = display.newGroup()
local scrollView
local imageTable

local heightInic = 140
local height = 106
local myTabla = display.newGroup( )
local myImage = display.newGroup( )
local myAudio = display.newGroup( )
local level 
local phase
local path
local fhd
local rectBehindImage
local image
local imageClose
local line
local lineWidth = 3
local color = {R = 0, G = 0, B = 0}
local facebookImage = false
local facebookTable = false
local updateImage = false
local updateTable = false

imageTable = display.newImageRect( imgDir.."tablaEstadisticas.png", 1000, 1155)
imageTable.x = display.contentCenterX ; imageTable.y = display.contentCenterY+200
groupImage:insert( imageTable )


scrollView = widget.newScrollView{
	top = 0,
    left = 0,
    width = display.contentWidth,
    height = display.contentHeight,
    scrollWidth = display.contentWidth,
    scrollHeight = 1200,
    bottomPadding = 50,
    horizontalScrollDisabled = true,
    verticalScrollDisabled = false,
    backgroundColor = { 237, 216, 197 }
}

scrollView:insert( groupImage )
menuGroup:insert(scrollView)

--table.insert( _G.Results, 1, {0, 1, 0, 0, 2, 0, 0, 0, 3, 6} )
--table.insert( _G.TimerResults, 1, {1.25, 2.85, 2, 1, 2, 1, 1, 4.58, 4, 5} )

local function goToStatistics( event )
	-- body
	_G.IndexStat = event.target.index
	director:changeScene( "page_22", "fade" )
end

local function closeImage( event )
	-- body
	rectBehindImage:removeSelf( )
	rectBehindImage = nil
	image:removeSelf( )
	image = nil
	imageClose:removeSelf( )
	imageClose = nil
	scrollView.alpha = 1.0
	scrollView._view._isVerticalScrollingDisabled = false
end

local function viewImage( event )
	-- body
	local object = event.target
	local path = system.pathForFile( "screen"..object.level..object.phase..".jpg", system.DocumentsDirectory )
	local file = io.open( path )
	if file then
		scrollView._view._isVerticalScrollingDisabled = true

		rectBehindImage = display.newRoundedRect( 0, 0, 670, 330, 25 )
		rectBehindImage.x = display.contentCenterX ; rectBehindImage.y = display.contentCenterY
		rectBehindImage:setFillColor( 120 )

		image = display.newImageRect( "screen"..object.level..object.phase..".jpg", system.DocumentsDirectory, 1280, 600)
    	image.x = display.contentCenterX ; image.y = display.contentCenterY
    	image:scale( 0.5, 0.5 )

    	imageClose = display.newImageRect( imgDir.."closeIconRed.png", 26, 26)
    	imageClose:scale( 2, 2 )
    	imageClose.x = display.contentCenterX+image.contentWidth/2+10 ; imageClose.y = display.contentCenterY-image.contentHeight/2-10
    	imageClose:addEventListener( "tap", closeImage )
    	scrollView.alpha = 0.8
    	io.close( file )
    	return true
	end
	return false
end

local function onCompleteSound( event )
		-- body
	scrollView.alpha = 1.0
end

local function playAudio( event )
	-- body
	scrollView.alpha = 0.8
	local object = event.target
	local filePath = system.pathForFile("audio"..object.level..object.phase..".pcm", system.DocumentsDirectory ) 
    local file = io.open(filePath, "r")
    if file then 
      io.close(file) 
      media.playSound("audio"..object.level..object.phase..".pcm", system.DocumentsDirectory, onCompleteSound ) 
    end  
end


local function onCompleteSound( event )
		-- body
	scrollView.alpha = 1.0
end

local function playAudio( event )
	-- body
	scrollView.alpha = 0.8
	local object = event.target
	local filePath = system.pathForFile("audio"..object.level..object.phase..".pcm", system.DocumentsDirectory ) 
    local file = io.open(filePath, "r")
    if file then 
      io.close(file) 
      media.playSound("audio"..object.level..object.phase..".pcm", system.DocumentsDirectory, onCompleteSound ) 
    end  
end

local function updateFacebook( event )
	local object = event.target

	local function nothing( event )
		-- body
		return true
	end

	local function onSwitchPress( event )
		-- body
		local object = event.target
		
		if (object.id == "checkTable") then
			updateTable = object.isOn	
		else
			updateImage = object.isOn
		end	
	end

	local rectangle = display.newRoundedRect( 0, 0, 670, 330, 25 )
	rectangle.x = display.contentCenterX ; rectangle.y = display.contentCenterY
	rectangle:setFillColor( 235 )
	rectangle:addEventListener( "tap", nothing )

	local text = display.newText( "Seleccione las imagenes de los resultados de los ejercicios que desea publicar en facebook :", rectangle.x - rectangle.width/2 + 10, rectangle.y - rectangle.height/2 + 20, rectangle.width-20, 50, native.systemFont, 23 )
	text:setFillColor( color.R, color.G, color.B )

	if (object.index) then
		local textTable = display.newText( "Publicar tabla resultados ejer. igualacion-muestra", rectangle.x - rectangle.width/2 + 20, rectangle.y - rectangle.height/2 + 100 , native.systemFont, 25 )
		textTable:setFillColor( color.R, color.G, color.B )
		local checkTable = widget.newSwitch{
    		left = rectangle.x - rectangle.width/2 + textTable.width + 30,
    		top = rectangle.y - rectangle.height/2 + 100,
    		style = "checkbox",
    		id = "checkTable",
    		initialSwitchState = true,
    		onPress = onSwitchPress
		}
		updateTable = true 	
	end
	if (object.level and object.phase) then
		local heightCheck

		if (textTable) then
    			heightCheck = rectangle.y - rectangle.height/2 + textTable.height + 40	
    	else
    			heightCheck = rectangle.y - rectangle.height/2 + 100
    	end

		local textCapture = display.newText( "Publicar resultado dibujar letra", rectangle.x - rectangle.width/2 + 20, heightCheck, native.systemFont, 25 )
		textCapture:setFillColor( color.R, color.G, color.B )
		local checkCapture = widget.newSwitch{
    		left = rectangle.x - rectangle.width/2 + textCapture.width + 30,
    		top = heightCheck,
    		style = "checkbox",
    		id = "checkCapture",
    		initialSwitchState = true,
    		onPress = onSwitchPress
		}
		updateImage = true
	end
    
    local buttonConfirm = widget.newButton{
    	width = 200,
    	height = 80,
    	defaultFile = imgDir.. "button.png",
    	label = "Confirmar",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 25,
    	onEvent = confirmUpdate
	}
	buttonConfirm.x = rectangle.x - buttonConfirm.width/2 - 25
	buttonConfirm.y = rectangle.y + rectangle.height/2 - buttonConfirm.height/2 + 20

	local buttonCancel = widget.newButton{
    	width = 200,
    	height = 80,
    	defaultFile = imgDir.. "button.png",
    	label = "Cancelar",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 25,
    	onEvent = cancelUpdate
	}
	buttonCancel.x = rectangle.x + buttonCancel.width/2 + 25
	buttonCancel.y = rectangle.y + rectangle.height/2 - buttonCancel.height/2 + 20

    return true
end

-- Program

for i=1,10 do
	level = math.ceil(i/2)
	if(math.fmod(i, 2) == 0)then
		phase = 2
	else 
		phase = 1
	end

	if(_G.Results[i]) then
		print( "Inserta TABLA" )
		facebookTable = true
		local objectTab = display.newText( "Mostrar tabla", 417, heightInic + (height*(i-1)), native.systemFont, 25 )
		objectTab:setFillColor( color.R, color.G, color.B ) 
		objectTab.index = i
		myTabla:insert( objectTab )
		line = display.newLine( 417, heightInic + (height*(i-1))+30, 520, heightInic + (height*(i-1))+30 )
		line:setColor(color.R, color.G, color.B);
        line.width=lineWidth;
		scrollView:insert(line)
	end
	path = system.pathForFile( "screen"..level..phase..".jpg", system.DocumentsDirectory )
	fhd = io.open( path )
	if fhd then
			facebookImage = true
			print( "Inserta Imagen" )
   			local objectImage = display.newText( "Ver imagen", 604, heightInic + (height*(i-1)), native.systemFont, 25 )
			objectImage:setFillColor( color.R, color.G, color.B )
			objectImage.level = level
			objectImage.phase = phase
			objectImage:addEventListener( "tap", viewImage )
			myImage:insert( objectImage )
			line = display.newLine( 604, heightInic + (height*(i-1))+30, 732, heightInic + (height*(i-1))+30 )
			line:setColor(color.R, color.G, color.B);
            line.width=lineWidth;
			scrollView:insert(line)
			io.close(fhd)
   	end
   	path = system.pathForFile("audio"..level..phase..".pcm", system.DocumentsDirectory ) 
    fhd = io.open(path, "r")
    if fhd then 
        local objectAudio = display.newText( "Reproducir Audio", 776, heightInic + (height*(i-1)) + 2, native.systemFont, 22 )
		objectAudio:setFillColor( color.R, color.G, color.B )
		objectAudio.level = level
		objectAudio.phase = phase
		objectAudio:addEventListener( "tap", playAudio )
		myAudio:insert( objectAudio )
		line = display.newLine( 776, heightInic + (height*(i-1))+30, 800, heightInic + (height*(i-1))+30 )
		line:setColor(color.R, color.G, color.B);
        line.width=lineWidth;
		scrollView:insert(line)
        io.close(fhd)
    end
    if (facebookImage or facebookTable) then
    	local objectFacebook = display.newText( "Publicar", 990, heightInic + (height*(i-1)) + 2, native.systemFont, 25 )
		objectFacebook:setFillColor( 0, 0, 150 )
		if (facebookTable) then
			objectFacebook.index = i
			facebookTable = false
		elseif (facebookImage) then
			objectFacebook.level = level
			objectFacebook.phase = phase
			facebookImage = false
		end
		scrollView:insert(objectFacebook)
		objectFacebook:addEventListener( "tap", updateFacebook )
    end
end

scrollView:insert(myTabla)
scrollView:insert(myImage)
scrollView:insert(myAudio)

for i=1,myTabla.numChildren do
	myTabla[i]:addEventListener( "tap", goToStatistics )
end 

       -- kwkRectangleOra positioning 
       kwkRectangleOra = display.newImageRect( imgDir.. "kwkrectangleora.png", 1279, 799 ); 
       kwkRectangleOra.x = 639; kwkRectangleOra.y = 399; kwkRectangleOra.alpha = 1; kwkRectangleOra.oldAlpha = 1 
       kwkRectangleOra.oriX = kwkRectangleOra.x; kwkRectangleOra.oriY = kwkRectangleOra.y 
       kwkRectangleOra.name = "kwkRectangleOra" 
       menuGroup:insert(1,kwkRectangleOra); menuGroup.kwkRectangleOra = kwkRectangleOra 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- swipe this page with spacer of 120 in normal direction 
       Gesture.activate( kwkRectangleOra, {swipeLength=120} ) 
       local function pageSwap(event ) 
         if event.phase == "ended" and event.direction ~= nil then  
            local wPage = curPage  
            local direction  
            if event.direction == "left" and kBidi == false then  
               wPage = curPage + 1  
               if wPage > numPages then wPage = curPage end  
               direction = "moveFromRight"  
            elseif event.direction == "left" and kBidi == true then  
               wPage = curPage - 1  
               if wPage < tonumber(initPage) then wPage = initPage end  
               direction = "moveFromLeft"  
            elseif event.direction == "right" and kBidi == true then  
               wPage = curPage + 1  
               if wPage > numPages then wPage = curPage end  
               direction = "moveFromRight"  
            elseif event.direction == "right" and kBidi == false then  
               wPage = curPage - 1  
               if wPage < tonumber(initPage) then wPage = initPage end  
               direction = "moveFromLeft"  
            end  
            if tonumber(wPage) ~= tonumber(curPage) then dispose(); 
               dispose(); director:changeScene("page_"..wPage, direction) 
            end 
         end  
       end 
       kwkRectangleOra:addEventListener( Gesture.SWIPE_EVENT, pageSwap ) 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
          kwkRectangleOra:removeEventListener( Gesture.SWIPE_EVENT, pageSwap ); Gesture.deactivate(kwkRectangleOra) 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
