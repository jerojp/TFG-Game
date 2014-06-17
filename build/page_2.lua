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

       local curPage = 2 

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
       local kwkrectangle  
       local btnEasy  
       local btnHard  
       local btnNormal  
       local Seleccione_la_d  

       -- (TOP) External code will render here 

       -- kwkrectangle positioning 
       kwkrectangle = display.newImageRect( imgDir.. "kwkrectangle.png", 1280, 800 ); 
       kwkrectangle.x = 640; kwkrectangle.y = 400; kwkrectangle.alpha = 1; kwkrectangle.oldAlpha = 1 
       kwkrectangle.oriX = kwkrectangle.x; kwkrectangle.oriY = kwkrectangle.y 
       kwkrectangle.name = "kwkrectangle" 
       menuGroup:insert(1,kwkrectangle); menuGroup.kwkrectangle = kwkrectangle 

       -- btnEasy positioning 
       btnEasy = display.newImageRect( imgDir.. "p2_btneasy.png", 434, 120 ); 
       btnEasy.x = 652; btnEasy.y = 231; btnEasy.alpha = 1; btnEasy.oldAlpha = 1 
       btnEasy.oriX = btnEasy.x; btnEasy.oriY = btnEasy.y 
       btnEasy.name = "btnEasy" 
       menuGroup:insert(btnEasy); menuGroup.btnEasy = btnEasy 

       -- btnHard positioning 
       btnHard = display.newImageRect( imgDir.. "p2_btnhard.png", 434, 120 ); 
       btnHard.x = 652; btnHard.y = 619; btnHard.alpha = 1; btnHard.oldAlpha = 1 
       btnHard.oriX = btnHard.x; btnHard.oriY = btnHard.y 
       btnHard.name = "btnHard" 
       menuGroup:insert(btnHard); menuGroup.btnHard = btnHard 

       -- btnNormal positioning 
       btnNormal = display.newImageRect( imgDir.. "p2_btnnormal.png", 434, 120 ); 
       btnNormal.x = 652; btnNormal.y = 418; btnNormal.alpha = 1; btnNormal.oldAlpha = 1 
       btnNormal.oriX = btnNormal.x; btnNormal.oriY = btnNormal.y 
       btnNormal.name = "btnNormal" 
       menuGroup:insert(btnNormal); menuGroup.btnNormal = btnNormal 

       -- Seleccione_la_d positioning 
       Seleccione_la_d = display.newImageRect( imgDir.. "p2_seleccione_la_d.png", 724, 45 ); 
       Seleccione_la_d.x = 672; Seleccione_la_d.y = 59; Seleccione_la_d.alpha = 1; Seleccione_la_d.oldAlpha = 1 
       Seleccione_la_d.oriX = Seleccione_la_d.x; Seleccione_la_d.oriY = Seleccione_la_d.y 
       Seleccione_la_d.name = "Seleccione_la_d" 
       menuGroup:insert(Seleccione_la_d); menuGroup.Seleccione_la_d = Seleccione_la_d 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- swipe this page with spacer of 120 in normal direction 
       Gesture.activate( kwkrectangle, {swipeLength=120} ) 
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
       kwkrectangle:addEventListener( Gesture.SWIPE_EVENT, pageSwap ) 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
          kwkrectangle:removeEventListener( Gesture.SWIPE_EVENT, pageSwap ); Gesture.deactivate(kwkrectangle) 
       end 

       -- (BOTTOM) External code will render here 
         -- Button event listeners 
       local function onbtnEasyEvent(event) 
          butEasy(btnEasy) 
          return true 
       end 
       btnEasy:addEventListener("tap", onbtnEasyEvent ) 
       local function onbtnHardEvent(event) 
          butHard(btnHard) 
          return true 
       end 
       btnHard:addEventListener("tap", onbtnHardEvent ) 
       local function onbtnNormalEvent(event) 
          butNormal(btnNormal) 
          return true 
       end 
       btnNormal:addEventListener("tap", onbtnNormalEvent ) 

       -- Button functions 
       function butEasy(self) 
           _G.DifficultLevel = 1
           CurrentPage = 3
          saveKwikVars({"CurrentPage",3}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_3", "fade" ) 
            end 
            timerStash.newTimer_238 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

       function butNormal(self) 
           _G.DifficultLevel = 2
           CurrentPage = 3
          saveKwikVars({"CurrentPage",3}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_3", "fade" ) 
            end 
            timerStash.newTimer_246 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 
       
       function butHard(self) 
           _G.DifficultLevel = 3
           CurrentPage = 3
          saveKwikVars({"CurrentPage",3}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_3", "fade" ) 
            end 
            timerStash.newTimer_242 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

 


    end 
    drawScreen() 

    return menuGroup 
end 
