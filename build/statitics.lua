local widget = require( "widget" )
local facebook = require "facebook"
local json = require( "json" )

local confirmUpdate
-- Groups
local groupImage = display.newGroup()
local scrollView
local imageTable
local facebookGroup
local color = {R = 0, G = 0, B = 0}
local heightInic = 180
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
local facebookImage = false
local facebookTable = false
local updateImage = false
local updateTable = false
local hiddenPanel

imageTable = display.newImageRect( imgDir.."tablaEstadistica.png", 1000, 1155)
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
    backgroundColor = { 203,245,231}
}

scrollView:insert( groupImage )
menuGroup:insert(scrollView)

--table.insert( _G.Results, 1, {0, 1, 0, 0, 2, 0, 0, 0, 3, 6} )
--table.insert( _G.TimerResults, 1, {1.25, 2.85, 2, 1, 2, 1, 1, 4.58, 4, 5} )

local function goToStatistics( event )
	-- body
	_G.IndexStat = event.target.index
	dispose()
	director:changeScene( "page_24", "fade" )
end

local function createHiddenPanel( )
	local function doNothing( event )
	  -- body
	  return true
	end
	-- body
	hiddenPanel = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	hiddenPanel.alpha = 0.5
	menuGroup:insert(hiddenPanel)
	hiddenPanel:addEventListener( "touch", doNothing )
	hiddenPanel:addEventListener( "tap", doNothing )
end

local function removeHiddenPanel( )
	-- body
	if (hiddenPanel) then
	  menuGroup:remove(hiddenPanel)
	  hiddenPanel:removeSelf( )
	  hiddenPanel = nil
	end
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
	removeHiddenPanel( )
end

local function viewImage( event )
	-- body
	local object = event.target
	local path = system.pathForFile( "screen"..object.level..object.phase..".jpg", system.DocumentsDirectory )
	local file = io.open( path )
	if file then
		createHiddenPanel( )
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
	removeHiddenPanel( )
end

local function playAudio( event )
	-- body
	local object = event.target
	local filePath = system.pathForFile("audioExLet"..object.level..object.phase..".wav", system.DocumentsDirectory ) 
    local file = io.open(filePath, "r")
    if file then 
      io.close(file) 
      scrollView.alpha = 0.8
      createHiddenPanel( )
      media.playSound("audioExLet"..object.level..object.phase..".wav", system.DocumentsDirectory, onCompleteSound ) 
    end  
end

local function uploadPhotoTable( )
	-- body
    local attachmentTable = {
    	name = "Reise, el viaje de las vocales",
        message = "Resultado de ".._G.NameUser.." para el ejercicio de igualacion de la muestra",
        source = { baseDir=system.DocumentsDirectory, filename="screenME"..math.ceil(_G.IndexStat/2)..math.fmod(_G.IndexStat, 2)..".jpg", type="image" },
        privacy = "{'value':'ALL_FRIENDS'}"
    }
    _G.IsTakePhoto = false
    _G.TakePhoto = false
    facebook.request( "me/photos", "POST", attachmentTable )
end

local function uploadPhotoDraw( )
	-- body
	local attachmentImage = {
    	name = "Reise, el viaje de las vocales",
        message = "Resultado de ".._G.NameUser.." para el ejercicio de dibujar la vocal",
        description = "Resultado de ".._G.NameUser.." para el ejercicio de dibujar la vocal",
        source = { baseDir=system.DocumentsDirectory, filename="screen".._G.DrawLevel.._G.DrawPhase..".jpg", type="image" },
        privacy = "{'value':'ALL_FRIENDS'}"
    }
    facebook.request( "me/photos", "POST", attachmentImage )
end

local function onLoginSuccess()
    --print( "Funcion onLoginSuccess" )
    if (_G.UploadImageDraw) then
    	uploadPhotoDraw( )
    elseif (_G.UploadImageTable) then
    	uploadPhotoTable( )
    end

    return true
end

-- facebook listener
local function fbListener( event )
	if ("session" == event.type) then
		if event.phase ~= "login" then
			-- Exit if login error
			return
		end
					
		onLoginSuccess()
	elseif ( "request" == event.type ) then
		--print( event.response )
		if ( not event.isError ) then
			--Hay que resetear _G.UploadImageTable y _G.UploadImageDraw
			if (_G.UploadImageDraw) then
				_G.UploadImageDraw = false
				if (_G.UploadImageTable) then
					confirmUpdate(nil)
				end
			elseif(_G.UploadImageTable) then
				_G.UploadImageTable = false
			end
			native.showAlert( "EXITO", "La foto ha sido subida con éxito", { "OK" } )
		else
			native.showAlert( "ERROR", "Ha ocurrido un error al subir la foto, intentelo más tarde", { "OK" } )
		end
	end

end


function confirmUpdate( event )
	-- desactivar Runtime:addEventListener("system", onSystemEvent), aÃ±adir al build.settings permiso "android.permission.INTERNET"
	-- You must use your own app id for this sample to work. 
	local fbAppID = "1428997230712728"  --fake
	local object = nil
	if (event) then
		object = event.target
	end

	if (updateImage) then
    	_G.UploadImageDraw = true
    	_G.DrawLevel = object.level
    	_G.DrawPhase = object.phase
    end

	if (updateTable) then
    	_G.IndexStat = object.index
    	_G.TakePhoto = true
    	_G.UploadImageTable = true
    	local myClosure_switch = function() 
                dispose(); director:changeScene( "page_24" )
        end 
        timerStash.newTimer_999 = timer.performWithDelay(0, myClosure_switch, 1)  
    end

 	if (fbAppID and not updateImage and not updateTable) then
			facebook.login( fbAppID, fbListener, { "publish_actions" } )
			--print( "SE LOGEA EN FACEBOOK HUREYYYYYYYYYYYY :) " )
 	end
end


local function buttonConfirmListener( event )
	-- body
	local object = event.target
	if event.phase == "began" then
        display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
            display.getCurrentStage():setFocus( nil )
            object.isFocus = false
            confirmUpdate(event)
        end
    end
end


local function removePanelUpdaeFacebook( )
	-- body
	menuGroup:remove( facebookGroup )
	display.remove(facebookGroup)
	facebookGroup = nil
	updateImage = false
	updateTable = false
	return true
end

local function cancelUpdate( event )
	-- body
	local object = event.target
	if event.phase == "began" then
        display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
            display.getCurrentStage():setFocus( nil )
            object.isFocus = false
            removePanelUpdaeFacebook()
        end
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

	if (not facebookGroup) then
		facebookGroup = display.newGroup( )
	end
	local color = {R = 255, G = 255, B = 255}

	local panelBackHiddle = display.newRect( 0, 0, display.contentWidth , display.contentHeight )
	panelBackHiddle.alpha = 0.1
	facebookGroup:insert( panelBackHiddle )

	panelBackHiddle:addEventListener( "tap", nothing )
	local rectangle = display.newRoundedRect( 0, 0, 670, 330, 25 )
	rectangle.x = display.contentCenterX ; rectangle.y = display.contentCenterY
	rectangle:setFillColor( 19,135,255 ) -- 1–93–188
	rectangle.alpha = 0.98
	facebookGroup:insert( rectangle )

	local textEx = display.newText( " Seleccione las imagenes de los resultados de los ejercicios que desea publicar en facebook :", rectangle.x - rectangle.width/2 + 10, rectangle.y - rectangle.height/2 + 20, rectangle.width-30, 55, native.systemFont, 23 )
	textEx:setFillColor( color.R, color.G, color.B )
	facebookGroup:insert( textEx )

	local textTable = nil
	local SheetInfo = {}
	SheetInfo.sheet =
	{
	    frames = {
	        {
	            -- MyCheckOff
	            x=1,
	            y=1,
	            width=62,
	            height=62,
	        },
	        {
	            -- MyCheckOn
	            x=64,
	            y=1,
	            width=62,
	            height=62,
	        },
	    },
	    sheetContentWidth = 128,
	    sheetContentHeight = 64
	}
	local checkboxSheet = graphics.newImageSheet( imgDir.."checkBox.png", SheetInfo.sheet )

	if (object.index) then
		textTable = display.newText( "- Igualacion-muestra", rectangle.x - rectangle.width/2 + 20, rectangle.y - rectangle.height/2 + 100 , native.systemFont, 25 )
		textTable:setFillColor( color.R, color.G, color.B )
		facebookGroup:insert( textTable )
	
		local checkTable = widget.newSwitch{
    		left = rectangle.x - 20,
    		top = rectangle.y - rectangle.height/2 + 100,
    		style = "checkbox",
    		id = "checkTable",
    		initialSwitchState = true,
    		onPress = onSwitchPress,
    		sheet = checkboxSheet,
    		frameOff = 1,
    		frameOn = 2
		}
		updateTable = true
		facebookGroup:insert( checkTable ) 	
	end
	if (object.level and object.phase) then
		local heightCheck

		if (textTable) then
    			heightCheck = rectangle.y - rectangle.height/2 + 100 + textTable.height + 25	
    	else
    			heightCheck = rectangle.y - rectangle.height/2 + 100
    	end

		local textCapture = display.newText( "- Dibujar letra", rectangle.x - rectangle.width/2 + 20, heightCheck, native.systemFont, 25 )
		textCapture:setFillColor( color.R, color.G, color.B )
		facebookGroup:insert( textCapture )
		local checkCapture = widget.newSwitch{
    		left = rectangle.x - 20,
    		top = heightCheck,
    		style = "checkbox",
    		id = "checkCapture",
    		initialSwitchState = true,
    		onPress = onSwitchPress,
    		sheet = checkboxSheet,
    		frameOff = 1,
    		frameOn = 2
		}
		updateImage = true
		facebookGroup:insert( checkCapture )
	end
    
    local buttonConfirm = widget.newButton{
    	width = 150,
    	height = 60,
    	defaultFile = imgDir.. "button.png",
    	label = "Confirmar",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 25,
    	onEvent = buttonConfirmListener
	}
	buttonConfirm.x = rectangle.x - buttonConfirm.width/2 - 50
	buttonConfirm.y = rectangle.y + rectangle.height/2 - buttonConfirm.height/2 - 20
	facebookGroup:insert( buttonConfirm )

	if (object.level and object.phase) then
		buttonConfirm.level = object.level
		buttonConfirm.phase = object.phase
	end

	if (object.index) then
		buttonConfirm.index = object.index
	end

	local buttonCancel = widget.newButton{
    	width = 150,
    	height = 60,
    	defaultFile = imgDir.. "button.png",
    	label = "Cancelar",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 25,
    	onEvent = cancelUpdate
	}
	buttonCancel.x = rectangle.x + buttonCancel.width/2 + 50
	buttonCancel.y = rectangle.y + rectangle.height/2 - buttonCancel.height/2 - 20
	facebookGroup:insert( buttonCancel )

	menuGroup:insert(facebookGroup)
    return true
end

-- Program
local objetosMuestra = { "objeto111.png", "objeto112.png", "objeto221.png", "objeto222.png", "objeto331.png", "objeto332.png", "objeto441.png", "objeto442.png", "objeto551.png", "objeto552.png"}
local imgIG

for i=1,10 do
	level = math.ceil(i/2)
	if(math.fmod(i, 2) == 0)then
		phase = 2
	else 
		phase = 1
	end
	imgIG = display.newImageRect( imgDir..objetosMuestra[i], 60, 50 )
	imgIG.x = 330; imgIG.y = heightInic + (height*(i-1)) + 10
	scrollView:insert(imgIG)

	if(_G.Results[i]) then
		facebookTable = true
		local objectTab = display.newText( "Mostrar tabla", 417, heightInic + (height*(i-1)), native.systemFont, 25 )
		objectTab:setFillColor( color.R, color.G, color.B ) 
		objectTab.index = i
		myTabla:insert( objectTab )
		line = display.newLine( 417, heightInic + (height*(i-1))+30, 565, heightInic + (height*(i-1))+30 )
		line:setColor(color.R, color.G, color.B);
        line.width=lineWidth;
		scrollView:insert(line)
	end
	path = system.pathForFile( "screen"..level..phase..".jpg", system.DocumentsDirectory )
	fhd = io.open( path )
	if fhd then
			facebookImage = true
   			local objectImage = display.newText( "Ver imagen", 604, heightInic + (height*(i-1)), native.systemFont, 25 )
			objectImage:setFillColor( color.R, color.G, color.B )
			objectImage.level = level
			objectImage.phase = phase
			objectImage:addEventListener( "tap", viewImage )
			myImage:insert( objectImage )
			line = display.newLine( 604, heightInic + (height*(i-1))+30, 734, heightInic + (height*(i-1))+30 )
			line:setColor(color.R, color.G, color.B);
            line.width=lineWidth;
			scrollView:insert(line)
			io.close(fhd)
   	end
   	path = system.pathForFile("audioExLet"..level..phase..".wav", system.DocumentsDirectory ) 
    fhd = io.open(path, "r")
    if fhd then 
        local objectAudio = display.newText( "Reproducir Audio", 776, heightInic + (height*(i-1)) + 2, native.systemFont, 21 )
		objectAudio:setFillColor( color.R, color.G, color.B )
		objectAudio.level = level
		objectAudio.phase = phase
		objectAudio:addEventListener( "tap", playAudio )
		myAudio:insert( objectAudio )
		line = display.newLine( 776, heightInic + (height*(i-1))+30, 940, heightInic + (height*(i-1))+30 )
		line:setColor(color.R, color.G, color.B);
        line.width=lineWidth;
		scrollView:insert(line)
        io.close(fhd)
    end
    if (facebookImage or facebookTable) then
    	local objectFacebook = display.newText( "Publicar", 990, heightInic + (height*(i-1)) + 2, native.systemFont, 25 )
		objectFacebook:setFillColor( 19, 135, 255 )
		if (facebookTable) then
			objectFacebook.index = i
			facebookTable = false
		end
		if (facebookImage) then
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

if (_G.IsTakePhoto) then
	confirmUpdate(nil)
end