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

       local curPage = 7 

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
       local butCancel
       local butConfirm

       -- Layer names 
       local kwkrectangle  
       local textConfirm  
       local buttoncancel  
       local kwkbuttonConfir  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  

       -- kwkrectangle positioning 
       kwkrectangle = display.newImageRect( imgDir.. "kwkrectangle.png", 1280, 800 ); 
       kwkrectangle.x = 640; kwkrectangle.y = 400; kwkrectangle.alpha = 1; kwkrectangle.oldAlpha = 1 
       kwkrectangle.oriX = kwkrectangle.x; kwkrectangle.oriY = kwkrectangle.y 
       kwkrectangle.name = "kwkrectangle" 
       menuGroup:insert(1,kwkrectangle); menuGroup.kwkrectangle = kwkrectangle 

       -- textConfirm positioning 
       textConfirm = display.newImageRect( imgDir.. "p7_textconfirm.png", 279, 35 ); 
       textConfirm.x = 699; textConfirm.y = 183; textConfirm.alpha = 1; textConfirm.oldAlpha = 1 
       textConfirm.oriX = textConfirm.x; textConfirm.oriY = textConfirm.y 
       textConfirm.name = "textConfirm" 
       menuGroup:insert(textConfirm); menuGroup.textConfirm = textConfirm 

       -- buttoncancel positioning 
       buttoncancel = display.newImageRect( imgDir.. "p7_buttoncancel.png", 254, 61 ); 
       buttoncancel.x = 884; buttoncancel.y = 455; buttoncancel.alpha = 1; buttoncancel.oldAlpha = 1 
       buttoncancel.oriX = buttoncancel.x; buttoncancel.oriY = buttoncancel.y 
       buttoncancel.name = "buttoncancel" 
       menuGroup:insert(buttoncancel); menuGroup.buttoncancel = buttoncancel 

       -- kwkbuttonConfir positioning 
       kwkbuttonConfir = display.newImageRect( imgDir.. "kwkbuttonconfir.png", 257, 67 ); 
       kwkbuttonConfir.x = 516; kwkbuttonConfir.y = 452; kwkbuttonConfir.alpha = 1; kwkbuttonConfir.oldAlpha = 1 
       kwkbuttonConfir.oriX = kwkbuttonConfir.x; kwkbuttonConfir.oriY = kwkbuttonConfir.y 
       kwkbuttonConfir.name = "kwkbuttonConfir" 
       menuGroup:insert(kwkbuttonConfir); menuGroup.kwkbuttonConfir = kwkbuttonConfir 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
        local nameIntro = display.newText( NameUser, 648, 248, native.systemFont, 48 ) 
 nameIntro:setTextColor (255, 255, 255)  
 menuGroup:insert(nameIntro); menuGroup.nameIntro = nameIntro  

       -- Button event listeners 
       local function onbuttoncancelEvent(event) 
          butCancel(buttoncancel) 
          return true 
       end 
       buttoncancel:addEventListener("tap", onbuttoncancelEvent ) 
       local function onkwkbuttonConfirEvent(event) 
          butConfirm(kwkbuttonConfir) 
          return true 
       end 
       kwkbuttonConfir:addEventListener("tap", onkwkbuttonConfirEvent ) 

       -- Button functions 
       function butCancel(self) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_6", "moveFromLeft" ) 
            end 
            timerStash.newTimer_080 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

       function butConfirm(self) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_64", "fade" ) 
            end 
            timerStash.newTimer_090 = timer.performWithDelay(0, myClosure_switch, 1) 
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
