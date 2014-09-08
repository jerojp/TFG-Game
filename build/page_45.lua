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

       local curPage = 45 

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
       local kwkexp  
       local kwkjap  
       local tablet  
       local kwktablet  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

       -- FondoJapon positioning 
       FondoJapon = display.newImageRect( imgDir.. "p45_fondojapon.png", 1296, 800 ); 
       FondoJapon.x = 640; FondoJapon.y = 400; FondoJapon.alpha = 1; FondoJapon.oldAlpha = 1 
       FondoJapon.oriX = FondoJapon.x; FondoJapon.oriY = FondoJapon.y 
       FondoJapon.name = "FondoJapon" 
       menuGroup:insert(1,FondoJapon); menuGroup.FondoJapon = FondoJapon 

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
       kwkexp_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       kwkexp = display.newSprite(kwkexp_sheet, kwkexp_seq ) 
       kwkexp:play(); 
       kwkexp.x = 391; kwkexp.y = 433; kwkexp.alpha = 1; kwkexp.oldAlpha = 1 
       kwkexp.xScale = 0.7; 
       kwkexp.yScale = 0.7; 
       kwkexp.oriX = kwkexp.x; kwkexp.oriY = kwkexp.y 
       kwkexp.name = "kwkexp" 
       menuGroup:insert(kwkexp); menuGroup.kwkexp = kwkexp 

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
       kwkjap_seq = { name = "default", start = 1, count = 9, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       kwkjap = display.newSprite(kwkjap_sheet, kwkjap_seq ) 
       kwkjap:play(); 
       kwkjap.x = 160; kwkjap.y = 407; kwkjap.alpha = 1; kwkjap.oldAlpha = 1 
       kwkjap.oriX = kwkjap.x; kwkjap.oriY = kwkjap.y 
       kwkjap.name = "kwkjap" 
       menuGroup:insert(kwkjap); menuGroup.kwkjap = kwkjap 

       -- tablet positioning 
       tablet = display.newImageRect( imgDir.. "p45_tablet.png", 17, 41 ); 
       tablet.x = 368; tablet.y = 468; tablet.alpha = 1; tablet.oldAlpha = 1 
       tablet.oriX = tablet.x; tablet.oriY = tablet.y 
       tablet.name = "tablet" 
       menuGroup:insert(tablet); menuGroup.tablet = tablet 

       -- kwktablet positioning 
       local kwktablet_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=46, height=82 }, -- Tablethumo_00000
               { x=50, y=2, width=46, height=82 }, -- Tablethumo_00001
               { x=98, y=2, width=46, height=82 }, -- Tablethumo_00002
               { x=146, y=2, width=46, height=82 }, -- Tablethumo_00003
               { x=194, y=2, width=46, height=82 }, -- Tablethumo_00004
               { x=2, y=86, width=46, height=82 }, -- Tablethumo_00005
               { x=50, y=86, width=46, height=82 }, -- Tablethumo_00006
               { x=98, y=86, width=46, height=82 }, -- Tablethumo_00007
               { x=146, y=86, width=46, height=82 }, -- Tablethumo_00008
           },
    
           sheetContentWidth = 242,
           sheetContentHeight = 170
 
       } 
       kwktablet_sheet = graphics.newImageSheet( spriteDir.. "tablethumo.png", kwktablet_options ) 
       kwktablet_seq = { name = "default", start = 1, count = 9, time = 1000, loopCount = 0, loopDirection = "forward" }; 
       kwktablet = display.newSprite(kwktablet_sheet, kwktablet_seq ) 
       kwktablet:play(); 
       kwktablet.x = 368; kwktablet.y = 448; kwktablet.alpha = 1; kwktablet.oldAlpha = 1 
       kwktablet.oriX = kwktablet.x; kwktablet.oriY = kwktablet.y 
       kwktablet.name = "kwktablet" 
       menuGroup:insert(kwktablet); menuGroup.kwktablet = kwktablet 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           kwkexp_sheet = nil; kwkexp = nil 
    kwkjap_sheet = nil; kwkjap = nil 
    kwktablet_sheet = nil; kwktablet = nil 
 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )

kwkexp:pause( )
kwkjap:pause( )

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

_G.Level = 4
_G.Phase = 1

local function changeAlpha( fun )
	-- body
	kwktablet:pause( )
	kwktablet.alpha = 0
	fun(300)
end

local aud = {"exp_ja3.mp3", "exp_ja4.mp3", "exp_ja5.mp3"}
local sub = {"!Hola! Sakura, me alegro de verte.",
			"¿Puedes ayudarme a reparar mi tablet?",
			"Claro, en marcha. La caza de animales debería estar prohibida. Pero antes de salir quiero asegurarme. ¿Un oso panda es es esto? Nunca he visto uno."}

addCharacter(kwkexp, aud, sub)

local aud2 = {"sakura_ja1.mp3", "sakura_ja2.mp3", "sakura_ja3.mp3"}
local sub2 = {"Hola, yo también me alegro.",
			 "Ya está arreglada. Ahora necesito tu ayuda para rescatar al oso panda secuestrado por unos cazadores furtivos.",
			 "No eso es un koala. Un oso panda es un oso de color blanco y negro. Su nombre empieza por la letra O."}

addCharacter(kwkjap, aud2, sub2)

local sec = {1, 2, 1, 2, 1, 2}
setSecuence( sec )

local events = { nil, nil, {mytype = "effects", value = {1, changeAlpha} }, nil, nil, nil }
setEventsControlScene(events)

playScene( "page_15" ) 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
