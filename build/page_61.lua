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

       local curPage = 61 

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
       local kwkFondoAfrica  
       local kwkexp  
       local kwkafr  
       local kwktruckt  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level] = curPage 

       -- kwkFondoAfrica positioning 
       kwkFondoAfrica = display.newImageRect( imgDir.. "kwkfondoafrica.png", 1280, 800 ); 
       kwkFondoAfrica.x = 640; kwkFondoAfrica.y = 400; kwkFondoAfrica.alpha = 1; kwkFondoAfrica.oldAlpha = 1 
       kwkFondoAfrica.oriX = kwkFondoAfrica.x; kwkFondoAfrica.oriY = kwkFondoAfrica.y 
       kwkFondoAfrica.name = "kwkFondoAfrica" 
       menuGroup:insert(1,kwkFondoAfrica); menuGroup.kwkFondoAfrica = kwkFondoAfrica 

       -- kwkexp positioning 
       local kwkexp_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=141, height=220 }, -- exploradorNormal_00000
               { x=145, y=2, width=141, height=220 }, -- exploradorNormal_00001
               { x=288, y=2, width=141, height=220 }, -- exploradorNormal_00002
               { x=431, y=2, width=141, height=220 }, -- exploradorNormal_00003
               { x=574, y=2, width=141, height=220 }, -- exploradorNormal_00004
               { x=717, y=2, width=141, height=220 }, -- exploradorNormal_00005
               { x=2, y=224, width=141, height=220 }, -- exploradorNormal_00006
               { x=145, y=224, width=141, height=220 }, -- exploradorNormal_00007
               { x=288, y=224, width=141, height=220 }, -- exploradorNormal_00008
               { x=431, y=224, width=141, height=220 }, -- exploradorNormal_00009
               { x=574, y=224, width=141, height=220 }, -- exploradorNormal_00010
               { x=717, y=224, width=141, height=220 }, -- exploradorNormal_00011
               { x=2, y=446, width=141, height=220 }, -- exploradorNormal_00012
               { x=145, y=446, width=141, height=220 }, -- exploradorNormal_00013
               { x=288, y=446, width=141, height=220 }, -- exploradorNormal_00014
               { x=431, y=446, width=141, height=220 }, -- exploradorNormal_00015
               { x=574, y=446, width=141, height=220 }, -- exploradorNormal_00016
           },
    
           sheetContentWidth = 860,
           sheetContentHeight = 668
 
       } 
       kwkexp_sheet = graphics.newImageSheet( spriteDir.. "exploradorhabla.png", kwkexp_options ) 
       kwkexp_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "forward" }; 
       kwkexp = display.newSprite(kwkexp_sheet, kwkexp_seq ) 
       kwkexp:play(); 
       kwkexp.x = 1016; kwkexp.y = 618; kwkexp.alpha = 1; kwkexp.oldAlpha = 1 
       kwkexp.oriX = kwkexp.x; kwkexp.oriY = kwkexp.y 
       kwkexp.name = "kwkexp" 
       menuGroup:insert(kwkexp); menuGroup.kwkexp = kwkexp 

       -- kwkafr positioning 
       local kwkafr_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=157, height=229 }, -- africana_00000
               { x=161, y=2, width=157, height=229 }, -- africana_00001
               { x=320, y=2, width=157, height=229 }, -- africana_00002
               { x=479, y=2, width=157, height=229 }, -- africana_00003
               { x=638, y=2, width=157, height=229 }, -- africana_00004
               { x=797, y=2, width=157, height=229 }, -- africana_00005
               { x=2, y=233, width=157, height=229 }, -- africana_00006
               { x=161, y=233, width=157, height=229 }, -- africana_00007
               { x=320, y=233, width=157, height=229 }, -- africana_00008
               { x=479, y=233, width=157, height=229 }, -- africana_00009
               { x=638, y=233, width=157, height=229 }, -- africana_00010
               { x=797, y=233, width=157, height=229 }, -- africana_00011
               { x=2, y=464, width=157, height=229 }, -- africana_00012
               { x=161, y=464, width=157, height=229 }, -- africana_00013
               { x=320, y=464, width=157, height=229 }, -- africana_00014
               { x=479, y=464, width=157, height=229 }, -- africana_00015
               { x=638, y=464, width=157, height=229 }, -- africana_00016
           },
    
           sheetContentWidth = 956,
           sheetContentHeight = 695
 
       } 
       kwkafr_sheet = graphics.newImageSheet( spriteDir.. "africana.png", kwkafr_options ) 
       kwkafr_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "forward" }; 
       kwkafr = display.newSprite(kwkafr_sheet, kwkafr_seq ) 
       kwkafr:play(); 
       kwkafr.x = 813; kwkafr.y = 627; kwkafr.alpha = 1; kwkafr.oldAlpha = 1 
       kwkafr.oriX = kwkafr.x; kwkafr.oriY = kwkafr.y 
       kwkafr.name = "kwkafr" 
       menuGroup:insert(kwkafr); menuGroup.kwkafr = kwkafr 

       -- kwktruckt positioning 
       kwktruckt = display.newImageRect( imgDir.. "kwktruckt.png", 608, 363 ); 
       kwktruckt.x = 304; kwktruckt.y = 579; kwktruckt.alpha = 1; kwktruckt.oldAlpha = 1 
       kwktruckt.oriX = kwktruckt.x; kwktruckt.oriY = kwktruckt.y 
       kwktruckt.name = "kwktruckt" 
       menuGroup:insert(kwktruckt); menuGroup.kwktruckt = kwktruckt 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           kwkexp_sheet = nil; kwkexp = nil 
    kwkafr_sheet = nil; kwkafr = nil 
 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )

kwkexp:pause( )
kwkafr:pause( )

_G.Level = 5
_G.Phase = 2

local aud = {"exp_afr10.mp3", "exp_afr11.mp3", "exp_afr12.mp3"}
local sub = {"Nuestra misión aquí ha finalizado.",
			"Sí, merece la pena verlos sonreir. Todos los niños que tienen juguetes deberían donarlos cuando ya no los necesiten.",
			"Gracias por el regalo. Bueno, debemos marcharnos, os volveremos a visitar pronto."}

addCharacter(kwkexp, aud, sub)

aud = {"sira_5.mp3", "sira_6.mp3"}
sub = {"Gracias otra vez, los niños se han puesto muy contentos.",
	  "Tienes razón, aquí los más pequeños no tienen nada con lo que jugar porque no se pueden comprar ni un caramelo. Toma este collar que he hecho yo misma como recompensa."}
addCharacter(kwkafr, aud, sub)

aud = {"genius_afr1.mp3"}
sub = {"!Qué collar más bonito!, esto vale una fortuna."}
addCharacter(nil, aud, sub)

local sec = {1, 2, 1, 2, 3, 1}

setSecuence( sec )

local parameters = {nameToy="Unicornio", pathToy="objeto552.png", costToy=_G.PriceToys.unicorn, widthToy = 254*1.5 , heightToy = 131*1.5, nextPage = "page_11", indexToy = 10}

playScene( "viewNewToy", parameters ) 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
