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

       local curPage = 27 

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
       local butSample

       -- Layer names 
       local FondoBrasil  
       local kwkrecty  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 

       -- FondoBrasil positioning 
       FondoBrasil = display.newImageRect( imgDir.. "p27_fondobrasil.png", 1288, 809 ); 
       FondoBrasil.x = 644; FondoBrasil.y = 395; FondoBrasil.alpha = 1; FondoBrasil.oldAlpha = 1 
       FondoBrasil.oriX = FondoBrasil.x; FondoBrasil.oriY = FondoBrasil.y 
       FondoBrasil.name = "FondoBrasil" 
       menuGroup:insert(1,FondoBrasil); menuGroup.FondoBrasil = FondoBrasil 

       -- kwkrecty positioning 
       kwkrecty = display.newImageRect( imgDir.. "kwkrecty.png", 148, 69 ); 
       kwkrecty.x = 962; kwkrecty.y = 165; kwkrecty.alpha = 1; kwkrecty.oldAlpha = 1 
       kwkrecty.oriX = kwkrecty.x; kwkrecty.oriY = kwkrecty.y 
       kwkrecty.name = "kwkrecty" 
       menuGroup:insert(kwkrecty); menuGroup.kwkrecty = kwkrecty 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- Button event listeners 
       local function onkwkrectyEvent(event) 
          butSample(kwkrecty) 
          return true 
       end 
       kwkrecty:addEventListener("tap", onkwkrectyEvent ) 

       -- Button functions 
       function butSample(self) 
           _G.Level = 1
          saveKwikVars({"Level",1}) 
           _G.Phase = 1
          saveKwikVars({"Phase",1}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_15", "fade" ) 
            end 
            timerStash.newTimer_820 = timer.performWithDelay(0, myClosure_switch, 1) 
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
