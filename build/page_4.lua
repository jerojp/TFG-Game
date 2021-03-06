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

       local curPage = 4 
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
       local actNextPage 

       -- Layer names 
       local kwkentradaMuseo  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  

       -- kwkentradaMuseo positioning 
       kwkentradaMuseo = display.newImageRect( imgDir.. "kwkentradamuseo.png", 1280, 800 ); 
       kwkentradaMuseo.x = 640; kwkentradaMuseo.y = 400; kwkentradaMuseo.alpha = 1; kwkentradaMuseo.oldAlpha = 1 
       kwkentradaMuseo.oriX = kwkentradaMuseo.x; kwkentradaMuseo.oriY = kwkentradaMuseo.y 
       kwkentradaMuseo.name = "kwkentradaMuseo" 
       menuGroup:insert(1,kwkentradaMuseo); menuGroup.kwkentradaMuseo = kwkentradaMuseo 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       --Animations
       local onEnd_linearEntry_290 = function() 
          actNextPage(); 
       end --ends reStart for linearEntry 
       gtStash.gt_linearEntry = gtween.new( kwkentradaMuseo, 5, {  x=830, y=1340,  alpha=1, rotation=0, xScale=3.6, yScale=3.6,}, {ease = gtween.easing.linear, repeatCount = 1, reflect = false,  delay=1, onComplete=onEnd_linearEntry_290}) 

 
       -- Actions (functions) 
       function actNextPage(event) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_5", "fade" ) 
            end 
            timerStash.newTimer_309 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

 
      --End Actions (functions) 


       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTweens() 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
