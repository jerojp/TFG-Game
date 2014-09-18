require( "Character" )
--Functions
local checkEvents

--Vars
local allCharacter = {}
local secuence = {}
local events = nil
local cont = 0
local page = nil
local panelNext
local posX
local moveRight = false
local isMoveGenio = false
local parameters
local inEvent
local arrow
local completeArrowOff
local completeArrowOn
local arrowCreated = false
local panelAdvanceCreated = false
local removeArrow
local playingMyScene

local function onCompleteGenioMove( )
	-- body

end

local function moveGenio( event )
	-- body
	if (gtStash.gt_mypathGenMove) then
		--gtStash.gt_mypathGenMove:play()
	else
		if (allCharacter[secuence[cont]].sprite) then
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
       			checkEvents("panelAdvance")
       			moveRight = false
       		end
       	end
    end
    return true
end

function createPanelAutoAdvance( )
	-- body
	if (not panelAdvanceCreated) then
		panelNext = display.newRect( 0, 0, display.contentWidth , display.contentHeight )
		panelNext.alpha = 0.01
		panelNext:addEventListener( "touch", nextScene )
		--menuGroup:insert(panelNext)
		panelAdvanceCreated = true
	else
		--print( "NO SE CREA EL PANEL AUTO ADVANCE" )
	end
end

function isPlayMyScene( )
	-- body
	return playingMyScene
end

function isCreatedPanelAutoAdvance( )
	-- body
	return panelAdvanceCreated
end

function removePanelAutoAdvance( sceneNotComplete )
	-- body
	if (panelAdvanceCreated) then
		--menuGroup:remove(panelNext)
		if (panelNext) then
			panelNext:removeSelf( )
			panelNext = nil
		end
		panelAdvanceCreated = false
		moveRight = false
		removeArrow( )
		if (not audio.isChannelActive( 1 ) and sceneNotComplete ) then
			checkEvents("autoAdvance")
		end
	end
end

completeArrowOn = function ( obj )
	transitionStash.arrow = transition.to( obj, {time = 1000, xScale = 0.8, yScale =0.8, alpha = 0.8, onComplete = completeArrowOff} )
end

completeArrowOff = function ( obj )
	transitionStash.arrow = transition.to( obj, {time = 1000, xScale = 1.1, yScale =1.1, alpha = 1.0, onComplete = completeArrowOn} )
end

local function createArrow( )
	-- body
	if (not arrowCreated) then
		arrowCreated = true
		arrow = display.newImageRect( imgDir.."arrowAdv.png", 220, 200 )
		arrow.x = display.contentWidth - arrow.contentWidth/2 - 50
		arrow.y = display.contentHeight - arrow.contentHeight/2 - 20

		transitionStash.arrow = transition.to( arrow, {time = 1000, xScale = 0.8, yScale =0.8, alpha = 0.8, onComplete = completeArrowOff} )
	end
end

removeArrow = function( )
	-- body
	if (arrowCreated) then
		if (transitionStash.arrow) then
			transition.cancel( transitionStash.arrow )
			transitionStash.arrow = nil
		end
		if (arrow) then
			arrow:removeSelf( )
			arrow = nil
		end
		arrowCreated = false
	end
end

local function checkTimer(time)
	-- body
	if (_G.Subtitle or not _G.AutoNextPage) then
		createPanelAutoAdvance( )
	end
	local function completeTimer( event )
			-- body
		if (cont ~= 0) then
			allCharacter[secuence[cont]]:clearObject()
			playScene(nil)
		end
	end
	if (not time) then
		time = 300
	end
	timerStash.timer_waitNext2 = timer.performWithDelay( time, completeTimer )
end

checkEvents = function( origin )
	-- body
	if ((_G.Subtitle or not _G.AutoNextPage) and origin=="panelAdvance" and not inEvent ) or ((not _G.Subtitle and _G.AutoNextPage) and origin=="autoAdvance") then
		removeArrow( )
		if (events and events[cont]) then
			inEvent = true
			if (events[cont].mytype == "effects") then
				events[cont].value[2]( checkTimer )
			elseif (events[cont].mytype == "image" and events[cont].value[1] == 1) then
				allCharacter[secuence[cont]]:addImage(events[cont].value[2])
				checkTimer(4300)
			else
				inEvent = false
				checkTimer(300)	
			end
		else
			checkTimer(300)	
		end
	end
end

function onCompleteCharacter(event)
	if (event.completed) then
		if (_G.Subtitle or not _G.AutoNextPage) then
			createPanelAutoAdvance( )
			createArrow( )
		end
		if (allCharacter[secuence[cont]]) then
			allCharacter[secuence[cont]]:finalize()			
		end
		checkEvents("autoAdvance")
	end
end

function finalizeScene( notGoNextPage )
	-- body
	if (notGoNextPage) then
		if ( table.maxn( allCharacter ) > 0 and cont > 0) then
			allCharacter[secuence[cont]]:clearObject()
		end
	end
	if (gtStash.gt_mypathGenMove) then
		gtStash.gt_mypathGenMove:pause()
		gtStash.gt_mypathGenMove = nil
		isMoveGenio = false
	end

	removePanelAutoAdvance(false)
	
	table.remove( allCharacter )
	allCharacter = nil
	_G.gSprites = nil
	allCharacter = {}

	events = nil
	secuence = nil

	playingMyScene = false
	if (page == -1) then
		_G.FunctionDelHiddenPanel()
	else
		if (not notGoNextPage) then
			if (_G.CurrentPage == 26) then
				director:changeScene( page)
			else
				cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions()
				if (parameters) then
					director:changeScene(parameters, page, "fade" ) 	
				else
					director:changeScene(page, "fade" )
				end
			end
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

function playScene( p, param )
	-- body
	inEvent = false
	if (p) then
		playingMyScene = true
		cont = 0
		page = p
		parameters = param
		if (_G.Subtitle or not _G.AutoNextPage) then
			createPanelAutoAdvance( )
		end
		timerStash.timer_waitNext = timer.performWithDelay( 500, playNextScene )
	else
		playNextScene()
	end
end