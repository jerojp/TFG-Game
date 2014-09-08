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

       local curPage = 36 

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
       local kwkfondoPS  
       local kwkexp  
       local kwkesq  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

       -- kwkfondoPS positioning 
       kwkfondoPS = display.newImageRect( imgDir.. "kwkfondops.png", 1280, 800 ); 
       kwkfondoPS.x = 640; kwkfondoPS.y = 400; kwkfondoPS.alpha = 1; kwkfondoPS.oldAlpha = 1 
       kwkfondoPS.oriX = kwkfondoPS.x; kwkfondoPS.oriY = kwkfondoPS.y 
       kwkfondoPS.name = "kwkfondoPS" 
       menuGroup:insert(1,kwkfondoPS); menuGroup.kwkfondoPS = kwkfondoPS 

       -- kwkexp positioning 
       local kwkexp_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=141, height=220 }, -- exploradorEsquimal_00000
               { x=145, y=2, width=141, height=220 }, -- exploradorEsquimal_00001
               { x=288, y=2, width=141, height=220 }, -- exploradorEsquimal_00002
               { x=431, y=2, width=141, height=220 }, -- exploradorEsquimal_00003
               { x=574, y=2, width=141, height=220 }, -- exploradorEsquimal_00004
               { x=717, y=2, width=141, height=220 }, -- exploradorEsquimal_00005
               { x=2, y=224, width=141, height=220 }, -- exploradorEsquimal_00006
               { x=145, y=224, width=141, height=220 }, -- exploradorEsquimal_00007
               { x=288, y=224, width=141, height=220 }, -- exploradorEsquimal_00008
               { x=431, y=224, width=141, height=220 }, -- exploradorEsquimal_00009
               { x=574, y=224, width=141, height=220 }, -- exploradorEsquimal_00010
               { x=717, y=224, width=141, height=220 }, -- exploradorEsquimal_00011
               { x=2, y=446, width=141, height=220 }, -- exploradorEsquimal_00012
               { x=145, y=446, width=141, height=220 }, -- exploradorEsquimal_00013
               { x=288, y=446, width=141, height=220 }, -- exploradorEsquimal_00014
               { x=431, y=446, width=141, height=220 }, -- exploradorEsquimal_00015
               { x=574, y=446, width=141, height=220 }, -- exploradorEsquimal_00016
           },
    
           sheetContentWidth = 860,
           sheetContentHeight = 668
 
       } 
       kwkexp_sheet = graphics.newImageSheet( spriteDir.. "expesquimal.png", kwkexp_options ) 
       kwkexp_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       kwkexp = display.newSprite(kwkexp_sheet, kwkexp_seq ) 
       kwkexp:play(); 
       kwkexp.x = 387; kwkexp.y = 623; kwkexp.alpha = 1; kwkexp.oldAlpha = 1 
       kwkexp.oriX = kwkexp.x; kwkexp.oriY = kwkexp.y 
       kwkexp.name = "kwkexp" 
       menuGroup:insert(kwkexp); menuGroup.kwkexp = kwkexp 

       -- kwkesq positioning 
       local kwkesq_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=140, height=220 }, -- esquimal_00000
               { x=144, y=2, width=140, height=220 }, -- esquimal_00001
               { x=286, y=2, width=140, height=220 }, -- esquimal_00002
               { x=2, y=224, width=140, height=220 }, -- esquimal_00003
               { x=144, y=224, width=140, height=220 }, -- esquimal_00004
               { x=286, y=224, width=140, height=220 }, -- esquimal_00005
               { x=2, y=446, width=140, height=220 }, -- esquimal_00006
               { x=144, y=446, width=140, height=220 }, -- esquimal_00007
               { x=286, y=446, width=140, height=220 }, -- esquimal_00008
           },
    
           sheetContentWidth = 428,
           sheetContentHeight = 668
 
       } 
       kwkesq_sheet = graphics.newImageSheet( spriteDir.. "esquimal.png", kwkesq_options ) 
       kwkesq_seq = { name = "default", start = 1, count = 9, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       kwkesq = display.newSprite(kwkesq_sheet, kwkesq_seq ) 
       kwkesq:play(); 
       kwkesq.x = 641; kwkesq.y = 623; kwkesq.alpha = 1; kwkesq.oldAlpha = 1 
       kwkesq.oriX = kwkesq.x; kwkesq.oriY = kwkesq.y 
       kwkesq.name = "kwkesq" 
       menuGroup:insert(kwkesq); menuGroup.kwkesq = kwkesq 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           kwkexp_sheet = nil; kwkexp = nil 
    kwkesq_sheet = nil; kwkesq = nil 
 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )

kwkexp:pause( )
kwkesq:pause()

_G.Level = 3
_G.Phase = 1

local aud = {"exp_ps2.mp3", "exp_ps3.mp3", "exp_ps4.mp3"}
local sub = {"Hola, soy un explorador en busca de aventuras. He leído que se ha hundido un barco por esta región ¿podrías indicarme el lugar?",
			"Genial, muchas gracias. ¿Donde está tu casa? No la veo.",
			"¿Un iglú?, ¿qué es eso? Yo no veo nada."}

addCharacter(kwkexp, aud, sub)

aud = {"esquimal_1.mp3", "esquimal_2.mp3"}
sub = {"Hola, yo me llamo Anori y vivo aquí al lado. Sé dónde está ese barco pero es muy de noche y es peligroso viajar ahora. Ven a mi casa a pasar la noche y mañana iremos en busca de ese barco.",
	 "Es aquel iglú que ves al fondo."}

addCharacter(kwkesq, aud, sub)

local sec = {1, 2, 1, 2, 1}
setSecuence( sec )

playScene( "page_15" ) 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
