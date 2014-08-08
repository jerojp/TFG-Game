--[[
  Refactorizar este código. Cambiar las funciones de guardar y cargar juego a un fichero aparte, preferiblemente añadirlas a una tabla
como clase.
]]
local widget = require( "widget" )
local facebook = require "facebook"
require("MyDialog")
local backgroundGroup = display.newGroup( )

-- functions
local createPauseMenu
local continueGame
local changeDifficult
local selectDifficult
local backMenu
local removePauseMenu 
local onKeyEvent
local createTableSetting
local printTable

-- display and vars
local rectangle
local rectangleHiddle
local continue
local selectDefficult
local backMainMenu
local difficultEasy
local difficultNormal
local difficultHard
local createdPauseMenu = false

local rectangleExer
local rectangleHiddleExer
local continueExer
local backMainMenuExer
local createdPauseMenuExer = false

-- names
local easy = "easy"
local normal = "normal"
local hard = "hard"

printTable = function ( myTable)
	-- body
	print( "-------INICIO IMPRESION-------" )
	for key,value in pairs(myTable) do
		print(key, value)
		print( "--------------" )
	end

	print( "-------FIN IMPRESION-------" )
end

function pauseMyTimers( )
	-- body
	local k, v

    for k,v in pairs(timerStash) do
        timer.pause( v )
    end
end

function resumeMyTimers(  )
	-- body
	local k, v

    for k,v in pairs(timerStash) do
        timer.resume( v )
    end
end

function savedTable(filename )
	-- body
	local t = createTableSetting()
	local path = system.pathForFile( filename, system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local contents = json.encode(t)
        file:write( contents )
        io.close( file )
        print( "Juego GUARDADO" )
        --printTable(t)
        return true
    else
        return false
    end
end

function loadTable(filename)
    local path = system.pathForFile( filename, system.DocumentsDirectory)
    local contents = ""
    local myTable = {}
    local file = io.open( path, "r" )
    if file then
         -- read all contents of file into a string
         local contents = file:read( "*a" )
         myTable = json.decode(contents);
         io.close( file )
         return myTable 
    end
    return nil
end

function loadSettingGame( )
	-- body
	local gameSettingsVars = loadTable("saveGame.json")
	if (gameSettingsVars) then
		print( "--------CARGANDO--------" )
		--printTable(gameSettingsVars)
		_G.GameStarted = gameSettingsVars.gameStarted
		_G.NameUser = gameSettingsVars.nameUser
		_G.Phase = gameSettingsVars.phase 
		_G.Level = gameSettingsVars.level
		_G.DifficultLevel = gameSettingsVars.difficultLevel
		_G.Coin = gameSettingsVars.coin
		_G.Results = gameSettingsVars.results
		_G.TimerResults = gameSettingsVars.timeResults
		_G.numDigCoin = gameSettingsVars.numDigCoin
		_G.CurrentPage = gameSettingsVars.currentPage
		_G.IndexStat = gameSettingsVars.indexStat
    	_G.TakePhoto = gameSettingsVars.takePhoto
    	_G.IsTakePhot = gameSettingsVars.isTakePhot
    	_G.UploadImageTable = gameSettingsVars.uploadTable
    	_G.UploadImageDraw = gameSettingsVars.uploadDraw
    	_G.DrawLevel = gameSettingsVars.drawLevel
    	_G.DrawPhase = gameSettingsVars.drawPhase
    	_G.SecondFaseDraw = gameSettingsVars.secondFaseDraw
    	_G.Subtitle = gameSettingsVars.subtitule
    	_G.Age = gameSettingsVars.age
    	_G.AutoNextPage = gameSettingsVars.autoNextPage
	else
		print( "--------JUEGO INICIAL--------" )
		_G.NameUser = "Pedro" -- Name of the user 
       _G.Phase = 1 -- Phase of Level : 1=normal or 2=advance 
       _G.Level = 2 -- Level selected by user, [1,5] 
       _G.DifficultLevel = 2 -- Difficult selected by user 
       _G.Coin = 000 --  
       _G.Results = {} --  
       _G.TimerResults = {} --  
       _G.numDigCoin = 4 --  
       _G.CurrentPage = 1 --  
       _G.GameStarted = false -- 
       _G.IndexStat = 0 
       _G.TakePhoto = false  -- if true screenshot of the result table is taken equalization exercise
       _G.IsTakePhot = false -- if true the screen shot been taken
       _G.UploadImageTable = false
       _G.UploadImageDraw = false
       _G.DrawLevel = 0
       _G.DrawPhase = 0
       _G.SecondFaseDraw = {false, false, false, false, false}
       _G.Subtitle = false
       _G.Age = 3
       _G.AutoNextPage = true
    end
end

createTableSetting = function ()
	print( "Entra a crear tabla....." )
	local gameSettingsVars = {}

	gameSettingsVars.gameStarted = _G.GameStarted
	gameSettingsVars.nameUser = _G.NameUser
	gameSettingsVars.phase = _G.Phase
	gameSettingsVars.level = _G.Level
	gameSettingsVars.difficultLevel = _G.DifficultLevel
	gameSettingsVars.coin = _G.Coin
	gameSettingsVars.results = _G.Results
	gameSettingsVars.timeResults = _G.TimerResults
	gameSettingsVars.numDigCoin = _G.numDigCoin
	gameSettingsVars.currentPage = _G.CurrentPage
	gameSettingsVars.indexStat = _G.IndexStat
    gameSettingsVars.takePhoto = _G.TakePhoto
    gameSettingsVars.isTakePhot = _G.IsTakePhot
    gameSettingsVars.uploadDraw = _G.UploadImageDraw
    gameSettingsVars.uploadTable = _G.UploadImageTable
    gameSettingsVars.drawLevel = _G.DrawLevel
    gameSettingsVars.drawPhase = _G.DrawPhase
    gameSettingsVars.secondFaseDraw = _G.SecondFaseDraw
    gameSettingsVars.subtitule = _G.Subtitle
    gameSettingsVars.age = _G.Age
    gameSettingsVars.autoNextPage = _G.AutoNextPage
	--printTable(gameSettingsVars)
	return gameSettingsVars
end

continueGame = function ( event )
	-- body
	print( "Continuar juego ...." )
	local object = event.target

  	if event.phase == "began" then
        display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
      if event.phase == "ended" or event.phase == "cancelled" then
          --transition.resume( )
          resumeMyTimers()
          audio.resume( 1 )
          removePauseMenu() -- es opcional si se confirma que solo te puede salir del juego por el menu de pausa
          display.getCurrentStage():setFocus( nil )
          object.isFocus = false
      end
    end
 	return true
end

changeDifficult = function ( event )
	-- body
	print( "Cambiando dificultad ...." )
	local object = event.target

	if event.phase == "began" then
        display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
        	if(object.name == easy) then
				_G.DifficultLevel = 1
			elseif(object.name == normal) then
				_G.DifficultLevel = 2
			elseif(object.name == hard) then
				_G.DifficultLevel = 3
			else
				print( "Error en la seleccion de dificultad" )
			end
			continue.alpha = 1
			selectedDefficult.alpha = 1
			backMenu.alpha = 1
			difficultEasy.alpha = 0
			difficultNormal.alpha = 0
			difficultHard.alpha = 0
			display.getCurrentStage():setFocus( nil )
			object.isFocus = false
			print( "Nueva dificultad : ".._G.DifficultLevel )

        end
    end
	return true
end

selectDifficult = function( event )
	-- body
	print( "Seleccionar dificultad ...." )
	local object = event.target
	if event.phase == "began" then

        display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
        	continue.alpha = 0
			selectedDefficult.alpha = 0
			backMenu.alpha = 0
			difficultEasy.alpha = 1
			difficultNormal.alpha = 1
			difficultHard.alpha = 1
            display.getCurrentStage():setFocus( nil )
            object.isFocus = false
        end
    end
	return true
end

backMainMenu = function( event )
	-- body
	print( "backMainMenu" )
	local object = event.target
	if event.phase == "began" then

        display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
        	--guardad y cambiar escena
			savedTable("saveGame.json")
			removePauseMenu()
			display.getCurrentStage():setFocus( nil )
			object.isFocus = false
			cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
			director:changeScene( "page_1", "fade" ) 
        end
    end
	return true
end

local function backMainMenuExer( event )
	-- body
	local myDialog
	local object = event.target 

	local function onCompleteC( event )
		-- body
		local object = event.target
		if event.phase == "began" then

        	display.getCurrentStage():setFocus(object)
        	object.isFocus = true
    	elseif object.isFocus then
        	if event.phase == "ended" or event.phase == "cancelled" then
        		--guardad y cambiar escena
				savedTable("saveGame.json")
				deleteMyDialog( myDialog )
				removePauseMenuExer()
				display.getCurrentStage():setFocus( nil )
				object.isFocus = false
				cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
				director:changeScene( "page_1", "fade" ) 
        	end
    	end
		return true 	
	end

	local function onCompleteD( event )
		-- body
		local object = event.target
		if event.phase == "began" then

        	display.getCurrentStage():setFocus(object)
        	object.isFocus = true
    	elseif object.isFocus then
        	if event.phase == "ended" or event.phase == "cancelled" then
        		display.getCurrentStage():setFocus( nil )
				object.isFocus = false
        		deleteMyDialog(myDialog)
        	end
    	end
		return true
	end

	if event.phase == "began" then
        	display.getCurrentStage():setFocus(object)
        	object.isFocus = true
    elseif object.isFocus then
        	if event.phase == "ended" or event.phase == "cancelled" then
        		display.getCurrentStage():setFocus( nil )
				object.isFocus = false
        		myDialog = createMyDialog("Salir", "Si abandonas el ejercicio perderas el progreso realizado", onCompleteC, onCompleteD)
        	end
    end
	return true
	--display.getCurrentStage():setFocus(myDialog)
	--backMainMenu()
end

local function nothingTouch( event )
	-- body
	return true
end

local function nothingTap( event )
	-- body
	return true
end

createPauseMenu = function ( event )
  if (not createdPauseMenu) then
	createdPauseMenu = true

	rectangleHiddle = display.newRect( 0, 0, display.contentWidth, display.contentHeight)
	rectangleHiddle:addEventListener( "touch", nothingTouch )
	rectangleHiddle:addEventListener( "tap", nothingTap )
	rectangleHiddle.alpha = 0.01

	rectangle = display.newRoundedRect( display.contentWidth/2-250, 100, 500, 600, 10 )
	
	rectangle:setFillColor( 210, 210, 210 )
	rectangle.alpha = 0.9
	backgroundGroup:insert(rectangle)

	continue = widget.newButton{
		width = 240,
    	height = 120,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Continuar",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 25,
    	onEvent = continueGame
	}

	continue.x = display.contentCenterX
	continue.y = display.contentCenterY - 200

	selectedDefficult = widget.newButton{
		width = 240,
    	height = 120,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Dificultad",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 25,
    	onEvent = selectDifficult
	}

	selectedDefficult.x = display.contentCenterX
	selectedDefficult.y = display.contentCenterY

	backMenu = widget.newButton{
		width = 240,
    	height = 120,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Menu Principal",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 25,
    	onEvent = backMainMenu
	}

	backMenu.x = display.contentCenterX
	backMenu.y = display.contentCenterY + 200


	difficultEasy = widget.newButton{
		width = 240,
    	height = 120,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Facil",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 25,
    	onEvent = changeDifficult
	}

	difficultEasy.x = display.contentCenterX
	difficultEasy.y = display.contentCenterY - 150

	difficultNormal = widget.newButton{
		width = 240,
    	height = 120,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Normal",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 25,
    	onEvent = changeDifficult
	}

	difficultNormal.x = display.contentCenterX
	difficultNormal.y = display.contentCenterY 

	difficultHard = widget.newButton{
		width = 240,
    	height = 120,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Dificil",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 25,
    	onEvent = changeDifficult
	}

	difficultHard.x = display.contentCenterX
	difficultHard.y = display.contentCenterY + 150

	difficultEasy.name = easy
	difficultNormal.name = normal
	difficultHard.name = hard

	difficultEasy.alpha = 0
	difficultNormal.alpha = 0
	difficultHard.alpha = 0
  end
end

removePauseMenu = function ( )
	-- body
	createdPauseMenu = false

	rectangleHiddle:removeSelf( )
	rectangleHiddle = nil

	rectangle:removeSelf( )
	rectangle = nil
	continue:removeSelf( )
	continue = nil
	selectedDefficult:removeSelf( )
	selectedDefficult = nil
	backMenu:removeSelf()
	backMenu = nil

	difficultEasy:removeSelf( )
	difficultEasy = nil
	difficultNormal:removeSelf( )
	difficultNormal = nil
	difficultHard:removeSelf( )
	difficultHard = nil
end

createPauseMenuExer = function( )
	-- body
	if (not createdPauseMenuExer) then
		createdPauseMenuExer = true

		rectangleHiddleExer = display.newRect( 0, 0, display.contentWidth, display.contentHeight)
		rectangleHiddleExer:addEventListener( "touch", nothingTouch )
		rectangleHiddleExer:addEventListener( "tap", nothingTap )
		rectangleHiddleExer.alpha = 0.01

		rectangleExer = display.newRoundedRect( display.contentWidth/2-250, 100, 500, 600, 10 )
	
		rectangleExer:setFillColor( 210, 210, 210 )
		rectangleExer.alpha = 0.9

		continueExer = widget.newButton{
			width = 240,
    		height = 120,
    		defaultFile = imgDir.. "button.png",
    		--overFile = imgDir.. "button.png",
    		label = "Continuar",
    		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    		fontSize = 25,
    		onEvent = continueGame
		}

		continueExer.x = display.contentCenterX
		continueExer.y = display.contentCenterY - 200

		backMenuExer = widget.newButton{
			width = 240,
    		height = 120,
    		defaultFile = imgDir.. "button.png",
    		--overFile = imgDir.. "button.png",
    		label = "Menu Principal",
    		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    		fontSize = 25,
    		onEvent = backMainMenuExer
		}

		backMenuExer.x = display.contentCenterX
		backMenuExer.y = display.contentCenterY + 200	
	end
end

removePauseMenuExer = function( event )
	-- body
	createdPauseMenuExer = false

	rectangleHiddleExer:removeSelf( )
	rectangleHiddleExer = nil
	rectangleExer:removeSelf( )
	rectangleExer = nil
	continueExer:removeSelf( )
	continueExer = nil
	backMenuExer:removeSelf()
	backMenuExer = nil

end

onKeyEvent = function ( event )
	-- body
	local phase = event.phase
    local keyName = event.keyName
    
    
    if ((system.getInfo("environment")=="device" and "back" == keyName) or system.getInfo("environment")=="simulator") then
    		if (_G.CurrentPage ~= 1) then
    			local pageExercise = {15, 17, 18, 29, 38, 49, 57}
    			print( "Indice Tabla pausa: ".._G.CurrentPage )
    			print( table.indexOf( pageExercise, _G.CurrentPage ) )
    			if (table.indexOf( pageExercise, _G.CurrentPage ) ~= nil) then
    				createPauseMenuExer()
    			else
    				createPauseMenu()
    			end
    			--transition.pause( )
    			pauseMyTimers( )
    			audio.pause( 1 )
    		else
    			facebook.logout()
    			savedTable("saveGame.json")
    			native.requestExit()
    		end
    		return true
    end 
	return false    
end

local function onSystemEvent(event) 
    if (event.type == "applicationSuspend")  then 
    	savedTable("saveGame.json")
    elseif (event.type == "applicationResume") then
    	loadSettingGame( )
    end 
end 

Runtime:addEventListener("system", onSystemEvent) 

if system.getInfo("environment")=="device" then
	Runtime:addEventListener( "key", onKeyEvent )
else
	local rectangle2 = display.newRoundedRect( 100, 100, 100, 100, 10 )
	rectangle2:addEventListener( "tap", onKeyEvent )
end

--Runtime:addEventListener( "key", onKeyEvent ) -- Al salir del juego hay que quitar el evento
