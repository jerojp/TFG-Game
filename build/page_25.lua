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

       local curPage = 25 

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
       local escenarioJefeMu  
       local MapaTumbado  
       local Mesa  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 

       -- escenarioJefeMu positioning 
       escenarioJefeMu = display.newImageRect( imgDir.. "p25_escenariojefemu.png", 1280, 800 ); 
       escenarioJefeMu.x = 640; escenarioJefeMu.y = 400; escenarioJefeMu.alpha = 1; escenarioJefeMu.oldAlpha = 1 
       escenarioJefeMu.oriX = escenarioJefeMu.x; escenarioJefeMu.oriY = escenarioJefeMu.y 
       escenarioJefeMu.name = "escenarioJefeMu" 
       menuGroup:insert(1,escenarioJefeMu); menuGroup.escenarioJefeMu = escenarioJefeMu 

       -- MapaTumbado positioning 
       MapaTumbado = display.newImageRect( imgDir.. "p25_mapatumbado.png", 149, 53 ); 
       MapaTumbado.x = 565; MapaTumbado.y = 522; MapaTumbado.alpha = 1; MapaTumbado.oldAlpha = 1 
       MapaTumbado.oriX = MapaTumbado.x; MapaTumbado.oriY = MapaTumbado.y 
       MapaTumbado.name = "MapaTumbado" 
       menuGroup:insert(MapaTumbado); menuGroup.MapaTumbado = MapaTumbado 

       -- Mesa positioning 
       Mesa = display.newImageRect( imgDir.. "p25_mesa.png", 850, 280 ); 
       Mesa.x = 584; Mesa.y = 593; Mesa.alpha = 1; Mesa.oldAlpha = 1 
       Mesa.oriX = Mesa.x; Mesa.oriY = Mesa.y 
       Mesa.name = "Mesa" 
       menuGroup:insert(Mesa); menuGroup.Mesa = Mesa 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
