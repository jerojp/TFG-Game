media.pauseSound()
        local filePath = system.pathForFile("page_17.3gp", system.DocumentsDirectory ) 
        local file = io.open(filePath, "r") 
                   if file then 
                      io.close(file) 
                      media.playSound( "page_17.3gp", system.DocumentsDirectory, onCompleteSound ) 
        end  