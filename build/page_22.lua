-- Code created by Kwik - Copyright: kwiksher.com 
-- Version: 2.7.6b 
module(..., package.seeall) 

function new() 
    local numPages = 65 
    local menuGroup = display.newGroup() 
    local dispose 
    local _W = display.contentWidth; 
    local _H = display.contentHeight; 

    local drawScreen = function() 

       local curPage = 22 

       Navigation.new("page", { backColor = {255, 255, 255}, anim=1, timer=1,  totPages = numPages, curPage = curPage, thumbW = 200, thumbH = 125, alpha = 1, imageDir = imgDir, dire = "top", audio={} } ) 
       Navigation.hide() 

       if (tonumber(kBookmark) == 1) then 
          local path = system.pathForFile( "book.txt", system.DocumentsDirectory ) 
          local file = io.open( path, "w+" ) 
          file:write ( curPage.."\n1" ) 
          io.close( file ) 
       end 

       math.randomseed(os.time()) 

       if (tonumber(_G.kAutoPlay) > 0) then 
          local function act_autoPlay(event) 
             if(curPage < numPages) then 
                if(kBidi == false) then  
                   dispose(); director:changeScene( "page_"..curPage+1, "moveFromRight" ) 
                else  
                   dispose(); director:changeScene( "page_"..curPage-1, "moveFromLeft" ) 
                end  
             end 
          end 
          timerStash.timer_AP = timer.performWithDelay( _G.kAutoPlay*1000, act_autoPlay, 1 ) 
       end 

 
       -- Layer names 
       local background  
       local explorer  
       local nurse  
       local table  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

       -- background positioning 
       background = display.newImageRect( imgDir.. "p22_background.png", 1280, 798 ); 
       background.x = 640; background.y = 401; background.alpha = 1; background.oldAlpha = 1 
       background.oriX = background.x; background.oriY = background.y 
       background.name = "background" 
       menuGroup:insert(1,background); menuGroup.background = background 

       -- explorer positioning 
       local explorer_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=107, height=220 }, -- exploradorBebe_00000
               { x=111, y=2, width=107, height=220 }, -- exploradorBebe_00001
               { x=220, y=2, width=107, height=220 }, -- exploradorBebe_00002
               { x=329, y=2, width=107, height=220 }, -- exploradorBebe_00003
               { x=2, y=224, width=107, height=220 }, -- exploradorBebe_00004
               { x=111, y=224, width=107, height=220 }, -- exploradorBebe_00005
               { x=220, y=224, width=107, height=220 }, -- exploradorBebe_00006
               { x=329, y=224, width=107, height=220 }, -- exploradorBebe_00007
               { x=2, y=446, width=107, height=220 }, -- exploradorBebe_00008
               { x=111, y=446, width=107, height=220 }, -- exploradorBebe_00009
               { x=220, y=446, width=107, height=220 }, -- exploradorBebe_00010
               { x=329, y=446, width=107, height=220 }, -- exploradorBebe_00011
               { x=2, y=668, width=107, height=220 }, -- exploradorBebe_00012
               { x=111, y=668, width=107, height=220 }, -- exploradorBebe_00013
               { x=220, y=668, width=107, height=220 }, -- exploradorBebe_00014
               { x=329, y=668, width=107, height=220 }, -- exploradorBebe_00015
           },
    
           sheetContentWidth = 438,
           sheetContentHeight = 890
 
       } 
       explorer_sheet = graphics.newImageSheet( spriteDir.. "expbebe.png", explorer_options ) 
       explorer_seq = { name = "default", start = 1, count = 15, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       explorer = display.newSprite(explorer_sheet, explorer_seq ) 
       explorer:play(); 
       explorer.x = 374; explorer.y = 567; explorer.alpha = 1; explorer.oldAlpha = 1 
       explorer.xScale = 2; 
       explorer.yScale = 2; 
       explorer.oriX = explorer.x; explorer.oriY = explorer.y 
       explorer.name = "explorer" 
       menuGroup:insert(explorer); menuGroup.explorer = explorer 

       -- nurse positioning 
       local nurse_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=104, height=207 }, -- EnfermeraNormal_00000
               { x=108, y=2, width=104, height=207 }, -- EnfermeraNormal_00001
               { x=214, y=2, width=104, height=207 }, -- EnfermeraNormal_00002
               { x=320, y=2, width=104, height=207 }, -- EnfermeraNormal_00003
               { x=426, y=2, width=104, height=207 }, -- EnfermeraNormal_00004
               { x=532, y=2, width=104, height=207 }, -- EnfermeraNormal_00005
               { x=638, y=2, width=104, height=207 }, -- EnfermeraNormal_00006
               { x=744, y=2, width=104, height=207 }, -- EnfermeraNormal_00007
               { x=850, y=2, width=104, height=207 }, -- EnfermeraNormal_00008
               { x=2, y=211, width=104, height=207 }, -- EnfermeraNormal_00009
               { x=108, y=211, width=104, height=207 }, -- EnfermeraNormal_00010
               { x=214, y=211, width=104, height=207 }, -- EnfermeraNormal_00011
               { x=320, y=211, width=104, height=207 }, -- EnfermeraNormal_00012
               { x=426, y=211, width=104, height=207 }, -- EnfermeraNormal_00013
               { x=532, y=211, width=104, height=207 }, -- EnfermeraNormal_00014
               { x=638, y=211, width=104, height=207 }, -- EnfermeraNormal_00015
               { x=744, y=211, width=104, height=207 }, -- EnfermeraNormal_00016
           },
    
           sheetContentWidth = 956,
           sheetContentHeight = 420
 
       } 
       nurse_sheet = graphics.newImageSheet( spriteDir.. "enfhabla.png", nurse_options ) 
       nurse_seq = { name = "default", start = 1, count = 16, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       nurse = display.newSprite(nurse_sheet, nurse_seq ) 
       nurse:play(); 
       nurse.x = 875; nurse.y = 560; nurse.alpha = 1; nurse.oldAlpha = 1 
       nurse.xScale = 2; 
       nurse.yScale = 2; 
       nurse.oriX = nurse.x; nurse.oriY = nurse.y 
       nurse.name = "nurse" 
       menuGroup:insert(nurse); menuGroup.nurse = nurse 

       -- table positioning 
       table = display.newImageRect( imgDir.. "p22_table.png", 725, 242 ); 
       table.x = 628; table.y = 677; table.alpha = 1; table.oldAlpha = 1 
       table.oriX = table.x; table.oriY = table.y 
       table.name = "table" 
       menuGroup:insert(table); menuGroup.table = table 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           explorer_sheet = nil; explorer = nil 
    nurse_sheet = nil; nurse = nil 
 
       end 

       -- (BOTTOM) External code will render here 
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


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
