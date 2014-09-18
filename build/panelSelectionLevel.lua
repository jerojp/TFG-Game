require( "ControlScene" )
require("MyDialog")
local groupFlLetter = display.newGroup( )
local groupTick = display.newGroup( )
local continents  
local FlechaMapaU  
local FlechaMapaE  
local FlechaI  
local FlechaMapaO  
local FlechaMapaA  
local Tickverde  
local limitPages = {30, 34, 19, 22, 39, 43, 50, 53, 58, 61}
local inicPages = {25, 12, 35, 44, 54}
local myDialog
local page
local ch = 1
local handleFirstVisit
local handleGoBackEx
local handleGoBackEnd
local handleGoBackExComplete
local hiddenPanel
local handlePushArrow

local function removeStatitics(  )
  -- body
  --Exercise Sample-Selection
  local index = _G.Level*2 - 1
  
  if (_G.Results[index] and _G.Results[index+1]) then
    _G.Results[index] = nil
    _G.Results[index+1] = nil
    _G.TimerResults[index] = nil
    _G.TimerResults[index+1] = nil
  end
  --Exercise Draw
  local results, reason = os.remove( system.pathForFile( "screen".._G.Level.."1.jpg", system.DocumentsDirectory  ) )
 
  results, reason = os.remove( system.pathForFile( "screen".._G.Level.."2.jpg", system.DocumentsDirectory  ) )
  
  --Exercise Rec
  results, reason = os.remove( system.pathForFile( "audioExLet".._G.Level.."1.wav", system.DocumentsDirectory  ) )
  
  results, reason = os.remove( system.pathForFile( "audioExLet".._G.Level.."2.wav", system.DocumentsDirectory  ) )
end

local function goToPage( p )
       -- body
       dispose(); director:changeScene( "page_"..p, "fade" )
end

local function listenerC( event )
       -- body
       local object = event.target

       if event.phase == "began" then
        display.getCurrentStage():setFocus(object)
        object.isFocus = true
       elseif object.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
            display.getCurrentStage():setFocus( nil )
            object.isFocus = false
            
            removeStatitics()

            deleteMyDialog( myDialog )

            goToPage( page )
        end
       end
       return true
end

local function listenerD( event )
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

local function goToLevelLetter( event )
       -- body
       local obj = event.target

       if event.phase == "began" then
        display.getCurrentStage():setFocus(obj)
        obj.isFocus = true
       elseif obj.isFocus then
        if event.phase == "ended" or event.phase == "cancelled" then
            display.getCurrentStage():setFocus( nil )
            obj.isFocus = false
            _G.Level = obj.index
            
            _G.Phase = _G.LastPageLevel[_G.Level].phase
         
            if (_G.LastPageLevel[obj.index].page == limitPages[obj.index*2]) then
              myDialog = createMyDialog( "ADVERTENCIA", "Ya has completado este nivel, si inicias de nuevo este nivel perderás todos los resultados obtenidos en él.", nil, "Confirmar", listenerC, "Cancelar", listenerD)
              page = inicPages[obj.index]
            else
              goToPage(_G.LastPageLevel[obj.index].page)    
            end
        end
       end
       return true
end

local function createHiddenPanel( )
  if (not hiddenPanel) then
    
    local function doNothing( event )
      -- body
      return true
    end
    -- body
    hiddenPanel = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
    hiddenPanel.alpha = 0.5
    menuGroup:insert(hiddenPanel)
    hiddenPanel:addEventListener( "touch", doNothing )
    hiddenPanel:addEventListener( "tap", doNothing )
  end
end

_G.FunctionDelHiddenPanel = function ( )
  -- body
  if (hiddenPanel) then
    
    menuGroup:remove(hiddenPanel)
    hiddenPanel:removeSelf( )
    hiddenPanel = nil
  end
end

local function goBackMenu( fun )
  -- body
  _G.GameStarted = false
  _G.FunctionDelHiddenPanel()
  fun(300)
end

local function viewUnicorn( fun )
  -- body
  local groupUnicorn = display.newGroup()
  local background = display.newRect( 0, 0, display.contentWidth , display.contentHeight )
  background:setFillColor( 85,159,191 )
  groupUnicorn:insert(background)
  local backPanel = display.newRoundedRect( 0, 0, 500, 600, 40 )
  backPanel.x = display.contentCenterX; backPanel.y = display.contentCenterY - 50
  backPanel:setFillColor( 0 )
  groupUnicorn:insert( backPanel )
  local frontPanel = display.newRoundedRect( 0, 0, 480, 580, 40 )
  frontPanel.x = display.contentCenterX; frontPanel.y = display.contentCenterY - 50
  frontPanel:setFillColor( 255 )
  groupUnicorn:insert(frontPanel)

  local toy = display.newImageRect( imgDir.."goldenUnicorn.png", 381, 196 ); 
  toy.x = display.contentCenterX; toy.y = frontPanel.y - frontPanel.contentHeight/2 + toy.contentHeight/2 + 80 ; 
  groupUnicorn:insert(toy);
  _G.UnlockToys[#_G.UnlockToys+1] = { nameToy = "Unicornio", path = "goldenUnicorn.png", widthToy = 135, heightToy = 81}
  _G.Toys[#_G.UnlockToys].block = false
  local textToy = display.newText( "Unicornio Dorado", display.contentCenterX, toy.y + 80, native.systemFontBold, 45 )
  textToy.x = toy.x
  textToy.y = toy.y + textToy.contentHeight/2 + 250
  textToy:setFillColor( 0 )
  groupUnicorn:insert(textToy)

  local audioHandle
  local groupStars = display.newGroup()

  local function onCompleteTransition( event )
                    -- body
    local function onCompleteTimerEndUnicorn()
      display.remove( groupUnicorn )
      groupUnicorn = nil
      fun(300)
    end

    if ( audio.isChannelActive( 1 ) ) then
        audio.stop()
    end
    audio.dispose( audioHandle )
    audioHandle = nil
    groupStars.alpha = 0
    
    timerStash.timer_stars2 = timer.performWithDelay( 1000, onCompleteTimerEndUnicorn )
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
  groupUnicorn:insert(groupStars)
  groupStars.x = display.contentCenterX
  groupStars.y = display.contentCenterY
  groupStars:scale( 0, 0 )

  audioHandle = audio.loadSound( audioDir.."stars.mp3" )

  local function onCompleteTimer( event )
    -- body
    transitionStash.groupStars2 = transition.to( groupStars, {  time=2000, xScale=1.5, yScale=1.5, alpha = 0.2, rotation = 340, onComplete=onCompleteTransition} )
    audio.play( audioHandle, {channel = 1, duration = 3000, fadein = 2000} )
  end
  timerStash.timer_stars2 = timer.performWithDelay( 600, onCompleteTimer, 1 )
end

local function playAnySound( )
  -- body
  local aud 
  local sub 
  local sec
  local nextPage = -1
  _G.Toys[10].block = true
  
  if(_G.goBackEnd) then
    _G.goBackEnd = false
    _G.goBackEndLevel = false
    aud = {"genius_final1.mp3", "genius_final2.mp3"}
    sub = {"!Muy bien! Ya has completado todos los países con éxito. Aquí tienes el cofre misterioso que te prometí. Con la llave que conseguiste en Suiza has conseguido que pueda abrir el cofre, veamos que contiene.",
          "!Felicidades! has conseguido un tesoro jamás encontrado y te has convertido en el mejor explorador del mundo !Enhorabuena!. Aquí finaliza tu aventura, ha sido muy divertido espero que nos podamos ver pronto."}
    sec = {1, 1}
    local events = { {mytype = "effects", value = {1, viewUnicorn} }, {mytype = "effects", value = {1, goBackMenu} } }
    setEventsControlScene(events)
    nextPage = "page_1"
  elseif(_G.goBackForExercise) then
    _G.goBackForExercise = false
    _G.goBackEndLevel = false
    aud = {"genius_GBNC.mp3", "genius_GL2.mp3"}
    sub = {"Has vuelto al mapa, no te preocupes puedes intentar continuar la aventura de ese país por donde los has dejado en cualquier momento.",
          "Pulsa la flecha del país al que deseas viajar."}
    sec = {1, 1}
  elseif (_G.FirstVisitMap) then
    _G.FirstVisitMap = false
    aud = {"genius_FVM.mp3"}
    sub = {"Para viajar a un pais, pulsa sobre la flecha azul que hay encima de él. En cada país aprenderás una nueva vocal."}
    sec = {1}
  elseif(_G.goBackEndLevel) then
    _G.goBackEndLevel = false
    aud = {"genius_GBEC.mp3", "genius_GL2.mp3"}
    sub = {"!Muy bien! Has completado con éxito la aventura de ese país. !Enhorabuena!",
          "Pulsa la flecha del país al que deseas viajar."}
    sec = {1, 1}
  end 
  createHiddenPanel( )
  addCharacter(nil, aud, sub)
  setSecuence( sec )
  playScene( nextPage )
end

-- (TOP) External code will render here 
_G.CurrentPage = curPage 
_G.LastPage = curPage 

-- continents positioning 
continents = display.newImageRect( imgDir.. "p11_continents.png", 1280, 800 ); 
continents.x = 640; continents.y = 400; 
menuGroup:insert(1,continents);

-- FlechaMapaA positioning 
FlechaMapaA = display.newImageRect( imgDir.. "p11_flechamapaa.png", 132, 206 ); 
FlechaMapaA.x = 394; FlechaMapaA.y = 326;
FlechaMapaA.index = 1
FlechaMapaA:addEventListener( "touch", goToLevelLetter )
groupFlLetter:insert(FlechaMapaA);

-- FlechaMapaE positioning 
FlechaMapaE = display.newImageRect( imgDir.. "p11_flechamapae.png", 132, 167 ); 
FlechaMapaE.x = 632; FlechaMapaE.y = 87;
FlechaMapaE.index = 2
FlechaMapaE:addEventListener( "touch", goToLevelLetter )
groupFlLetter:insert(FlechaMapaE); 

-- FlechaI positioning 
FlechaI = display.newImageRect( imgDir.. "p11_flechai.png", 132, 204 ); 
FlechaI.x = 675; FlechaI.y = 664; 
FlechaI.index = 3
FlechaI:addEventListener( "touch", goToLevelLetter )
groupFlLetter:insert(FlechaI);

-- FlechaMapaO positioning 
FlechaMapaO = display.newImageRect( imgDir.. "p11_flechamapao.png", 132, 206 ); 
FlechaMapaO.x = 1068; FlechaMapaO.y = 120;
FlechaMapaO.index = 4
FlechaMapaO:addEventListener( "touch", goToLevelLetter )
groupFlLetter:insert(FlechaMapaO); 

-- FlechaMapaU positioning 
FlechaMapaU = display.newImageRect( imgDir.. "p11_flechamapau.png", 203, 138 ); 
FlechaMapaU.x = 689; FlechaMapaU.y = 308; 
FlechaMapaU.index = 5
FlechaMapaU:addEventListener( "touch", goToLevelLetter )
groupFlLetter:insert(FlechaMapaU);

menuGroup:insert(groupFlLetter)


for i=1,groupFlLetter.numChildren do
       Tickverde = display.newImageRect( imgDir.. "tickVerde.png", 45, 50 ); 
       Tickverde.x = groupFlLetter[i].x - Tickverde.contentWidth + 15; Tickverde.y = groupFlLetter[i].y - 62;
       Tickverde.alpha = 0
       groupTick:insert(Tickverde);
       Tickverde = display.newImageRect( imgDir.. "tickVerde.png", 45, 50 ); 
       Tickverde.x = groupFlLetter[i].x + Tickverde.contentWidth - 10; Tickverde.y = groupFlLetter[i].y - 62;
       Tickverde.alpha = 0 
       groupTick:insert(Tickverde);    
end

--Correct position of the tick E
groupTick[3].y = groupTick[3].y + 10
groupTick[4].y = groupTick[4].y + 10
--Correct position of the tick U
groupTick[groupTick.numChildren - 1].x = groupTick[groupTick.numChildren - 1].x + 30
groupTick[groupTick.numChildren - 1].y = groupTick[groupTick.numChildren - 1].y + 30
groupTick[groupTick.numChildren].x = groupTick[groupTick.numChildren].x + 30
groupTick[groupTick.numChildren].y = groupTick[groupTick.numChildren].y + 30 
menuGroup:insert(groupTick)

local contLetter = 1
for i=1,groupTick.numChildren, 2 do
        
       if (_G.LastPageLevel[contLetter].phase == 2) then
              groupTick[i].alpha = 1
              if (_G.LastPageLevel[contLetter].page == limitPages[i+1]) then -- _G.lastPageLevel[1] can never be largue than 34  
                     groupTick[i+1].alpha = 1
              end
       end
       contLetter = contLetter + 1
end

if (_G.goBackForExercise or _G.FirstVisitMap or _G.goBackEnd or _G.goBackEndLevel) then
  timerStash.soundSelLevel = timer.performWithDelay( 800, playAnySound )
end