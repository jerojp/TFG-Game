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

       local curPage = 12 
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
       local act_079 

       -- Layer names 
       local kwkentradaMuseo  
       local explCall  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

       -- kwkentradaMuseo positioning 
       kwkentradaMuseo = display.newImageRect( imgDir.. "kwkentradamuseo.png", 1280, 800 ); 
       kwkentradaMuseo.x = 640; kwkentradaMuseo.y = 400; kwkentradaMuseo.alpha = 1; kwkentradaMuseo.oldAlpha = 1 
       kwkentradaMuseo.oriX = kwkentradaMuseo.x; kwkentradaMuseo.oriY = kwkentradaMuseo.y 
       kwkentradaMuseo.name = "kwkentradaMuseo" 
       menuGroup:insert(1,kwkentradaMuseo); menuGroup.kwkentradaMuseo = kwkentradaMuseo 

       -- explCall positioning 
       local explCall_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=178, height=220 }, -- explorador_00000
               { x=182, y=2, width=178, height=220 }, -- explorador_00001
               { x=362, y=2, width=178, height=220 }, -- explorador_00002
               { x=542, y=2, width=178, height=220 }, -- explorador_00003
               { x=2, y=224, width=178, height=220 }, -- explorador_00004
               { x=182, y=224, width=178, height=220 }, -- explorador_00005
               { x=362, y=224, width=178, height=220 }, -- explorador_00006
               { x=542, y=224, width=178, height=220 }, -- explorador_00007
               { x=2, y=446, width=178, height=220 }, -- explorador_00008
               { x=182, y=446, width=178, height=220 }, -- explorador_00009
               { x=362, y=446, width=178, height=220 }, -- explorador_00010
               { x=542, y=446, width=178, height=220 }, -- explorador_00011
           },
    
           sheetContentWidth = 722,
           sheetContentHeight = 668
 
       } 
       explCall_sheet = graphics.newImageSheet( spriteDir.. "exploradortelefono.png", explCall_options ) 
       explCall_seq = { name = "default", start = 1, count = 12, time = 1000, loopCount = 1, loopDirection = "forward" }; 
       explCall = display.newSprite(explCall_sheet, explCall_seq ) 
       explCall:play(); 
       explCall.x = 857; explCall.y = 450; explCall.alpha = 1; explCall.oldAlpha = 1 
       explCall.oriX = explCall.x; explCall.oriY = explCall.y 
       explCall.name = "explCall" 
       menuGroup:insert(explCall); menuGroup.explCall = explCall 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
 
       -- Actions (functions) 
       function act_079(event) 
           Level = 2
          saveKwikVars({"Level",2}) 
           Phase = 1
          saveKwikVars({"Phase",1}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_13", "fade" ) 
            end 
            timerStash.newTimer_298 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

 
      --End Actions (functions) 

 
       -- Timers 
       timerStash.timer_711 = timer.performWithDelay( 2000, act_079, 1 ) 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           explCall_sheet = nil; explCall = nil 
 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
