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

       local curPage = 50 

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
       local FondoJaulaOso  
       local bear  
       local cell  
       local cellBar  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

       -- FondoJaulaOso positioning 
       FondoJaulaOso = display.newImageRect( imgDir.. "p50_fondojaulaoso.png", 1288, 809 ); 
       FondoJaulaOso.x = 637; FondoJaulaOso.y = 404; FondoJaulaOso.alpha = 1; FondoJaulaOso.oldAlpha = 1 
       FondoJaulaOso.oriX = FondoJaulaOso.x; FondoJaulaOso.oriY = FondoJaulaOso.y 
       FondoJaulaOso.name = "FondoJaulaOso" 
       menuGroup:insert(1,FondoJaulaOso); menuGroup.FondoJaulaOso = FondoJaulaOso 

       -- bear positioning 
       bear = display.newImageRect( imgDir.. "p50_bear.png", 220, 255 ); 
       bear.x = 820; bear.y = 381; bear.alpha = 1; bear.oldAlpha = 1 
       bear.oriX = bear.x; bear.oriY = bear.y 
       bear.name = "bear" 
       menuGroup:insert(bear); menuGroup.bear = bear 

       -- cell positioning 
       cell = display.newImageRect( imgDir.. "p50_cell.png", 330, 215 ); 
       cell.x = 802; cell.y = 120; cell.alpha = 1; cell.oldAlpha = 1 
       cell.oriX = cell.x; cell.oriY = cell.y 
       cell.name = "cell" 
       menuGroup:insert(cell); menuGroup.cell = cell 

       -- cellBar positioning 
       cellBar = display.newImageRect( imgDir.. "p50_cellbar.png", 330, 330 ); 
       cellBar.x = 802; cellBar.y = 357; cellBar.alpha = 1; cellBar.oldAlpha = 1 
       cellBar.oriX = cellBar.x; cellBar.oriY = cellBar.y 
       cellBar.name = "cellBar" 
       menuGroup:insert(cellBar); menuGroup.cellBar = cellBar 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )
require("viewGenius")

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

local gpGenius = createGenius( )
gpGenius:scale( 0.3, 0.3 )
gpGenius:translate( display.contentWidth - (gpGenius.Tablet.contentWidth*1.85) , display.contentHeight - (gpGenius.Tablet.contentHeight *1.10) )
gpGenius.alpha = 0

_G.Level = 4
_G.Phase = 1

local aud = {"exp_ja9.mp3"}
local sub = {"Pues entonces rumbo a China."}

addCharacter(nil, aud, sub)

aud = {"genio_ja2.mp3"}
sub = {"Los osos panda viven en la selva de China."}

addCharacter(gpGenius.genius, aud, sub, gpGenius)

local sec = {2, 1}
setSecuence( sec )

local parameters = {nameToy="Oveja", pathToy="oveja.png", widthToy = 145, heightToy = 88, nextPage = "page_51"}

playScene( "viewNewToy", parameters ) 


    end 
    drawScreen() 

    return menuGroup 
end 
