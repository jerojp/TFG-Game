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

       local curPage = 3 
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
       local kwkrectangle  
       local Comineza_tu_ave  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  

       -- kwkrectangle positioning 
       kwkrectangle = display.newImageRect( imgDir.. "kwkrectangle.png", 1280, 800 ); 
       kwkrectangle.x = 640; kwkrectangle.y = 400; kwkrectangle.alpha = 1; kwkrectangle.oldAlpha = 1 
       kwkrectangle.oriX = kwkrectangle.x; kwkrectangle.oriY = kwkrectangle.y 
       kwkrectangle.name = "kwkrectangle" 
       menuGroup:insert(1,kwkrectangle); menuGroup.kwkrectangle = kwkrectangle 

       -- Comineza_tu_ave positioning 
       Comineza_tu_ave = display.newImageRect( imgDir.. "p3_comineza_tu_ave.png", 486, 33 ); 
       Comineza_tu_ave.x = 685; Comineza_tu_ave.y = 360; Comineza_tu_ave.alpha = 1; Comineza_tu_ave.oldAlpha = 1 
       Comineza_tu_ave.oriX = Comineza_tu_ave.x; Comineza_tu_ave.oriY = Comineza_tu_ave.y 
       Comineza_tu_ave.name = "Comineza_tu_ave" 
       menuGroup:insert(Comineza_tu_ave); menuGroup.Comineza_tu_ave = Comineza_tu_ave 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
 
       -- Actions (functions) 
       function actNextPage(event) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_4", "fade" ) 
            end 
            timerStash.newTimer_120 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

 
      --End Actions (functions) 

 
       -- Timers 
       timerStash.page4 = timer.performWithDelay( 4000, actNextPage, 1 ) 
 
       -- Page properties 
       menuGroup.xScale = 1; menuGroup.yScale = 1; 
       menuGroup.alpha = 1; 
 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
