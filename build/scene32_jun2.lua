require( "ControlScene" )

kwkexp:pause( )
kwksamin:pause()

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true
local groupMachine = display.newGroup( )
local machine = display.newImageRect( imgDir.. "machine.png", 330, 175 ); 
machine.x = 1043 ; machine.y = 278;
groupMachine:insert(machine)

-- ruedas positioning 
local ruedasL = display.newImageRect( imgDir.. "rueda.png", 103, 91 ); 
ruedasL.x = 1011; ruedasL.y = 354;
groupMachine:insert(ruedasL);

local ruedasR = display.newImageRect( imgDir.. "rueda.png", 103, 91 ); 
ruedasR.x = 1180; ruedasR.y = 354;
groupMachine:insert(ruedasR);

groupMachine.anchorChildren =true
groupMachine.x = display.contentWidth
menuGroup:insert( groupMachine )

_G.Level = 1
_G.Phase = 2
local ch = 1
local audioHandle

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

local function removeSound()
	-- body
	if ( audio.isChannelPlaying( ch ) ) then
      audio.stop( ch )
    end
    audio.dispose( audioHandle )
    audioHandle = nil
end

local function onCompleteTransition( event )
        -- body
        removeSound()
        
        inicDialog()
end

local function inicTransArbol( event )
	-- body
	removeSound()
	audioHandle = audio.loadSound( audioDir.."tree.mp3" )
	audio.play( audioHandle, {channel = ch} )

	transition.cancel( transitionStash.rdr )
	transition.cancel( transitionStash.rdl )
	transitionStash.tree = transition.to( ArbolCaido, {  time=6200, x= 713 , y=340, rotation = -80, transition=easing.inQuart, onComplete=onCompleteTransition} )
end

local function inicTransition( event )
	-- body
	audio.setVolume( 0.3, { channel=ch } )
	audioHandle = audio.loadSound( audioDir.."excavadora.mp3" )
	audio.play( audioHandle, {channel = ch, fadein=5000} )

	transitionStash.rdr = transition.to( ruedasR, {  time=2000, rotation = -360, iterations = 0} )
	transitionStash.rdl = transition.to( ruedasL, {  time=2000, rotation = -360, iterations = 0} )
	transitionStash.machine = transition.to( groupMachine, {  time=5000, x= -50 , y= groupMachine.y, onComplete=inicTransArbol} )	
end

timerStash.timer_arbol = timer.performWithDelay( 200, inicTransition, 1 )