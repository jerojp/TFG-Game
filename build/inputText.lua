      require("MyDialog")
      -- Button names 
       local butConfirm
       -- Action names 
       local actConfirmName 
       -- Layer names 
       local textInputName  
       local inputName  
       local kwkbuttonConfir  
       local name

       -- (TOP) External code will render here 


       -- textInputName positioning 
       textInputName = display.newImageRect( imgDir.. "p6_textinputname.png", 695, 93 ); 
       textInputName.x = 676; textInputName.y = 133; textInputName.alpha = 1; textInputName.oldAlpha = 1 
       textInputName.oriX = textInputName.x; textInputName.oriY = textInputName.y 
       textInputName.name = "textInputName" 
       menuGroup:insert(textInputName); menuGroup.textInputName = textInputName 

       -- inputName positioning 
       local function fieldHandler_inputName(event) 
               if ( event.phase == "submitted" or event.phase == "ended" )  then  
                  name = event.target.text
                  native.setKeyboardFocus(nil) 
               end  
       end 

       inputName = native.newTextField( 177, 270, 1000, 100 )  
       inputName.placeholder = "Nombre"
       inputName.font = native.newFont( native.systemFontBold, 24 ) 
       inputName:addEventListener( "userInput", fieldHandler_inputName ) 
       inputName.oriX = inputName.x; inputName.oriY = inputName.y 

       -- kwkbuttonConfir positioning 
       kwkbuttonConfir = display.newImageRect( imgDir.. "kwkbuttonconfir.png", 348, 86 ); 
       kwkbuttonConfir.x = 678; kwkbuttonConfir.y = 553; kwkbuttonConfir.alpha = 1; kwkbuttonConfir.oldAlpha = 1 
       kwkbuttonConfir.oriX = kwkbuttonConfir.x; kwkbuttonConfir.oriY = kwkbuttonConfir.y 
       kwkbuttonConfir.name = "kwkbuttonConfir" 
       menuGroup:insert(kwkbuttonConfir); menuGroup.kwkbuttonConfir = kwkbuttonConfir 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
 
       -- Actions (functions) 
       function actConfirmName(event) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_7", "fade" ) 
            end 
            timerStash.newTimer_333 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

 
      --End Actions (functions) 


       -- Button event listeners 
       local function onkwkbuttonConfirEvent(event) 
          butConfirm(kwkbuttonConfir) 
          return true 
       end 
       kwkbuttonConfir:addEventListener("tap", onkwkbuttonConfirEvent ) 

       -- Button functions 
       function butConfirm(self)
          local miDialog 
          if (name==nil or name="") and system.getInfo("environment")=="device" then
            local function listenerC( event )
              -- body
              local myDialog
              
              local function functionC( event )
                -- body
                local object = event.target

                if event.phase == "began" then
                  display.getCurrentStage():setFocus(object)
                  object.isFocus = true
                elseif object.isFocus then
                  if event.phase == "ended" or event.phase == "cancelled" then
                      display.getCurrentStage():setFocus( nil )
                      object.isFocus = false

                      deleteMyDialog( myDialog )
                  end
                end
                return true
              end
            end
            myDialog = createMyDialog( "ADVERTENCIA", "Debes introducir tu nombre.", nil, "Vale", listenerC)
          else
            local myClosure_switch = function()
                dispose(); director:changeScene( "page_7", "fade" ) 
            end 
            _G.NameUser = name
            timerStash.newTimer_391 = timer.performWithDelay(0, myClosure_switch, 1) 
          end
       end 
