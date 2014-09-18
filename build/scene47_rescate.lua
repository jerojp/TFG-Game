require( "ControlScene" )

_G.Level = 4
_G.Phase = 1
local audioHandle

local function playSceneRes( )
	-- body
	local aud = {"exp_ja7.mp3"}
	local sub = {"El guardia está dormido. Entremos sin hacer ruido."}

	addCharacter(nil, aud, sub)

	local sec = {1}
	setSecuence( sec )

	playScene( "page_48" )
end

function onCompleteSoundDor(event)
	-- body
	audio.dispose( audioHandle )
	audioHandle = nil
	if (event.completed) then
		playSceneRes()
	end
end
audioHandle = audio.loadSound( audioDir.."dormido.mp3" )
audio.play( audioHandle ,{time = 5000, channel = 1, onComplete = onCompleteSoundDor} )