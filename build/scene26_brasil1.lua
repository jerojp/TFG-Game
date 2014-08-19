require( "ControlScene" )
kwkexp:pause( )

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
_G.Subtitle = false
_G.AutoNextPage = true

local function playMusic( fun )
	-- body
	local audioHandle
	local img
	local function onCompleteTransition( event )
		-- body
		if ( audio.isChannelPlaying( 2 ) ) then
			audio.stop( 2 )
		end
		audio.dispose( audioHandle )
        audioHandle = nil
        img:removeSelf( )
        img = nil
		fun(300)
	end

	audioHandle = audio.loadSound( audioDir.."samba.mp3" )
	audio.play( audioHandle, {channel = 2} )
	img = display.newImageRect( imgDir.."carroza.png", 672, 574)
	img.x = -img.contentWidth; img.y = display.contentCenterY
	transition.to( img, {  time=20000, x= display.contentWidth + img.contentWidth , y=display.contentCenterY, onComplete=onCompleteTransition} )
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

local aud = {"exp_br2.mp3", "exp_br3.mp3"}
local sub = {"!Vaya! Qué ciudad más bonita. Pero ¿qué es esa música que se oye?",
			"!Qué pasada de fiesta! Yo quiero participar, pero el jefe me ha pedido que busque el tesoro. Bueno, creo que tengo tiempo de disfrutar un poco de la fiesta"}

addCharacter(kwkexp, aud, sub)

local sec = {1, 1}
setSecuence( sec )

local events = { {mytype = "effects", value = {1, playMusic} }, {mytype = "effects", value = {1, moveShop} } }
setEventsControlScene(events)

playScene( "page_27" )