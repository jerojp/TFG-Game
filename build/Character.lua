Character = {sprite = nil, audio = {}, subtitules = {}, images = nil, group = nil, cont = 1, audioHandle = nil, gpMyDisplays = nil}
Character.__index = Character

local imgFinal

function Character:new(...)
	obj = {}
	setmetatable(obj, self);
	obj.sprite,obj.audio,obj.subtitules,obj.images, obj.group = ...
	return obj
end

function Character:playCharacter(onCompleteSound)
	self.gpMyDisplays = display.newGroup( )

	if (self.sprite) then
		self.sprite:play()
	end
	if (self.images and self.images[self.cont] ~= -1) then
		if (self.images[self.cont][1] == 0) then
			local img = display.newImageRect( self.images[self.cont][2], display.contentWidth , display.contentHeight )
			img.x = display.contentCenterX; img.y = display.contentCenterY
			self.gpMyDisplays:insert( img )
		else
			imgFinal = true
		end
	end
	print( self.audio[self.cont] )
	self.audioHandle = audio.loadSound( audioDir..self.audio[self.cont] )
	if (_G.Subtitle) then
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
	end
	audio.play( self.audioHandle, {channel = 1, onComplete = onCompleteSound} )
end

function Character:clearObject( )
	-- body
	print( "------CLEAR SCENE------" )
	
	if (audio.isChannelPlaying( 1 )) then
		audio.stop( 1 )
	end
	audio.dispose( self.audioHandle )
	self.audioHandle = nil
	display.remove( self.gpMyDisplays )
	self.gpMyDisplays = nil
	self.cont = self.cont + 1
end

function Character:finalize()
	if (self.sprite) then
		self.sprite:pause( )
		self.sprite:setFrame( 1 )
	end
	print( "-----FINALIZE SCENE------" )
	if (imgFinal) then
		local function onCompleteTimerImg( )
			-- body
			imgFinal = false
		end
		local img = display.newImageRect( self.images[self.cont][2], display.contentWidth , display.contentHeight )
		img.x = display.contentCenterX; img.y = display.contentCenterY
		self.gpMyDisplays:insert( 1, img )
		timerStash.timer_waitImgFinal = timer.performWithDelay( 2500, onCompleteTimerImg )
	end
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