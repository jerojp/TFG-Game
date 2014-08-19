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
       local butLetraE
       local but_127
       local but_990
       local but_545

       -- Layer names 
       local continents  
       local FlechaMapa  
       local FlechaMapaCopia  
       local O  
       local U  
       local I  
       local A  
       local E  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage 

       -- continents positioning 
       continents = display.newImageRect( imgDir.. "p11_continents.png", 1280, 800 ); 
       continents.x = 640; continents.y = 400; continents.alpha = 1; continents.oldAlpha = 1 
       continents.oriX = continents.x; continents.oriY = continents.y 
       continents.name = "continents" 
       menuGroup:insert(1,continents); menuGroup.continents = continents 

       -- FlechaMapa positioning 
       FlechaMapa = display.newImageRect( imgDir.. "p11_flechamapa.png", 85, 100 ); 
       FlechaMapa.x = 632; FlechaMapa.y = 120; FlechaMapa.alpha = 1; FlechaMapa.oldAlpha = 1 
       FlechaMapa.oriX = FlechaMapa.x; FlechaMapa.oriY = FlechaMapa.y 
       FlechaMapa.name = "FlechaMapa" 
       menuGroup:insert(FlechaMapa); menuGroup.FlechaMapa = FlechaMapa 

       -- FlechaMapaCopia positioning 
       FlechaMapaCopia = display.newImageRect( imgDir.. "p11_flechamapacopia.png", 85, 100 ); 
       FlechaMapaCopia.x = 414; FlechaMapaCopia.y = 373; FlechaMapaCopia.alpha = 1; FlechaMapaCopia.oldAlpha = 1 
       FlechaMapaCopia.oriX = FlechaMapaCopia.x; FlechaMapaCopia.oriY = FlechaMapaCopia.y 
       FlechaMapaCopia.name = "FlechaMapaCopia" 
       menuGroup:insert(FlechaMapaCopia); menuGroup.FlechaMapaCopia = FlechaMapaCopia 

       -- O positioning 
       O = display.newImageRect( imgDir.. "p11_o.png", 55, 54 ); 
       O.x = 1057; O.y = 197; O.alpha = 1; O.oldAlpha = 1 
       O.oriX = O.x; O.oriY = O.y 
       O.name = "O" 
       menuGroup:insert(O); menuGroup.O = O 

       -- U positioning 
       U = display.newImageRect( imgDir.. "p11_u.png", 66, 60 ); 
       U.x = 633; U.y = 334; U.alpha = 1; U.oldAlpha = 1 
       U.oriX = U.x; U.oriY = U.y 
       U.name = "U" 
       menuGroup:insert(U); menuGroup.U = U 

       -- I positioning 
       I = display.newImageRect( imgDir.. "p11_i.png", 63, 81 ); 
       I.x = 643; I.y = 735; I.alpha = 1; I.oldAlpha = 1 
       I.oriX = I.x; I.oriY = I.y 
       I.name = "I" 
       menuGroup:insert(I); menuGroup.I = I 

       -- A positioning 
       A = display.newImageRect( imgDir.. "p11_a.png", 35, 26 ); 
       A.x = 414; A.y = 351; A.alpha = 1; A.oldAlpha = 1 
       A.oriX = A.x; A.oriY = A.y 
       A.name = "A" 
       menuGroup:insert(A); menuGroup.A = A 

       -- E positioning 
       E = display.newImageRect( imgDir.. "p11_e.png", 30, 26 ); 
       E.x = 633; E.y = 99; E.alpha = 1; E.oldAlpha = 1 
       E.oriX = E.x; E.oriY = E.y 
       E.name = "E" 
       menuGroup:insert(E); menuGroup.E = E 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- Button event listeners 
       local function onFlechaMapaEvent(event) 
          butLetraE(FlechaMapa) 
          return true 
       end 
       FlechaMapa:addEventListener("tap", onFlechaMapaEvent ) 
       local function onIEvent(event) 
          but_127(I) 
          return true 
       end 
       I:addEventListener("tap", onIEvent ) 
       local function onOEvent(event) 
          but_990(O) 
          return true 
       end 
       O:addEventListener("tap", onOEvent ) 
       local function onAEvent(event) 
          but_545(A) 
          return true 
       end 
       A:addEventListener("tap", onAEvent ) 

       -- Button functions 
       function butLetraE(self) 
           _G.Level = 2
          saveKwikVars({"Level",2}) 
           _G.Phase = 1
          saveKwikVars({"Phase",1}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_12", "fade" ) 
            end 
            timerStash.newTimer_286 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

       function but_127(self) 
           _G.Level = 3
          saveKwikVars({"Level",3}) 
           _G.Phase = 1
          saveKwikVars({"Phase",1}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_35", "fade" ) 
            end 
            timerStash.newTimer_303 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

       function but_990(self) 
           _G.Phase = 1
          saveKwikVars({"Phase",1}) 
           _G.Level = 4
          saveKwikVars({"Level",4}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_44", "fade" ) 
            end 
            timerStash.newTimer_310 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

       function but_545(self) 
           _G.Level = 1
          saveKwikVars({"Level",1}) 
           _G.Phase = 1
          saveKwikVars({"Phase",1}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_25", "fade" ) 
            end 
            timerStash.newTimer_318 = timer.performWithDelay(0, myClosure_switch, 1) 
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
