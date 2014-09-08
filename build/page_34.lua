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

       local curPage = 34 

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
       local forestUp  
       local HoleUp  
       local kwkmachine  
       local holeD  
       local forestDown  
       local kwkexp  
       local kwksamin  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

       -- forestUp positioning 
       forestUp = display.newImageRect( imgDir.. "p34_forestup.png", 1299, 341 ); 
       forestUp.x = 642; forestUp.y = 170; forestUp.alpha = 1; forestUp.oldAlpha = 1 
       forestUp.oriX = forestUp.x; forestUp.oriY = forestUp.y 
       forestUp.name = "forestUp" 
       menuGroup:insert(1,forestUp); menuGroup.forestUp = forestUp 

       -- HoleUp positioning 
       HoleUp = display.newImageRect( imgDir.. "p34_holeup.png", 398, 6 ); 
       HoleUp.x = 1018; HoleUp.y = 335; HoleUp.alpha = 0; HoleUp.oldAlpha = 0 
       HoleUp.oriX = HoleUp.x; HoleUp.oriY = HoleUp.y 
       HoleUp.name = "HoleUp" 
       menuGroup:insert(HoleUp); menuGroup.HoleUp = HoleUp 

       -- kwkmachine positioning 
       kwkmachine = display.newImageRect( imgDir.. "kwkmachine.png", 330, 198 ); 
       kwkmachine.x = 1018; kwkmachine.y = 239; kwkmachine.alpha = 1; kwkmachine.oldAlpha = 1 
       kwkmachine.oriX = kwkmachine.x; kwkmachine.oriY = kwkmachine.y 
       kwkmachine.name = "kwkmachine" 
       menuGroup:insert(kwkmachine); menuGroup.kwkmachine = kwkmachine 

       -- holeD positioning 
       holeD = display.newImageRect( imgDir.. "p34_holed.png", 398, 6 ); 
       holeD.x = 1018; holeD.y = 340; holeD.alpha = 0; holeD.oldAlpha = 0 
       holeD.oriX = holeD.x; holeD.oriY = holeD.y 
       holeD.name = "holeD" 
       menuGroup:insert(holeD); menuGroup.holeD = holeD 

       -- forestDown positioning 
       forestDown = display.newImageRect( imgDir.. "p34_forestdown.png", 1299, 465 ); 
       forestDown.x = 643; forestDown.y = 572; forestDown.alpha = 1; forestDown.oldAlpha = 1 
       forestDown.oriX = forestDown.x; forestDown.oriY = forestDown.y 
       forestDown.name = "forestDown" 
       menuGroup:insert(forestDown); menuGroup.forestDown = forestDown 

       -- kwkexp positioning 
       local kwkexp_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=141, height=220 }, -- exploradorNormal_00000
               { x=145, y=2, width=141, height=220 }, -- exploradorNormal_00001
               { x=288, y=2, width=141, height=220 }, -- exploradorNormal_00002
               { x=431, y=2, width=141, height=220 }, -- exploradorNormal_00003
               { x=574, y=2, width=141, height=220 }, -- exploradorNormal_00004
               { x=717, y=2, width=141, height=220 }, -- exploradorNormal_00005
               { x=2, y=224, width=141, height=220 }, -- exploradorNormal_00006
               { x=145, y=224, width=141, height=220 }, -- exploradorNormal_00007
               { x=288, y=224, width=141, height=220 }, -- exploradorNormal_00008
               { x=431, y=224, width=141, height=220 }, -- exploradorNormal_00009
               { x=574, y=224, width=141, height=220 }, -- exploradorNormal_00010
               { x=717, y=224, width=141, height=220 }, -- exploradorNormal_00011
               { x=2, y=446, width=141, height=220 }, -- exploradorNormal_00012
               { x=145, y=446, width=141, height=220 }, -- exploradorNormal_00013
               { x=288, y=446, width=141, height=220 }, -- exploradorNormal_00014
               { x=431, y=446, width=141, height=220 }, -- exploradorNormal_00015
               { x=574, y=446, width=141, height=220 }, -- exploradorNormal_00016
           },
    
           sheetContentWidth = 860,
           sheetContentHeight = 668
 
       } 
       kwkexp_sheet = graphics.newImageSheet( spriteDir.. "exploradorhabla.png", kwkexp_options ) 
       kwkexp_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "forward" }; 
       kwkexp = display.newSprite(kwkexp_sheet, kwkexp_seq ) 
       kwkexp:play(); 
       kwkexp.x = 126; kwkexp.y = 572; kwkexp.alpha = 1; kwkexp.oldAlpha = 1 
       kwkexp.oriX = kwkexp.x; kwkexp.oriY = kwkexp.y 
       kwkexp.name = "kwkexp" 
       menuGroup:insert(kwkexp); menuGroup.kwkexp = kwkexp 

       -- kwksamin positioning 
       local kwksamin_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=179, height=336 }, -- inca_00000
               { x=183, y=2, width=179, height=336 }, -- inca_00001
               { x=364, y=2, width=179, height=336 }, -- inca_00002
               { x=545, y=2, width=179, height=336 }, -- inca_00003
               { x=726, y=2, width=179, height=336 }, -- inca_00004
               { x=2, y=340, width=179, height=336 }, -- inca_00005
               { x=183, y=340, width=179, height=336 }, -- inca_00006
               { x=364, y=340, width=179, height=336 }, -- inca_00007
               { x=545, y=340, width=179, height=336 }, -- inca_00008
               { x=726, y=340, width=179, height=336 }, -- inca_00009
               { x=2, y=678, width=179, height=336 }, -- inca_00010
               { x=183, y=678, width=179, height=336 }, -- inca_00011
               { x=364, y=678, width=179, height=336 }, -- inca_00012
               { x=545, y=678, width=179, height=336 }, -- inca_00013
               { x=726, y=678, width=179, height=336 }, -- inca_00014
               { x=2, y=1016, width=179, height=336 }, -- inca_00015
               { x=183, y=1016, width=179, height=336 }, -- inca_00016
           },
    
           sheetContentWidth = 907,
           sheetContentHeight = 1354
 
       } 
       kwksamin_sheet = graphics.newImageSheet( spriteDir.. "inca.png", kwksamin_options ) 
       kwksamin_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "forward" }; 
       kwksamin = display.newSprite(kwksamin_sheet, kwksamin_seq ) 
       kwksamin:play(); 
       kwksamin.x = 362; kwksamin.y = 514; kwksamin.alpha = 1; kwksamin.oldAlpha = 1 
       kwksamin.oriX = kwksamin.x; kwksamin.oriY = kwksamin.y 
       kwksamin.name = "kwksamin" 
       menuGroup:insert(kwksamin); menuGroup.kwksamin = kwksamin 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           kwkexp_sheet = nil; kwkexp = nil 
    kwksamin_sheet = nil; kwksamin = nil 
 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )
require("viewGenius")

kwkexp:pause( )
kwksamin:pause()
_G.Level = 1
_G.Phase = 2
--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

local audioHandle
local gpGenius = createGenius( )
gpGenius:scale( 0.3, 0.3 )
gpGenius:translate( display.contentWidth - (gpGenius.Tablet.contentWidth*1.85) , display.contentHeight - (gpGenius.Tablet.contentHeight *1.10) )
gpGenius.alpha = 0

local function viewImg( fun )
	-- body
	local img
	local function removeElements( event )
		-- body
		img:removeSelf( )
		img = nil
		fun(300)
	end

	img = display.newImageRect( imgDir.."jarronInca.png", 391, 532 )
	img.x = display.contentCenterX; img.y = display.contentCenterY
	img.alpha = 0
	img:scale( 0, 0 )

	audioHandle = audio.loadSound( audioDir.."stars.mp3" )
	transitionStash.jarron = transition.to( img, {time = 2000, xScale = 1.0, yScale = 1.0, alpha = 1.0} )
	audio.play( audioHandle, {channel = 1, duration = 2000, fadein = 2000, onComplete = function()
																						audio.dispose( audioHandle ); audioHandle = nil
																						end} )
	timerStash.jarron = timer.performWithDelay( 3000, removeElements )
end

local function inicDialog( )
	-- body
	local aud = {"exp_br9.mp3", "exp_br10.mp3"}
	local sub = {"Ha sido un placer. Podrías indicarme la dirección para encontrar esta zona.",
			"Muchas gracias, mi jefe se va a poner muy contento."}

	addCharacter(kwkexp, aud, sub)

	local aud = {"samin_br4.mp3", "samin_br5.mp3"}
	local sub = {"Gracias por haberme ayudado, ahora los animales de la selva podrán descansar libremente.",
			"Claro, pero allí ya no queda nada. Tuve que retirar ese tesoro para evitar que las máquinas lo destruyeran. Toma, te lo doy como recompensa por haberme ayudado"}

	addCharacter(kwksamin, aud, sub)

	aud = {"genio_br1.mp3"}
	sub = {"Vaya, así que has conseguido el tesoro. Se lo llevaré volando ahora mismo al jefe. Aquí tienes las monedas como recompensa por haber completado esta aventura."}

	addCharacter(gpGenius.genius, aud, sub, gpGenius)

	local sec = {2, 1, 2, 1, 3}
	setSecuence( sec )

	local events = {nil, nil, {mytype = "effects", value = {1, viewImg } }, nil, nil}
	setEventsControlScene(events)

	local parameters = {nameToy="Abeja", pathToy="objeto141.png", widthToy = 137 , heightToy = 98, nextPage = "page_11"}

	playScene( "viewNewToy", parameters )
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

local function inicTransition( event )
	-- body
	--audioHandle = audio.loadSound( audioDir.."samba.mp3" )
	--audio.play( audioHandle, {channel = 2} )
	transitionStash.machine = transition.to( kwkmachine, {  time=1000, x= kwkmachine.x , y=kwkmachine.y + 200, onComplete=onCompleteTransition} )
end

HoleUp.alpha = 1
holeD.alpha = 1
timerStash.timer_machineDes = timer.performWithDelay( 500, inicTransition, 1 )

 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
