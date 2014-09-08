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

       local curPage = 54 

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
       local kwkentradaMuseo  
       local kwkexp  

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

       -- kwkexp positioning 
       local kwkexp_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=86, height=220 }, -- exploradorLellendo_00000
               { x=90, y=2, width=86, height=220 }, -- exploradorLellendo_00001
               { x=178, y=2, width=86, height=220 }, -- exploradorLellendo_00002
               { x=266, y=2, width=86, height=220 }, -- exploradorLellendo_00003
               { x=354, y=2, width=86, height=220 }, -- exploradorLellendo_00004
               { x=2, y=224, width=86, height=220 }, -- exploradorLellendo_00005
               { x=90, y=224, width=86, height=220 }, -- exploradorLellendo_00006
               { x=178, y=224, width=86, height=220 }, -- exploradorLellendo_00007
               { x=266, y=224, width=86, height=220 }, -- exploradorLellendo_00008
               { x=354, y=224, width=86, height=220 }, -- exploradorLellendo_00009
               { x=2, y=446, width=86, height=220 }, -- exploradorLellendo_00010
               { x=90, y=446, width=86, height=220 }, -- exploradorLellendo_00011
               { x=178, y=446, width=86, height=220 }, -- exploradorLellendo_00012
               { x=266, y=446, width=86, height=220 }, -- exploradorLellendo_00013
               { x=354, y=446, width=86, height=220 }, -- exploradorLellendo_00014
               { x=2, y=668, width=86, height=220 }, -- exploradorLellendo_00015
               { x=90, y=668, width=86, height=220 }, -- exploradorLellendo_00016
           },
    
           sheetContentWidth = 442,
           sheetContentHeight = 890
 
       } 
       kwkexp_sheet = graphics.newImageSheet( spriteDir.. "expleyendo.png", kwkexp_options ) 
       kwkexp_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "forward" }; 
       kwkexp = display.newSprite(kwkexp_sheet, kwkexp_seq ) 
       kwkexp:play(); 
       kwkexp.x = 867; kwkexp.y = 466; kwkexp.alpha = 1; kwkexp.oldAlpha = 1 
       kwkexp.oriX = kwkexp.x; kwkexp.oriY = kwkexp.y 
       kwkexp.name = "kwkexp" 
       menuGroup:insert(kwkexp); menuGroup.kwkexp = kwkexp 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           kwkexp_sheet = nil; kwkexp = nil 
 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )

kwkexp:pause( )

_G.Level = 5
_G.Phase = 1

local aud = {"exp_afr1.mp3"}
local sub = {"Así que mañana sale un cargamento de ayuda para los más pobres en la región de Malí de Sudáfrica. Es una buena oportunidad para ayudar a los más necesitados y de paso traernos algo bonito para el museo."}
local sec = {1}

addCharacter(kwkexp, aud, sub)
setSecuence( sec )
playScene( "page_55" ) 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
