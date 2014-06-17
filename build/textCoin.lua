local kwktextcoin

function createTextCoin(  )
	-- body
	kwktextcoin = display.newText( _G.Coin, 70, 8, 120, 0, native.systemFont, 40 ) 
    kwktextcoin:setTextColor (229, 185, 89) 
    kwktextcoin.alpha = 1; kwktextcoin.oldAlpha = 1 
    kwktextcoin.oriX = kwktextcoin.x; kwktextcoin.oriY = kwktextcoin.y 
    kwktextcoin.name = "kwktextcoin"

    textCoinUpdate() 
end

function textCoinUpdate( )
	-- body
	local number = _G.Coin
	local numDig = 1 
	local text = _G.Coin

    while number >= 10 do
    	numDig = numDig + 1
    	number = math.floor( number / 10 )
    end

    local numCero = _G.numDigCoin - numDig

    for i=1, numCero do
    	text = "0"..text
    end

    kwktextcoin.text = text
end
