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

       local curPage = 51 

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
       local FodoChina  
       local one  
       local two  
       local three  
       local four  
       local five  
       local six  
       local seven  
       local kwkexp  
       local kwkjap  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

       -- FodoChina positioning 
       FodoChina = display.newImageRect( imgDir.. "p51_fodochina.png", 1280, 808 ); 
       FodoChina.x = 640; FodoChina.y = 396; FodoChina.alpha = 1; FodoChina.oldAlpha = 1 
       FodoChina.oriX = FodoChina.x; FodoChina.oriY = FodoChina.y 
       FodoChina.name = "FodoChina" 
       menuGroup:insert(1,FodoChina); menuGroup.FodoChina = FodoChina 

       -- one positioning 
       one = display.newImageRect( imgDir.. "p51_one.png", 58, 80 ); 
       one.x = 339; one.y = 285; one.alpha = 0; one.oldAlpha = 0 
       one.oriX = one.x; one.oriY = one.y 
       one.name = "one" 
       menuGroup:insert(one); menuGroup.one = one 

       -- two positioning 
       two = display.newImageRect( imgDir.. "p51_two.png", 67, 79 ); 
       two.x = 310; two.y = 381; two.alpha = 0; two.oldAlpha = 0 
       two.oriX = two.x; two.oriY = two.y 
       two.name = "two" 
       menuGroup:insert(two); menuGroup.two = two 

       -- three positioning 
       three = display.newImageRect( imgDir.. "p51_three.png", 74, 81 ); 
       three.x = 523; three.y = 301; three.alpha = 0; three.oldAlpha = 0 
       three.oriX = three.x; three.oriY = three.y 
       three.name = "three" 
       menuGroup:insert(three); menuGroup.three = three 

       -- four positioning 
       four = display.newImageRect( imgDir.. "p51_four.png", 92, 95 ); 
       four.x = 786; four.y = 292; four.alpha = 0; four.oldAlpha = 0 
       four.oriX = four.x; four.oriY = four.y 
       four.name = "four" 
       menuGroup:insert(four); menuGroup.four = four 

       -- five positioning 
       five = display.newImageRect( imgDir.. "p51_five.png", 62, 80 ); 
       five.x = 740; five.y = 396; five.alpha = 0; five.oldAlpha = 0 
       five.oriX = five.x; five.oriY = five.y 
       five.name = "five" 
       menuGroup:insert(five); menuGroup.five = five 

       -- six positioning 
       six = display.newImageRect( imgDir.. "p51_six.png", 62, 80 ); 
       six.x = 877; six.y = 436; six.alpha = 0; six.oldAlpha = 0 
       six.oriX = six.x; six.oriY = six.y 
       six.name = "six" 
       menuGroup:insert(six); menuGroup.six = six 

       -- seven positioning 
       seven = display.newImageRect( imgDir.. "p51_seven.png", 62, 79 ); 
       seven.x = 965; seven.y = 436; seven.alpha = 0; seven.oldAlpha = 0 
       seven.oriX = seven.x; seven.oriY = seven.y 
       seven.name = "seven" 
       menuGroup:insert(seven); menuGroup.seven = seven 

       -- kwkexp positioning 
       local kwkexp_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=229, height=395 }, -- ExploradorJapones_00000
               { x=233, y=2, width=229, height=395 }, -- ExploradorJapones_00001
               { x=464, y=2, width=229, height=395 }, -- ExploradorJapones_00002
               { x=695, y=2, width=229, height=395 }, -- ExploradorJapones_00003
               { x=2, y=399, width=229, height=395 }, -- ExploradorJapones_00004
               { x=233, y=399, width=229, height=395 }, -- ExploradorJapones_00005
               { x=464, y=399, width=229, height=395 }, -- ExploradorJapones_00006
               { x=695, y=399, width=229, height=395 }, -- ExploradorJapones_00007
               { x=2, y=796, width=229, height=395 }, -- ExploradorJapones_00008
               { x=233, y=796, width=229, height=395 }, -- ExploradorJapones_00009
               { x=464, y=796, width=229, height=395 }, -- ExploradorJapones_00010
               { x=695, y=796, width=229, height=395 }, -- ExploradorJapones_00011
               { x=2, y=1193, width=229, height=395 }, -- ExploradorJapones_00012
               { x=233, y=1193, width=229, height=395 }, -- ExploradorJapones_00013
               { x=464, y=1193, width=229, height=395 }, -- ExploradorJapones_00014
               { x=695, y=1193, width=229, height=395 }, -- ExploradorJapones_00015
               { x=2, y=1590, width=229, height=395 }, -- ExploradorJapones_00016
           },
    
           sheetContentWidth = 926,
           sheetContentHeight = 1987
 
       } 
       kwkexp_sheet = graphics.newImageSheet( spriteDir.. "expjapones.png", kwkexp_options ) 
       kwkexp_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       kwkexp = display.newSprite(kwkexp_sheet, kwkexp_seq ) 
       kwkexp:play(); 
       kwkexp.x = 416; kwkexp.y = 635; kwkexp.alpha = 1; kwkexp.oldAlpha = 1 
       kwkexp.xScale = 0.7; 
       kwkexp.yScale = 0.7; 
       kwkexp.oriX = kwkexp.x; kwkexp.oriY = kwkexp.y 
       kwkexp.name = "kwkexp" 
       menuGroup:insert(kwkexp); menuGroup.kwkexp = kwkexp 

       -- kwkjap positioning 
       local kwkjap_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=258, height=360 }, -- Japonesa_00000
               { x=262, y=2, width=258, height=360 }, -- Japonesa_00001
               { x=522, y=2, width=258, height=360 }, -- Japonesa_00002
               { x=2, y=364, width=258, height=360 }, -- Japonesa_00003
               { x=262, y=364, width=258, height=360 }, -- Japonesa_00004
               { x=522, y=364, width=258, height=360 }, -- Japonesa_00005
               { x=2, y=726, width=258, height=360 }, -- Japonesa_00006
               { x=262, y=726, width=258, height=360 }, -- Japonesa_00007
               { x=522, y=726, width=258, height=360 }, -- Japonesa_00008
           },
    
           sheetContentWidth = 782,
           sheetContentHeight = 1088
 
       } 
       kwkjap_sheet = graphics.newImageSheet( spriteDir.. "japonesa.png", kwkjap_options ) 
       kwkjap_seq = { name = "default", start = 1, count = 9, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       kwkjap = display.newSprite(kwkjap_sheet, kwkjap_seq ) 
       kwkjap:play(); 
       kwkjap.x = 160; kwkjap.y = 601; kwkjap.alpha = 1; kwkjap.oldAlpha = 1 
       kwkjap.oriX = kwkjap.x; kwkjap.oriY = kwkjap.y 
       kwkjap.name = "kwkjap" 
       menuGroup:insert(kwkjap); menuGroup.kwkjap = kwkjap 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       function cleanSprite() 
           kwkexp_sheet = nil; kwkexp = nil 
    kwkjap_sheet = nil; kwkjap = nil 
 
       end 

       -- (BOTTOM) External code will render here 
       require( "ControlScene" )

kwkexp:pause( )
kwkjap:pause( )

_G.Level = 4
_G.Phase = 2

local numbers = {one, two, three, four, five, six, seven}
local cont = 1

local function viewNumber( fun )
	-- body
	local function nextNumber( event )
		-- body
		fun(300)
	end
	numbers[cont].alpha = 1
	cont = cont + 1

	timerStash.timer_numberOso = timer.performWithDelay( 1000, nextNumber, 1 )	
end

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

local aud = {"exp_ja10.mp3", "exp_ja11.mp3", "exp_ja12.mp3", "exp_ja13.mp3", "exp_ja14.mp3", "exp_ja15.mp3", "exp_ja16.mp3", "exp_ja17.mp3"}
local sub = {"!Cuántos osos!, son muchísimos. Voy a contarlos:",
			"Uno",
			"Dos",
			"Tres",
			"Cuatro",
			"Cinco",
			"Seis",
			"Siete",}

addCharacter(kwkexp, aud, sub)

local aud2 = {"sakura_ja6.mp3"}
local sub2 = {"Bueno, pequeño, ya estás en casa; corre con tu mama."}

addCharacter(kwkjap, aud2, sub2)

local sec = {2, 1, 1, 1, 1, 1, 1, 1, 1}
setSecuence( sec )

local events = { nil, nil, {mytype = "effects", value = {1, viewNumber} },
						   {mytype = "effects", value = {1, viewNumber} },
						   {mytype = "effects", value = {1, viewNumber} },
						   {mytype = "effects", value = {1, viewNumber} },
						   {mytype = "effects", value = {1, viewNumber} },
						   {mytype = "effects", value = {1, viewNumber} },
						   {mytype = "effects", value = {1, viewNumber} }}
setEventsControlScene(events)

playScene( "page_15" ) 


    end 
    drawScreen() 

    function clean() 
       cleanSprite() 
    end 

    return menuGroup 
end 
