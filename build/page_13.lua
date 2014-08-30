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

       local curPage = 13 

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
       local kwkrectangleW  
       local expCall  
       local girlCall  
       local Forma_1  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level] = curPage 

       -- kwkrectangleW positioning 
       kwkrectangleW = display.newImageRect( imgDir.. "kwkrectanglew.png", 1280, 800 ); 
       kwkrectangleW.x = 640; kwkrectangleW.y = 400; kwkrectangleW.alpha = 1; kwkrectangleW.oldAlpha = 1 
       kwkrectangleW.oriX = kwkrectangleW.x; kwkrectangleW.oriY = kwkrectangleW.y 
       kwkrectangleW.name = "kwkrectangleW" 
       menuGroup:insert(1,kwkrectangleW); menuGroup.kwkrectangleW = kwkrectangleW 

       -- expCall positioning 
       local expCall_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=380, height=700 }, -- Llamada2_00000
               { x=384, y=2, width=380, height=700 }, -- Llamada2_00001
               { x=766, y=2, width=380, height=700 }, -- Llamada2_00002
               { x=1148, y=2, width=380, height=700 }, -- Llamada2_00003
               { x=1530, y=2, width=380, height=700 }, -- Llamada2_00004
               { x=1912, y=2, width=380, height=700 }, -- Llamada2_00005
               { x=2294, y=2, width=380, height=700 }, -- Llamada2_00006
               { x=2676, y=2, width=380, height=700 }, -- Llamada2_00007
               { x=3058, y=2, width=380, height=700 }, -- Llamada2_00008
               { x=2, y=704, width=380, height=700 }, -- Llamada2_00009
               { x=384, y=704, width=380, height=700 }, -- Llamada2_00010
               { x=766, y=704, width=380, height=700 }, -- Llamada2_00011
               { x=1148, y=704, width=380, height=700 }, -- Llamada2_00012
               { x=1530, y=704, width=380, height=700 }, -- Llamada2_00013
               { x=1912, y=704, width=380, height=700 }, -- Llamada2_00014
               { x=2294, y=704, width=380, height=700 }, -- Llamada2_00015
               { x=2676, y=704, width=380, height=700 }, -- Llamada2_00016
           },
    
           sheetContentWidth = 3440,
           sheetContentHeight = 1406
 
       } 
       expCall_sheet = graphics.newImageSheet( spriteDir.. "llamadachico.png", expCall_options ) 
       expCall_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       expCall = display.newSprite(expCall_sheet, expCall_seq ) 
       expCall:play(); 
       expCall.x = 333; expCall.y = 450; expCall.alpha = 1; expCall.oldAlpha = 1 
       expCall.oriX = expCall.x; expCall.oriY = expCall.y 
       expCall.name = "expCall" 
       menuGroup:insert(expCall); menuGroup.expCall = expCall 

       -- girlCall positioning 
       local girlCall_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=380, height=700 }, -- Llamada-chica_00000
               { x=384, y=2, width=380, height=700 }, -- Llamada-chica_00001
               { x=766, y=2, width=380, height=700 }, -- Llamada-chica_00002
               { x=1148, y=2, width=380, height=700 }, -- Llamada-chica_00003
               { x=1530, y=2, width=380, height=700 }, -- Llamada-chica_00004
               { x=1912, y=2, width=380, height=700 }, -- Llamada-chica_00005
               { x=2294, y=2, width=380, height=700 }, -- Llamada-chica_00006
               { x=2676, y=2, width=380, height=700 }, -- Llamada-chica_00007
               { x=3058, y=2, width=380, height=700 }, -- Llamada-chica_00008
               { x=2, y=704, width=380, height=700 }, -- Llamada-chica_00009
               { x=384, y=704, width=380, height=700 }, -- Llamada-chica_00010
               { x=766, y=704, width=380, height=700 }, -- Llamada-chica_00011
               { x=1148, y=704, width=380, height=700 }, -- Llamada-chica_00012
               { x=1530, y=704, width=380, height=700 }, -- Llamada-chica_00013
               { x=1912, y=704, width=380, height=700 }, -- Llamada-chica_00014
               { x=2294, y=704, width=380, height=700 }, -- Llamada-chica_00015
               { x=2676, y=704, width=380, height=700 }, -- Llamada-chica_00016
           },
    
           sheetContentWidth = 3440,
           sheetContentHeight = 1406
 
       } 
       girlCall_sheet = graphics.newImageSheet( spriteDir.. "llamadachica.png", girlCall_options ) 
       girlCall_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "forward" }; 
       girlCall = display.newSprite(girlCall_sheet, girlCall_seq ) 
       girlCall:play(); 
       girlCall.x = 1009; girlCall.y = 450; girlCall.alpha = 1; girlCall.oldAlpha = 1 
       girlCall.oriX = girlCall.x; girlCall.oriY = girlCall.y 
       girlCall.name = "girlCall" 
       menuGroup:insert(girlCall); menuGroup.girlCall = girlCall 

       -- Forma_1 positioning 
       Forma_1 = display.newImageRect( imgDir.. "p13_forma_1.png", 4, 800 ); 
       Forma_1.x = 663; Forma_1.y = 400; Forma_1.alpha = 1; Forma_1.oldAlpha = 1 
       Forma_1.oriX = Forma_1.x; Forma_1.oriY = Forma_1.y 
       Forma_1.name = "Forma_1" 
       menuGroup:insert(Forma_1); menuGroup.Forma_1 = Forma_1 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           expCall_sheet = nil; expCall = nil 
    girlCall_sheet = nil; girlCall = nil 
 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )

girlCall:pause( )
expCall:pause()


local aud = {"exp_sz1.mp3", "exp_sz2.mp3", "exp_sz3.mp3"}
local sub = {"!Hola! ¿Quién es?",
			"Hola Eli, estoy fenomenal, ¿y tu?",
			"Ahora mismo me pongo en marcha hacia Suiza. Adiós y gracias por avisarme."}

addCharacter(expCall, aud, sub)

aud = {"eli_1.mp3", "eli_2.mp3"}
sub = {"Hola, soy Eli tu amiga de la infancia en Suiza. ¿Cómo estás?",
	  "Muy bien, te llamo porque creo que he encontrado algo muy valioso y me he enterado que te has convertido en un explorador. ¿Podrías pasarte por mi casa en Suiza para analizarlo? Ahora vivo en los Alpes Suizos, trae ropa de abrigo porque hace frío."}

addCharacter(girlCall, aud, sub)

local sec = {1, 2, 1, 2, 1 }
setSecuence( sec )

playScene( "page_14" ) 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
