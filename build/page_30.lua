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

       local curPage = 30 
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
       local FondoBrasil  

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 
       local danceGroup = display.newGroup()
local audioHandle

audioHandle = audio.loadSound( audioDir.."samba.mp3" )

local kwkgirl_options = { 
   -- created with TexturePacker (http://www.texturepacker.com)
   frames = {
     
       { x=2, y=2, width=180, height=265 }, -- carnavalMujer_00000
       { x=184, y=2, width=180, height=265 }, -- carnavalMujer_00001
       { x=366, y=2, width=180, height=265 }, -- carnavalMujer_00002
       { x=548, y=2, width=180, height=265 }, -- carnavalMujer_00003
       { x=730, y=2, width=180, height=265 }, -- carnavalMujer_00004
       { x=2, y=269, width=180, height=265 }, -- carnavalMujer_00005
       { x=184, y=269, width=180, height=265 }, -- carnavalMujer_00006
       { x=366, y=269, width=180, height=265 }, -- carnavalMujer_00007
       { x=548, y=269, width=180, height=265 }, -- carnavalMujer_00008
       { x=730, y=269, width=180, height=265 }, -- carnavalMujer_00009
       { x=2, y=536, width=180, height=265 }, -- carnavalMujer_00010
       { x=184, y=536, width=180, height=265 }, -- carnavalMujer_00011
       { x=366, y=536, width=180, height=265 }, -- carnavalMujer_00012
       { x=548, y=536, width=180, height=265 }, -- carnavalMujer_00013
       { x=730, y=536, width=180, height=265 }, -- carnavalMujer_00014
       { x=2, y=803, width=180, height=265 }, -- carnavalMujer_00015
       { x=184, y=803, width=180, height=265 }, -- carnavalMujer_00016
   },

   sheetContentWidth = 912,
   sheetContentHeight = 1070

} 
local kwkgirl_sheet = graphics.newImageSheet( spriteDir.. "mujerbaila.png", kwkgirl_options ) 
local kwkgirl_seq = { name = "default", start = 1, count = 17, time = 950, loopCount = 0, loopDirection = "bounce" }; 
local kwkgirl = display.newSprite(kwkgirl_sheet, kwkgirl_seq ) 
kwkgirl:play(); 
kwkgirl.x = 164; kwkgirl.y = 233;
danceGroup:insert(kwkgirl); 

-- kwkexp positioning 
local kwkexp_options = { 
   -- created with TexturePacker (http://www.texturepacker.com)
   frames = {
     
       { x=0, y=0, width=175, height=272 }, -- exploradorDisfrazBaila_00000
       { x=175, y=0, width=175, height=272 }, -- exploradorDisfrazBaila_00001
       { x=350, y=0, width=175, height=272 }, -- exploradorDisfrazBaila_00002
       { x=525, y=0, width=175, height=272 }, -- exploradorDisfrazBaila_00003
       { x=700, y=0, width=175, height=272 }, -- exploradorDisfrazBaila_00004
       { x=0, y=272, width=175, height=272 }, -- exploradorDisfrazBaila_00005
       { x=175, y=272, width=175, height=272 }, -- exploradorDisfrazBaila_00006
       { x=350, y=272, width=175, height=272 }, -- exploradorDisfrazBaila_00007
       { x=525, y=272, width=175, height=272 }, -- exploradorDisfrazBaila_00008
       { x=700, y=272, width=175, height=272 }, -- exploradorDisfrazBaila_00009
       { x=0, y=544, width=175, height=272 }, -- exploradorDisfrazBaila_00010
       { x=175, y=544, width=175, height=272 }, -- exploradorDisfrazBaila_00011
       { x=350, y=544, width=175, height=272 }, -- exploradorDisfrazBaila_00012
       { x=525, y=544, width=175, height=272 }, -- exploradorDisfrazBaila_00013
       { x=700, y=544, width=175, height=272 }, -- exploradorDisfrazBaila_00014
       { x=0, y=816, width=175, height=272 }, -- exploradorDisfrazBaila_00015
       { x=175, y=816, width=175, height=272 }, -- exploradorDisfrazBaila_00016
   },

   sheetContentWidth = 875,
   sheetContentHeight = 1088

} 
local kwkexp_sheet = graphics.newImageSheet( spriteDir.. "expbaila.png", kwkexp_options ) 
local kwkexp_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
local kwkexp = display.newSprite(kwkexp_sheet, kwkexp_seq ) 
kwkexp:play(); 
kwkexp.x = 370; kwkexp.y = 260;
kwkexp.xScale = 1.55; 
kwkexp.yScale = 1.57;  
danceGroup:insert(kwkexp); 

local kwkPrin_options = { 
   -- created with TexturePacker (http://www.texturepacker.com)
   frames = {
     
       { x=2, y=2, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00000
       { x=214, y=2, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00001
       { x=426, y=2, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00002
       { x=638, y=2, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00003
       { x=850, y=2, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00004
       { x=1062, y=2, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00005
       { x=1274, y=2, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00006
       { x=1486, y=2, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00007
       { x=2, y=365, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00008
       { x=214, y=365, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00009
       { x=426, y=365, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00010
       { x=638, y=365, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00011
       { x=850, y=365, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00012
       { x=1062, y=365, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00013
       { x=1274, y=365, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00014
       { x=1486, y=365, width=210, height=361 }, -- niÃ±aDisfrazPricesa_00015
   },

   sheetContentWidth = 1698,
   sheetContentHeight = 728

} 
kwkPrin_sheet = graphics.newImageSheet( spriteDir.. "princesa.png", kwkPrin_options ) 
kwkPrin_seq = { name = "default", start = 1, count = 16, time = 1300, loopCount = 0, loopDirection = "forward" }; 
kwkPrin = display.newSprite(kwkPrin_sheet, kwkPrin_seq ) 
kwkPrin:play(); 
kwkPrin.x = 540; kwkPrin.y = 300;  
kwkPrin.xScale = 0.95 
kwkPrin.yScale = 0.95
danceGroup:insert(kwkPrin);

-- carrozaSimple positioning 
local carrozaSimple = display.newImageRect( imgDir.. "carrozaSimple.png", 672, 328 ); 
carrozaSimple.x = 370; carrozaSimple.y = 525;
danceGroup:insert(carrozaSimple); 
danceGroup.alpha = 0
menuGroup:insert( danceGroup )

danceGroup:translate( -danceGroup[4].contentWidth , 0 )

local function onCompleteTransition( event )
-- body
if ( audio.isChannelPlaying( 2 ) ) then
  audio.stop( 2 )
end
audio.dispose( audioHandle )
audioHandle = nil
cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
_G.Level = 1
_G.Phase = 2
local parameters = {nameToy="Antifaz", pathToy="objeto111.png", widthToy = 139 , heightToy = 40, nextPage = "page_31"}
director:changeScene( parameters, "viewNewToy", "fade" )
end

audio.play( audioHandle, {channel = 2} )
danceGroup.alpha = 1
transitionStash.danceGroup = transition.to( danceGroup, {  time=20000, x= display.contentWidth + danceGroup[4].contentWidth , y=0, onComplete=onCompleteTransition} )
 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level].page = curPage
_G.LastPageLevel[_G.Level].phase = _G.Phase 

       -- FondoBrasil positioning 
       FondoBrasil = display.newImageRect( imgDir.. "p30_fondobrasil.png", 1288, 809 ); 
       FondoBrasil.x = 644; FondoBrasil.y = 395; FondoBrasil.alpha = 1; FondoBrasil.oldAlpha = 1 
       FondoBrasil.oriX = FondoBrasil.x; FondoBrasil.oriY = FondoBrasil.y 
       FondoBrasil.name = "FondoBrasil" 
       menuGroup:insert(1,FondoBrasil); menuGroup.FondoBrasil = FondoBrasil 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
