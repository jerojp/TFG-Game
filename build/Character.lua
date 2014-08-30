Character = {sprite = nil, audio = {}, subtitules = {}, group = nil, cont = 1, audioHandle = nil, gpMyDisplays = nil}
Character.__index = Character

function Character:new(...)
	obj = {}
	setmetatable(obj, self);
	obj.sprite,obj.audio,obj.subtitules, obj.group = ...
	return obj
end

function Character:playCharacter(onCompleteSound)
	if (not self.gpMyDisplays) then
		self.gpMyDisplays = display.newGroup( )
	end

	if (self.sprite) then
		self.sprite:play()
		_G.gSprites = self.sprite
	end
	--[[if (self.images and self.images[self.cont] ~= -1) then
		if (self.images[self.cont][1] == 0) then
			local img = display.newImageRect( self.images[self.cont][2], display.contentWidth , display.contentHeight )
			img.x = display.contentCenterX; img.y = display.contentCenterY
			self.gpMyDisplays:insert( img )
		else
			imgFinal = true
		end
	end]]--
	print( self.audio[self.cont] )
	self.audioHandle = audio.loadSound( audioDir..self.audio[self.cont] )
	local options = 
	{
    	text = self.subtitules[self.cont],     
    	x = display.contentCenterX,
    	y = 30,
    	width = display.contentWidth/2 + 250 ,
    	font = native.systemFontBold,  
    	fontSize = 32,
    	align = "center"
	}	
	local myText = display.newText( options )
	myText.x = display.contentCenterX
	myText:setFillColor( 20 )
	self.gpMyDisplays:insert( myText )
	if (not _G.Subtitle) then
		myText.alpha = 0
	end
	_G.MyCurrentSubtitle = myText
	audio.play( self.audioHandle, {channel = 1, onComplete = onCompleteSound} )
end

function Character:clearObject( )
	-- body
	print( "------CLEAR SCENE------" )
	
	if (audio.isChannelActive( 1 )) then
		audio.stop( 1 )
	end
	audio.dispose( self.audioHandle )
	self.audioHandle = nil
	if (_G.MyCurrentSubtitle) then
		_G.MyCurrentSubtitle:removeSelf( )
		_G.MyCurrentSubtitle = nil
	end
	display.remove( self.gpMyDisplays )
	self.gpMyDisplays = nil
	self.cont = self.cont + 1
end

function Character:finalize()
	if (self.sprite) then
		_G.gSprites = nil
		self.sprite:pause( )
		self.sprite:setFrame( 1 )
	end
	print( "-----FINALIZE SCENE------" )
		--[[local function onCompleteTimerImg( )
			-- body
			imgFinal = false
		end
		local img = display.newImageRect( self.images[self.cont][2], display.contentWidth , display.contentHeight )
		img.x = display.contentCenterX; img.y = display.contentCenterY
		self.gpMyDisplays:insert( 1, img )
		timerStash.timer_waitImgFinal = timer.performWithDelay( 2500, onCompleteTimerImg )
		]]--
end

function Character:addImage( options )
	-- body
	if (not self.gpMyDisplays) then
		self.gpMyDisplays = display.newGroup( )
	end
	local w = display.contentWidth
	local h = display.contentHeight 
	if (options.w and options.h) then
		w = options.w
		h = options.h
	end
	local img = display.newImageRect( options.path, w, h)
	img.x = display.contentCenterX; img.y = display.contentCenterY
	self.gpMyDisplays:insert( 1, img )
end

function Character:getName( )
	-- body
	print( string.find( self.audio[1] , "_" ) )
	local name = string.sub( self.audio[1], 1, string.find( self.audio[1] , "_" ) - 1 )
	print( name )
	return name
end

function Character:setAlphaGroup( newAlpha )
	-- body
	if (self.group) then
		self.group.alpha = newAlpha
	end
end