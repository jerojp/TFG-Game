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

       local curPage = 19 

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
       local act_nextScn 

       -- Layer names 
       local casaEnfermeraEx  
       local nurse  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage 

       -- casaEnfermeraEx positioning 
       casaEnfermeraEx = display.newImageRect( imgDir.. "p19_casaenfermeraex.png", 1280, 800 ); 
       casaEnfermeraEx.x = 640; casaEnfermeraEx.y = 400; casaEnfermeraEx.alpha = 1; casaEnfermeraEx.oldAlpha = 1 
       casaEnfermeraEx.oriX = casaEnfermeraEx.x; casaEnfermeraEx.oriY = casaEnfermeraEx.y 
       casaEnfermeraEx.name = "casaEnfermeraEx" 
       menuGroup:insert(1,casaEnfermeraEx); menuGroup.casaEnfermeraEx = casaEnfermeraEx 

       -- nurse positioning 
       local nurse_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=151, height=207 }, -- Enfermera_00000
               { x=155, y=2, width=151, height=207 }, -- Enfermera_00001
               { x=308, y=2, width=151, height=207 }, -- Enfermera_00002
               { x=461, y=2, width=151, height=207 }, -- Enfermera_00003
               { x=614, y=2, width=151, height=207 }, -- Enfermera_00004
               { x=767, y=2, width=151, height=207 }, -- Enfermera_00005
               { x=2, y=211, width=151, height=207 }, -- Enfermera_00006
               { x=155, y=211, width=151, height=207 }, -- Enfermera_00007
               { x=308, y=211, width=151, height=207 }, -- Enfermera_00008
               { x=461, y=211, width=151, height=207 }, -- Enfermera_00009
               { x=614, y=211, width=151, height=207 }, -- Enfermera_00010
               { x=767, y=211, width=151, height=207 }, -- Enfermera_00011
               { x=2, y=420, width=151, height=207 }, -- Enfermera_00012
               { x=155, y=420, width=151, height=207 }, -- Enfermera_00013
               { x=308, y=420, width=151, height=207 }, -- Enfermera_00014
               { x=461, y=420, width=151, height=207 }, -- Enfermera_00015
               { x=614, y=420, width=151, height=207 }, -- Enfermera_00016
           },
    
           sheetContentWidth = 920,
           sheetContentHeight = 629
 
       } 
       nurse_sheet = graphics.newImageSheet( spriteDir.. "enfsaluda.png", nurse_options ) 
       nurse_seq = { name = "default", start = 1, count = 18, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       nurse = display.newSprite(nurse_sheet, nurse_seq ) 
       nurse:play(); 
       nurse.x = 352; nurse.y = 670; nurse.alpha = 1; nurse.oldAlpha = 1 
       nurse.oriX = nurse.x; nurse.oriY = nurse.y 
       nurse.name = "nurse" 
       menuGroup:insert(nurse); menuGroup.nurse = nurse 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
 
       -- Actions (functions) 
       function act_nextScn(event) 
           _G.Phase = 2
          saveKwikVars({"Phase",2}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_20", "fade" ) 
            end 
            timerStash.newTimer_942 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

 
      --End Actions (functions) 

 
       -- Timers 
       timerStash.timer_nextScn = timer.performWithDelay( 4000, act_nextScn, 1 ) 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           nurse_sheet = nil; nurse = nil 
 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
