       local widget = require( "widget" )
       require( "textCoin" )
       require("MyDialog")
       -- Layer names 
       local but_recAudio
       local but_play
       local dataFileName = "audioExLet".._G.Level.._G.Phase..".wav" 
       local r
       local audioHandle
       local audioHandleExample
       local audioChannel = 1
       local red = {R=181, G=38, B=38}
       local blue = {R=125, G=189, B=216}
       local green = {R=105, G=200, B=95}
       local pink = {R=204, G=96, B=147}
       local yellow = {R=242, G=244, B=115}
       local backColors = {red, blue, green, pink, yellow}
       local receivedMoney = false
       _G.TotalAddCoinEx = 0
       local hiddenPanel
       local timerCont

       -- (TOP) External code will render here 
        local function finalize( )
         -- body
         local number
          if (_G.Level == 1) then
            if (_G.Phase == 1) then
              number = 30  
            else
              number = 34
          end
          elseif (_G.Level == 2) then
            if (_G.Phase == 1) then
              number = 19  
            else
              number = 22
            end
          elseif (_G.Level == 3) then
            if (_G.Phase == 1) then
              number = 39 
            else
              number = 43
            end
          elseif (_G.Level == 4) then
            if (_G.Phase == 1) then
              number = 50 
            else
              number = 53
            end
          elseif (_G.Level == 5) then
            if (_G.Phase == 1) then
              number = 58  
            else
              number = 61
            end
          end
          cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
          dispose(); director:changeScene( "page_"..number, "fade" ) 
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

      local function removeHiddenPanel( )
        -- body
        if (hiddenPanel) then
          menuGroup:remove(hiddenPanel)
          hiddenPanel:removeSelf( )
          hiddenPanel = nil
        end
      end

       local function onCompleteSoundExample( )
         -- body
         audio.dispose( audioHandleExample )
         audioHandleExample = nil
         removeHiddenPanel( )
         return true
       end

       -- Button event listeners 
       local function playSoundExampleFun( event )
         -- body
         local dataFile = audioDir.."letterExample".._G.Level..".mp3"
         createHiddenPanel( )
         --media.playSound( dataFile, { onComplete=onCompleteSoundExample })
         audioHandleExample = audio.loadSound( dataFile )
         audio.play( audioHandleExample, {channel = audioChannel, onComplete = onCompleteSoundExample} )
       end

       local function onCompleteSound( )
         -- body
         --audio.dispose( audioHandle )
         --audioHandle = nil
         removeHiddenPanel( )
         return true
       end

        local function onCompleteRecAudio( )
         -- body
          local finalAudioHandle

          local function onCompleteSoundExp( event )
           -- body
            audio.dispose( finalAudioHandle )
            local myDialog
            local function onCompleteSoundNo(  )
              -- body
              onCompleteSound()
              audio.dispose( finalAudioHandle )
              finalAudioHandle = nil
            end

            local function onCompleteCanc( event )
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
                            finalAudioHandle = audio.loadSound( audioDir.."genius_vozNo.mp3" )
                            audio.play( finalAudioHandle, {channel = audioChannel, onComplete = onCompleteSoundNo} )
                     end
              end
              return true
            end

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
                            onCompleteSound()
                            finalize()
                     end
              end
              return true
            end
            myDialog = createMyDialog("RESPONDE AL GENIO", "¿Has pronunciado bien la vocal?", nil, "Si", onCompleteCon, "No", onCompleteCanc)
          end

        finalAudioHandle = audio.loadSound( audioDir.."genius_voz".._G.Level..".mp3" )
        audio.play( finalAudioHandle, {channel = audioChannel, onComplete = onCompleteSoundExp} )
       end

       -- Button functions 
       local function but_recAudio(event) 
        local object = event.target

        if event.phase == "began" then
          display.getCurrentStage():setFocus(object)
          object.isFocus = true
          timerCont = system.getTimer( )
          menuGroup.alpha = 0.5 
          if (not r) then
            local filePath = system.pathForFile( dataFileName, system.DocumentsDirectory )
            r = media.newRecording(filePath)
          end
          r:startRecording( ) 
           
        elseif object.isFocus then
          if event.phase == "ended" or event.phase == "cancelled" then
            --transition.resume( )
            display.getCurrentStage():setFocus( nil )
            object.isFocus = false
            if r:isRecording() then
              r:stopRecording() 
              menuGroup.alpha = 1
              local time = (system.getTimer( ) - timerCont) / 1000
              if(time<0.7) then
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
                myDialog = createMyDialog("Aviso", "!Vas muy rápido! Pronucia la vocal con mayor tranquilidad.", nil, "Confirmar", onCompleteCon)
              else
                local filePath = system.pathForFile(dataFileName, system.DocumentsDirectory ) 
                local file = io.open(filePath, "r") 
                if file then 
                  io.close(file) 
                  createHiddenPanel( )
                  media.playSound( dataFileName, system.DocumentsDirectory, onCompleteRecAudio )
                  if (not receivedMoney) then
                    textCoinUpdate( 50, "add" )
                    _G.TotalAddCoinEx = 50
                    receivedMoney = true
                  end
                end
              end
              
            end 
          end
        end
        return true
       end  

       local function but_play(event) 
        local filePath = system.pathForFile(dataFileName, system.DocumentsDirectory ) 
        local file = io.open(filePath, "r")
        if file then 
          --print( file )
          io.close(file) 
          createHiddenPanel( )
          media.playSound( dataFileName, system.DocumentsDirectory, onCompleteSound )
        end   
       end 

      local function playSoundExp( )
        -- body
        local audioHandleExp
        local function onCompleteSound2()
          -- body
          audio.dispose( audioHandleExp )
          audioHandleExp = nil
          removeHiddenPanel()
        end
        local function onCompleteSound1()
          -- body
          audio.dispose( audioHandleExp )
          audioHandleExp = audio.loadSound( audioDir.."geniusVOZ2.mp3" )
          audio.play( audioHandleExp , {channel = audioChannel, onComplete = onCompleteSound2} )
        end
        createHiddenPanel()
        if (_G.firstRecAudio) then
          _G.firstRecAudio = false
          audioHandleExp = audio.loadSound( audioDir.."geniusVOZ1.mp3" )
          audio.play( audioHandleExp , {channel = audioChannel, onComplete = onCompleteSound1} )
        else
          audioHandleExp = audio.loadSound( audioDir.."geniusVOZ2.mp3" )
          audio.play( audioHandleExp , {channel = audioChannel, onComplete = onCompleteSound2} )
        end
      end

       -- recAudio positioning
       math.randomseed( system.getTimer( ) )

       local background = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
       local ran = math.random(#backColors)
       background:setFillColor( backColors[ran].R, backColors[ran].G, backColors[ran].B)
       menuGroup:insert( background )

       menuGroup:insert( createTextCoin( ) )

       local recAudio = widget.newButton{
        width = 57,
        height = 81,
        defaultFile = imgDir.. "recaudio.png",
        --overFile = imgDir.. "button.png",
        label = "Grabar",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
        labelYOffset = 50,
        fontSize = 25,
        onEvent = but_recAudio
       }
       recAudio.x = display.contentCenterX-200; recAudio.y = 518;
       menuGroup:insert( recAudio )
       -- play positioning 

       local play = widget.newButton{
        width = 71,
        height = 81,
        defaultFile = imgDir.. "play.png",
        --overFile = imgDir.. "button.png",
        label = "Reproducir",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
        labelYOffset = 50,
        fontSize = 25,
        onPress = but_play
       }
       play.x = display.contentCenterX+200; play.y = 518;
       menuGroup:insert(play)

        
       -- kwkE positioning 
       local letra = display.newImageRect( imgDir.. "letra".._G.Level..".png", 199, 232 ); 
       letra.x = display.contentCenterX; letra.y = 300; 
       letra.name = "letra" 
       menuGroup:insert(letra) 
       letra:addEventListener( "tap", playSoundExampleFun )

       local l
       if(_G.Level==1) then
        l = "A"
       elseif(_G.Level==2) then
        l = "E"
       elseif(_G.Level==3) then
        l = "I"
       elseif(_G.Level==4) then
        l = "O"
       else
        l = "U"
       end
       -- Grabacion_de_la positioning
       local textPr = display.newText( "Grabacion de la letra "..l, display.contentCenterX, display.contentCenterY-300, native.systemFontBold, 34 )
       textPr.x = display.contentCenterX
       textPr:setFillColor( 0 )
       menuGroup:insert( textPr )

       
       local textSec = display.newText( "Pulsa sobre la letra para escuchar el sonido de ejemplo", display.contentCenterX, display.contentCenterY-340, native.systemFont, 30 )
       textSec.x = display.contentCenterX
       textSec:setFillColor( 0 )
       menuGroup:insert( textSec )

      
      playSoundExp( )


