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

       local curPage = 55 

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
       local kwkFondoAfrica  
       local kwkrecty  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level] = curPage 

       -- kwkFondoAfrica positioning 
       kwkFondoAfrica = display.newImageRect( imgDir.. "kwkfondoafrica.png", 1280, 800 ); 
       kwkFondoAfrica.x = 640; kwkFondoAfrica.y = 400; kwkFondoAfrica.alpha = 1; kwkFondoAfrica.oldAlpha = 1 
       kwkFondoAfrica.oriX = kwkFondoAfrica.x; kwkFondoAfrica.oriY = kwkFondoAfrica.y 
       kwkFondoAfrica.name = "kwkFondoAfrica" 
       menuGroup:insert(1,kwkFondoAfrica); menuGroup.kwkFondoAfrica = kwkFondoAfrica 

       -- kwkrecty positioning 
       kwkrecty = display.newImageRect( imgDir.. "kwkrecty.png", 148, 69 ); 
       kwkrecty.x = 1049; kwkrecty.y = 181; kwkrecty.alpha = 1; kwkrecty.oldAlpha = 1 
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
           _G.Level = 5
          saveKwikVars({"Level",5}) 
           _G.Phase = 1
          saveKwikVars({"Phase",1}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_15", "fade" ) 
            end 
            timerStash.newTimer_356 = timer.performWithDelay(0, myClosure_switch, 1) 
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
