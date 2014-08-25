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

       local curPage = 62 

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

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
             require("MyDialog")
      -- Button names 
       local butConfirm
       -- Action names 
       local actConfirmName 
       -- Layer names 
       local textInputName  
       local inputName  
       local kwkbuttonConfir 
       --others 
       local age

       -- textInputName positioning
       textInputName = display.newText( "Introduce tu edad:", 676, 133, native.systemFontBold, 28 )
       textInputName.x = 676; textInputName.y = 133;
       menuGroup:insert(textInputName); menuGroup.textInputName = textInputName 

       -- inputName positioning 
       local function fieldHandler_inputName(event) 
               if ( event.phase == "submitted" or event.phase == "ended" )  then  
                  age = event.target.text
                  native.setKeyboardFocus(nil) 
               end  
       end 

       inputName = native.newTextField( 177, 270, 1000, 100 )  
       inputName.placeholder = "Edad"
       inputName.font = native.newFont( native.systemFontBold, 24 ) 
       inputName:addEventListener( "userInput", fieldHandler_inputName ) 

       -- kwkbuttonConfir positioning 
       kwkbuttonConfir = display.newImageRect( imgDir.. "kwkbuttonconfir.png", 348, 86 ); 
       kwkbuttonConfir.x = 678; kwkbuttonConfir.y = 553; 
       menuGroup:insert(kwkbuttonConfir); menuGroup.kwkbuttonConfir = kwkbuttonConfir 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
 
       -- Actions (functions) 
       function actConfirmName(event) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_63", "fade" ) 
            end 
            timerStash.newTimer_333 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

 
      --End Actions (functions) 


       -- Button event listeners 
       local function onkwkbuttonConfirEvent(event) 
          butConfirm(kwkbuttonConfir) 
          return true 
       end 
       kwkbuttonConfir:addEventListener("tap", onkwkbuttonConfirEvent ) 

       -- Button functions 
       function butConfirm(self)
          if (age==nil or age="") and system.getInfo("environment")=="device" then
            local myDialog
            
            local function functionC( event )
              -- body
              local object = event.target

              if event.phase == "began" then
                display.getCurrentStage():setFocus(object)
                object.isFocus = true
              elseif object.isFocus then
                if event.phase == "ended" or event.phase == "cancelled" then
                    display.getCurrentStage():setFocus( nil )
                    object.isFocus = false

                    deleteMyDialog( myDialog )
                end
              end
              return true
            end

            myDialog = createMyDialog( "ADVERTENCIA", "Debes introducir tu edad.", nil, "Vale", listenerC)
          else
            local myClosure_switch = function()
                dispose(); director:changeScene( "page_63", "fade" ) 
            end 
            _G.Age = age
            timerStash.newTimer_391 = timer.performWithDelay(0, myClosure_switch, 1) 
          end
       end 
 
       _G.LastPage = curPage  

       -- kwkrectangle positioning 
       kwkrectangle = display.newImageRect( imgDir.. "kwkrectangle.png", 1280, 800 ); 
       kwkrectangle.x = 640; kwkrectangle.y = 400; kwkrectangle.alpha = 1; kwkrectangle.oldAlpha = 1 
       kwkrectangle.oriX = kwkrectangle.x; kwkrectangle.oriY = kwkrectangle.y 
       kwkrectangle.name = "kwkrectangle" 
       menuGroup:insert(1,kwkrectangle); menuGroup.kwkrectangle = kwkrectangle 
 
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
