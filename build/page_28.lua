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

       local curPage = 28 

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
       local FondoBrasil  
       local kwkexpf  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level] = curPage 

       -- FondoBrasil positioning 
       FondoBrasil = display.newImageRect( imgDir.. "p28_fondobrasil.png", 1288, 809 ); 
       FondoBrasil.x = 644; FondoBrasil.y = 395; FondoBrasil.alpha = 1; FondoBrasil.oldAlpha = 1 
       FondoBrasil.oriX = FondoBrasil.x; FondoBrasil.oriY = FondoBrasil.y 
       FondoBrasil.name = "FondoBrasil" 
       menuGroup:insert(1,FondoBrasil); menuGroup.FondoBrasil = FondoBrasil 

       -- kwkexpf positioning 
       local kwkexpf_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=143, height=248 }, -- exploradorDisfraz_00000
               { x=147, y=2, width=143, height=248 }, -- exploradorDisfraz_00001
               { x=292, y=2, width=143, height=248 }, -- exploradorDisfraz_00002
               { x=437, y=2, width=143, height=248 }, -- exploradorDisfraz_00003
               { x=582, y=2, width=143, height=248 }, -- exploradorDisfraz_00004
               { x=727, y=2, width=143, height=248 }, -- exploradorDisfraz_00005
               { x=2, y=252, width=143, height=248 }, -- exploradorDisfraz_00006
               { x=147, y=252, width=143, height=248 }, -- exploradorDisfraz_00007
               { x=292, y=252, width=143, height=248 }, -- exploradorDisfraz_00008
               { x=437, y=252, width=143, height=248 }, -- exploradorDisfraz_00009
               { x=582, y=252, width=143, height=248 }, -- exploradorDisfraz_00010
               { x=727, y=252, width=143, height=248 }, -- exploradorDisfraz_00011
               { x=2, y=502, width=143, height=248 }, -- exploradorDisfraz_00012
               { x=147, y=502, width=143, height=248 }, -- exploradorDisfraz_00013
               { x=292, y=502, width=143, height=248 }, -- exploradorDisfraz_00014
               { x=437, y=502, width=143, height=248 }, -- exploradorDisfraz_00015
               { x=582, y=502, width=143, height=248 }, -- exploradorDisfraz_00016
           },
    
           sheetContentWidth = 872,
           sheetContentHeight = 752
 
       } 
       kwkexpf_sheet = graphics.newImageSheet( spriteDir.. "expdisfraz.png", kwkexpf_options ) 
       kwkexpf_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       kwkexpf = display.newSprite(kwkexpf_sheet, kwkexpf_seq ) 
       kwkexpf:play(); 
       kwkexpf.x = 496; kwkexpf.y = 332; kwkexpf.alpha = 1; kwkexpf.oldAlpha = 1 
       kwkexpf.oriX = kwkexpf.x; kwkexpf.oriY = kwkexpf.y 
       kwkexpf.name = "kwkexpf" 
       menuGroup:insert(kwkexpf); menuGroup.kwkexpf = kwkexpf 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           kwkexpf_sheet = nil; kwkexpf = nil 
 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )
gSprites.exp = kwkexpf
kwkexpf:pause( )

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
_G.Subtitle = false
_G.AutoNextPage = true

_G.Level = 1
_G.Phase = 1

local img = display.newImageRect( imgDir.."objeto111.png", 47, 16)
img.x = 485; img.y = 297
menuGroup:insert( img )

local aud = {"exp_br5.mp3"}
local sub = {"!AH! Eso era un antifaz. Bueno pues ya solo tengo que entrar a la tienda a comprarlo. Pero, un momento, para pagar con mi tarejta necesito recordar mi firma. Creo que me firma era como la letra A. Creo que la letra A tiene una forma parecida al tejado de una casa."}

addCharacter(kwkexpf, aud, sub)

local sec = {1}
setSecuence( sec )

playScene( "page_29" ) 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
