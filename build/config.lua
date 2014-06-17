local kScale = "zoomStretch"
if ( string.sub( system.getInfo("model"), 1, 4 ) == "iPad" and display.pixelHeight == 1024) then     -- all iPads checking 
   application = 
   { 
        content  = 
        { 
             graphicsCompatibility = 1,   --- This turns on V1 Compatibility mode 
             width = 800, 
             height = 1280, 
             fps = 60, 
             scale = kScale, 
             imageSuffix = {  
                ["@2"] = .5, 
             }  
        }, 
   } 
elseif ( display.pixelHeight > 1024 ) then  -- iPhone 5 (and all other high-res devices) checking - uses the New iPad Retina image 
   application = 
   { 
        content  = 
        { 
             graphicsCompatibility = 1,   --- This turns on V1 Compatibility mode 
             width = 800, 
             height = 1280, 
             fps = 60, 
             scale = kScale, 
        }, 
   } 
else  -- all other devices 
   application = 
   { 
        content  = 
        { 
             graphicsCompatibility = 1,   --- This turns on V1 Compatibility mode 
             width = 800, 
             height = 1280, 
             fps = 60, 
             scale = kScale, 
             imageSuffix = {  
                ["@2"] = .4, 
             }  
        }, 
   } 
end 
