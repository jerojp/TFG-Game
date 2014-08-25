require( "ControlScene" )
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

-- carrozaSimple positioning 
local carrozaSimple = display.newImageRect( imgDir.. "carrozaSimple.png", 672, 575 ); 
carrozaSimple.x = 370; carrozaSimple.y = 395;
danceGroup:insert(carrozaSimple); 

danceGroup.alpha = 0
menuGroup:insert( danceGroup )

danceGroup:translate( -danceGroup[2].contentWidth , 0 )

local aud = {"exp_br2.mp3", "exp_br3.mp3"}
local sub = {"!Vaya! Qué ciudad más bonita. Pero ¿qué es esa música que se oye?",
			"!Qué pasada de fiesta! Yo quiero participar, pero el jefe me ha pedido que busque el tesoro. Bueno, creo que tengo tiempo de disfrutar un poco de la fiesta"}

addCharacter(kwkexp, aud, sub)

local sec = {1, 1}
setSecuence( sec )

local events = { {mytype = "effects", value = {1, playMusic} }, {mytype = "effects", value = {1, moveShop} } }
setEventsControlScene(events)

playScene( "page_27" )