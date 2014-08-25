module(..., package.seeall) 
local widget = require( "widget" )
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
    local costToy = parameters.costToy
    local indexToy = parameters.indexToy 

    local drawScreen = function() 

       local function finalizeViewToy( )
           -- body
            local myClosure_switch = function() 
                dispose(); director:changeScene( nextScene, "fade")                 
            end
            
            local function onCompleteTransition( event )
                -- body
                timerStash.newTimer_vieToy2 = timer.performWithDelay(2000, myClosure_switch) 
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

            transition.to( finalText, { time = 4000, delay = 1000, alpha = 1.0, onComplete = onCompleteTransition} )
       end

       local function createViewToy( )
           -- body
           _G.CurrentPage = 66
            local groupCost = display.newGroup( )
            local groupStars = display.newGroup( )
            local audioHandle
        
                local background = display.newRect( 0, 0, display.contentWidth , display.contentHeight )
                background:setFillColor( 237, 216, 197 )
                menuGroup:insert(background)

            local backPanel = display.newRoundedRect( 0, 0, 500, 600, 5 )
                backPanel.x = display.contentCenterX; backPanel.y = display.contentCenterY
                backPanel:setFillColor( 0 )
                menuGroup:insert( backPanel )

                local frontPanel = display.newRoundedRect( 0, 0, 480, 580, 5 )
                frontPanel.x = display.contentCenterX; frontPanel.y = display.contentCenterY
                frontPanel:setFillColor( 255 )
                menuGroup:insert(frontPanel)

                local toy = display.newImageRect( imgDir..pathToy, widthToy, heightToy ); 
            toy.x = display.contentCenterX; toy.y = frontPanel.y - frontPanel.contentHeight/2 + toy.contentHeight/2 + 80 ; 
            menuGroup:insert(toy);
            _G.Toys[indexToy].block = false

            local textCost = display.newText( costToy, 0, 0, native.systemFontBold, 45 )
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

            local btnConfirm = widget.newButton{
                     width = 140,
                   height = 60,
                   defaultFile = imgDir.. "button.png",
                    --overFile = imgDir.. "button.png",
                   label = "Continuar",
                   labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
                   fontSize = 25,
                   onEvent = goNextPage
                }

                btnConfirm.x = display.contentCenterX
                btnConfirm.y = backPanel.y + backPanel.contentHeight/2 + 50
                btnConfirm.alpha = 0

                local function onCompleteTransition( event )
                    -- body
                    if ( audio.isChannelActive( 1 ) ) then
                        audio.stop()
                    end
                    audio.dispose( audioHandle )
              audioHandle = nil
                    groupStars.alpha = 0
                    btnConfirm.alpha = 1
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
                audio.play( audioHandle, {channel = 1, duration = 3000, fadein = 2000} )
            end
            timerStash.timer_stars = timer.performWithDelay( 600, onCompleteTimer, 1 )
       end

 
       --End Actions (functions) 

        
       -- Timers 
       if (_G.Toys[indexToy].block) then
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

