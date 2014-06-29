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

       local curPage = 11 

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

 
       -- Button names 
       local butLevelE

       -- Layer names 
       local continents  
       local kwkE  

       -- (TOP) External code will render here 

       -- continents positioning 
       continents = display.newImageRect( imgDir.. "p11_continents.png", 1280, 800 ); 
       continents.x = 640; continents.y = 400; continents.alpha = 1; continents.oldAlpha = 1 
       continents.oriX = continents.x; continents.oriY = continents.y 
       continents.name = "continents" 
       menuGroup:insert(1,continents); menuGroup.continents = continents 

       -- kwkE positioning 
       kwkE = display.newImageRect( imgDir.. "kwke.png", 69, 73 ); 
       kwkE.x = 641; kwkE.y = 112; kwkE.alpha = 1; kwkE.oldAlpha = 1 
       kwkE.oriX = kwkE.x; kwkE.oriY = kwkE.y 
       kwkE.name = "kwkE" 
       menuGroup:insert(kwkE); menuGroup.kwkE = kwkE 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- Button event listeners 
       local function onkwkEEvent(event) 
          butLevelE(kwkE) 
          return true 
       end 
       kwkE:addEventListener("tap", onkwkEEvent ) 

       -- Button functions 
       function butLevelE(self) 
           Level = 2
          saveKwikVars({"Level",2}) 
           CurrentPage = 12
          saveKwikVars({"CurrentPage",12}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_12", "fade" ) 
            end 
            timerStash.newTimer_625 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 


       -- swipe this page with spacer of 120 in normal direction 
       Gesture.activate( continents, {swipeLength=120} ) 
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
       continents:addEventListener( Gesture.SWIPE_EVENT, pageSwap ) 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
          continents:removeEventListener( Gesture.SWIPE_EVENT, pageSwap ); Gesture.deactivate(continents) 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
