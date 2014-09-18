module(..., package.seeall) 
local widget = require( "widget" )
require( "ControlScene" )
function new(parameters) 
    local numPages = 66 
    local menuGroup = display.newGroup() 
    local dispose 
    local _W = display.contentWidth; 
    local _H = display.contentHeight; 
    local nextScene = parameters.nextPage
    local nameToy = parameters.nameToy
    local pathToy = parameters.pathToy
    local widthToy = parameters.widthToy
    local heightToy = parameters.heightToy

    local drawScreen = function() 

        local function isToyUnlocked( )
            -- body
            for i=1,#_G.UnlockToys do
                if (_G.UnlockToys[i].nameToy == nameToy) then
                    return true
                end
            end
            return false
        end

        local function isEndGame(  )
            -- body
            for i=1,5 do
                if (not _G.LevelCompleted[i]) then
                    return false
                end
            end
            return true
        end

       local function finalizeViewToy( )
           -- body
            local myClosure_switch = function() 
                if (_G.Phase == 2) then
                    _G.LevelCompleted[_G.Level] = true 
                   _G.goBackEndLevel = true 
                end
                _G.goBackEnd = isEndGame(  )
                dispose(); director:changeScene( nextScene, "fade")                 
            end
            
            local function onCompleteTransition( event )
                -- body
                timerStash.newTimer_vieToy2 = timer.performWithDelay(1000, myClosure_switch) 
            end            
            local endText
            if (nextScene == "page_11") then
               endText = "2" 
            else
               endText = "1"
            end
            local background = display.newRect( 0, 0, display.contentWidth , display.contentHeight )
            background:setFillColor( 0 )
            menuGroup:insert(background)

            local finalText = display.newText( "Finalizada Fase "..endText, display.contentCenterX, display.contentCenterY, native.systemFontBold, 100 )
            finalText.x = display.contentCenterX
            finalText.y = display.contentCenterY
            finalText.alpha = 0

            menuGroup:insert(finalText)

            transitionStash.textFinal = transition.to( finalText, { time = 4000, delay = 1000, alpha = 1.0, onComplete = onCompleteTransition} )
       end

       local function createViewToy( )
           -- body
           _G.CurrentPage = 66
            local groupCost = display.newGroup( )
            local groupStars = display.newGroup( )
            local audioHandle
            local hiddenPanel
            local handle
            local ch = 1
            local contExp
            local mySoundsExp
            local btnConfirm

            local function viewButton( fun )
                -- body
                btnConfirm.alpha = 1
                fun(0)
            end

            local function createHiddenPanel( )
              if (not hiddenPanel) then
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
            end

            _G.FunctionDelHiddenPanel = function ( )
              -- body
              if (hiddenPanel) then
                menuGroup:remove(hiddenPanel)
                hiddenPanel:removeSelf( )
                hiddenPanel = nil
              end
            end

            function playSoundExpInic( )
            -- body 
                local aud
                local sub
                local sec
                local events
                if (_G.firstViewToy) then
                  _G.firstViewToy = false
                  aud = {"genius_nuevoJug.mp3", "genius_nuevoJug2.mp3"}
                  sub = {"!Enhorabuena! te he conseguido un nuevo juguete.",
                      "Puedes comprar este juguete en el armario de juguetes mágicos. Cuando vuelvas al menú principal podrás acceder a esta sección de juguetes."}
                  sec = {1, 1}
                  events = { nil, {mytype = "effects", value = {1, viewButton} } }
                else
                  aud = {"genius_nuevoJug.mp3"}
                  sub = {"!Enhorabuena! te he conseguido un nuevo juguete."}
                  sec = {1}
                  events = { {mytype = "effects", value = {1, viewButton} } }
                end
                createHiddenPanel( )
                setEventsControlScene(events)
                addCharacter(nil, aud, sub)
                setSecuence( sec )
                playScene( -1 )
            end

            local background = display.newRect( 0, 0, display.contentWidth , display.contentHeight )
            background:setFillColor( 85,159,191 )
            menuGroup:insert(background)

            local backPanel = display.newRoundedRect( 0, 0, 500, 600, 40 )
            backPanel.x = display.contentCenterX; backPanel.y = display.contentCenterY - 50
            backPanel:setFillColor( 0 )
            menuGroup:insert( backPanel )

            local frontPanel = display.newRoundedRect( 0, 0, 480, 580, 40 )
            frontPanel.x = display.contentCenterX; frontPanel.y = display.contentCenterY - 50
            frontPanel:setFillColor( 255 )
            menuGroup:insert(frontPanel)

            local toy = display.newImageRect( imgDir..pathToy, 233*1.5, 168*1.5 ); 
            toy.x = display.contentCenterX; toy.y = frontPanel.y - frontPanel.contentHeight/2 + toy.contentHeight/2 + 80 ; 
            menuGroup:insert(toy);
            _G.UnlockToys[#_G.UnlockToys+1] = { nameToy = nameToy, path = pathToy, widthToy = widthToy, heightToy = heightToy}
            _G.Toys[#_G.UnlockToys].block = false

            local textCost = display.newText( _G.PriceToys[#_G.UnlockToys], 0, 0, native.systemFontBold, 45 )
            textCost:setTextColor (229, 185, 89)
            groupCost:insert( textCost )

            local kwkcoin = display.newImageRect( imgDir.. "kwkcoin.png", 68, 54 ); 
            kwkcoin.x = textCost.x + textCost.contentWidth + 5 ; kwkcoin.y = textCost.y; 
            groupCost:insert( kwkcoin )

            groupCost.x = display.contentCenterX - groupCost.contentWidth/2 ; groupCost.y = toy.y + toy.contentHeight/2 + 40

            menuGroup:insert(groupCost)

            local textToy = display.newText( nameToy, display.contentCenterX, groupCost.y + 80, native.systemFontBold, 40 )
            textToy.x = textToy.x - textToy.contentWidth/2
            textToy:setFillColor( 0 )
            menuGroup:insert(textToy)

            local function goNextPage( event )
                -- body
                local object = event.target
                if event.phase == "began" then
                    display.getCurrentStage():setFocus(object)
                    object.isFocus = true
                  elseif object.isFocus then
                    if event.phase == "ended" or event.phase == "cancelled" then
                        display.getCurrentStage():setFocus( nil )
                            object.isFocus = false
                        finalizeViewToy()
                    end
                  end
                    return true
            end

            btnConfirm = widget.newButton{
               width = 180,
               height = 60,
               defaultFile = imgDir.. "button.png",
                --overFile = imgDir.. "button.png",
               label = "Continuar",
               labelColor = { default={ 255, 255, 255 }, over={ 0, 0, 210 } },
               fontSize = 25,
               onEvent = goNextPage
            }

            btnConfirm.x = display.contentCenterX
            btnConfirm.y = backPanel.y + backPanel.contentHeight/2 + 80
            btnConfirm:setFillColor(228,89,145)
            btnConfirm.alpha = 0

            function removeAudioNewToy( event )
                -- body
                audio.dispose( audioHandle )
                audioHandle = nil
            end

            local function onCompleteTransition( event )
                -- body
                if ( audio.isChannelActive( 1 ) ) then
                    audio.stop()
                end
                removeAudioNewToy(  )
                groupStars.alpha = 0
                playSoundExpInic( )
            end

            local an
            local n_div = 15
            local radius = 150
            local star
            for i=0,n_div do
                an = (2*math.pi/n_div)*i;
                star = display.newImageRect( imgDir.."star.png", 55, 55 ); 
                star.x = radius*math.cos(an); star.y = radius*math.sin(an); 
                groupStars:insert(star);
            end
            menuGroup:insert(groupStars)
            groupStars.x = display.contentCenterX
            groupStars.y = display.contentCenterY
            groupStars:scale( 0, 0 )
                  
            audioHandle = audio.loadSound( audioDir.."stars.mp3" )

            local function onCompleteTimer( event )
                -- body
                transitionStash.groupStars = transition.to( groupStars, {  time=2000, xScale=1.5, yScale=1.5, alpha = 0.2, rotation = 340, onComplete=onCompleteTransition} )
                audio.play( audioHandle, {channel = 1, duration = 3000, fadein = 2000, onComplete = removeAudioNewToy} )
            end
            timerStash.timer_stars = timer.performWithDelay( 600, onCompleteTimer, 1 )
       end

 
       --End Actions (functions) 

        
       -- Timers 
       if ((#_G.UnlockToys+1) < 10 and not isToyUnlocked()) then
            createViewToy()
       else
            timerStash.newTimer_vieToy1 = timer.performWithDelay(0,finalizeViewToy ) 
       end

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 
    end 
    drawScreen()

    return menuGroup 
end 

