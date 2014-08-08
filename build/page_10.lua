-- Code created by Kwik - Copyright: kwiksher.com 
-- Version: 2.7.6b 
module(..., package.seeall) 

function new() 
    local numPages = 64 
    local menuGroup = display.newGroup() 
    local dispose 
    local _W = display.contentWidth; 
    local _H = display.contentHeight; 

    local drawScreen = function() 

       local curPage = 10 

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
       local rectWh  
       local kwkcoin  
       local kwktextcoin  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 

       -- rectWh positioning 
       rectWh = display.newImageRect( imgDir.. "p10_rectwh.png", 1280, 800 ); 
       rectWh.x = 640; rectWh.y = 400; rectWh.alpha = 1; rectWh.oldAlpha = 1 
       rectWh.oriX = rectWh.x; rectWh.oriY = rectWh.y 
       rectWh.name = "rectWh" 
       menuGroup:insert(1,rectWh); menuGroup.rectWh = rectWh 

       -- kwkcoin positioning 
       kwkcoin = display.newImageRect( imgDir.. "kwkcoin.png", 72, 67 ); 
       kwkcoin.x = 63; kwkcoin.y = 48; kwkcoin.alpha = 1; kwkcoin.oldAlpha = 1 
       kwkcoin.oriX = kwkcoin.x; kwkcoin.oriY = kwkcoin.y 
       kwkcoin.name = "kwkcoin" 
       menuGroup:insert(kwkcoin); menuGroup.kwkcoin = kwkcoin 

       -- kwktextcoin positioning 
       kwktextcoin = display.newImageRect( imgDir.. "kwktextcoin.png", 71, 32 ); 
       kwktextcoin.x = 148; kwktextcoin.y = 49; kwktextcoin.alpha = 1; kwktextcoin.oldAlpha = 1 
       kwktextcoin.oriX = kwktextcoin.x; kwktextcoin.oriY = kwktextcoin.y 
       kwktextcoin.name = "kwktextcoin" 
       menuGroup:insert(kwktextcoin); menuGroup.kwktextcoin = kwktextcoin 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )
require("viewGenius")

local gpGenius = createGenius( )

menuGroup:insert( gpGenius )
gpGenius.genius:pause( )

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
_G.Subtitle = false
_G.AutoNextPage = true

local aud = {"genio_1.mp3", "genio_2.mp3", "genio_3.mp3", "genio_4.mp3"}
local sub = {"Hola, soy el genio mágico Ali encerrado en esta tablet mágica. ¿Que puedo hacer por ti?",
			"Sí. es cierto, pero yo soy un genio moderno. Así que un explorador..., creo que puedo ayudarte, tengo por aquí un mapa misterioso con el que podrás encontrar algunos tesoros. He oído antes que el Jefe te pagará cada vez que descubras un nuevo tesoro, yo me encargaré de que te llegue el dinero. Cuando tengas suficientes monedas te podré conseguir juguetes mágicos como estos",
			"Este es el mapa que te ha enviado el jefe para tu aventura. Tiene todos los lugares a donde puedes viajar para conseguir todos los tesoros. Si consigues viajar a todos estos lugares y encontrar todos los tesoros te recompensaré con un pergamino de oro. Este pergamino mágico es el mapa de una región oculta hasta el momento y muy misteriosa.",
			"¿Bueno, por dónde quieres comenzar tu aventura?"}

local images = {-1, -1, {0, imgDir.."continentes.jpg"}, -1}

addCharacter(gpGenius.genius, aud, sub, images)
images = nil

aud = {"exp_2.mp3", "exp_3.mp3"}
sub = {"!Qué sorpresa, un genio! Yo acabo de convertirme en explorador y deseo viajar por todo el mundo para buscar tesoros ocultos. Pero una pregunta, ¿los genios no estáis siempre escondidos en una lámpara?.",
	  "!Genial! Muchas gracias genio."}

addCharacter(nil, aud, sub)

local sec = {1, 2, 1, 2, 1, 1 }
setSecuence( sec )

playScene( "page_11" )
 


    end 
    drawScreen() 

    return menuGroup 
end 
