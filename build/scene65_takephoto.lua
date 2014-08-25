local cam = display.newRect( 0, 0, display.contentWidth , display.contentHeight )
cam:setFillColor( 250 )
cam.alpha = 0

local function onFinalizeScene( event )
	-- body
	cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
	director:changeScene( "page_53", "fade" )
end

local function onCompletePhoto( event )
		-- body
	transitionStash.cam2 = transition.to( cam, {time = 500, alpha = 0, onComplete=onFinalizeScene} )	
end

local function takePhoto( event )
	-- body
	transitionStash.cam = transition.to( cam, {time = 500, alpha = 1, onComplete=onCompletePhoto} )
end

timerStash.photo = timer.performWithDelay( 700, takePhoto, 1 )