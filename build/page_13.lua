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

       local curPage = 13 

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

 
       -- Action names 
       local act_438 

       -- Layer names 
       local kwkrectangleW  
       local spriteCall  
       local spriteCallGirl  
       local Forma_1  

       -- (TOP) External code will render here 

       -- kwkrectangleW positioning 
       kwkrectangleW = display.newImageRect( imgDir.. "kwkrectanglew.png", 1280, 800 ); 
       kwkrectangleW.x = 640; kwkrectangleW.y = 400; kwkrectangleW.alpha = 1; kwkrectangleW.oldAlpha = 1 
       kwkrectangleW.oriX = kwkrectangleW.x; kwkrectangleW.oriY = kwkrectangleW.y 
       kwkrectangleW.name = "kwkrectangleW" 
       menuGroup:insert(1,kwkrectangleW); menuGroup.kwkrectangleW = kwkrectangleW 

       -- spriteCall positioning 
       local spriteCall_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=132, height=213 }, -- Llamada2_00000
               { x=136, y=2, width=132, height=213 }, -- Llamada2_00001
               { x=270, y=2, width=132, height=213 }, -- Llamada2_00002
               { x=404, y=2, width=132, height=213 }, -- Llamada2_00003
               { x=538, y=2, width=132, height=213 }, -- Llamada2_00004
               { x=2, y=217, width=132, height=213 }, -- Llamada2_00005
               { x=136, y=217, width=132, height=213 }, -- Llamada2_00006
               { x=270, y=217, width=132, height=213 }, -- Llamada2_00007
               { x=404, y=217, width=132, height=213 }, -- Llamada2_00008
               { x=538, y=217, width=132, height=213 }, -- Llamada2_00010
               { x=2, y=432, width=132, height=213 }, -- Llamada2_00011
               { x=136, y=432, width=132, height=213 }, -- Llamada2_00012
               { x=270, y=432, width=132, height=213 }, -- Llamada2_00013
               { x=404, y=432, width=132, height=213 }, -- Llamada2_00014
               { x=538, y=432, width=132, height=213 }, -- Llamada2_00015
           },
    
           sheetContentWidth = 672,
           sheetContentHeight = 647
 
       } 
       spriteCall_sheet = graphics.newImageSheet( spriteDir.. "llamadachico.png", spriteCall_options ) 
       spriteCall_seq = { name = "default", start = 1, count = 17, time = 800, loopCount = 0, loopDirection = "forward" }; 
       spriteCall = display.newSprite(spriteCall_sheet, spriteCall_seq ) 
       spriteCall:play(); 
       spriteCall.x = 336; spriteCall.y = 399; spriteCall.alpha = 1; spriteCall.oldAlpha = 1 
       spriteCall.xScale = 3; 
       spriteCall.yScale = 4; 
       spriteCall.oriX = spriteCall.x; spriteCall.oriY = spriteCall.y 
       spriteCall.name = "spriteCall" 
       menuGroup:insert(spriteCall); menuGroup.spriteCall = spriteCall 

       -- spriteCallGirl positioning 
       local spriteCallGirl_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=188, height=211 }, -- Llamada-chica_00000
               { x=192, y=2, width=188, height=211 }, -- Llamada-chica_00001
               { x=382, y=2, width=188, height=211 }, -- Llamada-chica_00002
               { x=572, y=2, width=188, height=211 }, -- Llamada-chica_00003
               { x=762, y=2, width=188, height=211 }, -- Llamada-chica_00004
               { x=2, y=215, width=188, height=211 }, -- Llamada-chica_00005
               { x=192, y=215, width=188, height=211 }, -- Llamada-chica_00006
               { x=382, y=215, width=188, height=211 }, -- Llamada-chica_00007
               { x=572, y=215, width=188, height=211 }, -- Llamada-chica_00008
               { x=762, y=215, width=188, height=211 }, -- Llamada-chica_00009
               { x=2, y=428, width=188, height=211 }, -- Llamada-chica_00010
               { x=192, y=428, width=188, height=211 }, -- Llamada-chica_00011
               { x=382, y=428, width=188, height=211 }, -- Llamada-chica_00012
               { x=572, y=428, width=188, height=211 }, -- Llamada-chica_00013
               { x=762, y=428, width=188, height=211 }, -- Llamada-chica_00014
               { x=2, y=641, width=188, height=211 }, -- Llamada-chica_00015
               { x=192, y=641, width=188, height=211 }, -- Llamada-chica_00016
           },
    
           sheetContentWidth = 952,
           sheetContentHeight = 854
 
       } 
       spriteCallGirl_sheet = graphics.newImageSheet( spriteDir.. "llamadachica.png", spriteCallGirl_options ) 
       spriteCallGirl_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "forward" }; 
       spriteCallGirl = display.newSprite(spriteCallGirl_sheet, spriteCallGirl_seq ) 
       spriteCallGirl:play(); 
       spriteCallGirl.x = 975; spriteCallGirl.y = 400; spriteCallGirl.alpha = 1; spriteCallGirl.oldAlpha = 1 
       spriteCallGirl.xScale = 3; 
       spriteCallGirl.yScale = 3.9; 
       spriteCallGirl.oriX = spriteCallGirl.x; spriteCallGirl.oriY = spriteCallGirl.y 
       spriteCallGirl.name = "spriteCallGirl" 
       menuGroup:insert(spriteCallGirl); menuGroup.spriteCallGirl = spriteCallGirl 

       -- Forma_1 positioning 
       Forma_1 = display.newImageRect( imgDir.. "p13_forma_1.png", 4, 800 ); 
       Forma_1.x = 663; Forma_1.y = 400; Forma_1.alpha = 1; Forma_1.oldAlpha = 1 
       Forma_1.oriX = Forma_1.x; Forma_1.oriY = Forma_1.y 
       Forma_1.name = "Forma_1" 
       menuGroup:insert(Forma_1); menuGroup.Forma_1 = Forma_1 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
 
       -- Actions (functions) 
       function act_438(event) 
           CurrentPage = 14
          saveKwikVars({"CurrentPage",14}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_14", "fade" ) 
            end 
            timerStash.newTimer_836 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

 
      --End Actions (functions) 


       -- swipe this page with spacer of 120 in normal direction 
       Gesture.activate( kwkrectangleW, {swipeLength=120} ) 
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
       kwkrectangleW:addEventListener( Gesture.SWIPE_EVENT, pageSwap ) 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
          kwkrectangleW:removeEventListener( Gesture.SWIPE_EVENT, pageSwap ); Gesture.deactivate(kwkrectangleW) 
       end 

       function cleanSprite() 
           spriteCall_sheet = nil; spriteCall = nil 
    spriteCallGirl_sheet = nil; spriteCallGirl = nil 
 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
