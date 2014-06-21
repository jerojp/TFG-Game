local widget = require( "widget" )
local facebook = require "facebook"
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
local continue
local selectDefficult
local backMainMenu
local difficultEasy
local difficultNormal
local difficultHard
local createdPauseMenu = false

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

function savedTable(filename )
	-- body
	local t = createTableSetting()
	local path = system.pathForFile( filename, system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local contents = json.encode(t)
        file:write( contents )
        io.close( file )
        printTable(t)
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
	print( "--------CARGANDO--------" )
	printTable(gameSettingsVars)
	_G.NameUser = gameSettingsVars.nameUser
	_G.Phase = gameSettingsVars.phase 
	_G.Level = gameSettingsVars.level
	_G.DifficultLevel = gameSettingsVars.difficultLevel
	_G.Coin = gameSettingsVars.coin
	_G.Results = gameSettingsVars.results
	_G.TimerResults = gameSettingsVars.timeResults
	_G.numDigCoin = gameSettingsVars.numDigCoin
	_G.CurrentPage = gameSettingsVars.currentPage
end

createTableSetting = function ()
	print( "Entra a crear tabla....." )
	local gameSettingsVars = {}

	gameSettingsVars.nameUser = _G.NameUser
	gameSettingsVars.phase = _G.Phase
	gameSettingsVars.level = _G.Level
	gameSettingsVars.difficultLevel = _G.DifficultLevel
	gameSettingsVars.coin = _G.Coin
	gameSettingsVars.results = _G.Results
	gameSettingsVars.timeResults = _G.TimerResults
	gameSettingsVars.numDigCoin = _G.numDigCoin
	gameSettingsVars.currentPage = _G.CurrentPage
	printTable(gameSettingsVars)
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
          audio.resume( 1 )
          removePauseMenu() -- es opcional si se confirma que solo te puede salir del juego por el menu de pausa
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
			object.isFocus = false
			_G.CurrentPage = 1
			cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
			director:changeScene( "page_1", "fade" ) 
        end
    end
	return true
end

createPauseMenu = function ( event )
	createdPauseMenu = true

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

removePauseMenu = function ( )
	-- body
	createdPauseMenu = false

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

onKeyEvent = function ( event )
	-- body
	local phase = event.phase
    local keyName = event.keyName
    
    if (_G.CurrentPage ~= -1) then
     --if ( "back" == keyName ) then
    	        --local alert = native.showAlert( "Corona", "Dream. Build. Ship.", { "OK" })
    	if (not createdPauseMenu) then
    		createPauseMenu()
    	end
    	--transition.pause( )
    	audio.pause( 1 )
    	return true
     --end	
    else
    	facebook.logout()
    	native.requestExit() 
    end
	return false    
end

local rectangle2 = display.newRoundedRect( 100, 100, 100, 100, 10 )

rectangle2:addEventListener( "tap", onKeyEvent )
--Runtime:addEventListener( "key", onKeyEvent ) -- Al salir del juego hay que quitar el evento

local unhandledErrorListener = function( event )
	native.showAlert( "ERROR", event.errorMessage, { "OK" } )
    print( "Houston, we have a problem: " .. event.errorMessage )
end

Runtime:addEventListener( "unhandledError", unhandledErrorListener )