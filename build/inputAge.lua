      require("MyDialog")
      -- Button names 
       local butConfirm
       -- Action names 
       local actConfirmName 
       -- Layer names 
       local textInputName  
       local inputName  
       local kwkbuttonConfir 
       --others 
       local age

       -- textInputName positioning
       textInputName = display.newText( "Introduce tu edad:", 676, 133, native.systemFontBold, 28 )
       textInputName.x = 676; textInputName.y = 133;
       menuGroup:insert(textInputName); menuGroup.textInputName = textInputName 

       -- inputName positioning 
       local function fieldHandler_inputName(event) 
               if ( event.phase == "submitted" or event.phase == "ended" )  then  
                  age = event.target.text
                  native.setKeyboardFocus(nil) 
               end  
       end 

       inputName = native.newTextField( 177, 270, 1000, 100 )  
       inputName.placeholder = "Edad"
       inputName.font = native.newFont( native.systemFontBold, 24 ) 
       inputName:addEventListener( "userInput", fieldHandler_inputName ) 

       -- kwkbuttonConfir positioning 
       kwkbuttonConfir = display.newImageRect( imgDir.. "kwkbuttonconfir.png", 348, 86 ); 
       kwkbuttonConfir.x = 678; kwkbuttonConfir.y = 553; 
       menuGroup:insert(kwkbuttonConfir); menuGroup.kwkbuttonConfir = kwkbuttonConfir 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 
 
       -- Actions (functions) 
       function actConfirmName(event) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_63", "fade" ) 
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
          local myClosure_switch = function()
              dispose(); director:changeScene( "page_63", "fade" ) 
          end 
          if (age==nil or age=="") then
            if (system.getInfo("environment")=="device") then
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
              myDialog = createMyDialog( "ADVERTENCIA", "Debes introducir tu edad.", nil, "Vale", listenerC)  
            else
              _G.Age = "3"
              timerStash.newTimer_391 = timer.performWithDelay(0, myClosure_switch, 1) 
            end
          else
            _G.Age = age
            timerStash.newTimer_391 = timer.performWithDelay(0, myClosure_switch, 1) 
          end
       end 
