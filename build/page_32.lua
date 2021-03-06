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

       local curPage = 32 
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
       local fondoBrasilBosq  
       local kwkexp  
       local kwksamin  
       local ArbolAtr  
       local ArbolMed  
       local ArbolCaido  
       local ArbolDel  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

       -- fondoBrasilBosq positioning 
       fondoBrasilBosq = display.newImageRect( imgDir.. "p32_fondobrasilbosq.png", 1305, 800 ); 
       fondoBrasilBosq.x = 639; fondoBrasilBosq.y = 400; fondoBrasilBosq.alpha = 1; fondoBrasilBosq.oldAlpha = 1 
       fondoBrasilBosq.oriX = fondoBrasilBosq.x; fondoBrasilBosq.oriY = fondoBrasilBosq.y 
       fondoBrasilBosq.name = "fondoBrasilBosq" 
       menuGroup:insert(1,fondoBrasilBosq); menuGroup.fondoBrasilBosq = fondoBrasilBosq 

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
       kwkexp_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
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
       kwksamin_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       kwksamin = display.newSprite(kwksamin_sheet, kwksamin_seq ) 
       kwksamin:play(); 
       kwksamin.x = 362; kwksamin.y = 514; kwksamin.alpha = 1; kwksamin.oldAlpha = 1 
       kwksamin.oriX = kwksamin.x; kwksamin.oriY = kwksamin.y 
       kwksamin.name = "kwksamin" 
       menuGroup:insert(kwksamin); menuGroup.kwksamin = kwksamin 

       -- ArbolAtr positioning 
       ArbolAtr = display.newImageRect( imgDir.. "p32_arbolatr.png", 229, 326 ); 
       ArbolAtr.x = 878; ArbolAtr.y = 173; ArbolAtr.alpha = 1; ArbolAtr.oldAlpha = 1 
       ArbolAtr.oriX = ArbolAtr.x; ArbolAtr.oriY = ArbolAtr.y 
       ArbolAtr.name = "ArbolAtr" 
       menuGroup:insert(ArbolAtr); menuGroup.ArbolAtr = ArbolAtr 

       -- ArbolMed positioning 
       ArbolMed = display.newImageRect( imgDir.. "p32_arbolmed.png", 229, 326 ); 
       ArbolMed.x = 637; ArbolMed.y = 203; ArbolMed.alpha = 1; ArbolMed.oldAlpha = 1 
       ArbolMed.oriX = ArbolMed.x; ArbolMed.oriY = ArbolMed.y 
       ArbolMed.name = "ArbolMed" 
       menuGroup:insert(ArbolMed); menuGroup.ArbolMed = ArbolMed 

       -- ArbolCaido positioning 
       ArbolCaido = display.newImageRect( imgDir.. "p32_arbolcaido.png", 229, 326 ); 
       ArbolCaido.x = 845; ArbolCaido.y = 203; ArbolCaido.alpha = 1; ArbolCaido.oldAlpha = 1 
       ArbolCaido.oriX = ArbolCaido.x; ArbolCaido.oriY = ArbolCaido.y 
       ArbolCaido.name = "ArbolCaido" 
       menuGroup:insert(ArbolCaido); menuGroup.ArbolCaido = ArbolCaido 

       -- ArbolDel positioning 
       ArbolDel = display.newImageRect( imgDir.. "p32_arboldel.png", 229, 326 ); 
       ArbolDel.x = 739; ArbolDel.y = 227; ArbolDel.alpha = 1; ArbolDel.oldAlpha = 1 
       ArbolDel.oriX = ArbolDel.x; ArbolDel.oriY = ArbolDel.y 
       ArbolDel.name = "ArbolDel" 
       menuGroup:insert(ArbolDel); menuGroup.ArbolDel = ArbolDel 
 
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
	local sub = {"Hola joven, siento interrumpirte. Soy el protector de este bosque y necesito tu ayuda. Esas máquina de hierro están destruyendo la selva derribando sus árboles.",
			"He instalado una serie de trampas por la zona, para parar la tala de árboles. Solo tienes que pulsar una de esas rocas de color. Pulsa la roca de color Amarillo para hacer desparecer las máquinas."}

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


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
