--[[
  Refactorizar este código. Cambiar las funciones de guardar y cargar juego a un fichero aparte, preferiblemente añadirlas a una tabla
como clase.
]]

local widget = require( "widget" )
local facebook = require "facebook"
require("MyDialog")
require("ControlScene")
local normalPauseGroup

-- functions
local onKeyEvent
local createTableSetting
local printTable
local removePauseMenu 
local removePauseMenuExer
local createPauseMenuNormal
local createPauseMenuExer
local continueGame
local viewOptions
local backMainMenu
local continueExercise
local onKeyEvent

-- display and vars
local backMainMenu
local createdPauseMenu = false

local exerPauseGroup
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

function pauseAllTransition( )
    -- body
    local k, v

    for k,v in pairs(gtStash) do
        v:pause();
    end

    for k,v in pairs(transitionStash) do
        transition.pause( v )
    end
end

function resumeAllTransition( )
    -- body
    local k, v

    for k,v in pairs(gtStash) do
        v:play();
    end

    for k,v in pairs(transitionStash) do
        transition.resume( v )
    end
end

function pauseMyTimers( )
	-- body
	local k, v

    print( "Pausados TODOS los TIMERS" )
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

function unlockToy( level, phase )
    -- body
    local index = (level*2 - 1)+(phase-1)
    _G.Toys[index].block = true
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
    _G.LastPage = gameSettingsVars.lastPage
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
    _G.UpLevelSample = gameSettingsVars.upLevelSample
    _G.Toys = gameSettingsVars.toys
    _G.PriceToys = gameSettingsVars.priceToys
    _G.LastPageLevel = gameSettingsVars.lastPageLevel
    _G.StoreToysUnlocked = gameSettingsVars.storeToysUnlocked
    --_G.MyCurrentSubtitle = gameSettingsVars.currentSubtitles
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
        _G.LastPage = nil  
        _G.MyCurrentSubtitle = nil
        _G.GameStarted = false -- 
        _G.IndexStat = 0 
        _G.TakePhoto = false  -- if true screenshot of the result table is taken equalization exercise
        _G.IsTakePhot = false -- if true the screen shot been taken
        _G.UploadImageTable = false
        _G.UploadImageDraw = false
        _G.DrawLevel = 0
        _G.DrawPhase = 0
        _G.SecondFaseDraw = {false, false, false, false, false}
        if (_G.Subtitle == nil) then
            _G.Subtitle = false
        end
        _G.Age = 3
        if (_G.AutoNextPage == nil) then
            _G.AutoNextPage = true
        end
        _G.UpLevelSample = {}
        _G.Toys = {}
        for i=1,10 do
            _G.Toys[i] = {block = true, sold = false}    
        end
        _G.PriceToys = {mask = 289, bee = 324, elephant = 361, bicycle = 400, indian = 441, dolphin = 484, sheep = 529, donkey = 576, guitar = 625, unicorn = 676}
        _G.LastPageLevel = {25, 12, 35, 44, 54}
        _G.StoreToysUnlocked = false
  end
end

createTableSetting = function ()
	print( "-------------Entra a crear tabla.....--------------" )
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
  gameSettingsVars.upLevelSample = _G.UpLevelSample
  gameSettingsVars.lastPage = _G.LastPage
  gameSettingsVars.toys = _G.Toys
  gameSettingsVars.priceToys = _G.PriceToys
  gameSettingsVars.lastPageLevel = _G.LastPageLevel
  gameSettingsVars.storeToysUnlocked = _G.StoreToysUnlocked

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
          local notAutoAdv = {2, 3, 4, 6, 7, 11, 19, 30, 62, 63}
          if (table.indexOf( notAutoAdv, _G.CurrentPage ) == nil) then
              if ( (_G.Subtitle or not _G.AutoNextPage) and not isCreatedPanelAutoAdvance( )) then
                print( "Se crea panel de AVANCE AUTO PAGINA ")
                createPanelAutoAdvance( )
              elseif ( not _G.Subtitle and _G.AutoNextPage and isCreatedPanelAutoAdvance( ) ) then
                print( "Se elimina panel de AVANCE AUTO PAGINA " )
                removePanelAutoAdvance( )
              end
          end
          
          resumeAllTransition()
          resumeMyTimers()
          audio.resume( 1 )
          audio.resume( 2 )
          removePauseMenu() -- es opcional si se confirma que solo te puede salir del juego por el menu de pausa
          display.getCurrentStage():setFocus( nil )
          object.isFocus = false
      end
    end
 	return true
end

viewOptions = function ( event )
	-- body
	local object = event.target

	if event.phase == "began" then
        display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
			display.getCurrentStage():setFocus( nil )
			object.isFocus = false
			createPanelOptions( )
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
            finalizeScene( true )
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

continueExercise = function ( event )
    -- body
    local object = event.target

    if event.phase == "began" then
        display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
      if event.phase == "ended" or event.phase == "cancelled" then
          print( "Continuar juego ...." )
          resumeAllTransition()
          resumeMyTimers()
          audio.resume( 1 )
          audio.resume( 2 )
          removePauseMenuExer()
          display.getCurrentStage():setFocus( nil )
          object.isFocus = false
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
                _G.Coin = _G.Coin - _G.TotalAddCoinEx
                print( "-------------------Nuevo COIN : ".._G.Coin )
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

        		myDialog = createMyDialog("Salir", " Si abandonas el ejercicio perderas el progreso realizado", nil, "Confirmar", onCompleteC, "Cancelar" , onCompleteD)
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

createPauseMenuNormal = function ( event )
  if (not normalPauseGroup) then
	normalPauseGroup = display.newGroup( )
    createdPauseMenu = true

    local rectangleHiddle = display.newRect( 0, 0, display.contentWidth, display.contentHeight)
    rectangleHiddle:addEventListener( "touch", nothingTouch )
    rectangleHiddle:addEventListener( "tap", nothingTap )
    rectangleHiddle:setFillColor( 182,210,236 )
    rectangleHiddle.alpha = 0.6
    normalPauseGroup:insert( rectangleHiddle )

    local rectangle = display.newRoundedRect( display.contentCenterX-250, 100, 500, 600, 38 )
    rectangle:setFillColor( 56,187,105 )
    normalPauseGroup:insert(rectangle)

    local colorLabelBtn = {R=10, G=25, B=106}
    
    local textPr = display.newText( "Pausa", display.contentCenterX, rectangle.y - rectangle.contentHeight/2 + 50, native.systemFontBold, 60 )
    textPr.x = display.contentCenterX
    textPr:setFillColor(  255 )
    normalPauseGroup:insert( textPr )

	local continue = widget.newButton{
		width = 240,
    	height = 70,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Continuar",
    	labelColor = { default={ colorLabelBtn.R, colorLabelBtn.G, colorLabelBtn.B }, over={ 0, 0, 210 } },
        font = native.systemFontBold,
    	fontSize = 28,
    	onEvent = continueGame
	}

	continue.x = rectangle.x
	continue.y = rectangle.y - continue.contentHeight
    continue:setFillColor(  255,248,143 )
    normalPauseGroup:insert( continue )

	local btnOptions = widget.newButton{
		width = 240,
    	height = 70,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Opciones",
    	labelColor = { default={ colorLabelBtn.R, colorLabelBtn.G, colorLabelBtn.B }, over={ 0, 0, 210 } },
        font = native.systemFontBold,
    	fontSize = 28,
    	onEvent = viewOptions
	}

	btnOptions.x = rectangle.x
	btnOptions.y = continue.y + continue.contentHeight/2 + 50 + btnOptions.contentHeight/2
    btnOptions:setFillColor( 255,132,107 )
    normalPauseGroup:insert( btnOptions )

	local backMenu = widget.newButton{
		width = 240,
    	height = 70,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Menu Principal",
    	labelColor = { default={ colorLabelBtn.R, colorLabelBtn.G, colorLabelBtn.B }, over={ 0, 0, 210 } },
        font = native.systemFontBold,
    	fontSize = 28,
    	onEvent = backMainMenu
	}

	backMenu.x = rectangle.x
	backMenu.y = btnOptions.y + backMenu.contentHeight/2 + 50 + backMenu.contentHeight/2
    backMenu:setFillColor( 185,129,221 )
    normalPauseGroup:insert( backMenu )

  end
end

removePauseMenu = function ( )
	-- body
	createdPauseMenu = false

	display.remove( normalPauseGroup )
    normalPauseGroup = nil

end

createPauseMenuExer = function( )
	-- body
	if (not exerPauseGroup) then
		createdPauseMenuExer = true
        exerPauseGroup = display.newGroup( )

		local rectangleHiddleExer = display.newRect( 0, 0, display.contentWidth, display.contentHeight)
		rectangleHiddleExer:addEventListener( "touch", nothingTouch )
		rectangleHiddleExer:addEventListener( "tap", nothingTap )
        rectangleHiddleExer:setFillColor( 182,210,236 )
		rectangleHiddleExer.alpha = 0.6
        exerPauseGroup:insert( rectangleHiddleExer )

		local rectangleExer = display.newRoundedRect( display.contentCenterX-250, display.contentCenterY-225 , 500, 450, 28 )
		rectangleExer:setFillColor( 56,187,105 )
        exerPauseGroup:insert( rectangleExer )

        local colorLabelBtn = {R=10, G=25, B=106}
        
        local textPr = display.newText( "Pausa", display.contentCenterX, rectangleExer.y - rectangleExer.contentHeight/2 + 50, native.systemFontBold, 60 )
        textPr.x = display.contentCenterX
        textPr:setFillColor(  255 )
        exerPauseGroup:insert( textPr )

		local continueExer = widget.newButton{
			width = 240,
    		height = 70,
    		defaultFile = imgDir.. "button.png",
    		--overFile = imgDir.. "button.png",
    		label = "Continuar",
    		labelColor = { default={ colorLabelBtn.R, colorLabelBtn.G, colorLabelBtn.B }, over={ 0, 0, 210 } },
    		fontSize = 28,
    		onEvent = continueExercise
		}

		continueExer.x = rectangleExer.x
		continueExer.y = rectangleExer.y - continueExer.contentHeight + 50
        continueExer:setFillColor(  255,248,143 )
        exerPauseGroup:insert( continueExer )

		local backMenuExer = widget.newButton{
			width = 240,
    		height = 70,
    		defaultFile = imgDir.. "button.png",
    		--overFile = imgDir.. "button.png",
    		label = "Menu Principal",
    		labelColor = { default={ colorLabelBtn.R, colorLabelBtn.G, colorLabelBtn.B }, over={ 0, 0, 210 } },
    		fontSize = 28,
    		onEvent = backMainMenuExer
		}

		backMenuExer.x = rectangleExer.x
		backMenuExer.y = continueExer.y + continueExer.contentHeight/2 + 50 + backMenuExer.contentHeight/2
        backMenuExer:setFillColor( 185,129,221 )	
        exerPauseGroup:insert( backMenuExer )
	end
end

removePauseMenuExer = function( event )
	-- body
	createdPauseMenuExer = false

    display.remove( exerPauseGroup )
    exerPauseGroup = nil

end

function createPauseMenu( isExercise )
    -- body
    pauseAllTransition()
    --transition.pause( )
    pauseMyTimers( )

    if ( audio.isChannelActive( 1 ) ) then
        audio.pause( 1 )    
    end
    if ( audio.isChannelActive( 2 ) ) then
        audio.pause( 2 )
    end

    if (isExercise) then
        createPauseMenuExer()
    else
        createPauseMenuNormal()
    end
end

onKeyEvent = function ( event )
	-- body
    local keyName = event.keyName
    local object = event.target
    
    print( object.name )
    if ((system.getInfo("environment")=="device" and "back" == keyName and event.phase == "up") or system.getInfo("environment")=="simulator") then
            if (_G.CurrentPage ~= 1) then
                local pageExercise = {15, 17, 18, 29, 38, 49, 57}
                print( "Indice Tabla pausa: ".._G.CurrentPage )
                print( table.indexOf( pageExercise, _G.CurrentPage ) )
                if (table.indexOf( pageExercise, _G.CurrentPage ) ~= nil) then
                    createPauseMenu(true)
                elseif ( _G.CurrentPage == 24) then
                    cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
                    director:changeScene("page_23")
                elseif ( _G.CurrentPage == 23 or _G.CurrentPage == 65) then
                    cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
                    director:changeScene("page_1")
                else
                    createPauseMenu(false)
                end
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
    rectangle2.name = "RectPause"
	rectangle2:addEventListener( "tap", onKeyEvent )
end

--Runtime:addEventListener( "key", onKeyEvent ) -- Al salir del juego hay que quitar el evento