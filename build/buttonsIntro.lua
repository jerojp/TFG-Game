--[[
Refactorizar para quitar el nombre del archivo saveGame. Añadir la opcion de resetear juego al modulo de guardar estado cuando se cree.
]]

local widget = require( "widget" )
require( "viewOptions" )

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
        dispose(); director:changeScene( "page_".._G.LastPage, "fade" ) 
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

local function btnOptions( event )
    -- body
    if (event.phase == "ended" or event.phase == "cancelled") then
       createPanelOptions( )  
    end
end

local function btnStoreToys( event )
    -- body
    if (event.phase == "ended" or event.phase == "cancelled") then
       dispose(); director:changeScene( "page_65", "fade" ) 
    end
end

local continue = widget.newButton{
		width = 500,
    	height = 100,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Continuar",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 30,
    	onEvent = continueGame
}

continue.x = display.contentCenterX
continue.y = display.contentCenterY - 300

if (not _G.GameStarted) then
    continue.alpha = 0
else 
    continue.alpha = 1
end

local inicGame  = widget.newButton{
		width = 500,
    	height = 100,
    	defaultFile = imgDir.. "button.png",
    	--overFile = imgDir.. "button.png",
    	label = "Nueva Partida",
    	labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    	fontSize = 30,
    	onEvent = butIntro
}

inicGame.x = display.contentCenterX
inicGame.y = display.contentCenterY - 150


local options  = widget.newButton{
        width = 500,
        height = 100,
        defaultFile = imgDir.. "button.png",
        --overFile = imgDir.. "button.png",
        label = "Opciones",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
        fontSize = 30,
        onEvent = btnOptions
}

options.x = display.contentCenterX
options.y = display.contentCenterY

local storeToys  = widget.newButton{
        width = 500,
        height = 100,
        defaultFile = imgDir.. "button.png",
        --overFile = imgDir.. "button.png",
        label = "Juguetes",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
        fontSize = 30,
        onEvent = btnStoreToys
}

storeToys.x = display.contentCenterX
storeToys.y = display.contentCenterY + 150

local statistics  = widget.newButton{
        width = 500,
        height = 100,
        defaultFile = imgDir.. "button.png",
        --overFile = imgDir.. "button.png",
        label = "Estadisticas",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
        fontSize = 30,
        onEvent = btnEtadistics
}

statistics.x = display.contentCenterX
statistics.y = display.contentCenterY + 300
