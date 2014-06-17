  -- Button event listeners 
       local function onbtnEasyEvent(event) 
          butEasy(btnEasy) 
          return true 
       end 
       btnEasy:addEventListener("tap", onbtnEasyEvent ) 
       local function onbtnHardEvent(event) 
          butHard(btnHard) 
          return true 
       end 
       btnHard:addEventListener("tap", onbtnHardEvent ) 
       local function onbtnNormalEvent(event) 
          butNormal(btnNormal) 
          return true 
       end 
       btnNormal:addEventListener("tap", onbtnNormalEvent ) 

       -- Button functions 
       function butEasy(self) 
           _G.DifficultLevel = 1
           CurrentPage = 3
          saveKwikVars({"CurrentPage",3}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_3", "fade" ) 
            end 
            timerStash.newTimer_238 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

       function butNormal(self) 
           _G.DifficultLevel = 2
           CurrentPage = 3
          saveKwikVars({"CurrentPage",3}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_3", "fade" ) 
            end 
            timerStash.newTimer_246 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 
       
       function butHard(self) 
           _G.DifficultLevel = 3
           CurrentPage = 3
          saveKwikVars({"CurrentPage",3}) 
            local myClosure_switch = function() 
                dispose(); director:changeScene( "page_3", "fade" ) 
            end 
            timerStash.newTimer_242 = timer.performWithDelay(0, myClosure_switch, 1) 
       end 

