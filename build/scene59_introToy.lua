require( "ControlScene" )

function onCompleteSoundCamion(event)
	-- body
	audio.dispose( audioHandle )
	audioHandle = nil
end

local function translateTruck( fun )
	-- body
	local oldX = kwktruckf.x
	local function onCompleteTruckT( )
		-- body
		if ( audio.isChannelActive( 1 ) ) then
			audio.stop( 1 )
			onCompleteSoundCamion()
		end
		fun(300)
	end
	local function onCompleteTruckF( )
		-- body
		if ( audio.isChannelActive( 1 ) ) then
			audio.stop( 1 )
		end
		audioHandle = audio.loadSound( audioDir.."camion.mp3" )
		audio.play( audioHandle, { channel = 1, fadein = 2000, onComplete = onCompleteSoundCamion} )
		transitionStash.cam = transition.to( kwktruckt, {time = 4000, x = oldX, onComplete = onCompleteTruckT } )		
	end
	audioHandle = audio.loadSound( audioDir.."camion.mp3" )
	audio.play( audioHandle, { channel = 1, onComplete = onCompleteSoundCamion} )
	audio.fade( { channel=1, time=3000, volume=0.5 } )
	transitionStash.cam = transition.to( kwktruckf, {time = 3000, x = -kwktruckf.contentWidth, onComplete = onCompleteTruckF } )
end

kwkexp:pause( )
kwkafr:pause( )

_G.Level = 5
_G.Phase = 2

local aud = {"exp_afr7.mp3", "exp_afr8.mp3"}
local sub = {"Ya está aquí el camión de los juguetes.",
			"Es un placer ayudar, estos juguetes han sido donados por niños que ya no los necesitaban. Vamos a bajarlos. Empezaré bajando los unicornios."}

addCharacter(kwkexp, aud, sub)

aud = {"sira_4.mp3"}
sub = {"Mucha gracias por todo de verdad."}
addCharacter(kwkafr, aud, sub)


local sec = {1, 2, 1}

setSecuence( sec )

local events = { {mytype = "effects", value = {1, translateTruck} }, nil, nil }
setEventsControlScene(events)

playScene( "page_15" )