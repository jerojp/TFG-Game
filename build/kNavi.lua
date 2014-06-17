--===================================================================--
-- kNavi.lua (creates navigation for thumbnails)
--
-- by Kwiksher
-- version 1: April 12, 2012
-- version 2: October, 15, 2012 //ability to NOT show some pages (exclude={})
-- version 3: November, 19, 2012 //re-written to use scrollView widget
-- version 3.1: November 20, 2012 //dispose of animations and timers, when they exist
-- version 3.2: November 21, 2012 //starts the view with the current page as the first
-- version 3.3: November 27, 2012 //shows the correct pages in the navigation menu
-- version 3.4: December 10, 2012 //separates content from the background and fix scrolling when just 1-2 thumbs exist
-- version 3.5: December 13, 2012 //compatibility with Director/Storyboard 1.5
-- version 3.6: January 2, 2013 //hides the navigator if it is opened after 10s
-- version 3.7: March 13, 2013 //add variable to control disposal of Multiplier objects (under menuItemTap)
-- version 3.8: March 28, 2013 //scrollView compatibility with Widget 2.0
-- version 3.9: January 10, 2014 //scrollView compatibility with Widget 2.0 - fix with help of Alex from Corona (there is still an issue with the scrolling back showing only page 2)
--===================================================================--
-- Sintaxe:
-- Navigation.show( g1, { backColor = {255,255,0}, alpha = alpha, totPages = numPages, curPage = curPage, thumbW = 120, thumbH = 70, imageDir = imgDir, dire = "right"} )
-- navGroup holds all navigation elements
-- navBack holds the rect or image acting as background for the navigation
-- navItems holds all thumbnails

local widget = require("widget") 

local Navigation = {}
local navShow = 0

Navigation.new = function( obj, params )
	params = params or {}
    local spacer = 10 --pixels distance between images

	local audios = params.audio

	local _W = display.contentWidth
	local _H = display.contentHeight
	
	local numAnim = params.anim
	local numTimers = params.timer
	
	local thumbW = params.thumbW
	local thumbH = params.thumbH
	local dire = params.dire
	local cpage = params.curPage
	
	
	--creates group for the full navigation
	kNavig = display.newGroup()
	kNavig.x = 0; kNavig.y = 0

	local pageList = {}
	local notShow --table with pages who should not appear in the navigation

	--Loads all images to the table
	for i = 1,params.totPages do
		--checks if page shows
		local k, v
		if (params.exclude == nil) then
		  notShow = {-1}
		else
		  notShow = params.exclude
		end

		local c = 0 --control
		--builds the navigation
		for xc = 1,#notShow do
			--print("i: "..i.." xc: "..xc.." notShow[xc]: ".. notShow[xc].." c: "..c)
			if (i==notShow[xc]) then
				c = notShow[xc]
				break
			else 
				c = 0 
			end
		end
			
		if (c==0) then
			--print ("show "..i)
			table.insert(pageList, {params.imageDir.."p"..i.."_thumb.jpg", i})
		else 
			--print("do not show "..i)
		end
				
    end


    --sets background
    local nTop, nLeft, nWidth, nHeight, nVert, nHor
    if (params.dire == "top") then
    	nTop = 0; nLeft = 0; 
    	nWidth = _W; 
    	nHeight = (spacer * 2) + params.thumbH; 
    	nVert = true; nHor = false
    elseif (params.dire == "bottom") then
    	nTop = _H - (params.thumbH + (spacer * 2)); 
    	nLeft = 0; nWidth = _W; 
    	nHeight = (spacer * 2) + params.thumbH; 
    	nVert = true; nHor = false
    elseif (params.dire == "left") then
    	nTop = 0; 
    	nLeft = 0; 
    	nWidth = params.thumbW + (spacer * 2); 
    	nHeight = _H; 
    	nVert = false; nHor = true
    elseif (params.dire == "right") then
    	nTop = 0; 
    	nLeft = _W - (params.thumbW + (spacer * 2)); 
    	nWidth = params.thumbW + (spacer * 2); 
    	nHeight = _H; 
    	nVert = false; nHor = true
	end
	
	--creates the background
	local naviBackground = display.newRect( nLeft, nTop, nWidth, nHeight ) 
       naviBackground:setFillColor (params.backColor[1],params.backColor[2],params.backColor[3]) 
       naviBackground.alpha = params.alpha; 
       kNavig:insert(naviBackground);

	--create navigation
	local navItems = display.newGroup()
	--navGroup:insert(navItems)
	
	--controls thumbnails actions
	local menuItemTap = function ( event )
		if curPage  ~= event.target.id then -- director.getCurrBookPageNum() ~= event.target.id then
			local togo = "page_"..event.target.id
			
			--variable to control disposal on runtime events for multipliers
			_G.disposeMultiplier = 1

			if (#audios > 0) then
				--dispose audios
				for x = 1,#audios do
					audio.stop(audios[x][1]); audio.dispose(audios[x][2]); audios[x][2] = nil
				end
			end
			if (numAnim==1) then
				cancelAllTweens();cancelAllTransitions()
			end 
			if (numTimers==1) then
				cancelAllTimers()
			end 
			--director:changeScene ( imgDir..togo, true )
			--director:changeScene ( togo, true )
			director:changeScene ( togo)
		end
	end
    --builds thumbnails
    local menuTab = {}
    for i=1, table.maxn( pageList ) do
   		   menuTab[i] = display.newImage( pageList[i][1])
		   menuTab[i]:setReferencePoint( display.TopLeftReferencePoint )
		   menuTab[i].id = pageList[i][2]; --i
		   menuTab[i]:addEventListener( "tap", menuItemTap )

		   -- navigation positioning
		   if i == 1 and params.dire == "bottom" then
			  menuTab[i].x = spacer
			  menuTab[i].y = 0 + spacer --_H - (spacer + menuTab[i].height)
		   elseif i == 1 and params.dire == "top" then
		  	  menuTab[i].x = spacer
			  menuTab[i].y = 0 + spacer
		   elseif i == 1 and params.dire == "left" then
			  menuTab[i].x = spacer
			  menuTab[i].y = 0 + spacer
			  print(menuTab[i].y)
		   elseif i == 1 and params.dire == "right" then
			  menuTab[i].x = _W - (spacer + menuTab[i].width)
			  menuTab[i].x = 0 + spacer
			  menuTab[i].y = 0 + spacer
		   elseif i ~= 1 and params.dire == "bottom" or params.dire == "top" then
			  menuTab[i].x = menuTab[i-1].x + spacer + menuTab[i-1].width
			  menuTab[i].y = menuTab[i-1].y
		   elseif i ~= 1 and params.dire == "left" or params.dire == "right" then
			  menuTab[i].x = menuTab[i-1].x
			  menuTab[i].y = menuTab[i-1].y + spacer + menuTab[i].height
		   end

		   navItems:insert( menuTab[i] )
	end
	
	if (params.dire=="bottom" or params.dire=="top") then
		nWidth = _W
	else
		nHeight = _H
	end
	   -- Scroll objects 
	   --Position of the scrollview
	   kNavigation = widget.newScrollView { 
          top = nTop, left = nLeft,  
          width = nWidth, height = nHeight, 
          hideScrollBar = false,  
          hideBackground = true, 
          verticalScrollDisabled = nVert;
          horizontalScrollDisabled = nHor;
          --bgColor = { 255,255,255,255 } 
       } 


       --kNavigation.verticalScrollDisabled = nVert; 
       --kNavigation.horizontalScrollDisabled = nHor;

       
       kNavigation:insert(navItems) 
       kNavig:insert(kNavigation)
       
       kNavigation:scrollToPosition{ x = -kNavigation.contentWidth*.5, y = -kNavigation.contentHeight*.5 } --tGo*-1 }
       
       print("ntop: "..nTop)
			print("nleft: "..nLeft)
			print("nW: "..nWidth)
			print("nH: "..nHeight)
			
			print(navItems.x,navItems.y)
       
    local function touchNavig(event) 
          --do not allow swipe of the next/previous page 
          return true 
       end   
     kNavig:addEventListener( "touch", touchNavig ) 

     Navigation.hide = function( obj, params )
		kNavig.alpha = 0
	end

	Navigation.show = function( obj, params )
		kNavig.alpha = 1
    	--calculates current page in the scroll
    	local tGo = 1
    	local xx = 1

    	for i=1, table.maxn( pageList ) do
    		if (pageList[i][2] == cpage) then
    			xx = i
    		end
    	end
	    
	    --compatibility with widget 2.0 library
	    --local function scrollCompleted()
	    --end
    	if (dire == "top" or dire == "bottom") then
			local tGo = ( ((xx - 1) * spacer) + ((xx - 1) * thumbW) )
			--kNavigation:scrollToPosition( tGo*-1, nil)
			kNavigation:scrollToPosition{ x = tGo*-1 - kNavigation.contentWidth*.5, y = - kNavigation.contentHeight*.5 } --, time = 500, onComplete = scrollCompleted}
		else 
			local tGo = ( ((xx - 1) * spacer) + ((xx - 1) * thumbH) )		
			--kNavigation:scrollToPosition{ x = nil, y = tGo*-1 }
			
			kNavigation:scrollToPosition{ x = -kNavigation.contentWidth*.5, y = tGo*-1 - kNavigation.contentHeight*.5 }
		end
		
		--starts a timer. If nothing is pressed in 10 seconds, hide the panel
		local function hideAgain()
			if kNavig.alpha == 1 then
				Navigation.hide()
			end
		end
		--kNavig.alpha = 1
		timerStash.timer_nav = timer.performWithDelay( 10000, hideAgain ) 
		
	end

	return obj

end







return Navigation
