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

       local curPage = 47 
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
       local FondoCazador  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 
       require( "ControlScene" )

_G.Level = 4
_G.Phase = 1
local audioHandle

local function playSceneRes( )
	-- body
	local aud = {"exp_ja7.mp3"}
	local sub = {"El guardia está dormido. Entremos sin hacer ruido."}

	addCharacter(nil, aud, sub)

	local sec = {1}
	setSecuence( sec )

	playScene( "page_48" )
end

function onCompleteSoundDor(event)
	-- body
	audio.dispose( audioHandle )
	audioHandle = nil
	if (event.completed) then
		playSceneRes()
	end
end
audioHandle = audio.loadSound( audioDir.."dormido.mp3" )
audio.play( audioHandle ,{time = 5000, channel = 1, onComplete = onCompleteSoundDor} ) 

       -- FondoCazador positioning 
       FondoCazador = display.newImageRect( imgDir.. "p47_fondocazador.png", 1280, 800 ); 
       FondoCazador.x = 640; FondoCazador.y = 400; FondoCazador.alpha = 1; FondoCazador.oldAlpha = 1 
       FondoCazador.oriX = FondoCazador.x; FondoCazador.oriY = FondoCazador.y 
       FondoCazador.name = "FondoCazador" 
       menuGroup:insert(1,FondoCazador); menuGroup.FondoCazador = FondoCazador 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
