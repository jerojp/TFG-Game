-- Layer names 
       require( "textCoin" )
       require("MyDialog")
       local buyToy

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
       local left
       local doorLeft
       local textDoorLeft
       local textDoorLeft2
       local right
       local doorRight
       local textDoorRight
       local maxLevel = 10
       local kwkcoin
       local block
       local obj
       local textToy  
       local groupTextCoin = {}
       local groupImgCoin = {}
       local ch = 1
       local contDoor = 0

       local function playSoundToy( event )
              local object = event.target
              if event.phase == "began" then
                     display.getCurrentStage():setFocus(object)
                     object.isFocus = true
              elseif object.isFocus then
                     if event.phase == "ended" or event.phase == "cancelled" then
                            display.getCurrentStage():setFocus( nil )
                            object.isFocus = false
                            local audioHandle
                            local rot = -1
                            local function onCompleteSound( event )
                                   -- body
                                   audio.dispose( audioHandle )
                                   audioHandle = nil
                                   if (transitionStash["rot"]) then
                                      transition.cancel(transitionStash["rot"])
                                      transitionStash["rot"] = nil    
                                   end
                                   object.rotation = 0
                            end

                            if ( audio.isChannelActive( ch ) ) then
                                   audio.stop( ch )
                                   onCompleteSound()
                            end

                            local function onCompleteRot( obj )
                                   -- body
                                   rot = rot * -1
                                   transitionStash["rot"] = transition.to( obj, {time = 1000, rotation = rot*25, transition=easing.inOutCubic, onComplete = onCompleteRot} )       
                            end
                            transitionStash["rot"] = transition.to( object, {time = 1000, rotation = rot*25, transition=easing.inOutCubic, onComplete = onCompleteRot} )
                            audioHandle = audio.loadSound( audioDir..event.target.name..".mp3" )
                            audio.play( audioHandle, {duration = 6000, channel = ch, onComplete = onCompleteSound} )
                            print( "Reproducir sonido "..event.target.name )
                     end
              end
              return true  
       end

       local function checkBuy( object )
              -- body
              if (_G.Coin < object.cost) then
                     local myDialog
                     local function onCompleteCon( event )
                            -- body
                            local object = event.target
                            if event.phase == "began" then
                                   display.getCurrentStage():setFocus(object)
                                   object.isFocus = true
                            elseif object.isFocus then
                                   if event.phase == "ended" or event.phase == "cancelled" then
                                          display.getCurrentStage():setFocus( nil )
                                          object.isFocus = false
                                          deleteMyDialog(myDialog)
                                   end
                            end
                            return true
                     end
                     myDialog = createMyDialog("COMPRA DENEGADA", "No tienes suficiente dinero para comprar este juguete.", nil, "Confirmar", onCompleteCon)

              else
                     --print( groupTextCoin[object.index].name )
                     --print( groupImgCoin[object.index].name )
                     display.remove( groupTextCoin[object.index] )
                     groupTextCoin[object.index] = nil

                     display.remove( groupImgCoin[object.index] )
                     groupImgCoin[object.index] = nil              

                     _G.Toys[object.index].sold = true

                     object.alpha = 1.0

                     _G.Coin  = _G.Coin - object.cost
                     textCoinUpdate( object.cost, "substract" )

                     object:removeEventListener( "touch", buyToy )
                     object:addEventListener( "touch", playSoundToy )
                     print( "Eliminado evento buyToy de "..object.name )
              end
              return true
       end

       buyToy = function( event )
              -- body
              local object = event.target
              if event.phase == "began" then
                     display.getCurrentStage():setFocus(object)
                     object.isFocus = true
              elseif object.isFocus then
                     if event.phase == "ended" or event.phase == "cancelled" then
                            display.getCurrentStage():setFocus( nil )
                            object.isFocus = false
                            checkBuy(object)
                     end
              end
              return true         
       end

       local function createToys( )
              -- body
              local posBaseX = 280.66
              local posBaseY = 198.66
              local contToy = 0
              print( "TOTAL: "..menuGroup.numChildren )
              
              for i=1,#_G.UnlockToys do
                     table.insert( groupTextCoin, nil )
                     table.insert( groupImgCoin, nil )
               end 

              for i=1,#_G.UnlockToys do
                     obj = display.newImageRect( imgDir.._G.UnlockToys[i].path, _G.UnlockToys[i].widthToy, _G.UnlockToys[i].heightToy ); -- 135,81 unicornio
                     if ( math.fmod( contToy, 3) == 0) then
                            obj.x = display.contentCenterX - posBaseX 
                     elseif ( math.fmod( contToy, 3) == 1) then
                            obj.x = display.contentCenterX
                     else
                            obj.x = display.contentCenterX + posBaseX 
                     end
                     if ( contToy < 3) then
                            obj.y = display.contentCenterY - posBaseY
                     elseif ( contToy < 6) then
                            obj.y = display.contentCenterY
                     else
                            obj.y = display.contentCenterY + posBaseY
                     end
                     if (i == maxLevel) then
                            obj.x = display.contentCenterX + 20; obj.y = display.contentCenterY - posBaseY - 157;        
                     end 
                     obj.name = _G.UnlockToys[i].nameToy 
                     menuGroup:insert(obj);
                     obj.cost = _G.PriceToys[i]
                     obj.index = i
                     if (_G.Toys[i]) then
                            if (not _G.Toys[i].sold and i~=maxLevel) then
                                   textCost = display.newText( obj.cost, obj.x-5, obj.y + 71, native.systemFontBold, 25 )
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
                                   obj:addEventListener( "touch", buyToy )
                            else
                                   obj:addEventListener( "touch", playSoundToy )
                            end    
                     end
                     
                     textToy = display.newText( obj.name, obj.x, obj.y+112.5, native.systemFontBold, 25 )
                     textToy.x = textToy.x - textToy.contentWidth/2
                     if (i==maxLevel) then
                            textToy.y = obj.y + 85
                     end
                     menuGroup:insert(textToy)
                     contToy = contToy + 1
              end
              textCost = nil
              kwkcoin = nil
              print( "N: "..menuGroup.numChildren )
       end
       
       local function completeDoor( obj )
              -- body
              obj.alpha = 0
       end

       local function createCloset( )
              -- body
              local audioHandle

              local function onCompleteSoundDoor( event )
                     -- body
                     audio.dispose( audioHandle )
                     audioHandle = nil
              end

              audioHandle = audio.loadSound( audioDir.."stars.mp3" )
              audio.play( audioHandle, {duration = 3000, fadein = 2000, channel = ch, onComplete = onCompleteSoundDoor} )
              transitionStash.doorL = transition.to( left, {time = 2000, x = doorLeft.x - doorLeft.contentWidth/2, xScale = 0, onComplete = completeDoor} )
              transitionStash.doorR = transition.to( right, {time = 2000, x = doorRight.x + doorRight.contentWidth/2-5, xScale = 0, onComplete = completeDoor} )
              menuGroup:insert(left)
              menuGroup:insert(right)
       end

       _G.CurrentPage = curPage 

       print( "TOTOAL: "..menuGroup.numChildren )
       back = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
       back:setFillColor( 255, 249, 231 )
       menuGroup:insert(back)

       -- Estante positioning 
       Estante = display.newImageRect( imgDir.. "estanteJuguetes.png", 902.982  , 793.76 ); 
       Estante.x = display.contentCenterX ; Estante.y = display.contentCenterY;
       Estante.name = "Estante" 
       menuGroup:insert(Estante);

       left = display.newGroup( )
       doorLeft = display.newImageRect( imgDir.. "puertaEst.jpg", 420.284  , 596.293  ); 
       doorLeft.x = display.contentCenterX - doorLeft.contentWidth/2 ; doorLeft.y = display.contentCenterY+42;
       left:insert(doorLeft);

       local options = {
              text = "Arm\nd\n",     
              x = display.contentCenterX,
              y = display.contentCenterY,
              width = 180,     --required for multi-line and alignment
              font = native.systemFontBold,   
              fontSize = 75,
              align = "right"  --new alignment parameter
       }
       textDoorLeft = display.newText(options)
       textDoorLeft.x = display.contentCenterX - textDoorLeft.contentWidth/2 + 38
       textDoorLeft.y = doorLeft.y - 62
       textDoorLeft:setFillColor( 194, 146, 84 )
       left:insert(textDoorLeft)

       options = {
              text = "Jugu",     
              x = display.contentCenterX,
              y = display.contentCenterY,
              width = 180,     --required for multi-line and alignment
              font = native.systemFontBold,   
              fontSize = 75,
              align = "right"  --new alignment parameter
       }
       textDoorLeft2 = display.newText(options)
       textDoorLeft2.x = display.contentCenterX - textDoorLeft2.contentWidth/2 - 3
       textDoorLeft2.y = doorLeft.y + 75
       textDoorLeft2:setFillColor( 194, 146, 84 )
       left:insert(textDoorLeft2)

       right = display.newGroup( )
       doorRight = display.newImageRect( imgDir.. "puertaEst.jpg", 420.284  , 596.293  ); 
       doorRight.x = display.contentCenterX + doorRight.contentWidth/2 ; doorRight.y = display.contentCenterY+42;
       right:insert(doorRight);

       options = {
              text = "ario\ne\netes",     
              x = display.contentCenterX,
              y = display.contentCenterY,
              width = 150,     --required for multi-line and alignment
              font = native.systemFontBold,   
              fontSize = 75,
              align = "left"  --new alignment parameter
       }
       textDoorRight = display.newText(options)
       textDoorRight.x = display.contentCenterX + textDoorRight.contentWidth/2 + 3
       textDoorRight.y = doorLeft.y - 15.5
       textDoorRight:setFillColor( 194, 146, 84 )
       right:insert(textDoorRight)

       if (_G.StoreToysUnlocked) then
              createToys() 
              timerStash.createToys = timer.performWithDelay( 2000, createCloset )   
       else
              local myDialog
              local function onCompleteC( event )
              -- body
                     local object = event.target
                     if event.phase == "began" then
                            display.getCurrentStage():setFocus(object)
                            object.isFocus = true
                     elseif object.isFocus then
                            if event.phase == "ended" or event.phase == "cancelled" then
                                   display.getCurrentStage():setFocus( nil )
                                   object.isFocus = false
                                   deleteMyDialog(myDialog)
                                   director:changeScene("page_1", "fade")
                            end
                     end
                     return true
              end
              menuGroup:insert(left)
              menuGroup:insert(right)
              myDialog  = createMyDialog("Armario cerrado", "Lo siento, el genio todavia no ha desbloqueado este armario magico", nil, "Confirmar", onCompleteC)
              menuGroup:insert(myDialog)
       end
       menuGroup:insert( createTextCoin( ) )