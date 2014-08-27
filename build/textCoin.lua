local myGroup

local function contNumDig(number)
    local numDig = 1
    local n = number

    while n >= 10 do
        numDig = numDig + 1
        n = math.floor( n / 10 )
    end

    return numDig
end

local function textCoinFormat( )
    -- body
    local number = _G.Coin
    local numDig
    local text = _G.Coin
    local imgNewCoin

    numDig = contNumDig(number)

    local numCero = _G.numDigCoin - numDig

    for i=1, numCero do
        text = "0"..text
    end
    if (myGroup) then
       myGroup[2].text = text 
    end
end

function createTextCoin(  )
	-- body
    myGroup = display.newGroup( )

    local kwkcoin = display.newImageRect( imgDir.. "kwkcoin.png", 54, 47 ); 
    kwkcoin.x = 36; kwkcoin.y = 32;
    myGroup:insert(kwkcoin) 

	local textCoin = display.newText( _G.Coin, 70, 8, 120, 0, native.systemFont, 40 ) 
    textCoin:setTextColor (229, 185, 89) 
    myGroup:insert(textCoin)

    textCoinFormat() 

    return myGroup
end

function textCoinUpdate( incCoin, operation )
    -- body
    local newTextCoin

    local function onCompleteTransition( event )
        -- body

        textCoinFormat( )

        if ( newTextCoin ) then
            newTextCoin:removeSelf( )
            newTextCoin = nil    
        end
        print( "Completada transicion" )
        return true        
    end

    if (not myGroup) then
        createTextCoin()
    end

    local symbol
    if (operation == "add") then
        symbol = "+ "
    else
        symbol = "- "
    end

    local options = 
    {
        --parent = textGroup,
        text = symbol..incCoin,     
        x = myGroup[2].x,
        y = myGroup[2].y + 40,
        font = native.systemFontBold,   
        fontSize = 40,
    }
    newTextCoin =  display.newText( options )
    newTextCoin.x = newTextCoin.x - newTextCoin.contentWidth/2 - ((contNumDig(incCoin)-1)*10)
    newTextCoin:setTextColor (229, 185, 89) 

    if (operation == "add") then
            _G.Coin = _G.Coin + incCoin 
    end
    transitionStash.newcoin = transition.to( newTextCoin, {  time=500, y=myGroup[2].y, alpha = 0, onComplete=onCompleteTransition} )
end
