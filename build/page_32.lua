-- Code created by Kwik - Copyright: kwiksher.com 
-- Version: 2.7.6b 
module(..., package.seeall) 

function new() 
    local numPages = 64 
    local menuGroup = display.newGroup() 
    local dispose 
    local _W = display.contentWidth; 
    local _H = display.contentHeight; 

    local drawScreen = function() 

       local curPage = 32 

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
       local but_911

       -- Layer names 
       local fondoBrasilBosq  
       local kwkrg  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 

       -- fondoBrasilBosq positioning 
       fondoBrasilBosq = display.newImageRect( imgDir.. "p32_fondobrasilbosq.png", 1298, 800 ); 
       fondoBrasilBosq.x = 641; fondoBrasilBosq.y = 400; fondoBrasilBosq.alpha = 1; fondoBrasilBosq.oldAlpha = 1 
       fondoBrasilBosq.oriX = fondoBrasilBosq.x; fondoBrasilBosq.oriY = fondoBrasilBosq.y 
       fondoBrasilBosq.name = "fondoBrasilBosq" 
       menuGroup:insert(1,fondoBrasilBosq); menuGroup.fondoBrasilBosq = fondoBrasilBosq 

       -- kwkrg positioning 
       kwkrg = display.newImageRect( imgDir.. "kwkrg.png", 212, 96 ); 
       kwkrg.x = 1102; kwkrg.y = 214; kwkrg.alpha = 1; kwkrg.oldAlpha = 1 
       kwkrg.oriX = kwkrg.x; kwkrg.oriY = kwkrg.y 
       kwkrg.name = "kwkrg" 
       menuGroup:insert(kwkrg); menuGroup.kwkrg = kwkrg 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- Button event listeners 
       local function onkwkrgEvent(event) 
          but_911(kwkrg) 
          return true 
       end 
       kwkrg:addEventListener("tap", onkwkrgEvent ) 

       -- Button functions 
       function but_911(self) 
           _G.Phase = 2
          saveKwikVars({"Phase",2}) 
           _G.Level = 2
          saveKwikVars({"Level",2}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_29", "fade" ) 
            end 
            timerStash.newTimer_844 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 


       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
