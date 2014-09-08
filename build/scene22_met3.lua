require( "ControlScene" )
require("viewGenius")

local audioHandle
local myKey
local gpGenius = createGenius( )
gpGenius:scale( 0.3, 0.3 )
gpGenius:translate( display.contentWidth - (gpGenius.Tablet.contentWidth*1.85) , display.contentHeight - (gpGenius.Tablet.contentHeight *1.10) )
gpGenius.alpha = 0

menuGroup:insert( gpGenius )
gpGenius.genius:pause( )


nurse:pause( )
explorer:pause()

function removeAudioKey( event )
	-- body
	audio.dispose( audioHandle )
	audioHandle = nil
end

local function clearImg( fun )
	-- body
	menuGroup:remove(myKey)
	myKey:removeSelf( )
	myKey = nil
	fun(300)
end

local function playScene22( )
	-- body

	local aud = {"eli_6.mp3"}
	local sub = {"La encontré cuando caminaba por la montaña, un viejo sabio del pueblo me ha dicho que tiene un poder grandioso."}

	addCharacter(nurse, aud, sub)

	aud = {"exp_sz7.mp3", "exp_sz8.mp3"}
	sub = {"!Vaya! !Qué llave más bonita!",
		  "!Genial! Entonce pongamos de nuevo en marcha."}

	addCharacter(explorer, aud, sub)

	aud = {"genio_sz1.mp3"}
	sub = {"Parece que no miente, esta llave está ligada a la caja que prometí darte si superabas todas tus aventura. Cuando consigas finalizar todas las aventuras te daré la caja misteriosa y al fin podremos ver que contiene."}

	addCharacter(gpGenius.genius, aud, sub, gpGenius)

	local sec = {2, 1, 3, 2 }
	setSecuence( sec )

	local events = {{mytype = "effects", value = {1, clearImg } }, nil, nil, nil}
	setEventsControlScene(events)

	local parameters = {nameToy="Bicicleta", pathToy="objeto321.png", widthToy = 137, heightToy = 99, nextPage = "page_11"}

	playScene( "viewNewToy", parameters )
end

myKey = display.newImageRect( imgDir.."llaveOro.png", 229, 76 )
myKey.x = display.contentCenterX; myKey.y = display.contentCenterY - 200
myKey.alpha = 0
myKey:scale( 0, 0 ) 
menuGroup:insert(myKey)

audioHandle = audio.loadSound( audioDir.."stars.mp3" )
transitionStash.key = transition.to( myKey, {time = 2000, xScale = 1.0, yScale = 1.0, alpha = 1.0, onComplete = playScene22} )
audio.play( audioHandle, {channel = 1, duration = 2000, fadein = 2000, onComplete = removeAudioKey} )