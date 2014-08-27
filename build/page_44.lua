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

       local curPage = 44 

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
       local kwkexphumo  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level] = curPage 

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
             
               { x=2, y=2, width=86, height=220 }, -- exploradorTabletRota_00000
               { x=90, y=2, width=86, height=220 }, -- exploradorTabletRota_00001
               { x=178, y=2, width=86, height=220 }, -- exploradorTabletRota_00002
               { x=266, y=2, width=86, height=220 }, -- exploradorTabletRota_00003
               { x=354, y=2, width=86, height=220 }, -- exploradorTabletRota_00004
               { x=2, y=224, width=86, height=220 }, -- exploradorTabletRota_00005
               { x=90, y=224, width=86, height=220 }, -- exploradorTabletRota_00006
               { x=178, y=224, width=86, height=220 }, -- exploradorTabletRota_00007
               { x=266, y=224, width=86, height=220 }, -- exploradorTabletRota_00008
               { x=354, y=224, width=86, height=220 }, -- exploradorTabletRota_00009
               { x=2, y=446, width=86, height=220 }, -- exploradorTabletRota_00010
               { x=90, y=446, width=86, height=220 }, -- exploradorTabletRota_00011
               { x=178, y=446, width=86, height=220 }, -- exploradorTabletRota_00012
               { x=266, y=446, width=86, height=220 }, -- exploradorTabletRota_00013
               { x=354, y=446, width=86, height=220 }, -- exploradorTabletRota_00014
               { x=2, y=668, width=86, height=220 }, -- exploradorTabletRota_00015
               { x=90, y=668, width=86, height=220 }, -- exploradorTabletRota_00016
           },
    
           sheetContentWidth = 442,
           sheetContentHeight = 890
 
       } 
       kwkexp_sheet = graphics.newImageSheet( spriteDir.. "tabletrota.png", kwkexp_options ) 
       kwkexp_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       kwkexp = display.newSprite(kwkexp_sheet, kwkexp_seq ) 
       kwkexp:play(); 
       kwkexp.x = 829; kwkexp.y = 448; kwkexp.alpha = 1; kwkexp.oldAlpha = 1 
       kwkexp.oriX = kwkexp.x; kwkexp.oriY = kwkexp.y 
       kwkexp.name = "kwkexp" 
       menuGroup:insert(kwkexp); menuGroup.kwkexp = kwkexp 

       -- kwkexphumo positioning 
       local kwkexphumo_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=86, height=220 }, -- exploradorTabletRotaHumo_00000
               { x=90, y=2, width=86, height=220 }, -- exploradorTabletRotaHumo_00001
               { x=178, y=2, width=86, height=220 }, -- exploradorTabletRotaHumo_00002
               { x=266, y=2, width=86, height=220 }, -- exploradorTabletRotaHumo_00003
               { x=354, y=2, width=86, height=220 }, -- exploradorTabletRotaHumo_00004
               { x=2, y=224, width=86, height=220 }, -- exploradorTabletRotaHumo_00005
               { x=90, y=224, width=86, height=220 }, -- exploradorTabletRotaHumo_00006
               { x=178, y=224, width=86, height=220 }, -- exploradorTabletRotaHumo_00007
               { x=266, y=224, width=86, height=220 }, -- exploradorTabletRotaHumo_00008
               { x=354, y=224, width=86, height=220 }, -- exploradorTabletRotaHumo_00009
               { x=2, y=446, width=86, height=220 }, -- exploradorTabletRotaHumo_00010
               { x=90, y=446, width=86, height=220 }, -- exploradorTabletRotaHumo_00011
               { x=178, y=446, width=86, height=220 }, -- exploradorTabletRotaHumo_00012
               { x=266, y=446, width=86, height=220 }, -- exploradorTabletRotaHumo_00013
               { x=354, y=446, width=86, height=220 }, -- exploradorTabletRotaHumo_00014
               { x=2, y=668, width=86, height=220 }, -- exploradorTabletRotaHumo_00015
               { x=90, y=668, width=86, height=220 }, -- exploradorTabletRotaHumo_00016
           },
    
           sheetContentWidth = 442,
           sheetContentHeight = 890
 
       } 
       kwkexphumo_sheet = graphics.newImageSheet( spriteDir.. "exptabletrotahumo.png", kwkexphumo_options ) 
       kwkexphumo_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "forward" }; 
       kwkexphumo = display.newSprite(kwkexphumo_sheet, kwkexphumo_seq ) 
       kwkexphumo:play(); 
       kwkexphumo.x = 829; kwkexphumo.y = 448; kwkexphumo.alpha = 1; kwkexphumo.oldAlpha = 1 
       kwkexphumo.oriX = kwkexphumo.x; kwkexphumo.oriY = kwkexphumo.y 
       kwkexphumo.name = "kwkexphumo" 
       menuGroup:insert(kwkexphumo); menuGroup.kwkexphumo = kwkexphumo 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           kwkexp_sheet = nil; kwkexp = nil 
    kwkexphumo_sheet = nil; kwkexphumo = nil 
 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )
gSprites.exp = kwkexp
kwkexp:pause( )
kwkexphumo:pause( )
kwkexphumo.alpha = 0

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

_G.Level = 4
_G.Phase = 1

local function changeAlpha( fun )
	-- body
	kwkexp.alpha = 0
	kwkexphumo.alpha = 1
	fun(300)
end

local aud = {"exp_ja1.mp3"}
local sub = {"!Qué lastima!, un oso panda ha sido secuestrado para venderlo. No puedo permitirlo hay que rescatarlo, los animales deben vivir en libertad."}

addCharacter(kwkexp, aud, sub)

local aud2 = {"exp_ja2.mp3"}
local sub2 = {"!No! La tablet se ha roto. Espero que el Ali esté bien. Debe viajar rápido a Japón para poder arreglarla."}

addCharacter(kwkexphumo, aud2, sub2)

local sec = {1, 2}
setSecuence( sec )

local events = { {mytype = "effects", value = {1, changeAlpha} }, nil }
setEventsControlScene(events)

playScene( "page_45" ) 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
