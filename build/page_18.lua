-- Code created by Kwik - Copyright: kwiksher.com 
-- Version: 2.7.6b 
module(..., package.seeall) 

function new() 
    local numPages = 22 
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
       local Rectangulo_1  

       -- (TOP) External code will render here 

       -- Rectangulo_1 positioning 
       Rectangulo_1 = display.newImageRect( imgDir.. "p18_rectangulo_1.png", 1280, 800 ); 
       Rectangulo_1.x = 640; Rectangulo_1.y = 400; Rectangulo_1.alpha = 1; Rectangulo_1.oldAlpha = 1 
       Rectangulo_1.oriX = Rectangulo_1.x; Rectangulo_1.oriY = Rectangulo_1.y 
       Rectangulo_1.name = "Rectangulo_1" 
       menuGroup:insert(1,Rectangulo_1); menuGroup.Rectangulo_1 = Rectangulo_1 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- swipe this page with spacer of 120 in normal direction 
       Gesture.activate( Rectangulo_1, {swipeLength=120} ) 
       local function pageSwap(event ) 
         if event.phase == "ended" and event.direction ~= nil then  
            local wPage = curPage  
            local direction  
            if event.direction == "left" and kBidi == false then  
               wPage = curPage + 1  
               if wPage > numPages then wPage = curPage end  
               direction = "moveFromRight"  
            elseif event.direction == "left" and kBidi == true then  
               wPage = curPage - 1  
               if wPage < tonumber(initPage) then wPage = initPage end  
               direction = "moveFromLeft"  
            elseif event.direction == "right" and kBidi == true then  
               wPage = curPage + 1  
               if wPage > numPages then wPage = curPage end  
               direction = "moveFromRight"  
            elseif event.direction == "right" and kBidi == false then  
               wPage = curPage - 1  
               if wPage < tonumber(initPage) then wPage = initPage end  
               direction = "moveFromLeft"  
            end  
            if tonumber(wPage) ~= tonumber(curPage) then dispose(); 
               dispose(); director:changeScene("page_"..wPage, direction) 
            end 
         end  
       end 
       Rectangulo_1:addEventListener( Gesture.SWIPE_EVENT, pageSwap ) 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
          Rectangulo_1:removeEventListener( Gesture.SWIPE_EVENT, pageSwap ); Gesture.deactivate(Rectangulo_1) 
       end 

       -- (BOTTOM) External code will render here 
        -- Button names 
       local but_recAudio
       local but_play

       -- Layer names 
       local recAudio  
       local play  
       local kwkE  
       local Grabar  
       local Reproducir  
       local Grabacion_de_la
       local dataFileName = "audio".._G.Level.._G.Phase..".pcm"  
       local playSound = false

       -- (TOP) External code will render here 

       -- recAudio positioning 
       recAudio = display.newImageRect( imgDir.. "p18_recaudio.png", 57, 81 ); 
       recAudio.x = 455; recAudio.y = 518; recAudio.alpha = 1; recAudio.oldAlpha = 1 
       recAudio.oriX = recAudio.x; recAudio.oriY = recAudio.y 
       recAudio.name = "recAudio" 
       menuGroup:insert(recAudio); menuGroup.recAudio = recAudio 

       -- play positioning 
       play = display.newImageRect( imgDir.. "p18_play.png", 71, 81 ); 
       play.x = 731; play.y = 518; play.alpha = 1; play.oldAlpha = 1 
       play.oriX = play.x; play.oriY = play.y 
       play.name = "play" 
       menuGroup:insert(play); menuGroup.play = play 

       -- kwkE positioning 
       kwkE = display.newImageRect( imgDir.. "kwke.png", 199, 232 ); 
       kwkE.x = 587; kwkE.y = 274; kwkE.alpha = 1; kwkE.oldAlpha = 1 
       kwkE.oriX = kwkE.x; kwkE.oriY = kwkE.y 
       kwkE.name = "kwkE" 
       menuGroup:insert(kwkE); menuGroup.kwkE = kwkE 

       -- Grabar positioning 
       Grabar = display.newImageRect( imgDir.. "p18_grabar.png", 79, 20 ); 
       Grabar.x = 454; Grabar.y = 587; Grabar.alpha = 1; Grabar.oldAlpha = 1 
       Grabar.oriX = Grabar.x; Grabar.oriY = Grabar.y 
       Grabar.name = "Grabar" 
       menuGroup:insert(Grabar); menuGroup.Grabar = Grabar 

       -- Reproducir positioning 
       Reproducir = display.newImageRect( imgDir.. "p18_reproducir.png", 128, 26 ); 
       Reproducir.x = 718; Reproducir.y = 590; Reproducir.alpha = 1; Reproducir.oldAlpha = 1 
       Reproducir.oriX = Reproducir.x; Reproducir.oriY = Reproducir.y 
       Reproducir.name = "Reproducir" 
       menuGroup:insert(Reproducir); menuGroup.Reproducir = Reproducir 

       -- Grabacion_de_la positioning 
       Grabacion_de_la = display.newImageRect( imgDir.. "p18_grabacion_de_la.png", 652, 60 ); 
       Grabacion_de_la.x = 610; Grabacion_de_la.y = 77; Grabacion_de_la.alpha = 1; Grabacion_de_la.oldAlpha = 1 
       Grabacion_de_la.oriX = Grabacion_de_la.x; Grabacion_de_la.oriY = Grabacion_de_la.y 
       Grabacion_de_la.name = "Grabacion_de_la" 
       menuGroup:insert(Grabacion_de_la); menuGroup.Grabacion_de_la = Grabacion_de_la 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- Button event listeners 
       local function onrecAudioEvent(event) 
          but_recAudio(recAudio) 
          return true 
       end 
       recAudio:addEventListener("tap", onrecAudioEvent ) 
       local function onplayEvent(event) 
          but_play(play) 
          return true 
       end 
       play:addEventListener("tap", onplayEvent ) 

       local function onCompleteSound( )
         -- body
       end
       -- Button functions 
       function but_recAudio(self) 
           local playback 
           local filePath = system.pathForFile(dataFileName, system.DocumentsDirectory ) 
           local r = media.newRecording(filePath) 
           menuGroup.alpha = 0.5 
           r:startRecording( ) 
           local audioClosure = function(event ) 
                   r:stopRecording() 
                   menuGroup.alpha = 1 
                   local file = io.open(filePath, "r") 
                   if file then 
                      io.close(file) 
                      playSound = true
                      media.playSound( dataFileName, system.DocumentsDirectory, onCompleteSound )
                   end 
            end 
            timerStash.recTimer = timer.performWithDelay(2000, audioClosure ) 
       end 

       function but_play(self) 
           --External code  
        if (playSound) then
          media.stopSound()
          playSound = false
        end
        local filePath = system.pathForFile(dataFileName, system.DocumentsDirectory ) 
        local file = io.open(filePath, "r")
        if file then 
          --print( file )
          io.close(file) 
          media.playSound(dataFileName, system.DocumentsDirectory, onCompleteSound ) 
        end   
       end 
 


    end 
    drawScreen() 

    return menuGroup 
end 
