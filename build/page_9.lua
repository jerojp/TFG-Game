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

       local curPage = 9 

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

 
       -- Action names 
       local act_892 

       -- Layer names 
       local kwkentradaMuseo  
       local kwkcoin  
       local kwktextcoin  

       -- (TOP) External code will render here 

       -- kwkentradaMuseo positioning 
       kwkentradaMuseo = display.newImageRect( imgDir.. "kwkentradamuseo.png", 1280, 800 ); 
       kwkentradaMuseo.x = 640; kwkentradaMuseo.y = 400; kwkentradaMuseo.alpha = 1; kwkentradaMuseo.oldAlpha = 1 
       kwkentradaMuseo.oriX = kwkentradaMuseo.x; kwkentradaMuseo.oriY = kwkentradaMuseo.y 
       kwkentradaMuseo.name = "kwkentradaMuseo" 
       menuGroup:insert(1,kwkentradaMuseo); menuGroup.kwkentradaMuseo = kwkentradaMuseo 

       -- kwkcoin positioning 
       kwkcoin = display.newImageRect( imgDir.. "kwkcoin.png", 72, 67 ); 
       kwkcoin.x = 67; kwkcoin.y = 48; kwkcoin.alpha = 1; kwkcoin.oldAlpha = 1 
       kwkcoin.oriX = kwkcoin.x; kwkcoin.oriY = kwkcoin.y 
       kwkcoin.name = "kwkcoin" 
       menuGroup:insert(kwkcoin); menuGroup.kwkcoin = kwkcoin 

       -- kwktextcoin positioning 
       kwktextcoin = display.newImageRect( imgDir.. "kwktextcoin.png", 71, 32 ); 
       kwktextcoin.x = 147; kwktextcoin.y = 48; kwktextcoin.alpha = 1; kwktextcoin.oldAlpha = 1 
       kwktextcoin.oriX = kwktextcoin.x; kwktextcoin.oriY = kwktextcoin.y 
       kwktextcoin.name = "kwktextcoin" 
       menuGroup:insert(kwktextcoin); menuGroup.kwktextcoin = kwktextcoin 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
 
       -- Actions (functions) 
       function act_892(event) 
           CurrentPage = 10
          saveKwikVars({"CurrentPage",10}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_10", "fade" ) 
            end 
            timerStash.newTimer_795 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

 
      --End Actions (functions) 


       -- swipe this page with spacer of 120 in normal direction 
       Gesture.activate( kwkentradaMuseo, {swipeLength=120} ) 
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
       kwkentradaMuseo:addEventListener( Gesture.SWIPE_EVENT, pageSwap ) 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
          kwkentradaMuseo:removeEventListener( Gesture.SWIPE_EVENT, pageSwap ); Gesture.deactivate(kwkentradaMuseo) 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
