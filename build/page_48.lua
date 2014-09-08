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

       local curPage = 48 

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
       local bearH  
       local bearS  
       local cell  
       local cellB  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

       -- FondoJaulaOso positioning 
       FondoJaulaOso = display.newImageRect( imgDir.. "p48_fondojaulaoso.png", 1288, 809 ); 
       FondoJaulaOso.x = 637; FondoJaulaOso.y = 404; FondoJaulaOso.alpha = 1; FondoJaulaOso.oldAlpha = 1 
       FondoJaulaOso.oriX = FondoJaulaOso.x; FondoJaulaOso.oriY = FondoJaulaOso.y 
       FondoJaulaOso.name = "FondoJaulaOso" 
       menuGroup:insert(1,FondoJaulaOso); menuGroup.FondoJaulaOso = FondoJaulaOso 

       -- bearH positioning 
       bearH = display.newImageRect( imgDir.. "p48_bearh.png", 220, 255 ); 
       bearH.x = 806; bearH.y = 376; bearH.alpha = 1; bearH.oldAlpha = 1 
       bearH.oriX = bearH.x; bearH.oriY = bearH.y 
       bearH.name = "bearH" 
       menuGroup:insert(bearH); menuGroup.bearH = bearH 

       -- bearS positioning 
       bearS = display.newImageRect( imgDir.. "p48_bears.png", 220, 255 ); 
       bearS.x = 806; bearS.y = 376; bearS.alpha = 1; bearS.oldAlpha = 1 
       bearS.oriX = bearS.x; bearS.oriY = bearS.y 
       bearS.name = "bearS" 
       menuGroup:insert(bearS); menuGroup.bearS = bearS 

       -- cell positioning 
       cell = display.newImageRect( imgDir.. "p48_cell.png", 330, 316 ); 
       cell.x = 789; cell.y = 353; cell.alpha = 1; cell.oldAlpha = 1 
       cell.oriX = cell.x; cell.oriY = cell.y 
       cell.name = "cell" 
       menuGroup:insert(cell); menuGroup.cell = cell 

       -- cellB positioning 
       cellB = display.newImageRect( imgDir.. "p48_cellb.png", 330, 330 ); 
       cellB.x = 789; cellB.y = 353; cellB.alpha = 1; cellB.oldAlpha = 1 
       cellB.oriX = cellB.x; cellB.oriY = cellB.y 
       cellB.name = "cellB" 
       menuGroup:insert(cellB); menuGroup.cellB = cellB 
 
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

local function openCell( fun )
	-- body
	local function onCompleteOpen( event )
		-- body
		bearS.alpha = 0
		bearH.alpha = 1
		fun(300)
	end
	transitionStash.oso = transition.to( cell, {time = 2000, x = cell.x, y = cell.y - 230, yScale = 0.74, onComplete=onCompleteOpen} )
end

local aud = {"exp_ja8.mp3"}
local sub = {"Ali, ¿dónde viven los osos panda?."}

addCharacter(nil, aud, sub)

local aud2 = {"sakura_ja4.mp3", "sakura_ja5.mp3"}
local sub2 = {"Ahi está el oso. Liberemosle.",
			 "Ahora debemos llevarlo a su casa."}

addCharacter(nil, aud2, sub2)

aud = {"genio_ja1.mp3"}
sub = {"Para que pueda consultarlo en Internet debes escribir su nombre. Con la primera letra me bastará. Escribe la letra O en la tablet."}

addCharacter(gpGenius.genius, aud, sub, gpGenius)

local sec = {2, 2, 1, 3}
setSecuence( sec )

local events = { {mytype = "effects", value = {1, openCell} }, nil, nil, nil }
setEventsControlScene(events)

playScene( "page_49" ) 


    end 
    drawScreen() 

    return menuGroup 
end 
