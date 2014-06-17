-- Code created by Kwik - Copyright: kwiksher.com 
-- Version: 2.7.6b 
module(..., package.seeall) 

function new() 
    local numPages = 20 
    local menuGroup = display.newGroup() 
    local dispose 
    local _W = display.contentWidth; 
    local _H = display.contentHeight; 

    -- Audio callings 
    local geniopr1 =  audio.loadStream( audioDir.."geniopr1.mp3") 
    local geniopr3 =  audio.loadStream( audioDir.."geniopr3.mp3") 


    local drawScreen = function() 

       local curPage = 10 

       Navigation.new("page", { backColor = {255, 255, 255}, anim=1, timer=1,  totPages = numPages, curPage = curPage, thumbW = 200, thumbH = 125, alpha = 1, imageDir = imgDir, dire = "top", audio={{ 1, "geniopr1"},{ 2, "geniopr3"},} } ) 
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

 
       -- Action names 
       local act_194 

       -- Layer names 
       local Tablet  
       local genius  
       local text1  
       local text2  
       local kwkcoin  
       local kwktextcoin  

       -- (TOP) External code will render here 

       -- Tablet positioning 
       Tablet = display.newImageRect( imgDir.. "p10_tablet.png", 585, 800 ); 
       Tablet.x = 668; Tablet.y = 400; Tablet.alpha = 1; Tablet.oldAlpha = 1 
       Tablet.oriX = Tablet.x; Tablet.oriY = Tablet.y 
       Tablet.name = "Tablet" 
       menuGroup:insert(1,Tablet); menuGroup.Tablet = Tablet 

       -- genius positioning 
       local genius_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=283, height=615 }, -- Genio_00000
               { x=287, y=2, width=283, height=615 }, -- Genio_00001
               { x=572, y=2, width=283, height=615 }, -- Genio_00002
               { x=857, y=2, width=283, height=615 }, -- Genio_00003
               { x=1142, y=2, width=283, height=615 }, -- Genio_00004
               { x=1427, y=2, width=283, height=615 }, -- Genio_00005
               { x=2, y=619, width=283, height=615 }, -- Genio_00006
               { x=287, y=619, width=283, height=615 }, -- Genio_00007
               { x=572, y=619, width=283, height=615 }, -- Genio_00008
               { x=857, y=619, width=283, height=615 }, -- Genio_00009
               { x=1142, y=619, width=283, height=615 }, -- Genio_00010
               { x=1427, y=619, width=283, height=615 }, -- Genio_00011
               { x=2, y=1236, width=283, height=615 }, -- Genio_00012
               { x=287, y=1236, width=283, height=615 }, -- Genio_00013
               { x=572, y=1236, width=283, height=615 }, -- Genio_00014
               { x=857, y=1236, width=283, height=615 }, -- Genio_00015
           },
    
           sheetContentWidth = 1712,
           sheetContentHeight = 1853
 
       } 
       genius_sheet = graphics.newImageSheet( spriteDir.. "geniohabla.png", genius_options ) 
       genius_seq = { name = "default", start = 1, count = 16, time = 500, loopCount = 0, loopDirection = "bounce" }; 
       genius = display.newSprite(genius_sheet, genius_seq ) 
       genius:play(); 
       genius.x = 715; genius.y = 372; genius.alpha = 1; genius.oldAlpha = 1 
       genius.oriX = genius.x; genius.oriY = genius.y 
       genius.name = "genius" 
       menuGroup:insert(genius); menuGroup.genius = genius 

       -- text1 positioning 
       local text1_txt = { 
            {start =  0, out = 0, dur = 0, name = "Hola", file = ""},  
            {start =  0, out = 0, dur = 0, name = "soy", file = ""},  
            {start =  0, out = 1000, dur = 0, name = "el", file = ""},  
            {start =  1000, out = 1000, dur = 0, name = "genio", file = ""},  
            {start =  1000, out = 1000, dur = 0, name = "Ali", file = ""},  
            {start =  1000, out = 2000, dur = 0, name = "encerrado", file = ""},  
            {start =  2000, out = 2000, dur = 0, name = "en", file = ""},  
            {start =  2000, out = 2000, dur = 0, name = "esta", file = ""},  
            {start =  2000, out = 2000, dur = 0, name = "tablet", file = ""},  
            {start =  2000, out = 3000, dur = 0, name = "mágica", file = ""},  
       } 
       local speak_485 =  display.newImageRect( imgDir.. "kAudio.png", 30, 30 ); 
       speak_485.x = 439; speak_485.y = 24  
       speak_485.oriX = 439; speak_485.oriY = 24  
       speak_485.alpha = 0  

       local b_text1, text1 = syncSound.addSentence{ x = 454, y = -6, padding = 10, sentence=geniopr1, volume=10, sentenceDir="audio", line=text1_txt, button=speak_485, font=native.systemFont, fontColor = {63, 62, 62}, fontSize = 28.1666698455811, fontColorHi = {0, 128, 255}, fadeDuration = 500, wordTouch = false, readDir="leftToRight", channel=1} 
       menuGroup:insert(text1) 
       menuGroup.text1 = text1 


       -- text2 positioning 
       local text2_txt = { 
            {start =  0, out = 0, dur = 0, name = "Creo", file = ""},  
            {start =  0, out = 0, dur = 0, name = "que", file = ""},  
            {start =  0, out = 0, dur = 0, name = "puedo", file = ""},  
            {start =  0, out = 1000, dur = 0, name = "ayudarte.", file = ""},  
            {start =  1000, out = 1000, dur = 0, name = "Tengo", file = ""},  
            {start =  1000, out = 1000, dur = 0, name = "por", file = ""},  
            {start =  1000, out = 2000, dur = 0, name = "aquí", file = ""},  
            {start =  2000, out = 2000, dur = 0, name = "un", file = ""},  
            {start =  2000, out = 2000, dur = 0, name = "mapa", file = ""},  
            {start =  2000, out = 2000, dur = 0, name = "con", file = ""},  
            {start =  2000, out = 3000, dur = 0, name = "el", file = ""},  
            {start =  3000, out = 3000, dur = 0, name = "que", file = ""},  
            {start =  3000, out = 3000, dur = 0, name = "podrás", file = ""},  
            {start =  3000, out = 3000, dur = 0, name = "descrubrir", file = ""},  
            {start =  3000, out = 4000, dur = 0, name = "varios", file = ""},  
            {start =  4000, out = 4000, dur = 0, name = "tesoros", file = ""},  
            {start =  4000, out = 5000, dur = 0, name = "repartidos", file = ""},  
            {start =  5000, out = 5000, dur = 0, name = "por", file = ""},  
            {start =  5000, out = 5000, dur = 0, name = "el", file = ""},  
            {start =  5000, out = 5000, dur = 0, name = "mundo.", file = ""},  
       } 
       local speak_595 =  display.newImageRect( imgDir.. "kAudio.png", 30, 30 ); 
       speak_595.x = 309; speak_595.y = 24  
       speak_595.oriX = 309; speak_595.oriY = 24  
       speak_595.alpha = 0  

       local b_text2, text2 = syncSound.addSentence{ x = 324, y = -6, padding = 10, sentence=geniopr3, volume=10, sentenceDir="audio", line=text2_txt, button=speak_595, font=native.systemFont, fontColor = {63, 62, 62}, fontSize = 28.1666698455811, fontColorHi = {0, 128, 255}, fadeDuration = 500, wordTouch = false, readDir="leftToRight", channel=2} 
       menuGroup:insert(text2) 
       menuGroup.text2 = text2



       -- kwkcoin positioning 
       kwkcoin = display.newImageRect( imgDir.. "kwkcoin.png", 72, 67 ); 
       kwkcoin.x = 63; kwkcoin.y = 48; kwkcoin.alpha = 1; kwkcoin.oldAlpha = 1 
       kwkcoin.oriX = kwkcoin.x; kwkcoin.oriY = kwkcoin.y 
       kwkcoin.name = "kwkcoin" 
       menuGroup:insert(kwkcoin); menuGroup.kwkcoin = kwkcoin 

       -- kwktextcoin positioning 
       kwktextcoin = display.newImageRect( imgDir.. "kwktextcoin.png", 71, 32 ); 
       kwktextcoin.x = 148; kwktextcoin.y = 49; kwktextcoin.alpha = 1; kwktextcoin.oldAlpha = 1 
       kwktextcoin.oriX = kwktextcoin.x; kwktextcoin.oriY = kwktextcoin.y 
       kwktextcoin.name = "kwktextcoin" 
       menuGroup:insert(kwktextcoin); menuGroup.kwktextcoin = kwktextcoin 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       --Animations
       local onEnd_pathGenMove_512 = function() 
          genius.x = genius.oriX; genius.y = genius.oriY; 
          genius.xScale = 1;genius.yScale = 1; genius.alpha = genius.oldAlpha; genius.rotation = 0; genius.isVisible = true; 
          genius:pause(); 
          genius.currentFrame = 1; 
       end --ends reStart for pathGenMove 
       gtStash.gt_pathGenMove = btween.new( genius, 10, { 
         { x = 701, y = 360}, --regular curve
         { x = 701, y = 360}, 
         { x = 632, y = 421}, 
         { x = 675, y = 435}, 

         { x = 675, y = 435}, --regular curve
         { x = 717, y = 450}, 
         { x = 740, y = 361}, 
         { x = 707, y = 361}, 

         { x = 707, y = 361}, 
         { x = 707, y = 361}, 
         { x = 707, y = 361}, 
         { x = 707, y = 361}, 
angle = 0       }, {ease = gtween.easing.linear, repeatCount = math.huge, reflect = false,  delay=0.1, onComplete=onEnd_pathGenMove_512}, {  x=715, y=372,  alpha=1, xScale=1, yScale=1, newAngle=0}) 

 
       -- Actions (functions) 
       function act_194(event) 
            _G.kwk_readMe = 1 
            syncSound.saySentence{sentence=geniopr1, line=text1_txt, button=b_text1} 
       end 

 
      --End Actions (functions) 

 
       -- Timers 
       timerStash.timer_534 = timer.performWithDelay( 1000, act_194, 1 ) 

       -- swipe this page with spacer of 120 in normal direction 
       Gesture.activate( Tablet, {swipeLength=120} ) 
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
       Tablet:addEventListener( Gesture.SWIPE_EVENT, pageSwap ) 

       dispose = function(event) 
          cancelAllTweens() 
          cancelAllTimers(); cancelAllTransitions() 
          if audio.isChannelActive ( 1 ) then 
   audio.stop(1); 
 end 
 audio.dispose(geniopr1); geniopr1 = nil 
          if audio.isChannelActive ( 2 ) then 
   audio.stop(2); 
 end 
 audio.dispose(geniopr3); geniopr3 = nil 
          Tablet:removeEventListener( Gesture.SWIPE_EVENT, pageSwap ); Gesture.deactivate(Tablet) 
       end 

       function cleanSprite() 
           genius_sheet = nil; genius = nil 
 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
