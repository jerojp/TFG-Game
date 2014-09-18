-- Book created by Kwik for Adobe Photoshop  - Developed by Kwiksher 
-- Copyright (C) 2012 kwiksher.com. All Rights Reserved. 
-- uses Director class, by Ricardo Rauber 
-- uses DMC classes, by David McCuskey 
-- Exported on Fri Sep 12 2014 01:10:45 GMT+0200 
-- uses gTween class, by Josh Tynjala (modified by Kwiksher) 

_G.kwk_readMe = 0 

director = require("director") 
Gesture = require("dmc_gesture") 
MultiTouch = require("dmc_multitouch") 
system.activate("multitouch") 
json = require("json") 
-- check if current SDK version is the latest compatible with Kwik 
local function versionCheck(event) if "clicked" == event.action then if event.index == 2 then system.openURL( "https://developer.coronalabs.com/downloads/coronasdk" ) end end end 
if ( system.getInfo("environment") =="simulator" and system.getInfo("build") ~="2013.2100" ) then native.showAlert("Corona SDK Incompatible Version","Your Corona SDK version is different than the certified one with Kwik. Install build 2013.2100 or you may have issues in your project.",{"OK", "Download"}, versionCheck) end 

local gtween = require("gtween") 

display.setStatusBar( display.HiddenStatusBar ) 
imgDir = "images/" 
audioDir = "audio/" 
videoDir = "video/" 
spriteDir = "sprites/" 

_G.lang = "" 

kBidi = false 
_G.kAutoPlay = 0 
initPage = 1 
local goPage = 1 

-- Json code for external variable loading 
local jsonFile = function(filename ) 
   local path = system.pathForFile(filename, system.DocumentsDirectory ) 
   local contents 
   local file = io.open( path, "r" ) 
   if file then 
      contents = file:read("*a") 
      io.close(file) 
   end 
   return contents 
end 
-- Variable saving function 
local path = system.pathForFile( "kwkVars.json", system.DocumentsDirectory ) 
local file = io.open( path, "r" ) 
if file then 
else 
   local file = io.open( path, "w+b" ) 
   file:write("{{}}") 
   io.close(file) 
end 

-- Loads vars 
kwkVar = json.decode( jsonFile("kwkVars.json") ) 
-- Check for saved variables 
function kwkVarCheck(variable) 
   kwkVar = json.decode( jsonFile("kwkVars.json") ) 
   local found = nil 
   if kwkVar ~= nil then 
      for i = 1, #kwkVar do 
         if (variable == kwkVar[i].name) then 
            found = kwkVar[i].value; break 
         end 
      end 
   end
   return (found) 
end 



--Create a main group
local mainGroup = display.newGroup()

-- Main function
local function main()
   -- Add the group from Director calls
   mainGroup:insert(director.directorView)

   -- Adding external code
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

_G.gSprites = nil

printTable = function ( myTable)
	-- body
	print( "-------INICIO IMPRESION-------" )
	for key,value in pairs(myTable) do
		print(key, value)
		print( "--------------" )
	end

	print( "-------FIN IMPRESION-------" )
end

function pauseAllSprites(  )
    -- body
    if (_G.gSprites) then
        _G.gSprites:pause( )
    end

end

function resumeAllSprites( )
    -- body
    if (_G.gSprites) then
        _G.gSprites:play( )
    end
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

--[[function unlockToy( level, phase )
    -- body
    local index = (level*2 - 1)+(phase-1)
    _G.Toys[index].block = true
end
]]--
function savedTable(filename )
	-- body
	local t = createTableSetting()
	local path = system.pathForFile( filename, system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local contents = json.encode(t)
        file:write( contents )
        io.close( file )
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
    _G.IsTakePhoto = gameSettingsVars.isTakePhot
    _G.UploadImageTable = gameSettingsVars.uploadTable
    _G.UploadImageDraw = gameSettingsVars.uploadDraw
    _G.DrawLevel = gameSettingsVars.drawLevel
    _G.DrawPhase = gameSettingsVars.drawPhase
    _G.Subtitle = gameSettingsVars.subtitule
    _G.Age = gameSettingsVars.age
    _G.AutoNextPage = gameSettingsVars.autoNextPage
    _G.UpLevelSample = gameSettingsVars.upLevelSample
    _G.Toys = gameSettingsVars.toys
    _G.UnlockToys = gameSettingsVars.unlockToys
    _G.PriceToys = gameSettingsVars.priceToys
    _G.LastPageLevel = gameSettingsVars.lastPageLevel
    _G.StoreToysUnlocked = gameSettingsVars.storeToysUnlocked
    _G.goBackForExercise = gameSettingsVars.goBackForExercise
    _G.FirstVisitMap = gameSettingsVars.firstVisitMap
    _G.goBackEnd = gameSettingsVars.goBackEnd
    _G.LetterInSyllable = gameSettingsVars.letterInSyllable
    _G.firstDrawLetter = gameSettingsVars.firstDrawLetter
    _G.firstSampleSel = gameSettingsVars.firstSampleSel
    _G.firstRecAudio = gameSettingsVars.firstRecAudio
    _G.firstViewToy = gameSettingsVars.firstViewToy
    _G.firstStoreToy = gameSettingsVars.firstStoreToy
    _G.goBackEndLevel = gameSettingsVars.goBackEndLevel
    _G.LevelCompleted = gameSettingsVars.levelCompleted
    _G.ScaleDraw = gameSettingsVars.scaleDraw
    _G.LastDifDraw = gameSettingsVars.changeDifDraw
    --_G.MyCurrentSubtitle = gameSettingsVars.currentSubtitles
	else
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
        _G.GameStarted = false -- 
        _G.IndexStat = 0 
        _G.TakePhoto = false  -- if true screenshot of the result table is taken equalization exercise
        _G.IsTakePhoto = false -- if true the screen shot been taken
        _G.UploadImageTable = false
        _G.UploadImageDraw = false
        _G.DrawLevel = 0
        _G.DrawPhase = 0
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
            _G.Toys[i] = {sold = false, block = true}    
        end
        _G.UnlockToys = {} -- _G.UnlockToys[n] = { nameToy = "", path = "", widthToy, heightToy}
        _G.PriceToys = {289, 324, 361, 400, 441, 484, 529, 576, 625, 0}
        _G.LastPageLevel = {{page = 25, phase = 1}, {page = 12, phase = 1}, {page = 35, phase = 1}, {page = 44, phase = 1}, {page = 54, phase = 1}}
        _G.StoreToysUnlocked = false
        _G.goBackForExercise = false
        _G.FirstVisitMap = true
        _G.goBackEnd = false
        _G.goBackEndLevel = false
        _G.firstSampleSel = true
        _G.firstDrawLetter = true
        _G.firstRecAudio = true
        _G.firstViewToy = true
        _G.firstStoreToy = true
        _G.LetterInSyllable = true
        _G.LevelCompleted = {false, false, false, false, false}
        _G.ScaleDraw = 1
        _G.LastDifDraw = 2
        _G.MyCurrentSubtitle = nil
        _G.FunctionDelHiddenPanel = nil
        _G.InPanelOptions = false
  end
end

createTableSetting = function ()
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
  gameSettingsVars.isTakePhot = _G.IsTakePhoto
  gameSettingsVars.uploadDraw = _G.UploadImageDraw
  gameSettingsVars.uploadTable = _G.UploadImageTable
  gameSettingsVars.drawLevel = _G.DrawLevel
  gameSettingsVars.drawPhase = _G.DrawPhase
  gameSettingsVars.subtitule = _G.Subtitle
  gameSettingsVars.age = _G.Age
  gameSettingsVars.autoNextPage = _G.AutoNextPage
  gameSettingsVars.upLevelSample = _G.UpLevelSample
  gameSettingsVars.lastPage = _G.LastPage
  gameSettingsVars.toys = _G.Toys
  gameSettingsVars.unlockToys = _G.UnlockToys
  gameSettingsVars.priceToys = _G.PriceToys
  gameSettingsVars.lastPageLevel = _G.LastPageLevel
  gameSettingsVars.storeToysUnlocked = _G.StoreToysUnlocked
  gameSettingsVars.goBackForExercise =  _G.goBackForExercise
  gameSettingsVars.firstVisitMap = _G.FirstVisitMap
  gameSettingsVars.goBackEnd =  _G.goBackEnd
  gameSettingsVars.goBackEndLevel = _G.goBackEndLevel
  gameSettingsVars.letterInSyllable = _G.LetterInSyllable
  gameSettingsVars.firstDrawLetter = _G.firstDrawLetter
  gameSettingsVars.firstSampleSel = _G.firstSampleSel
  gameSettingsVars.firstRecAudio = _G.firstRecAudio
  gameSettingsVars.firstViewToy = _G.firstViewToy
  gameSettingsVars.firstStoreToy = _G.firstStoreToy
  gameSettingsVars.levelCompleted = _G.LevelCompleted
  gameSettingsVars.scaleDraw = _G.ScaleDraw
  gameSettingsVars.lastDifDraw = _G.LastDifDraw
	--printTable(gameSettingsVars)
	return gameSettingsVars
end

continueGame = function ( event )
	-- body
	local object = event.target

  	if event.phase == "began" then
        display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
      if event.phase == "ended" or event.phase == "cancelled" then
          local notAutoAdv = {1, 2, 3, 4, 6, 7, 12, 19, 23, 24, 30, 40, 62, 63, 65}
          if (table.indexOf( notAutoAdv, _G.CurrentPage ) == nil) then
              if ( (_G.Subtitle or not _G.AutoNextPage) and isPlayMyScene())then
                createPanelAutoAdvance( )
              elseif ( not _G.Subtitle and _G.AutoNextPage and isCreatedPanelAutoAdvance( )) then
                removePanelAutoAdvance( true )
              end
          end
          resumeAllSprites()
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
	local object = event.target
	if event.phase == "began" then

        display.getCurrentStage():setFocus(object)
        object.isFocus = true
    elseif object.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
        	--guardad y cambiar escena
          finalizeScene( true )
          audio.stop( 1 )
          audio.stop( 2 )
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
              audio.stop( 1 )
              audio.stop( 2 )
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
    pauseAllSprites()
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
    
    if ((system.getInfo("environment")=="device" and "back" == keyName and event.phase == "up") or system.getInfo("environment")=="simulator") then
            if (_G.CurrentPage ~= 1) then
                local pageExercise = {15, 17, 18, 29, 38, 49, 57}
 
                if (table.indexOf( pageExercise, _G.CurrentPage ) ~= nil) then
                    createPauseMenu(true)
                elseif ( _G.CurrentPage == 24) then
                    cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
                    director:changeScene("page_23")
                elseif ( _G.CurrentPage == 23 or _G.CurrentPage == 65) then
                    cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions()
                    audio.stop( 1 ) 
                    director:changeScene("page_1")
                else
                    createPauseMenu(false)
                end
            else
                if (not _G.InPanelOptions) then
                  facebook.logout()
                  savedTable("saveGame.json")
                  native.requestExit()
                end
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
    rectangle2.alpha = 0.1
	rectangle2:addEventListener( "tap", onKeyEvent )
end

--[[
if ( system.getInfo("environment") =="simulator" ) then 
   local function monitorMem() 
       collectgarbage() 
       print( "MemUsage: " .. collectgarbage("count") ) 
       local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000 
       print( "TexMem:   " .. textMem ) 
   end 
   Runtime:addEventListener("enterFrame", monitorMem) 
]]--
loadSettingGame( ) 
_G.EnterGame = true
_G.MyCurrentSubtitle = nil
_G.FunctionDelHiddenPanel = nil
_G.InPanelOptions = false
--Runtime:addEventListener( "key", onKeyEvent ) -- Al salir del juego hay que quitar el evento 

   director:changeScene("page_"..goPage)
   return true
end




--Clear timers and transitions
timerStash = {}
transitionStash = {}
gtStash = {}

function cancelAllTimers()
    local k, v

    for k,v in pairs(timerStash) do
        timer.cancel( v )
        v = nil; k = nil
    end

    timerStash = nil
    timerStash = {}
end

--

function cancelAllTransitions()
    local k, v

    for k,v in pairs(transitionStash) do
        transition.cancel( v )
        v = nil; k = nil
    end

    transitionStash = nil
    transitionStash = {}
end

--cancel all gtweens
function cancelAllTweens()
    local k, v

    for k,v in pairs(gtStash) do
        v:pause();
        v = nil; k = nil
    end

    gtStash = nil
    gtStash = {}
end

--save all permanent variables
function zeroesKwikVars() --restart the file to save variable content
	local path = system.pathForFile( "kwkVars.json", system.DocumentsDirectory )
	local contents
	local file = io.open( path, "w+b" )
	if file then
	   contents = file:write( "{{}}" )
	   io.close( file )	-- close the file after using it
	end
end

function saveKwikVars(toSave) --toSave is a table with contents
    local varTab={}
	--loop current kwkVar content (contains ALL variables saved)
	local found = nil
	local jsonString
	
	--checks if current file is empty or not
	local path = system.pathForFile( "kwkVars.json", system.DocumentsDirectory )
	local contents
	--check if file exists
	local file = io.open( path, "r" )
	if file then
	    --reads to check if original content is empty == {{}}
	    local test = file:read("*l") 

	    if (test=="{{}}") then
	        -- kwkVar.json is empty. Recreates the file with the new content
	    	local file = io.open( path, "w+b" )
	    	varTab[1] = {["name"] = toSave[1],["value"] = toSave[2]}
			jsonString = json.encode( varTab )

			contents = file:write( jsonString )
			io.close( file )
	    else
	        --there are already variables saved in the kwkVars.json file
	    	local file = io.open( path, "w" )
	    	local ts = 0

		    for i = 1,#kwkVar do
		      if (toSave[1] == kwkVar[i].name) then
				kwkVar[i].value = toSave[2]
				varTab[i] = {["name"] = kwkVar[i].name,["value"] = kwkVar[i].value}
				ts = 1
			  else
				varTab[i] = {["name"] = kwkVar[i].name,["value"] = kwkVar[i].value}
			  end
		    end
		    if (ts == 0) then --variable not in the file yet
		    	local x = #kwkVar
		    	x = x + 1
			    varTab[x] = {["name"] = toSave[1],["value"] = toSave[2]}
			end

		    jsonString = json.encode( varTab )
	    	contents = file:write( jsonString )
			io.close( file )
	    end
	    
	    
	else
	    --re-creation scenario
	    zeroesKwikVars()
	end
	kwkVar = json.decode( jsonFile( "kwkVars.json" ) )	
	
end


-- Begin
main()