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

       local curPage = 25 

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
       local escenarioJefeMu  
       local kwkboss  
       local MapaTumbado  
       local Mesa  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

       -- escenarioJefeMu positioning 
       escenarioJefeMu = display.newImageRect( imgDir.. "p25_escenariojefemu.png", 1280, 800 ); 
       escenarioJefeMu.x = 640; escenarioJefeMu.y = 400; escenarioJefeMu.alpha = 1; escenarioJefeMu.oldAlpha = 1 
       escenarioJefeMu.oriX = escenarioJefeMu.x; escenarioJefeMu.oriY = escenarioJefeMu.y 
       escenarioJefeMu.name = "escenarioJefeMu" 
       menuGroup:insert(1,escenarioJefeMu); menuGroup.escenarioJefeMu = escenarioJefeMu 

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
       kwkboss.x = 491; kwkboss.y = 440; kwkboss.alpha = 1; kwkboss.oldAlpha = 1 
       kwkboss.oriX = kwkboss.x; kwkboss.oriY = kwkboss.y 
       kwkboss.name = "kwkboss" 
       menuGroup:insert(kwkboss); menuGroup.kwkboss = kwkboss 

       -- MapaTumbado positioning 
       MapaTumbado = display.newImageRect( imgDir.. "p25_mapatumbado.png", 149, 53 ); 
       MapaTumbado.x = 565; MapaTumbado.y = 522; MapaTumbado.alpha = 1; MapaTumbado.oldAlpha = 1 
       MapaTumbado.oriX = MapaTumbado.x; MapaTumbado.oriY = MapaTumbado.y 
       MapaTumbado.name = "MapaTumbado" 
       menuGroup:insert(MapaTumbado); menuGroup.MapaTumbado = MapaTumbado 

       -- Mesa positioning 
       Mesa = display.newImageRect( imgDir.. "p25_mesa.png", 850, 280 ); 
       Mesa.x = 584; Mesa.y = 593; Mesa.alpha = 1; Mesa.oldAlpha = 1 
       Mesa.oriX = Mesa.x; Mesa.oriY = Mesa.y 
       Mesa.name = "Mesa" 
       menuGroup:insert(Mesa); menuGroup.Mesa = Mesa 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           kwkboss_sheet = nil; kwkboss = nil 
 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )

kwkboss:pause( )


--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

_G.Level = 1
_G.Phase = 1

local aud = {"jefe_br1.mp3"}
local sub = {"Hola, te he llamado porque me acaban de dar un mapa de un tesoro y quiero que tú intentes encontrarlo. El mapa tiene una marca en forma de cruz sobre la región del río Amazonas en Brasil."}

addCharacter(kwkboss, aud, sub)

aud = {"exp_br1.mp3"}
sub = {"Vale jefe, pongo rumbo a brasil ahora mismo."}

addCharacter(nil, aud, sub)

local sec = {1, 2 }
setSecuence( sec )

local img = {path = imgDir.."mapAntiguo.png", w = 531, h = 707}
local events = { {mytype = "image", value = {1,  img} }, nil }
setEventsControlScene(events)

playScene( "page_26" ) 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
