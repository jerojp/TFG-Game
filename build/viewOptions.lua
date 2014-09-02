local widget = require( "widget" )
local scrollView

function removePanelOptions( )
    -- body
    display.remove( scrollView )
    scrollView = nil
end

function createPanelOptions( )
    -- body
    local myGroup = display.newGroup( )

    local selDif
    local selSubt
    local selAuto
    local varDifficulty = _G.DifficultLevel
    local varSubtitles = _G.Subtitle
    local varAdvance = _G.AutoNextPage
    local varLetter = _G.LetterInSyllable
    local inicAlphaSubtitle
    if (_G.MyCurrentSubtitle) then
        inicAlphaSubtitle = _G.MyCurrentSubtitle.alpha
    end

--_G.DifficultLevel = event.target.id
          --print( object.id )
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
                print( varDifficulty )
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
                print( varSubtitles )
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
                print( varAdvance )
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
                print( varLetter )
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
        scrollHeight = 1000,
        bottomPadding = 50,
        horizontalScrollDisabled = true,
        verticalScrollDisabled = false,
        backgroundColor = {203,245,231}
    }

    local options = 
		{
    		text = "Dificultad",     
    		x = 100,
    		y = 70,
    		fontSize = 32,
		}	
    local textDif = display.newText( options )
    textDif:setFillColor( 0 )
    myGroup:insert( textDif )

    local rectDif = display.newRoundedRect( 120, textDif.y+50, 700, 60, 25 )
    rectDif:setFillColor( colorRect.R, colorRect.G, colorRect.B )
    myGroup:insert( rectDif )

    selDif = display.newRoundedRect( 655, textDif.y+60, 110, 38, 7 )
    selDif:setFillColor(  colorSelec.R, colorSelec.G, colorSelec.B  )
    myGroup:insert( selDif )
    if (_G.DifficultLevel == 1) then
    	selDif.x = 225
    elseif (_G.DifficultLevel == 2) then
    	selDif.x = 480
    elseif (_G.DifficultLevel == 3) then
    	selDif.x = 710
    end

    local easyBut = display.newText( "Fácil", 200, textDif.y+65, native.systemFont, 25 )
    easyBut:setFillColor( 100 )
    easyBut.difficulty = 1
    easyBut:addEventListener( "touch", changeDifficult )
    myGroup:insert( easyBut )

    local normalBut = display.newText( "Normal", 440, textDif.y+65, native.systemFont, 25 )
    normalBut:setFillColor( 100 )
    normalBut.difficulty = 2
    normalBut:addEventListener( "touch", changeDifficult )
    myGroup:insert( normalBut )

    local hardBut = display.newText( "Dificil", 680, textDif.y+65, native.systemFont, 25 )
    hardBut:setFillColor( 100 )
    hardBut.difficulty = 3
    hardBut:addEventListener( "touch", changeDifficult )
    myGroup:insert( hardBut )

    local textSubt = display.newText( "Subtítulos", 100, 260, native.systemFont, 32 )
    textSubt:setFillColor( 0 )
    myGroup:insert( textSubt )

    local rectSub = display.newRoundedRect( 120, textSubt.y+50, 700, 60, 25 )
    rectSub:setFillColor( colorRect.R, colorRect.G, colorRect.B)
    myGroup:insert( rectSub )

    selSubt = display.newRoundedRect( 680, textSubt.y+60, 65, 38, 7 )
    selSubt:setFillColor( colorSelec.R, colorSelec.G, colorSelec.B )
    myGroup:insert( selSubt )
    if ( _G.Subtitle ) then
    	selSubt.x = 323
    else
    	selSubt.x = 605
    end

    local yesSub = display.newText( "Si", 310, textSubt.y+65, native.systemFont, 25 )
    yesSub:setFillColor( 100 )
    yesSub.subtitle = true
    yesSub:addEventListener( "touch", changeStateSubtitles )
    myGroup:insert( yesSub )

    local noSub = display.newText( "No", 590, textSubt.y+65, native.systemFont, 25 )
    noSub:setFillColor( 100 )
    noSub.subtitle = false
    noSub:addEventListener( "touch", changeStateSubtitles )
    myGroup:insert( noSub )

    local textAuto = display.newText( "Avance Automático", 100, 470, native.systemFont, 32 )
    textAuto:setFillColor( 0 )
    myGroup:insert( textAuto )

    local rectAuto = display.newRoundedRect( 120, textAuto.y+50, 700, 60, 25 )
    rectAuto:setFillColor( colorRect.R, colorRect.G, colorRect.B)
    myGroup:insert( rectAuto )

    selAuto = display.newRoundedRect( 290, textAuto.y+60, 65, 38, 7 )
    selAuto:setFillColor(  colorSelec.R, colorSelec.G, colorSelec.B  )
    myGroup:insert( selAuto )
    if ( _G.AutoNextPage ) then
    	selAuto.x = 323
    else
    	selAuto.x = 605
    end

    local yesAuto = display.newText( "Si", 310, textAuto.y+65, native.systemFont, 25 )
    yesAuto:setFillColor( 100 )
    yesAuto.auto = true
    yesAuto:addEventListener( "touch", changeAdvance )
    myGroup:insert( yesAuto )

    local noAuto = display.newText( "No", 590, textAuto.y+65, native.systemFont, 25 )
    noAuto:setFillColor( 100 )
    noAuto.auto = false
    noAuto:addEventListener( "touch", changeAdvance )
    myGroup:insert( noAuto )

    local textLetter = display.newText( "Visualizar sílabas", 100, 680, native.systemFont, 32 )
    textLetter:setFillColor( 0 )
    myGroup:insert( textLetter )

    local rectLetter = display.newRoundedRect( 120, textLetter.y+50, 700, 60, 25 )
    rectLetter:setFillColor( colorRect.R, colorRect.G, colorRect.B)
    myGroup:insert( rectLetter )

    selLetter = display.newRoundedRect( 290, textLetter.y+60, 65, 38, 7 )
    selLetter:setFillColor(  colorSelec.R, colorSelec.G, colorSelec.B  )
    myGroup:insert( selLetter )
    if ( _G.LetterInSyllable ) then
        selLetter.x = 323
    else
        selLetter.x = 605
    end

    local yesLetter = display.newText( "Si", 310, textLetter.y+65, native.systemFont, 25 )
    yesLetter:setFillColor( 100 )
    yesLetter.auto = true
    yesLetter:addEventListener( "touch", changeLetters )
    myGroup:insert( yesLetter )

    local noLetter = display.newText( "No", 590, textLetter.y+65, native.systemFont, 25 )
    noLetter:setFillColor( 100 )
    noLetter.auto = false
    noLetter:addEventListener( "touch", changeLetters )
    myGroup:insert( noLetter )

    local btnConfim = widget.newButton{
        width = 140,
        height = 50,
        defaultFile = imgDir.."button.png",
        --overFile = imgDir.. "button.png",
        label = "Confimar",
        labelColor = { default={ 50 }, over={ 0, 0, 210 } },
        fontSize = 25,
        onEvent = confirmOptions
    }
    btnConfim.x = display.contentCenterX-250
    btnConfim.y = rectLetter.y + 140
    btnConfim:setFillColor( colorRect.R, colorRect.G, colorRect.B )
    myGroup:insert( btnConfim )

    local btnCancel = widget.newButton{
        width = 140,
        height = 50,
        defaultFile = imgDir.."button.png",
        --overFile = imgDir.. "button.png",
        label = "Cancelar",
        labelColor = { default={ 50 }, over={ 0, 0, 210 } },
        fontSize = 25,
        onEvent = cancelOptions
    }
    btnCancel.x = display.contentCenterX+250
    btnCancel.y = rectLetter.y + 140
    btnCancel:setFillColor( colorRect.R, colorRect.G, colorRect.B )
    myGroup:insert( btnCancel )

    scrollView:insert( myGroup )
    scrollView:setScrollHeight( 940 )
end