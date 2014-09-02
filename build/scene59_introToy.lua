require( "ControlScene" )

local function translateTruck( fun )
	-- body
	local oldX = kwktruckf.x
	local function onCompleteTruckT( )
		-- body
		fun(300)
	end
	local function onCompleteTruckF( )
		-- body
		transition.to( kwktruckt, {time = 2000, x = oldX, onComplete = onCompleteTruckT } )		
	end

	transition.to( kwktruckf, {time = 2000, x = -kwktruckf.contentWidth, onComplete = onCompleteTruckF } )
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