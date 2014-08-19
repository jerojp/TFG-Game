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