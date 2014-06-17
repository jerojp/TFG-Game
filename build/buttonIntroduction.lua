  local widget = require( "widget" )

  -- Button names 
       local butIntroduction

 
 		local btnIniciar = widget.newButton
{
    left = 689,
    top = 192,
    id = "iniciar",
    label = "Introduccion",
    fontSize = 25,
    defaultFile = imgDir.. "kwkbutton.png",
    onEvent = onbuttonEvent
}
menuGroup:insert(btnIniciar); menuGroup.btnIniciar = btnIniciar 
       -- Button event listeners 
       local function onbuttonEvent(event) 
          butIntroduction(btnIniciar) 
          return true 
       end 

       -- Button functions 
       function butIntroduction(self) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_2", "fade" ) 
            end 
            timerStash.newTimer_334 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

