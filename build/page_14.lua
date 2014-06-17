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

       local curPage = 14 

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
       local act_568 

       -- Layer names 
       local kwksnowyLandsca  
       local explTalk  

       -- (TOP) External code will render here 

       -- kwksnowyLandsca positioning 
       kwksnowyLandsca = display.newImageRect( imgDir.. "kwksnowylandsca.png", 1280, 799 ); 
       kwksnowyLandsca.x = 640; kwksnowyLandsca.y = 399; kwksnowyLandsca.alpha = 1; kwksnowyLandsca.oldAlpha = 1 
       kwksnowyLandsca.oriX = kwksnowyLandsca.x; kwksnowyLandsca.oriY = kwksnowyLandsca.y 
       kwksnowyLandsca.name = "kwksnowyLandsca" 
       menuGroup:insert(1,kwksnowyLandsca); menuGroup.kwksnowyLandsca = kwksnowyLandsca 

       -- explTalk positioning 
       local explTalk_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=431, y=668, width=141, height=220 }, -- exploradorNormal_00000
               { x=288, y=668, width=141, height=220 }, -- exploradorNormal_00001
               { x=431, y=446, width=141, height=220 }, -- exploradorNormal_00002
               { x=288, y=446, width=141, height=220 }, -- exploradorNormal_00003
               { x=145, y=668, width=141, height=220 }, -- exploradorNormal_00004
               { x=145, y=446, width=141, height=220 }, -- exploradorNormal_00005
               { x=431, y=224, width=141, height=220 }, -- exploradorNormal_00006
               { x=288, y=224, width=141, height=220 }, -- exploradorNormal_00007
               { x=145, y=224, width=141, height=220 }, -- exploradorNormal_00008
               { x=2, y=668, width=141, height=220 }, -- exploradorNormal_00009
               { x=2, y=446, width=141, height=220 }, -- exploradorNormal_00010
               { x=2, y=224, width=141, height=220 }, -- exploradorNormal_00011
               { x=431, y=2, width=141, height=220 }, -- exploradorNormal_00012
               { x=288, y=2, width=141, height=220 }, -- exploradorNormal_00013
               { x=145, y=2, width=141, height=220 }, -- exploradorNormal_00014
               { x=2, y=2, width=141, height=220 }, -- exploradorNormal_00015
           },
    
           sheetContentWidth = 574,
           sheetContentHeight = 891
 
       } 
       explTalk_sheet = graphics.newImageSheet( spriteDir.. "exploradorhabla.png", explTalk_options ) 
       explTalk_seq = { name = "default", start = 1, count = 16, time = 800, loopCount = 0, loopDirection = "bounce" }; 
       explTalk = display.newSprite(explTalk_sheet, explTalk_seq ) 
       explTalk:play(); 
       explTalk.x = 428; explTalk.y = 618; explTalk.alpha = 1; explTalk.oldAlpha = 1 
       explTalk.oriX = explTalk.x; explTalk.oriY = explTalk.y 
       explTalk.name = "explTalk" 
       menuGroup:insert(explTalk); menuGroup.explTalk = explTalk 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
 
       -- Actions (functions) 
       function act_568(event) 
           CurrentPage = 15
          saveKwikVars({"CurrentPage",15}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_15", "fade" ) 
            end 
            timerStash.newTimer_223 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

 
      --End Actions (functions) 


       -- swipe this page with spacer of 120 in normal direction 
       Gesture.activate( kwksnowyLandsca, {swipeLength=120} ) 
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
       kwksnowyLandsca:addEventListener( Gesture.SWIPE_EVENT, pageSwap ) 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
          kwksnowyLandsca:removeEventListener( Gesture.SWIPE_EVENT, pageSwap ); Gesture.deactivate(kwksnowyLandsca) 
       end 

       function cleanSprite() 
           explTalk_sheet = nil; explTalk = nil 
 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
