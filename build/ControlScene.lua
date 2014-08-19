require( "Character" )

local allCharacter = {}
local secuence = {}
local events = nil
local cont = 0
local page = nil
local panelNext = nil
local posX
local moveRight = false
local isMoveGenio = false

local function onCompleteGenioMove( )
	-- body

end

local function moveGenio( event )
	-- body
	if (gtStash.gt_mypathGenMove) then
		print( "EXISTEEEEEE" )
		--gtStash.gt_mypathGenMove:play()
	else
		local objGenio = allCharacter[secuence[cont]].sprite
		local radius = 30
    	local n_div = 100
    	local an
		local pos = {}
		local time = 8

		allCharacter[secuence[cont]]:setAlphaGroup(1)

		for i=0,n_div do
        	an = (2*math.pi/n_div)*i;
        	an = an - math.pi/2
        	posx = objGenio.x + radius*math.cos(an)
        	posy = objGenio.y + radius*math.sin(an) + 30
			table.insert( pos, { x = posx, y = posy} )
    	end
    	pos.angle = 0 

    	isMoveGenio = true
    	gtStash.gt_mypathGenMove = btween.new( objGenio, time, pos, {ease = gtween.easing.linear, repeatCount = math.huge, reflect = false,  delay=0, onComplete=onCompleteGenioMove}, {  x=objGenio.x, y=objGenio.y,  alpha=1, xScale=1, yScale=1, newAngle=0}) 
	end
end

function addCharacter( spr, aud, sub, group )
	-- body
	local obj = Character:new( spr, aud, sub, group)
	table.insert( allCharacter, obj )
end

function setSecuence( sec )
	-- body
	secuence = sec
end

function setEventsControlScene( ev )
	-- body
	events = ev
end

local function nextScene( event )
	-- body
	local object = event.target
	if event.phase == "began" then
		posX = event.x
		display.getCurrentStage():setFocus(object)
        object.isFocus = true 
    elseif object.isFocus then
    	if event.phase == "moved" then    		
    		if (posX<=event.x) then
    			moveRight = true
    		else
    			moveRight = false
    		end
    		posX = event.x
    	elseif event.phase == "ended" or event.phase == "cancelled" then
        	display.getCurrentStage():setFocus( nil )
			object.isFocus = false
       		if (moveRight) then
       			if ( audio.isChannelPlaying( 1 ) ) then
       				audio.stop( 1 )
       				allCharacter[secuence[cont]]:finalize()	
       			end
       			allCharacter[secuence[cont]]:clearObject()	
       			moveRight = false
       			playScene(nil)
       		end
       	end
    end
    return true
end

local function checkTimer(time)
	-- body
	if (not _G.Subtitle and _G.AutoNextPage) then
		local function completeTimer( event )
			-- body
			allCharacter[secuence[cont]]:clearObject()
			playScene(nil)
		end
		if (not time) then
			time = 300
		end
		timerStash.timer_waitNext = timer.performWithDelay( time, completeTimer )
	elseif(not panelNext) then
		panelNext = display.newRect( 0, 0, display.contentWidth , display.contentHeight )
		panelNext.alpha = 0.01
		panelNext:addEventListener( "touch", nextScene )
	end
end

function onCompleteCharacter(event)
	if (event.completed) then
		allCharacter[secuence[cont]]:finalize()
		if (events and events[cont]) then
			if (events[cont].mytype == "effects") then
				events[cont].value[2]( checkTimer )
			elseif (events[cont].mytype == "image" and events[cont].value[1] == 1) then
				allCharacter[secuence[cont]]:addImage(events[cont].value[2])
				checkTimer(2300)
			else
				checkTimer(300)	
			end
		else
			checkTimer(300)
		end
	end
end

function finalizeScene( notGoNextPage )
	-- body
	print("*******FINALIZAR ESCENA*********")
	if (notGoNextPage) then
		if ( table.maxn( allCharacter ) > 0 ) then
			allCharacter[secuence[cont]]:clearObject()
		end
	end
	if (gtStash.gt_mypathGenMove) then
		gtStash.gt_mypathGenMove:pause()
		gtStash.gt_mypathGenMove = nil
		isMoveGenio = false
	end

	if (panelNext) then
		panelNext:removeSelf( )
		panelNext = nil
		moveRight = false
	end
	table.remove( allCharacter )
	allCharacter = nil
	allCharacter = {}

	events = nil
	secuence = nil

	if (not notGoNextPage) then
		print("*******CAMBIAR ESCENA*********")
		if (_G.CurrentPage == 26) then
			director:changeScene( page)
		else
			cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
			director:changeScene( page, "fade" )
		end
	end
end

local function playNextScene( )
	-- body
	cont = cont + 1
	if (cont <= #secuence) then
		if (events and events[cont]) then
			if (events[cont].mytype == "image" and events[cont].value[1] == 0) then
				allCharacter[secuence[cont]]:addImage(events[cont].value[2])
			end 
		end
		if (allCharacter[secuence[cont]]:getName() == "genio" and not isMoveGenio) then
			moveGenio()
		end
		allCharacter[secuence[cont]]:playCharacter(onCompleteCharacter)
	else
		finalizeScene()
	end
end

function playScene( p )
	-- body
	if (p) then
		cont = 0
		page = p
		if (_G.Subtitle or not _G.AutoNextPage) then
			panelNext = display.newRect( 0, 0, display.contentWidth , display.contentHeight )
			panelNext.alpha = 0.01
			panelNext:addEventListener( "touch", nextScene )
		end
		timerStash.timer_waitNext = timer.performWithDelay( 500, playNextScene )
	else
		playNextScene()
	end
end