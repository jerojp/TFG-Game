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

       local curPage = 33 

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
       local fondoBrasilBosq  
       local kwkexplora  
       local kwksamin  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level] = curPage 

       -- fondoBrasilBosq positioning 
       fondoBrasilBosq = display.newImageRect( imgDir.. "p33_fondobrasilbosq.png", 1298, 800 ); 
       fondoBrasilBosq.x = 641; fondoBrasilBosq.y = 400; fondoBrasilBosq.alpha = 1; fondoBrasilBosq.oldAlpha = 1 
       fondoBrasilBosq.oriX = fondoBrasilBosq.x; fondoBrasilBosq.oriY = fondoBrasilBosq.y 
       fondoBrasilBosq.name = "fondoBrasilBosq" 
       menuGroup:insert(1,fondoBrasilBosq); menuGroup.fondoBrasilBosq = fondoBrasilBosq 

       -- kwkexplora positioning 
       kwkexplora = display.newImageRect( imgDir.. "kwkexplora.png", 140, 220 ); 
       kwkexplora.x = 126; kwkexplora.y = 572; kwkexplora.alpha = 1; kwkexplora.oldAlpha = 1 
       kwkexplora.oriX = kwkexplora.x; kwkexplora.oriY = kwkexplora.y 
       kwkexplora.name = "kwkexplora" 
       menuGroup:insert(kwkexplora); menuGroup.kwkexplora = kwkexplora 

       -- kwksamin positioning 
       local kwksamin_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=179, height=336 }, -- inca_00000
               { x=183, y=2, width=179, height=336 }, -- inca_00001
               { x=364, y=2, width=179, height=336 }, -- inca_00002
               { x=545, y=2, width=179, height=336 }, -- inca_00003
               { x=726, y=2, width=179, height=336 }, -- inca_00004
               { x=2, y=340, width=179, height=336 }, -- inca_00005
               { x=183, y=340, width=179, height=336 }, -- inca_00006
               { x=364, y=340, width=179, height=336 }, -- inca_00007
               { x=545, y=340, width=179, height=336 }, -- inca_00008
               { x=726, y=340, width=179, height=336 }, -- inca_00009
               { x=2, y=678, width=179, height=336 }, -- inca_00010
               { x=183, y=678, width=179, height=336 }, -- inca_00011
               { x=364, y=678, width=179, height=336 }, -- inca_00012
               { x=545, y=678, width=179, height=336 }, -- inca_00013
               { x=726, y=678, width=179, height=336 }, -- inca_00014
               { x=2, y=1016, width=179, height=336 }, -- inca_00015
               { x=183, y=1016, width=179, height=336 }, -- inca_00016
           },
    
           sheetContentWidth = 907,
           sheetContentHeight = 1354
 
       } 
       kwksamin_sheet = graphics.newImageSheet( spriteDir.. "inca.png", kwksamin_options ) 
       kwksamin_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       kwksamin = display.newSprite(kwksamin_sheet, kwksamin_seq ) 
       kwksamin:play(); 
       kwksamin.x = 362; kwksamin.y = 514; kwksamin.alpha = 1; kwksamin.oldAlpha = 1 
       kwksamin.oriX = kwksamin.x; kwksamin.oriY = kwksamin.y 
       kwksamin.name = "kwksamin" 
       menuGroup:insert(kwksamin); menuGroup.kwksamin = kwksamin 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           kwksamin_sheet = nil; kwksamin = nil 
 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )

kwksamin:pause()

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

_G.Level = 1
_G.Phase = 2

local aud = {"samin_br3.mp3"}
local sub = {"Ah, se me olvidó decirte que debes escribir la letra A sobre la roca para activar la trampa."}

addCharacter(kwksamin, aud, sub)

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
