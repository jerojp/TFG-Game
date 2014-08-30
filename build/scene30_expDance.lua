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
       local kwkgirl_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
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

       -- carrozaSimple positioning 
       local carrozaSimple = display.newImageRect( imgDir.. "carrozaSimple.png", 672, 575 ); 
       carrozaSimple.x = 370; carrozaSimple.y = 395;
       danceGroup:insert(carrozaSimple); 
       danceGroup.alpha = 0
       menuGroup:insert( danceGroup )

       danceGroup:translate( -danceGroup[3].contentWidth , 0 )

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
        local parameters = {nameToy="Antifaz", pathToy="objeto111.png", costToy=_G.PriceToys.mask, widthToy = 233*1.5 , heightToy = 168*1.5, nextPage = "page_31", indexToy = 1}
        director:changeScene( parameters, "viewNewToy", "fade" )
       end

       audio.play( audioHandle, {channel = 2} )
       danceGroup.alpha = 1
       transitionStash.danceGroup = transition.to( danceGroup, {  time=20000, x= display.contentWidth + danceGroup[3].contentWidth , y=0, onComplete=onCompleteTransition} )
