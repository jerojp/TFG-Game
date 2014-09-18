local widget = require( "widget" )
require("MyDialog")
local scrollView

function removePanelOptions( )
    -- body
    _G.InPanelOptions = false
    display.remove( scrollView )
    scrollView = nil
end

function createPanelOptions( )
    -- body
    _G.InPanelOptions = true
    local myGroup = display.newGroup( )

    local selDif
    local selSubt
    local selAuto
    local varDifficulty = _G.DifficultLevel
    local varSubtitles = _G.Subtitle
    local varAdvance = _G.AutoNextPage
    local varLetter = _G.LetterInSyllable
    local inicAlphaSubtitle
    local hiddenPanelAuto
    if (_G.MyCurrentSubtitle) then
        inicAlphaSubtitle = _G.MyCurrentSubtitle.alpha
    end

--_G.DifficultLevel = event.target.id
          --print( object.id )

    local function butHelp( event )
        -- body
        local obj = event.target
        local myDialog
        local function onCompleteCon( event )
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
        myDialog = createMyDialog("INFORMACIÓN", obj.textHelp, nil, "Confirmar", onCompleteCon)
    end
    local function changeDifficult( event )
	-- body
	   local object = event.target
	   if event.phase == "began" then

        --display.getCurrentStage():setFocus(object)
         object.isFocus = true
        elseif object.isFocus then
            if event.phase == "ended" or event.phase == "cancelled" then
        	   selDif.x = object.x - 3
        	   varDifficulty = object.difficulty
			 --display.getCurrentStage():setFocus( nil )
			 object.isFocus = false
            end
        end
	   return true
    end

    local function changeStateSubtitles( event )
    -- body
        local object = event.target
        if event.phase == "began" then

        --display.getCurrentStage():setFocus(object)
            object.isFocus = true
        elseif object.isFocus then
            if event.phase == "ended" or event.phase == "cancelled" then
                selSubt.x = object.x - 3
                varSubtitles = object.subtitle
                if (_G.MyCurrentSubtitle) then
                    if (varSubtitles) then
                        _G.MyCurrentSubtitle.alpha = 1
                    else
                        _G.MyCurrentSubtitle.alpha = 0
                    end
                end
                if (varSubtitles) then
                    hiddenPanelAuto.alpha = 0.6
                else
                    hiddenPanelAuto.alpha = 0
                end
                --display.getCurrentStage():setFocus( nil )
                object.isFocus = false
            end
        end
        return true
    end

    local function changeAdvance( event )
    -- body
        local object = event.target
        if event.phase == "began" then

            --display.getCurrentStage():setFocus(object)
            object.isFocus = true
        elseif object.isFocus then
            if event.phase == "ended" or event.phase == "cancelled" then
                selAuto.x = object.x - 3
                varAdvance = object.auto
                --display.getCurrentStage():setFocus( nil )
                object.isFocus = false
            end
        end
        return true
    end

    local function changeLetters( event )
    -- body
        local object = event.target
        if event.phase == "began" then

            --display.getCurrentStage():setFocus(object)
            object.isFocus = true
        elseif object.isFocus then
            if event.phase == "ended" or event.phase == "cancelled" then
                selLetter.x = object.x - 3
                varLetter = object.auto
                --display.getCurrentStage():setFocus( nil )
                object.isFocus = false
            end
        end
        return true
    end

    local function cancelOptions( event )
    -- body
    local object = event.target
        if event.phase == "began" then

        --display.getCurrentStage():setFocus(object)
            object.isFocus = true
        elseif object.isFocus then
            if event.phase == "ended" or event.phase == "cancelled" then
                if (_G.MyCurrentSubtitle) then
                    _G.MyCurrentSubtitle.alpha = inicAlphaSubtitle
                end
                removePanelOptions( )
                --display.getCurrentStage():setFocus( nil )
                object.isFocus = false
            end
        end
        return true 
    end

    local function confirmOptions( event )
        -- body
        local object = event.target
        if event.phase == "began" then

        --display.getCurrentStage():setFocus(object)
            object.isFocus = true
        elseif object.isFocus then
            if event.phase == "ended" or event.phase == "cancelled" then
                _G.Subtitle = varSubtitles
                _G.DifficultLevel = varDifficulty
                _G.AutoNextPage = varAdvance
                _G.LetterInSyllable = varLetter
                removePanelOptions( )
                --display.getCurrentStage():setFocus( nil )
                object.isFocus = false
            end
        end
        return true 
    end

    local function doNothing(event)
        -- body
        return true
    end

    local colorRect = {R=154,G=225,B=202}
    local colorSelec = {R=255,G=255,B=255}

    --[[local background = display.newRect( 0, 0, display.contentWidth, display.contentHeight)
    background:setFillColor(203,245,231)
    myGroup:insert(background)
    background:addEventListener( "touch", doNothing )
    --]]
    scrollView = widget.newScrollView{
        top = 0,
        left = 0,
        width = display.contentWidth,
        height = display.contentHeight,
        scrollWidth = display.contentWidth,
        scrollHeight = 1300,
        bottomPadding = 30,
        horizontalScrollDisabled = true,
        verticalScrollDisabled = false,
        backgroundColor = {203,245,231}
    }

    local options = 
		{
    		text = "Dificultad",     
    		x = 100,
    		y = 70,
    		fontSize = 38,
		}	
    local textDif = display.newText( options )
    textDif:setFillColor( 0 )
    myGroup:insert( textDif )

    local rectDif = display.newRoundedRect( 120, textDif.y+50, 900, 100, 25 )
    rectDif:setFillColor( colorRect.R, colorRect.G, colorRect.B )
    myGroup:insert( rectDif )

    selDif = display.newRoundedRect( 655, textDif.y+75, 160, 50, 20 )
    selDif:setFillColor(  colorSelec.R, colorSelec.G, colorSelec.B  )
    myGroup:insert( selDif )

    local imgHelp = widget.newButton{
            width = 80,
            height = 80,
            defaultFile = imgDir.. "help.png",
            --overFile = imgDir.. "button.png",
            onPress = butHelp
    }
    imgHelp.x = rectDif.x + rectDif.contentWidth/2 + 50
    imgHelp.y = rectDif.y - rectDif.contentHeight/2 - 30
    imgHelp.textHelp = "Cambia la dificultad de los ejercicios:\n- Igualacion-muestra: mayor dificultad, mayor número y degradación de la visibilidad de los objetos\n- Grafía: mayor dificultad, menor tamaño de la letra\n- Grabación de fonema: no afecta"
    myGroup:insert( imgHelp )

    local easyBut = display.newText( "Fácil", 200, textDif.y+80, native.systemFont, 30 )
    easyBut:setFillColor( 100 )
    easyBut.difficulty = 1
    easyBut:addEventListener( "touch", changeDifficult )
    myGroup:insert( easyBut )

    local normalBut = display.newText( "Normal", 520, textDif.y+80, native.systemFont, 30 )
    normalBut:setFillColor( 100 )
    normalBut.difficulty = 2
    normalBut:addEventListener( "touch", changeDifficult )
    myGroup:insert( normalBut )

    local hardBut = display.newText( "Dificil", 860, textDif.y+80, native.systemFont, 30 )
    hardBut:setFillColor( 100 )
    hardBut.difficulty = 3
    hardBut:addEventListener( "touch", changeDifficult )
    myGroup:insert( hardBut )

    if (_G.DifficultLevel == 1) then
        selDif.x = easyBut.x
    elseif (_G.DifficultLevel == 2) then
        selDif.x = normalBut.x
    elseif (_G.DifficultLevel == 3) then
        selDif.x = hardBut.x
    end

    local textSubt = display.newText( "Subtítulos", 100, selDif.y + selDif.contentWidth/2 + 30 , native.systemFont, 38 )
    textSubt:setFillColor( 0 )
    myGroup:insert( textSubt )

    local rectSub = display.newRoundedRect( 120, textSubt.y+50, 750, 100, 25 )
    rectSub:setFillColor( colorRect.R, colorRect.G, colorRect.B)
    myGroup:insert( rectSub )

    selSubt = display.newRoundedRect( 680, textSubt.y+75, 100, 50, 10 )
    selSubt:setFillColor( colorSelec.R, colorSelec.G, colorSelec.B )
    myGroup:insert( selSubt )

    imgHelp = widget.newButton{
            width = 80,
            height = 80,
            defaultFile = imgDir.. "help.png",
            --overFile = imgDir.. "button.png",
            onPress = butHelp
    }
    imgHelp.x = rectSub.x + rectSub.contentWidth/2 + 50
    imgHelp.y = rectSub.y - rectSub.contentHeight/2 - 30
    imgHelp.textHelp = "Activa los subtítulos del juego solo durante las escenas animadas. Para avanzar en los diálogos arrastra de izquierda a derecha el dedo sobre la pantalla."
    myGroup:insert( imgHelp )

    local yesSub = display.newText( "Si", 280, textSubt.y+80, native.systemFont, 30 )
    yesSub:setFillColor( 100 )
    yesSub.subtitle = true
    yesSub:addEventListener( "touch", changeStateSubtitles )
    myGroup:insert( yesSub )

    local noSub = display.newText( "No", 680, textSubt.y+80, native.systemFont, 30 )
    noSub:setFillColor( 100 )
    noSub.subtitle = false
    noSub:addEventListener( "touch", changeStateSubtitles )
    myGroup:insert( noSub )

    if ( _G.Subtitle ) then
        selSubt.x = yesSub.x
    else
        selSubt.x = noSub.x
    end

    local textAuto = display.newText( "Avance Automático", 100, selSubt.y + selSubt.contentWidth/2 + 80, native.systemFont, 38 )
    textAuto:setFillColor( 0 )
    myGroup:insert( textAuto )

    local rectAuto = display.newRoundedRect( 120, textAuto.y+50, 750, 100, 25 )
    rectAuto:setFillColor( colorRect.R, colorRect.G, colorRect.B)
    myGroup:insert( rectAuto )

    selAuto = display.newRoundedRect( 290, textAuto.y+75, 100, 50, 10 )
    selAuto:setFillColor(  colorSelec.R, colorSelec.G, colorSelec.B  )
    myGroup:insert( selAuto )

    imgHelp = widget.newButton{
            width = 80,
            height = 80,
            defaultFile = imgDir.. "help.png",
            --overFile = imgDir.. "button.png",
            onPress = butHelp
    }
    imgHelp.x = rectAuto.x + rectAuto.contentWidth/2 + 50
    imgHelp.y = rectAuto.y - rectAuto.contentHeight/2 - 30
    imgHelp.textHelp = "Activa o desactiva el avance automático en los diálogos. Si esta desactivada esta opción, arrastra de izquierda a derecha el dedo sobre la pantalla para avanzar en los diálogos."
    myGroup:insert( imgHelp )

    local yesAuto = display.newText( "Si", 280, textAuto.y+80, native.systemFont, 30 )
    yesAuto:setFillColor( 100 )
    yesAuto.auto = true
    yesAuto:addEventListener( "touch", changeAdvance )
    myGroup:insert( yesAuto )

    local noAuto = display.newText( "No", 590, textAuto.y+80, native.systemFont, 30 )
    noAuto:setFillColor( 100 )
    noAuto.auto = false
    noAuto:addEventListener( "touch", changeAdvance )
    myGroup:insert( noAuto )

    if ( _G.AutoNextPage ) then
        selAuto.x = yesAuto.x
    else
        selAuto.x = noAuto.x
    end

    hiddenPanelAuto = display.newRoundedRect( 120, textAuto.y+50, 750, 100, 25 )
    --display.newRoundedRect( textAuto.x - textAuto.contentWidth/2 - 15 , textAuto.y - textAuto.contentHeight/2 - 15 , rectAuto.contentWidth+55, rectAuto.contentHeight+textAuto.contentHeight+75, 10 )
    hiddenPanelAuto:setFillColor( 190 )
    hiddenPanelAuto:addEventListener( "touch", doNothing )
    myGroup:insert( hiddenPanelAuto )
    if (not _G.Subtitle) then
        hiddenPanelAuto.alpha = 0
    else
        hiddenPanelAuto.alpha = 0.6
    end

    local textLetter = display.newText( "Visualizar sílabas", 100, selAuto.y + selAuto.contentWidth/2 + 80, native.systemFont, 38 )
    textLetter:setFillColor( 0 )
    myGroup:insert( textLetter )

    local rectLetter = display.newRoundedRect( 120, textLetter.y+50, 750, 100, 25 )
    rectLetter:setFillColor( colorRect.R, colorRect.G, colorRect.B)
    myGroup:insert( rectLetter )

    selLetter = display.newRoundedRect( 290, textLetter.y+75, 100, 50, 10 )
    selLetter:setFillColor(  colorSelec.R, colorSelec.G, colorSelec.B  )
    myGroup:insert( selLetter )

    imgHelp = widget.newButton{
            width = 80,
            height = 80,
            defaultFile = imgDir.. "help.png",
            --overFile = imgDir.. "button.png",
            onPress = butHelp
    }
    imgHelp.x = rectLetter.x + rectLetter.contentWidth/2 + 50
    imgHelp.y = rectLetter.y - rectLetter.contentHeight/2 - 30
    imgHelp.textHelp = "Para el ejercicio de igualación-muestra activa o desactiva la visualización de la sílaba en la que se encuentra la vocal, si el objeto no comienze por dicha vocal. Esto te ayudará a asociar de forma más rápida la vocal con el objeto que representa."
    myGroup:insert( imgHelp )

    local yesLetter = display.newText( "Si", 280, textLetter.y+80, native.systemFont, 30 )
    yesLetter:setFillColor( 100 )
    yesLetter.auto = true
    yesLetter:addEventListener( "touch", changeLetters )
    myGroup:insert( yesLetter )

    local noLetter = display.newText( "No", 590, textLetter.y+80, native.systemFont, 30 )
    noLetter:setFillColor( 100 )
    noLetter.auto = false
    noLetter:addEventListener( "touch", changeLetters )
    myGroup:insert( noLetter )

    if ( _G.LetterInSyllable ) then
        selLetter.x = yesLetter.x
    else
        selLetter.x = noLetter.x
    end

    local btnConfim = widget.newButton{
        width = 220,
        height = 80,
        defaultFile = imgDir.."button.png",
        --overFile = imgDir.. "button.png",
        label = "Confimar",
        labelColor = { default={ 50 }, over={ 0, 0, 210 } },
        fontSize = 25,
        onEvent = confirmOptions
    }
    btnConfim.x = display.contentCenterX-250
    btnConfim.y = rectLetter.y + 190
    --btnConfim:setFillColor( colorRect.R, colorRect.G, colorRect.B )
    myGroup:insert( btnConfim )

    local btnCancel = widget.newButton{
        width = 220,
        height = 80,
        defaultFile = imgDir.."button.png",
        --overFile = imgDir.. "button.png",
        label = "Cancelar",
        labelColor = { default={ 50 }, over={ 0, 0, 210 } },
        fontSize = 25,
        onEvent = cancelOptions
    }
    btnCancel.x = display.contentCenterX+250
    btnCancel.y = btnConfim.y
    --btnCancel:setFillColor( colorRect.R, colorRect.G, colorRect.B )
    myGroup:insert( btnCancel )

    scrollView:insert( myGroup )
    scrollView:setScrollHeight( 1200 )
end