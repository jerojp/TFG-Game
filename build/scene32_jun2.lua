require( "ControlScene" )
kwkexp:pause( )
kwksamin:pause()

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

_G.Level = 1
_G.Phase = 2

local function inicDialog( )
	-- body
	local aud = {"exp_br7.mp3", "exp_br8.mp3"}
	local sub = {"Claro, ¿en qué puedo ayudarte? Hay que evitar la tala de árboles a toda costa.",
			"La roca de color Amarillo. A ver si consigo recordar cuál es el color amarillo, creo que empieza por la vocal A."}

	addCharacter(kwkexp, aud, sub)

	local aud = {"samin_br1.mp3", "samin_br2.mp3"}
	local sub = {"Hola joven, siento interrumpirte soy el protector de este bosque y necesito su ayuda. Esas máquina de hierro estan destruyendo la selva derribando sus árboles.",
			"He instalado una serie de trampas por la zona, solo tienes que pulsar una de esas rocas de color. Pulsa la roca de color Amarillo."}

	addCharacter(kwksamin, aud, sub)

	local sec = {2, 1, 2, 1}
	setSecuence( sec )

	playScene( "page_15" )
end

local function onCompleteTransition( event )
        -- body
        --[[if ( audio.isChannelPlaying( 2 ) ) then
          audio.stop( 2 )
        end
        audio.dispose( audioHandle )
        audioHandle = nil
        ]]--
        inicDialog()
end

local function inicTransArbol( event )
	-- body
	--audioHandle = audio.loadSound( audioDir.."samba.mp3" )
	--audio.play( audioHandle, {channel = 2} )

	transitionStash.tree = transition.to( ArbolCaido, {  time=2000, x= 713 , y=340, rotation = -90, onComplete=onCompleteTransition} )
end

local function inicTransition( event )
	-- body
	transitionStash.machine = transition.to( machine, {  time=4000, x= 950 , y= machine.y, onComplete=inicTransArbol} )	
end

timerStash.timer_arbol = timer.performWithDelay( 500, inicTransition, 1 )