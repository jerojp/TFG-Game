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

       local curPage = 8 

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
       local act_139 

       -- Layer names 
       local kwkescenarioJef  
       local kwkboss  
       local kwktextcoin  
       local kwktable  
       local kwkcoin  

       -- (TOP) External code will render here 

       -- kwkescenarioJef positioning 
       kwkescenarioJef = display.newImageRect( imgDir.. "kwkescenariojef.png", 1280, 800 ); 
       kwkescenarioJef.x = 640; kwkescenarioJef.y = 400; kwkescenarioJef.alpha = 1; kwkescenarioJef.oldAlpha = 1 
       kwkescenarioJef.oriX = kwkescenarioJef.x; kwkescenarioJef.oriY = kwkescenarioJef.y 
       kwkescenarioJef.name = "kwkescenarioJef" 
       menuGroup:insert(1,kwkescenarioJef); menuGroup.kwkescenarioJef = kwkescenarioJef 

       -- kwkboss positioning 
       local kwkboss_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=140, height=189 }, -- JefeMuseo_00000
               { x=144, y=2, width=140, height=189 }, -- JefeMuseo_00001
               { x=286, y=2, width=140, height=189 }, -- JefeMuseo_00002
               { x=428, y=2, width=140, height=189 }, -- JefeMuseo_00003
               { x=570, y=2, width=140, height=189 }, -- JefeMuseo_00004
               { x=712, y=2, width=140, height=189 }, -- JefeMuseo_00005
               { x=854, y=2, width=140, height=189 }, -- JefeMuseo_00006
               { x=2, y=193, width=140, height=189 }, -- JefeMuseo_00007
               { x=144, y=193, width=140, height=189 }, -- JefeMuseo_00008
               { x=286, y=193, width=140, height=189 }, -- JefeMuseo_00009
               { x=428, y=193, width=140, height=189 }, -- JefeMuseo_00010
               { x=570, y=193, width=140, height=189 }, -- JefeMuseo_00011
               { x=712, y=193, width=140, height=189 }, -- JefeMuseo_00012
               { x=854, y=193, width=140, height=189 }, -- JefeMuseo_00013
               { x=2, y=384, width=140, height=189 }, -- JefeMuseo_00014
               { x=144, y=384, width=140, height=189 }, -- JefeMuseo_00015
               { x=286, y=384, width=140, height=189 }, -- JefeMuseo_00016
               { x=428, y=384, width=140, height=189 }, -- JefeMuseo_00017
               { x=570, y=384, width=140, height=189 }, -- JefeMuseo_00018
               { x=712, y=384, width=140, height=189 }, -- JefeMuseo_00019
               { x=854, y=384, width=140, height=189 }, -- JefeMuseo_00020
               { x=2, y=575, width=140, height=189 }, -- JefeMuseo_00021
               { x=144, y=575, width=140, height=189 }, -- JefeMuseo_00022
               { x=286, y=575, width=140, height=189 }, -- JefeMuseo_00023
               { x=428, y=575, width=140, height=189 }, -- JefeMuseo_00024
               { x=570, y=575, width=140, height=189 }, -- JefeMuseo_00025
               { x=712, y=575, width=140, height=189 }, -- JefeMuseo_00026
               { x=854, y=575, width=140, height=189 }, -- JefeMuseo_00027
               { x=2, y=766, width=140, height=189 }, -- JefeMuseo_00028
               { x=144, y=766, width=140, height=189 }, -- JefeMuseo_00029
               { x=286, y=766, width=140, height=189 }, -- JefeMuseo_00030
               { x=428, y=766, width=140, height=189 }, -- JefeMuseo_00031
           },
    
           sheetContentWidth = 1024,
           sheetContentHeight = 1024
 
       } 
       kwkboss_sheet = graphics.newImageSheet( spriteDir.. "jefe.png", kwkboss_options ) 
       kwkboss_seq = { name = "default", start = 1, count = 32, time = 1000, loopCount = 0, loopDirection = "forward" }; 
       kwkboss = display.newSprite(kwkboss_sheet, kwkboss_seq ) 
       kwkboss:play(); 
       kwkboss.x = 542; kwkboss.y = 439; kwkboss.alpha = 1; kwkboss.oldAlpha = 1 
       kwkboss.xScale = 1.5; 
       kwkboss.yScale = 1.5; 
       kwkboss.oriX = kwkboss.x; kwkboss.oriY = kwkboss.y 
       kwkboss.name = "kwkboss" 
       menuGroup:insert(kwkboss); menuGroup.kwkboss = kwkboss 

       -- kwktextcoin positioning 
       kwktextcoin = display.newImageRect( imgDir.. "kwktextcoin.png", 71, 32 ); 
       kwktextcoin.x = 131; kwktextcoin.y = 44; kwktextcoin.alpha = 1; kwktextcoin.oldAlpha = 1 
       kwktextcoin.oriX = kwktextcoin.x; kwktextcoin.oriY = kwktextcoin.y 
       kwktextcoin.name = "kwktextcoin" 
       menuGroup:insert(kwktextcoin); menuGroup.kwktextcoin = kwktextcoin 

       -- kwktable positioning 
       kwktable = display.newImageRect( imgDir.. "kwktable.png", 850, 280 ); 
       kwktable.x = 594; kwktable.y = 592; kwktable.alpha = 1; kwktable.oldAlpha = 1 
       kwktable.oriX = kwktable.x; kwktable.oriY = kwktable.y 
       kwktable.name = "kwktable" 
       menuGroup:insert(kwktable); menuGroup.kwktable = kwktable 

       -- kwkcoin positioning 
       kwkcoin = display.newImageRect( imgDir.. "kwkcoin.png", 72, 67 ); 
       kwkcoin.x = 56; kwkcoin.y = 46; kwkcoin.alpha = 1; kwkcoin.oldAlpha = 1 
       kwkcoin.oriX = kwkcoin.x; kwkcoin.oriY = kwkcoin.y 
       kwkcoin.name = "kwkcoin" 
       menuGroup:insert(kwkcoin); menuGroup.kwkcoin = kwkcoin 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
 
       -- Actions (functions) 
       function act_139(event) 
           CurrentPage = 9
          saveKwikVars({"CurrentPage",9}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_9", "moveFromRight" ) 
            end 
            timerStash.newTimer_584 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

 
      --End Actions (functions) 


       -- swipe this page with spacer of 120 in normal direction 
       Gesture.activate( kwkescenarioJef, {swipeLength=120} ) 
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
       kwkescenarioJef:addEventListener( Gesture.SWIPE_EVENT, pageSwap ) 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
          kwkescenarioJef:removeEventListener( Gesture.SWIPE_EVENT, pageSwap ); Gesture.deactivate(kwkescenarioJef) 
       end 

       function cleanSprite() 
           kwkboss_sheet = nil; kwkboss = nil 
 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
