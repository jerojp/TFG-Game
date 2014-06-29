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

       local curPage = 16 

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
       local act_484 

       -- Layer names 
       local kwksnowylandsca  
       local explSkier  

       -- (TOP) External code will render here 

       -- kwksnowylandsca positioning 
       kwksnowylandsca = display.newImageRect( imgDir.. "kwksnowylandsca.png", 1280, 799 ); 
       kwksnowylandsca.x = 640; kwksnowylandsca.y = 399; kwksnowylandsca.alpha = 1; kwksnowylandsca.oldAlpha = 1 
       kwksnowylandsca.oriX = kwksnowylandsca.x; kwksnowylandsca.oriY = kwksnowylandsca.y 
       kwksnowylandsca.name = "kwksnowylandsca" 
       menuGroup:insert(1,kwksnowylandsca); menuGroup.kwksnowylandsca = kwksnowylandsca 

       -- explSkier positioning 
       local explSkier_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=192, height=219 }, -- ExploradorEsquando_00000
               { x=196, y=2, width=192, height=219 }, -- ExploradorEsquando_00001
               { x=390, y=2, width=192, height=219 }, -- ExploradorEsquando_00002
               { x=584, y=2, width=192, height=219 }, -- ExploradorEsquando_00003
               { x=2, y=223, width=192, height=219 }, -- ExploradorEsquando_00004
               { x=196, y=223, width=192, height=219 }, -- ExploradorEsquando_00005
               { x=390, y=223, width=192, height=219 }, -- ExploradorEsquando_00006
               { x=584, y=223, width=192, height=219 }, -- ExploradorEsquando_00007
               { x=2, y=444, width=192, height=219 }, -- ExploradorEsquando_00008
               { x=196, y=444, width=192, height=219 }, -- ExploradorEsquando_00009
               { x=390, y=444, width=192, height=219 }, -- ExploradorEsquando_00010
               { x=584, y=444, width=192, height=219 }, -- ExploradorEsquando_00011
               { x=2, y=665, width=192, height=219 }, -- ExploradorEsquando_00012
               { x=196, y=665, width=192, height=219 }, -- ExploradorEsquando_00013
               { x=390, y=665, width=192, height=219 }, -- ExploradorEsquando_00014
               { x=584, y=665, width=192, height=219 }, -- ExploradorEsquando_00015
           },
    
           sheetContentWidth = 778,
           sheetContentHeight = 886
 
       } 
       explSkier_sheet = graphics.newImageSheet( spriteDir.. "exploradoresquiando.png", explSkier_options ) 
       explSkier_seq = { name = "default", start = 1, count = 16, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       explSkier = display.newSprite(explSkier_sheet, explSkier_seq ) 
       explSkier:play(); 
       explSkier.x = 608; explSkier.y = 618; explSkier.alpha = 1; explSkier.oldAlpha = 1 
       explSkier.oriX = explSkier.x; explSkier.oriY = explSkier.y 
       explSkier.name = "explSkier" 
       menuGroup:insert(explSkier); menuGroup.explSkier = explSkier 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
 
       -- Actions (functions) 
       function act_484(event) 
           CurrentPage = 17
          saveKwikVars({"CurrentPage",17}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_17", "fade" ) 
            end 
            timerStash.newTimer_498 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

 
      --End Actions (functions) 


       -- swipe this page with spacer of 120 in normal direction 
       Gesture.activate( kwksnowylandsca, {swipeLength=120} ) 
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
       kwksnowylandsca:addEventListener( Gesture.SWIPE_EVENT, pageSwap ) 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
          kwksnowylandsca:removeEventListener( Gesture.SWIPE_EVENT, pageSwap ); Gesture.deactivate(kwksnowylandsca) 
       end 

       function cleanSprite() 
           explSkier_sheet = nil; explSkier = nil 
 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
