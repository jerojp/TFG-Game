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

       local curPage = 16 
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
       local kwksnowylandsca  
       local explSkier  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

       -- kwksnowylandsca positioning 
       kwksnowylandsca = display.newImageRect( imgDir.. "kwksnowylandsca.png", 1280, 799 ); 
       kwksnowylandsca.x = 640; kwksnowylandsca.y = 399; kwksnowylandsca.alpha = 1; kwksnowylandsca.oldAlpha = 1 
       kwksnowylandsca.oriX = kwksnowylandsca.x; kwksnowylandsca.oriY = kwksnowylandsca.y 
       kwksnowylandsca.name = "kwksnowylandsca" 
       menuGroup:insert(1,kwksnowylandsca); menuGroup.kwksnowylandsca = kwksnowylandsca 

       -- explSkier positioning 
       local explSkier_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=192, height=219 }, -- ExploradorEsquando_00000
               { x=196, y=2, width=192, height=219 }, -- ExploradorEsquando_00001
               { x=390, y=2, width=192, height=219 }, -- ExploradorEsquando_00002
               { x=584, y=2, width=192, height=219 }, -- ExploradorEsquando_00003
               { x=778, y=2, width=192, height=219 }, -- ExploradorEsquando_00004
               { x=2, y=223, width=192, height=219 }, -- ExploradorEsquando_00005
               { x=196, y=223, width=192, height=219 }, -- ExploradorEsquando_00006
               { x=390, y=223, width=192, height=219 }, -- ExploradorEsquando_00007
               { x=584, y=223, width=192, height=219 }, -- ExploradorEsquando_00008
               { x=778, y=223, width=192, height=219 }, -- ExploradorEsquando_00009
               { x=2, y=444, width=192, height=219 }, -- ExploradorEsquando_00010
               { x=196, y=444, width=192, height=219 }, -- ExploradorEsquando_00011
               { x=390, y=444, width=192, height=219 }, -- ExploradorEsquando_00012
               { x=584, y=444, width=192, height=219 }, -- ExploradorEsquando_00013
               { x=778, y=444, width=192, height=219 }, -- ExploradorEsquando_00014
               { x=2, y=665, width=192, height=219 }, -- ExploradorEsquando_00015
               { x=196, y=665, width=192, height=219 }, -- ExploradorEsquando_00016
           },
    
           sheetContentWidth = 972,
           sheetContentHeight = 886
 
       } 
       explSkier_sheet = graphics.newImageSheet( spriteDir.. "expesquiando.png", explSkier_options ) 
       explSkier_seq = { name = "default", start = 1, count = 16, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       explSkier = display.newSprite(explSkier_sheet, explSkier_seq ) 
       explSkier:play(); 
       explSkier.x = 608; explSkier.y = 618; explSkier.alpha = 1; explSkier.oldAlpha = 1 
       explSkier.oriX = explSkier.x; explSkier.oriY = explSkier.y 
       explSkier.name = "explSkier" 
       menuGroup:insert(explSkier); menuGroup.explSkier = explSkier 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           explSkier_sheet = nil; explSkier = nil 
 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )
require("viewGenius")

explSkier:pause( )

local gpGenius = createGenius( )
gpGenius:scale( 0.3, 0.3 )
gpGenius:translate( display.contentWidth - (gpGenius.Tablet.contentWidth*1.85) , display.contentHeight - (gpGenius.Tablet.contentHeight *1.10) )
gpGenius.alpha = 0
menuGroup:insert( gpGenius )
gpGenius.genius:pause( )

_G.Level = 2
_G.Phase = 1

local aud = {"exp_sz5.mp3"}
local sub = {"A ver si recuerdo cómo se llega a la casa de Eli. Pero antes debería parar en un pueblo cercano a su casa para realizar algunas compras."}

addCharacter(explSkier, aud, sub)

local aud = {"genio_eGPS.mp3"}
local sub = {"No te preocupes escribe la letra E para activar el gps de tu tablet, así no te perderás."}

addCharacter(gpGenius.genius, aud, sub)

local sec = {1, 2}
setSecuence( sec )

playScene( "page_17" ) 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
