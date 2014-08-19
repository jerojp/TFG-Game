module(..., package.seeall) 
local widget = require( "widget" )
function new(parameters) 
    local numPages = 66 
    local menuGroup = display.newGroup() 
    local dispose 
    local _W = display.contentWidth; 
    local _H = display.contentHeight; 
    local nextScene = parameters.nextPage
    local nameToy = parameters.nameToy
    local pathToy = parameters.pathToy
    local widthToy = parameters.widthToy
    local heightToy = parameters.heightToy
    local costToy = parameters.costToy

    local drawScreen = function() 

       local curPage = 66 

       Navigation.new("page", { backColor = {255, 255, 255}, anim=1, timer=1,  totPages = numPages, curPage = curPage, thumbW = 200, thumbH = 125, alpha = 1, imageDir = imgDir, dire = "top", audio={} } ) 
       Navigation.hide() 

       if (tonumber(kBookmark) == 1) then 
          local path = system.pathForFile( "book.txt", system.DocumentsDirectory ) 
          local file = io.open( path, "w+" ) 
          file:write ( curPage.."\n1" ) 
          io.close( file ) 
       end 

       math.randomseed(os.time()) 

       if (tonumber(_G.kAutoPlay) > 0) then 
          local function act_autoPlay(event) 
             if(curPage < numPages) then 
                if(kBidi == false) then  
                   dispose(); director:changeScene( "page_"..curPage+1, "moveFromRight" ) 
                else  
                   dispose(); director:changeScene( "page_"..curPage-1, "moveFromLeft" ) 
                end  
             end 
          end 
          timerStash.timer_AP = timer.performWithDelay( _G.kAutoPlay*1000, act_autoPlay, 1 ) 
       end 

        local groupCost = display.newGroup( )
        local groupStars = display.newGroup( )
        local audioHandle
 	
 		local background = display.newRect( 0, 0, display.contentWidth , display.contentHeight )
 		background:setFillColor( 237, 216, 197 )
 		menuGroup:insert(background)

        local backPanel = display.newRoundedRect( 0, 0, 500, 600, 5 )
		backPanel.x = display.contentCenterX; backPanel.y = display.contentCenterY
		backPanel:setFillColor( 0 )
		menuGroup:insert( backPanel )

		local frontPanel = display.newRoundedRect( 0, 0, 480, 580, 5 )
		frontPanel.x = display.contentCenterX; frontPanel.y = display.contentCenterY
		frontPanel:setFillColor( 255 )
		menuGroup:insert(frontPanel)

		local toy = display.newImageRect( imgDir..pathToy, widthToy, heightToy ); 
       	toy.x = display.contentCenterX; toy.y = frontPanel.y - frontPanel.contentHeight/2 + toy.contentHeight/2 + 80 ; 
       	menuGroup:insert(toy);

       	local textCost = display.newText( costToy, 0, 0, native.systemFontBold, 45 )
        textCost:setTextColor (229, 185, 89)
        groupCost:insert( textCost )

        local kwkcoin = display.newImageRect( imgDir.. "kwkcoin.png", 68, 54 ); 
        kwkcoin.x = textCost.x + textCost.contentWidth + 5 ; kwkcoin.y = textCost.y; 
        groupCost:insert( kwkcoin )

        groupCost.x = display.contentCenterX - groupCost.contentWidth/2 ; groupCost.y = toy.y + toy.contentHeight/2 + 40

        menuGroup:insert(groupCost)

        local textToy = display.newText( nameToy, display.contentCenterX, groupCost.y + 80, native.systemFontBold, 40 )
        textToy.x = textToy.x - textToy.contentWidth/2
        textToy:setFillColor( 0 )
        menuGroup:insert(textToy)

        local function goNextPage( event )
        	-- body
        	local object = event.target
        	if event.phase == "began" then
        		display.getCurrentStage():setFocus(object)
        		object.isFocus = true
    		elseif object.isFocus then
        		if event.phase == "ended" or event.phase == "cancelled" then
        			display.getCurrentStage():setFocus( nil )
					object.isFocus = false
        			dispose(); director:changeScene( nextScene, "fade" )
        		end
    		end
			return true
        end

        local btnConfirm = widget.newButton{
			width = 140,
    		height = 60,
    		defaultFile = imgDir.. "button.png",
    		--overFile = imgDir.. "button.png",
    		label = "Continuar",
    		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 210 } },
    		fontSize = 25,
    		onEvent = goNextPage
		}

		btnConfirm.x = display.contentCenterX
		btnConfirm.y = backPanel.y + backPanel.contentHeight/2 + 50
		btnConfirm.alpha = 0

		local function onCompleteTransition( event )
			-- body
			if ( audio.isChannelActive( 1 ) ) then
				audio.stop()
			end
			audio.dispose( audioHandle )
        	audioHandle = nil
			groupStars.alpha = 0
			btnConfirm.alpha = 1
		end

		local an
		local n_div = 15
		local radius = 150
		local star
		for i=0,n_div do
            an = (2*math.pi/n_div)*i;
            star = display.newImageRect( imgDir.."star.png", 55, 55 ); 
       		star.x = radius*math.cos(an); star.y = radius*math.sin(an); 
       		groupStars:insert(star);
      	end
      	menuGroup:insert(groupStars)
      	groupStars.x = display.contentCenterX
      	groupStars.y = display.contentCenterY
      	groupStars:scale( 0, 0 )
              
        audioHandle = audio.loadSound( audioDir.."stars.mp3" )

        local function onCompleteTimer( event )
        	-- body
        	transition.to( groupStars, {  time=2000, xScale=1.5, yScale=1.5, alpha = 0.2, rotation = 340, onComplete=onCompleteTransition} )
      		audio.play( audioHandle, {channel = 1, duration = 3000, fadein = 2000} )
        end
      	timerStash.timer_stars = timer.performWithDelay( 600, onCompleteTimer, 1 )

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 

