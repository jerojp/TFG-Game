-- Book created by Kwik for Adobe Photoshop  - Developed by Kwiksher 
-- Copyright (C) 2012 kwiksher.com. All Rights Reserved. 
-- uses Director class, by Ricardo Rauber 
-- uses DMC classes, by David McCuskey 
-- Exported on Fri Aug 08 2014 17:55:51 GMT+0200 
-- uses gTween class, by Josh Tynjala (modified by Kwiksher) 
-- uses bTween class, by Josh Tynjala (modified by Kwiksher) 

_G.kwk_readMe = 0 

director = require("director") 
Gesture = require("dmc_gesture") 
MultiTouch = require("dmc_multitouch") 
system.activate("multitouch") 
json = require("json") 
-- check if current SDK version is the latest compatible with Kwik 
local function versionCheck(event) if "clicked" == event.action then if event.index == 2 then system.openURL( "https://developer.coronalabs.com/downloads/coronasdk" ) end end end 
if ( system.getInfo("environment") =="simulator" and system.getInfo("build") ~="2013.2100" ) then native.showAlert("Corona SDK Incompatible Version","Your Corona SDK version is different than the certified one with Kwik. Install build 2013.2100 or you may have issues in your project.",{"OK", "Download"}, versionCheck) end 

Navigation = require("kNavi") 
local gtween = require("gtween") 
local btween = require("btween") 

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
  Refactorizar este c�digo. Cambiar las funciones de guardar y cargar juego a un fichero aparte, preferiblemente a�adirlas a una tabla
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
 
   loadSettingGame( )    
        

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