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

       local curPage = 26 

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
       local kwkexp  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level] = curPage 

       -- FondoBrasil positioning 
       FondoBrasil = display.newImageRect( imgDir.. "p26_fondobrasil.png", 1297, 808 ); 
       FondoBrasil.x = 640; FondoBrasil.y = 396; FondoBrasil.alpha = 1; FondoBrasil.oldAlpha = 1 
       FondoBrasil.oriX = FondoBrasil.x; FondoBrasil.oriY = FondoBrasil.y 
       FondoBrasil.name = "FondoBrasil" 
       menuGroup:insert(1,FondoBrasil); menuGroup.FondoBrasil = FondoBrasil 

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
       kwkexp.x = 496; kwkexp.y = 332; kwkexp.alpha = 1; kwkexp.oldAlpha = 1 
       kwkexp.oriX = kwkexp.x; kwkexp.oriY = kwkexp.y 
       kwkexp.name = "kwkexp" 
       menuGroup:insert(kwkexp); menuGroup.kwkexp = kwkexp 
 
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
gSprites.exp = kwkexp
kwkexp:pause( )
local danceGroup = display.newGroup( )

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )

local function playMusic( fun )
	-- body
	local audioHandle
	local function onCompleteTransition( event )
		-- body
		if ( audio.isChannelPlaying( 2 ) ) then
			audio.stop( 2 )
		end
		audio.dispose( audioHandle )
        audioHandle = nil
		fun(300)
	end
	danceGroup.alpha = 1
	audioHandle = audio.loadSound( audioDir.."samba.mp3" )
	audio.play( audioHandle, {channel = 2} )
	transitionStash.img = transition.to( danceGroup, {  time=20000, x= display.contentWidth + danceGroup[2].contentWidth , y=0, onComplete=onCompleteTransition} )
end

local function moveShop( fun )
	-- body
	if gtStash.gt_linear_104 then 
      gtStash.gt_linear_104:toBeginning() 
    end 
    local function endMove( )
    	-- body
    	fun(300)
    end 
    gtStash.gt_linear_104 = gtween.new( menuGroup, 5, {  x=-800, y=0,  alpha=1, rotation=0, xScale=2.0, yScale=2.0,}, {ease = gtween.easing.linear, repeatCount = 1, reflect = false,  delay=0.1, onComplete=endMove}) 
end

_G.Level = 1
_G.Phase = 1

local kwkgirl_options = { 
   -- created with TexturePacker (http://www.texturepacker.com)
   frames = {
     
       { x=2, y=2, width=180, height=265 }, -- carnavalMujer_00000
       { x=184, y=2, width=180, height=265 }, -- carnavalMujer_00001
       { x=366, y=2, width=180, height=265 }, -- carnavalMujer_00002
       { x=548, y=2, width=180, height=265 }, -- carnavalMujer_00003
       { x=730, y=2, width=180, height=265 }, -- carnavalMujer_00004
       { x=2, y=269, width=180, height=265 }, -- carnavalMujer_00005
       { x=184, y=269, width=180, height=265 }, -- carnavalMujer_00006
       { x=366, y=269, width=180, height=265 }, -- carnavalMujer_00007
       { x=548, y=269, width=180, height=265 }, -- carnavalMujer_00008
       { x=730, y=269, width=180, height=265 }, -- carnavalMujer_00009
       { x=2, y=536, width=180, height=265 }, -- carnavalMujer_00010
       { x=184, y=536, width=180, height=265 }, -- carnavalMujer_00011
       { x=366, y=536, width=180, height=265 }, -- carnavalMujer_00012
       { x=548, y=536, width=180, height=265 }, -- carnavalMujer_00013
       { x=730, y=536, width=180, height=265 }, -- carnavalMujer_00014
       { x=2, y=803, width=180, height=265 }, -- carnavalMujer_00015
       { x=184, y=803, width=180, height=265 }, -- carnavalMujer_00016
   },

   sheetContentWidth = 912,
   sheetContentHeight = 1070

} 

local kwkgirl_sheet = graphics.newImageSheet( spriteDir.. "mujerbaila.png", kwkgirl_options ) 
local kwkgirl_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
local kwkgirl = display.newSprite(kwkgirl_sheet, kwkgirl_seq ) 
kwkgirl:play(); 
kwkgirl.x = 164; kwkgirl.y = 233;
danceGroup:insert(kwkgirl); 
gSprites.girl = kwkgirl

-- carrozaSimple positioning 
local carrozaSimple = display.newImageRect( imgDir.. "carrozaSimple.png", 672, 575 ); 
carrozaSimple.x = 370; carrozaSimple.y = 395;
danceGroup:insert(carrozaSimple); 

danceGroup.alpha = 0
menuGroup:insert( danceGroup )

danceGroup:translate( -danceGroup[2].contentWidth , 0 )

local aud = {"exp_br2.mp3", "exp_br3.mp3"}
local sub = {"!Vaya! QuÃ© ciudad mÃ¡s bonita. Pero Â¿quÃ© es esa mÃºsica que se oye?",
			"!QuÃ© pasada de fiesta! Yo quiero participar, pero el jefe me ha pedido que busque el tesoro. Bueno, creo que tengo tiempo de disfrutar un poco de la fiesta"}

addCharacter(kwkexp, aud, sub)

local sec = {1, 1}
setSecuence( sec )

local events = { {mytype = "effects", value = {1, playMusic} }, {mytype = "effects", value = {1, moveShop} } }
setEventsControlScene(events)

playScene( "page_27" ) 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
