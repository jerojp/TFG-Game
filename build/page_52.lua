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

       local curPage = 52 
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
       local FodoChina  
       local kwkexp  
       local kwkjaponesa  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

       -- FodoChina positioning 
       FodoChina = display.newImageRect( imgDir.. "p52_fodochina.png", 1280, 808 ); 
       FodoChina.x = 640; FodoChina.y = 396; FodoChina.alpha = 1; FodoChina.oldAlpha = 1 
       FodoChina.oriX = FodoChina.x; FodoChina.oriY = FodoChina.y 
       FodoChina.name = "FodoChina" 
       menuGroup:insert(1,FodoChina); menuGroup.FodoChina = FodoChina 

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
       kwkexp.x = 416; kwkexp.y = 657; kwkexp.alpha = 1; kwkexp.oldAlpha = 1 
       kwkexp.xScale = 0.7; 
       kwkexp.yScale = 0.7; 
       kwkexp.oriX = kwkexp.x; kwkexp.oriY = kwkexp.y 
       kwkexp.name = "kwkexp" 
       menuGroup:insert(kwkexp); menuGroup.kwkexp = kwkexp 

       -- kwkjaponesa positioning 
       kwkjaponesa = display.newImageRect( imgDir.. "kwkjaponesa.png", 258, 360 ); 
       kwkjaponesa.x = 160; kwkjaponesa.y = 601; kwkjaponesa.alpha = 1; kwkjaponesa.oldAlpha = 1 
       kwkjaponesa.oriX = kwkjaponesa.x; kwkjaponesa.oriY = kwkjaponesa.y 
       kwkjaponesa.name = "kwkjaponesa" 
       menuGroup:insert(kwkjaponesa); menuGroup.kwkjaponesa = kwkjaponesa 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           kwkexp_sheet = nil; kwkexp = nil 
 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )
require("viewGenius")

kwkexp:pause( )

local gpGenius = createGenius( )
gpGenius:scale( 0.3, 0.3 )
gpGenius:translate( display.contentWidth - (gpGenius.Tablet.contentWidth*1.85) , display.contentHeight - (gpGenius.Tablet.contentHeight *1.10) )
gpGenius.alpha = 0
menuGroup:insert( gpGenius )
gpGenius.genius:pause( )

_G.Level = 4
_G.Phase = 2

local aud = {"exp_ja19.mp3"}
local sub = {"Estoy muy agusto aquí, pero es hora de irse. Voy a tomar una foto antes de irnos a los osos panda."}

addCharacter(kwkexp, aud, sub)

local aud = {"genio_oFoto.mp3"}
local sub = {"Escribe la letra O para poder tomar la foto."}

addCharacter(gpGenius.genius, aud, sub)

local sec = {1, 2}
setSecuence( sec )

playScene( "page_49" ) 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
