-- Layer names 
       require( "textCoin" )
       local Estante  
       local objeto111  
       local objeto241  
       local objeto321  
       local objeto341  
       local oveja  
       local objeto541  
       local objeto352  
       local objeto552  
       local indio  
       local objeto141
       local maxLevel = 10
       local baseCost = 50
       local kwkcoin
       local block
       local obj
       local textToy  
       local groupTextCoin = {}
       local groupImgCoin = {}
       local ch = 1

       local function soundErrorGenius( event )
              -- body
              --[[local audioHandle
              local function onCompleteSoundError( event )
                     -- body
                     audio.dispose( audioHandle )
                     audioHandle = nil
              end

              if ( audio.isChannelActive( ch ) ) then
                     audio.stop( ch )
              end

              audioHandle = audio.loadSound( audioDir.."geniusExpNotBuyToy.mp3" )
              audio.play( audioHandle, {channel = ch, onComplete = onCompleteSoundError} )
              ]]--
              print( "Reproducir audio Genio" )
       end

       local function playSoundToy( event )
              -- body
              --[[local audioHandle
              local function onCompleteSound( event )
                     -- body
                     audio.dispose( audioHandle )
                     audioHandle = nil
              end

              if ( audio.isChannelActive( ch ) ) then
                     audio.stop( ch )
              end
              
              audioHandle = audio.loadSound( audioDir..event.target.name )
              audio.play( audioHandle, {channel = ch, onComplete = onCompleteSound} )]]--
              print( "Reproducir sonido "..event.target.name )
       end

       local function buyToy( event )
              -- body
              local object = event.target

              print( groupTextCoin[object.index].name )
              print( groupImgCoin[object.index].name )
              display.remove( groupTextCoin[object.index] )
              groupTextCoin[object.index] = nil

              display.remove( groupImgCoin[object.index] )
              groupImgCoin[object.index] = nil              

              _G.Toys[object.index].sold = true

              object.alpha = 1.0

              textCoinUpdate( object.cost, "substract" )

              object:removeEventListener( "tap", buyToy )
              object:addEventListener( "tap", playSoundToy )
              print( "Eliminado evento buyToy de "..object.name )
              return true
       end

       -- (TOP) External code will render here 
       _G.CurrentPage = curPage 

       -- Estante positioning 
       Estante = display.newImageRect( imgDir.. "estanteJuguetes.jpg", 1279, 800 ); 
       Estante.x = 639; Estante.y = 400;
       Estante.name = "Estante" 
       menuGroup:insert(1,Estante);

       -- objeto111 positioning 
       objeto111 = display.newImageRect( imgDir.. "objeto111.png", 251, 85 ); 
       objeto111.x = 140; objeto111.y = 282;
       objeto111.name = "Antifaz" 
       menuGroup:insert(objeto111);

       -- objeto141 positioning 
       objeto141 = display.newImageRect( imgDir.. "objeto141.png", 233, 168 ); 
       objeto141.x = 415; objeto141.y = 282; 
       objeto141.name = "Abeja" 
       menuGroup:insert(objeto141);

       -- objeto241 positioning 
       objeto241 = display.newImageRect( imgDir.. "objeto241.png", 233, 168 ); 
       objeto241.x = 681; objeto241.y = 282;
       objeto241.name = "Elefante" 
       menuGroup:insert(objeto241);

       -- objeto321 positioning 
       objeto321 = display.newImageRect( imgDir.. "objeto321.png", 199, 166 ); 
       objeto321.x = 933; objeto321.y = 282;
       objeto321.name = "Bicicleta" 
       menuGroup:insert(objeto321);

       -- indio positioning 
       indio = display.newImageRect( imgDir.. "indio.png", 187, 178 ); 
       indio.x = 1164; indio.y = 282; 
       indio.name = "Indio" 
       menuGroup:insert(indio);

       -- objeto341 positioning 
       objeto341 = display.newImageRect( imgDir.. "objeto341.png", 250, 152 ); 
       objeto341.x = 141; objeto341.y = 590;
       objeto341.name = "Delfin" 
       menuGroup:insert(objeto341);

       -- oveja positioning 
       oveja = display.newImageRect( imgDir.. "oveja.png", 233, 133 ); 
       oveja.x = 415; oveja.y = 590;
       oveja.name = "Oveja" 
       menuGroup:insert(oveja); 

       -- objeto541 positioning 
       objeto541 = display.newImageRect( imgDir.. "objeto541.png", 238, 152 ); 
       objeto541.x = 679; objeto541.y = 590; 
       objeto541.name = "Burro" 
       menuGroup:insert(objeto541); 

       -- objeto352 positioning 
       objeto352 = display.newImageRect( imgDir.. "objeto352.png", 199, 93 ); 
       objeto352.x = 931; objeto352.y = 590;
       objeto352.name = "Guitarra" 
       menuGroup:insert(objeto352); 

       -- objeto552 positioning 
       objeto552 = display.newImageRect( imgDir.. "objeto552.png", 209, 154 ); 
       objeto552.x = 1169; objeto552.y = 590; 
       objeto552.name = "Unicornio" 
       menuGroup:insert(objeto552);

       _G.Toys[3].block = false
       
       for i=1,maxLevel do
              table.insert( groupTextCoin, nil )
              table.insert( groupImgCoin, nil )
        end 
       for i=1,maxLevel do
              obj = menuGroup[i+1]
              obj.cost = baseCost*i
              obj.index = i
              if (_G.Toys[i]) then
                     if (_G.Toys[i].block) then
                            block = display.newImageRect( imgDir.. "block.png", 128, 129 )
                            block.x = obj.x ; block.y = obj.y 
                            menuGroup:insert( block )
                            obj.alpha = 0.3
                            obj:addEventListener( "tap", soundErrorGenius )
                     elseif (not _G.Toys[i].sold) then
                            textCost = display.newText( obj.cost, obj.x, obj.y + 132, native.systemFontBold, 25 )
                            textCost.x = textCost.x - textCost.contentWidth/2
                            textCost:setTextColor (229, 185, 89)
                            textCost.name = "cost"..obj.name 
                            groupTextCoin[i] = textCost
                            menuGroup:insert( textCost )
                            kwkcoin = display.newImageRect( imgDir.. "kwkcoin.png", 34, 27 ); 
                            kwkcoin.x = textCost.x + textCost.contentWidth + 5 ; kwkcoin.y = textCost.y; 
                            kwkcoin.name = "imgcoin"..obj.name
                            groupImgCoin[i] = kwkcoin
                            menuGroup:insert(kwkcoin)

                            obj:addEventListener( "tap", buyToy )
                     else
                            obj:addEventListener( "tap", playSoundToy )
                     end    
              end

              textToy = display.newText( obj.name, obj.x, obj.y + 182, native.systemFontBold, 25 )
              textToy.x = textToy.x - textToy.contentWidth/2
              menuGroup:insert(textToy)
       end
       textCost = nil
       kwkcoin = nil 

       menuGroup:insert( createTextCoin( ) )