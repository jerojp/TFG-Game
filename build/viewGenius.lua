function createGenius( )
       -- Tablet positioning 
       local geniusGroup = display.newGroup( )

       local Tablet = display.newImageRect( imgDir.. "tablet.png", 585, 800 ); 
       Tablet.x = 668; Tablet.y = 400; Tablet.alpha = 1; Tablet.oldAlpha = 1 
       Tablet.oriX = Tablet.x; Tablet.oriY = Tablet.y 
       Tablet.name = "Tablet" 
       geniusGroup:insert(Tablet); geniusGroup.Tablet = Tablet 

       -- genius positioning 
       local genius_options = { 
           -- created with TexturePacker (http://www.texturepacker.com)
           frames = {
             
               { x=2, y=2, width=283, height=615 }, -- Genio_00000
               { x=287, y=2, width=283, height=615 }, -- Genio_00001
               { x=572, y=2, width=283, height=615 }, -- Genio_00002
               { x=857, y=2, width=283, height=615 }, -- Genio_00003
               { x=1142, y=2, width=283, height=615 }, -- Genio_00004
               { x=1427, y=2, width=283, height=615 }, -- Genio_00005
               { x=1712, y=2, width=283, height=615 }, -- Genio_00006
               { x=2, y=619, width=283, height=615 }, -- Genio_00007
               { x=287, y=619, width=283, height=615 }, -- Genio_00009
               { x=572, y=619, width=283, height=615 }, -- Genio_00010
               { x=857, y=619, width=283, height=615 }, -- Genio_00011
               { x=1142, y=619, width=283, height=615 }, -- Genio_00012
               { x=1427, y=619, width=283, height=615 }, -- Genio_00014
               { x=1712, y=619, width=283, height=615 }, -- Genio_00015
           },
    
           sheetContentWidth = 1997,
           sheetContentHeight = 1236
 
       } 
       local genius_sheet = graphics.newImageSheet( spriteDir.. "genio.png", genius_options ) 
       genius_seq = { name = "default", start = 1, count = 17, time = 1000, loopCount = 0, loopDirection = "bounce" }; 
       local genius = display.newSprite(genius_sheet, genius_seq ) 
       genius:play(); 
       genius.x = 688; genius.y = 389; genius.alpha = 1; genius.oldAlpha = 1 
       genius.oriX = genius.x; genius.oriY = genius.y 
       genius.name = "genius" 
       gSprites.gen = genius
       geniusGroup:insert(genius); geniusGroup.genius = genius 

       return geniusGroup
end