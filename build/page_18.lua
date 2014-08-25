-- Code created by Kwik - Copyright: kwiksher.com 
-- Version: 2.7.6b 
module(..., package.seeall) 

function new() 
    local numPages = 65 
    local menuGroup = display.newGroup() 
    local dispose 
    local _W = display.contentWidth; 
    local _H = display.contentHeight; 

    local drawScreen = function() 

       local curPage = 18 

       Navigation.new("page", { backColor = {255, 255, 255}, anim=1, timer=1,  totPages = numPages, curPage = curPage, thumbW = 200, thumbH = 125, alpha = 1, imageDir = imgDir, dire = "top", audio={} } ) 
       Navigation.hide() 

       if (tonumber(kBookmark) == 1) then 
          local path = system.pathForFile( "book.txt", system.DocumentsDirectory ) 
          local file = io.open( path, "w+" ) 
          file:write ( curPage.."\n1" ) 
          io.close( file ) 
       end 

       math.randomseed(os.time()) 

       if (tonumber(_G.kAutoPlay) > 0) then 
          local function act_autoPlay(event) 
             if(curPage < numPages) then 
                if(kBidi == false) then  
                   dispose(); director:changeScene( "page_"..curPage+1, "moveFromRight" ) 
                else  
                   dispose(); director:changeScene( "page_"..curPage-1, "moveFromLeft" ) 
                end  
             end 
          end 
          timerStash.timer_AP = timer.performWithDelay( _G.kAutoPlay*1000, act_autoPlay, 1 ) 
       end 

 
       -- Layer names 
       local Capa_1  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level] = curPage 

       -- Capa_1 positioning 
       Capa_1 = display.newImageRect( imgDir.. "p18_capa_1.png", 0, 0 ); 
       Capa_1.x = 0; Capa_1.y = 0; Capa_1.alpha = 1; Capa_1.oldAlpha = 1 
       Capa_1.oriX = Capa_1.x; Capa_1.oriY = Capa_1.y 
       Capa_1.name = "Capa_1" 
       menuGroup:insert(1,Capa_1); menuGroup.Capa_1 = Capa_1 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 
              local widget = require( "widget" )
       require( "textCoin" )
       -- Layer names 
       local but_recAudio
       local but_play
       local dataFileName = "audioExLet".._G.Level.._G.Phase..".wav" 
       local r
       local audioHandle
       local audioHandleExample
       local audioChannel = 1
       local playSound = false
       local playSoundExample = false
       local red = {R=181, G=38, B=38}
       local blue = {R=125, G=189, B=216}
       local green = {R=105, G=200, B=95}
       local pink = {R=204, G=96, B=147}
       local yellow = {R=242, G=244, B=115}
       local backColors = {red, blue, green, pink, yellow}
       local receivedMoney = false
       _G.TotalAddCoinEx = 0

       -- (TOP) External code will render here 

       -- recAudio positioning
       math.randomseed( system.getTimer( ) )

       local background = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
       local ran = math.random(#backColors)
       background:setFillColor( backColors[ran].R, backColors[ran].G, backColors[ran].B)
       menuGroup:insert( background )

       menuGroup:insert( createTextCoin( ) )

       local recAudio = display.newImageRect( imgDir.. "recaudio.png", 57, 81 ); 
       recAudio.x = display.contentCenterX-200; recAudio.y = 518;
       recAudio.name = "recAudio" 
       menuGroup:insert(recAudio); menuGroup.recAudio = recAudio 

       -- play positioning 
       local play = display.newImageRect( imgDir.. "play.png", 71, 81 ); 
       play.x = display.contentCenterX+200; play.y = 518;
       play.name = "play" 
       menuGroup:insert(play); menuGroup.play = play 

       -- kwkE positioning 
       local letra = display.newImageRect( imgDir.. "letra".._G.Level..".png", 199, 232 ); 
       letra.x = display.contentCenterX; letra.y = 300; 
       letra.name = "letra" 
       menuGroup:insert(letra) 

       -- Grabar positioning
       local textRec = display.newText( "Grabar", display.contentCenterX-245, display.contentCenterY+187, native.systemFontBold, 30 )
       menuGroup:insert( textRec )
       textRec:setFillColor( 0 ) 

       -- Reproducir positioning
       local textPlay = display.newText( "Reproducir", display.contentCenterX+130, display.contentCenterY+187, native.systemFontBold, 30 )
       textPlay:setFillColor( 0 )
       menuGroup:insert( textPlay )

       -- Grabacion_de_la positioning
       local textPr = display.newText( "Grabacion de la letra ".._G.Level, display.contentCenterX, display.contentCenterY-300, native.systemFontBold, 34 )
       textPr.x = display.contentCenterX
       textPr:setFillColor( 0 )
       menuGroup:insert( textPr )

       
       local textSec = display.newText( "Pulsa sobre la letra para escuchar el sonido de ejemplo", display.contentCenterX, display.contentCenterY-340, native.systemFont, 30 )
       textSec.x = display.contentCenterX
       textSec:setFillColor( 0 )
       menuGroup:insert( textSec )

       local function finalize( event )
         -- body
         local object = event.target
         if event.phase == "began" then
           display.getCurrentStage():setFocus(object)
           object.isFocus = true
         elseif object.isFocus then
          if event.phase == "ended" or event.phase == "cancelled" then
            display.getCurrentStage():setFocus( nil )
            object.isFocus = false
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
                number = 1  
              else
                number = 1
              end
            end
            cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
            dispose(); director:changeScene( "page_"..number, "fade" ) 
          end
         end
        return true
       end

       local continue = widget.newButton{
        width = 190,
        height = 90,
        defaultFile = imgDir.. "button.png",
        --overFile = imgDir.. "button.png",
        label = "Finalizar",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
        fontSize = 25,
        onEvent = finalize
       }

       continue.x = display.contentCenterX
       continue.y = display.contentCenterY+320
       continue.alpha = 0

       local function onCompleteSoundExample( )
         -- body
         playSoundExample = false
         audio.dispose( audioHandleExample )
         audioHandleExample = nil
         return true
       end

       local function onCompleteSound( )
         -- body
         playSound = false
         audio.dispose( audioHandle )
         audioHandle = nil
         continue.alpha = 1
         return true
       end

       -- Button event listeners 
       local function playSoundExampleFun( event )
         -- body
         local dataFile = audioDir.."letterExample".._G.Level..".mp3"
         playSoundExample = true
         --media.playSound( dataFile, { onComplete=onCompleteSoundExample })
         audioHandleExample = audio.loadSound( dataFile )
         audio.play( audioHandleExample, {channel = 1, onComplete = onCompleteSoundExample} )
       end
       letra:addEventListener( "tap", playSoundExampleFun )

       -- Button functions 
       local function but_recAudio(event) 
        local object = event.target

        if event.phase == "began" then
          display.getCurrentStage():setFocus(object)
          object.isFocus = true

          if (playSound or playSoundExample) then
            playSoundExample = false
            playSound = false
            --media.stopSound()
            audio.stop( audioChannel )
            print( "dentro if play" )
          end

          --local filePath = system.pathForFile(dataFileName, system.DocumentsDirectory ) 
          --os.remove( filePath )
          menuGroup.alpha = 0.5 
          r:startRecording( ) 
           
        elseif object.isFocus then
          if event.phase == "ended" or event.phase == "cancelled" then
            --transition.resume( )
            if r:isRecording() then
              r:stopRecording() 
              menuGroup.alpha = 1
              print( "Entra repr" ) 
              local filePath = system.pathForFile(dataFileName, system.DocumentsDirectory ) 
              local file = io.open(filePath, "r") 
              if file then 
                io.close(file) 
                playSound = true
                print( "reproduce" )
                audioHandle = audio.loadSound( dataFileName, system.DocumentsDirectory )
                audio.play( audioHandle, {channel = audioChannel, onComplete = onCompleteSound} )
                if (not receivedMoney) then
                  textCoinUpdate( 50, "add" )
                  receivedMoney = true
                end
                --media.playSound( dataFileName, system.DocumentsDirectory, onCompleteSound )
              end
            end 
            display.getCurrentStage():setFocus( nil )
            object.isFocus = false
          end
        end
        return true
       end

       
       recAudio:addEventListener("touch", but_recAudio )  

       local function but_play(event) 
           --External code  
        if (playSound or playSoundExample) then
          --media.stopSound()
          audio.stop( audioChannel )
          playSound = false
          playSoundExample = false
        end
        local filePath = system.pathForFile(dataFileName, system.DocumentsDirectory ) 
        local file = io.open(filePath, "r")
        if file then 
          --print( file )
          playSound = true
          io.close(file) 
          audioHandle = audio.loadSound( dataFileName, system.DocumentsDirectory )
          audio.play( audioHandle, {channel = audioChannel, onComplete = onCompleteSound} )
          --media.playSound(dataFileName, system.DocumentsDirectory, onCompleteSound ) 
        end   
       end 

       play:addEventListener("tap", but_play )
        
      local filePath = system.pathForFile( dataFileName, system.DocumentsDirectory )
      r = media.newRecording(filePath)
 


    end 
    drawScreen() 

    return menuGroup 
end 
