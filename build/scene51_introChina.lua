require( "ControlScene" )

kwkexp:pause( )
kwkjap:pause( )

_G.Level = 4
_G.Phase = 2

local numbers = {one, two, three, four, five, six, seven}
local cont = 1

local function viewNumber( fun )
	-- body
	local function nextNumber( event )
		-- body
		fun(300)
	end
	numbers[cont].alpha = 1
	cont = cont + 1

	timerStash.timer_numberOso = timer.performWithDelay( 1000, nextNumber, 1 )	
end

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

local aud = {"exp_ja10.mp3", "exp_ja11.mp3", "exp_ja12.mp3", "exp_ja13.mp3", "exp_ja14.mp3", "exp_ja15.mp3", "exp_ja16.mp3", "exp_ja17.mp3"}
local sub = {"!Cuántos osos!, son muchísimos. Voy a contarlos:",
			"Uno",
			"Dos",
			"Tres",
			"Cuatro",
			"Cinco",
			"Seis",
			"Siete",}

addCharacter(kwkexp, aud, sub)

local aud2 = {"sakura_ja6.mp3"}
local sub2 = {"Bueno, pequeño, ya estás en casa; corre con tu mama."}

addCharacter(kwkjap, aud2, sub2)

local sec = {2, 1, 1, 1, 1, 1, 1, 1, 1}
setSecuence( sec )

local events = { nil, nil, {mytype = "effects", value = {1, viewNumber} },
						   {mytype = "effects", value = {1, viewNumber} },
						   {mytype = "effects", value = {1, viewNumber} },
						   {mytype = "effects", value = {1, viewNumber} },
						   {mytype = "effects", value = {1, viewNumber} },
						   {mytype = "effects", value = {1, viewNumber} },
						   {mytype = "effects", value = {1, viewNumber} }}
setEventsControlScene(events)

playScene( "page_15" )