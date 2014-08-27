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

       local curPage = 46 

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
       local FondoJapon  
       local kwkjap  
       local kwkexp  
       local tablet  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level] = curPage 

       -- FondoJapon positioning 
       FondoJapon = display.newImageRect( imgDir.. "p46_fondojapon.png", 1296, 800 ); 
       FondoJapon.x = 640; FondoJapon.y = 400; FondoJapon.alpha = 1; FondoJapon.oldAlpha = 1 
       FondoJapon.oriX = FondoJapon.x; FondoJapon.oriY = FondoJapon.y 
       FondoJapon.name = "FondoJapon" 
       menuGroup:insert(1,FondoJapon); menuGroup.FondoJapon = FondoJapon 

       -- kwkjap positioning 
       local kwkjap_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=258, height=360 }, -- Japonesa_00000
               { x=262, y=2, width=258, height=360 }, -- Japonesa_00001
               { x=522, y=2, width=258, height=360 }, -- Japonesa_00002
               { x=2, y=364, width=258, height=360 }, -- Japonesa_00003
               { x=262, y=364, width=258, height=360 }, -- Japonesa_00004
               { x=522, y=364, width=258, height=360 }, -- Japonesa_00005
               { x=2, y=726, width=258, height=360 }, -- Japonesa_00006
               { x=262, y=726, width=258, height=360 }, -- Japonesa_00007
               { x=522, y=726, width=258, height=360 }, -- Japonesa_00008
           },
    
           sheetContentWidth = 782,
           sheetContentHeight = 1088
 
       } 
       kwkjap_sheet = graphics.newImageSheet( spriteDir.. "japonesa.png", kwkjap_options ) 
       kwkjap_seq = { name = "default", start = 1, count = 9, time = 1000, loopCount = 0, loopDirection = "forward" }; 
       kwkjap = display.newSprite(kwkjap_sheet, kwkjap_seq ) 
       kwkjap:play(); 
       kwkjap.x = 160; kwkjap.y = 407; kwkjap.alpha = 1; kwkjap.oldAlpha = 1 
       kwkjap.oriX = kwkjap.x; kwkjap.oriY = kwkjap.y 
       kwkjap.name = "kwkjap" 
       menuGroup:insert(kwkjap); menuGroup.kwkjap = kwkjap 

       -- kwkexp positioning 
       local kwkexp_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=229, height=395 }, -- ExploradorJapones_00000
               { x=233, y=2, width=229, height=395 }, -- ExploradorJapones_00001
               { x=464, y=2, width=229, height=395 }, -- ExploradorJapones_00002
               { x=695, y=2, width=229, height=395 }, -- ExploradorJapones_00003
               { x=2, y=399, width=229, height=395 }, -- ExploradorJapones_00004
               { x=233, y=399, width=229, height=395 }, -- ExploradorJapones_00005
               { x=464, y=399, width=229, height=395 }, -- ExploradorJapones_00006
               { x=695, y=399, width=229, height=395 }, -- ExploradorJapones_00007
               { x=2, y=796, width=229, height=395 }, -- ExploradorJapones_00008
               { x=233, y=796, width=229, height=395 }, -- ExploradorJapones_00009
               { x=464, y=796, width=229, height=395 }, -- ExploradorJapones_00010
               { x=695, y=796, width=229, height=395 }, -- ExploradorJapones_00011
               { x=2, y=1193, width=229, height=395 }, -- ExploradorJapones_00012
               { x=233, y=1193, width=229, height=395 }, -- ExploradorJapones_00013
               { x=464, y=1193, width=229, height=395 }, -- ExploradorJapones_00014
               { x=695, y=1193, width=229, height=395 }, -- ExploradorJapones_00015
               { x=2, y=1590, width=229, height=395 }, -- ExploradorJapones_00016
           },
    
           sheetContentWidth = 926,
           sheetContentHeight = 1987
 
       } 
       kwkexp_sheet = graphics.newImageSheet( spriteDir.. "expjapones.png", kwkexp_options ) 
       kwkexp_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "forward" }; 
       kwkexp = display.newSprite(kwkexp_sheet, kwkexp_seq ) 
       kwkexp:play(); 
       kwkexp.x = 391; kwkexp.y = 433; kwkexp.alpha = 1; kwkexp.oldAlpha = 1 
       kwkexp.xScale = 0.7; 
       kwkexp.yScale = 0.7; 
       kwkexp.oriX = kwkexp.x; kwkexp.oriY = kwkexp.y 
       kwkexp.name = "kwkexp" 
       menuGroup:insert(kwkexp); menuGroup.kwkexp = kwkexp 

       -- tablet positioning 
       tablet = display.newImageRect( imgDir.. "p46_tablet.png", 17, 41 ); 
       tablet.x = 360; tablet.y = 447; tablet.alpha = 1; tablet.oldAlpha = 1 
       tablet.oriX = tablet.x; tablet.oriY = tablet.y 
       tablet.name = "tablet" 
       menuGroup:insert(tablet); menuGroup.tablet = tablet 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           kwkjap_sheet = nil; kwkjap = nil 
    kwkexp_sheet = nil; kwkexp = nil 
 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )
gSprites.exp = kwkexp
gSprites.jap = kwkjap
kwkexp:pause( )
kwkjap:pause( )

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

_G.Level = 4
_G.Phase = 1

local aud = {"exp_ja6.mp3"}
local sub = {"Ah, claro, un oso panda. Bueno, era parecido a lo que yo había dicho."}

addCharacter(kwkexp, aud, sub)

local sec = {1}
setSecuence( sec )

playScene( "page_47" ) 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
