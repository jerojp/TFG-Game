--[[
Refactorizar para quitar el nombre del archivo saveGame. Añadir la opcion de resetear juego al modulo de guardar estado cuando se cree.
]]

local widget = require( "widget" )

local function butIntro(event) 
    if (event.phase == "ended" or event.phase == "cancelled") then
        local destDir = system.DocumentsDirectory  -- where the file is stored
        local results, reason = os.remove( system.pathForFile( "saveGame.json", destDir  ) )
        if results then
            print( "file removed" )
        else
            print( "file does not exist", reason )
        end
        loadSettingGame( )
        _G.CurrentPage = 2
        saveKwikVars({"CurrentPage",2}) 
        _G.GameStarted = true
        dispose(); director:changeScene( "page_2", "fade" )
    end
   return true 
end 

local function continueGame( event )
	-- body
	if (event.phase == "ended" or event.phase == "cancelled") then
        loadSettingGame( )
        dispose(); director:changeScene( "page_".._G.CurrentPage, "fade" ) 
    end
	
	return true
end

local function btnEtadistics( event )
    -- body
    if (event.phase == "ended" or event.phase == "cancelled") then
       _G.CurrentPage = 21
        dispose(); director:changeScene( "page_23", "fade" )  
    end
end

local continue = widget.newButton{
		width = 500,
    	height = 130,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Continuar",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 30,
    	onEvent = continueGame
}

continue.x = display.contentCenterX
continue.y = display.contentCenterY - 200

print( "Variable :" )
print( _G.GameStarted )
if (not _G.GameStarted) then
    continue.alpha = 0
else 
    continue.alpha = 1
end

local inicGame  = widget.newButton{
		width = 500,
    	height = 130,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Nueva Partida",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 30,
    	onEvent = butIntro
}

inicGame.x = display.contentCenterX
inicGame.y = display.contentCenterY

local statistics  = widget.newButton{
        width = 500,
        height = 130,
        defaultFile = imgDir.. "button.png",
        --overFile = imgDir.. "button.png",
        label = "Estadisticas",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
        fontSize = 30,
        onEvent = btnEtadistics
}

statistics.x = display.contentCenterX
statistics.y = display.contentCenterY + 200
