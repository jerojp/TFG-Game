-- Code created by Kwik - Copyright: kwiksher.com 
-- Version: 2.7.6b 
module(..., package.seeall) 

function new() 
    local numPages = 65 
    local menuGroup = display.newGroup() 
    local dispose 
    local _W = display.contentWidth; 
    local _H = display.contentHeight; 

    local drawScreen = function() 

       local curPage = 11 

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

 
       -- Layer names 
       local Capa_1  

       -- (TOP) External code will render here 
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
  print( "Indice para borrar: "..index..","..index+1 )
  if (_G.Results[index] and _G.Results[index+1]) then
    print( "Borradas estadisticas ejercicio IGUALACION-MUESTRA" )
    _G.Results[index] = nil
    _G.Results[index+1] = nil
    _G.TimerResults[index] = nil
    _G.TimerResults[index+1] = nil
  end
  --Exercise Draw
  local results, reason = os.remove( system.pathForFile( "screen".._G.Level.."1.jpg", system.DocumentsDirectory  ) )
  if results then
     print( "Borradas estadisticas ejercicio GRAFIA" )
  else
     print( "file does not exist", reason )
  end
  results, reason = os.remove( system.pathForFile( "screen".._G.Level.."2.jpg", system.DocumentsDirectory  ) )
  
  --Exercise Rec
  results, reason = os.remove( system.pathForFile( "audioExLet".._G.Level.."1.wav", system.DocumentsDirectory  ) )
  if results then
     print( "Borradas estadisticas ejercicio VOZ" )
  else
     print( "file does not exist", reason )
  end
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
            print( "Nivel"..obj.index )
            print("Ultima pagina del nivel ".._G.LastPageLevel[obj.index].page)
            print( "Limite de la pagina "..limitPages[obj.index*2 - 1] )
            _G.Phase = _G.LastPageLevel[_G.Level].phase
         
            if (_G.LastPageLevel[obj.index].page == limitPages[obj.index*2]) then
              myDialog = createMyDialog( "ADVERTENCIA", "Ya has completado este nivel, si inicias de nuevo este nivel perderÃ¡s todos los resultados obtenidos en Ã©l.", nil, "Confirmar", listenerC, "Cancelar", listenerD)
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
    print( "CREANDO PANEL OCULTO....." )
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
    print( "BORRANDO PANEL OCULTO....." )
    menuGroup:remove(hiddenPanel)
    hiddenPanel:removeSelf( )
    hiddenPanel = nil
  end
end

local function goBackMenu( )
  -- body
  _G.GameStarted = false
  dispose(); director:changeScene( "page_1", "fade") 
end

local function viewUnicorn( fun )
  -- body
  local groupUnicorn = display.newGroup()
  local background = display.newRect( 0, 0, display.contentWidth , display.contentHeight )
  background:setFillColor( 85,159,191 )
  groupUnicorn:insert(background)
  local toy = display.newImageRect( imgDir.."goldenUnicorn.png", 381, 196 ); 
  toy.x = display.contentCenterX; toy.y = display.contentCenterY ; 
  groupUnicorn:insert(toy);
  _G.UnlockToys[#_G.UnlockToys+1] = { nameToy = "Unicornio", path = "goldenUnicorn.png", widthToy = 135, heightToy = 81}
  _G.Toys[#_G.UnlockToys].block = false
  local textToy = display.newText( "Unicornio", display.contentCenterX, toy.y + 80, native.systemFontBold, 40 )
  textToy.x = textToy.x - textToy.contentWidth/2
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
  _G.Toys[10].block = true
  if(_G.goBackForExercise) then
    _G.goBackForExercise = false
    aud = {"genius_GBNC.mp3", "genius_GL2.mp3"}
    sub = {"Has vuelto al mapa, no te preocupes puedes intentar continuar la aventura de ese paÃ­s por donde los has dejado en cualquier momento.",
          "Pulsa la flecha del paÃ­s al que deseas viajar."}
    sec = {1, 1}
  elseif (_G.FirstVisitMap) then
    _G.FirstVisitMap = false
    aud = {"genius_FVM.mp3"}
    sub = {"Para viajar a un pais, pulsa sobre la flecha azÃºl que hay encima de Ã©l. En cada paÃ­s aprenderÃ¡s una nueva vocal."}
    sec = {1}
  elseif(_G.goBackEnd) then
    _G.goBackEnd = false
    aud = {"genius_final1.mp3", "genius_final2.mp3"}
    sub = {"!Muy bien! Ya has completado todos los paÃ­ses con Ã©xito. AquÃ­ tienes el cofre misterioso que te prometÃ­. Con la llave que conseguiste en Suiza has conseguido que pueda abrir el cofre, veamos que contiene.",
          "Felicidades has conseguido un tesoro jamÃ¡s encontrado y te has convertido en el mejor explorador del mundo !Enhorabuena!. AquÃ­ finaliza tu aventura, ha sido muy divertido espero que nos podamos ver pronto."}
    sec = {1, 1}
    local events = { {mytype = "effects", value = {1, viewUnicorn} }, {mytype = "effects", value = {1, goBackMenu} } }
    setEventsControlScene(events)
  else
    aud = {"genius_GBEC.mp3", "genius_GL2.mp3"}
    sub = {"Muy bien has completado con exito la aventura de ese paÃ­s. !Enhorabuena!",
          "Pulsa la flecha del paÃ­s al que deseas viajar."}
    sec = {1, 1}
  end 
  createHiddenPanel( )
  addCharacter(nil, aud, sub)
  setSecuence( sec )
  playScene( -1 )
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
        print( "Nivel "..contLetter )
        print( "Pagina ".._G.LastPageLevel[contLetter].page )
        print( "Limit "..limitPages[i] )
        print( "Limit2 "..limitPages[i+1] )
       if (_G.LastPageLevel[contLetter].phase == 2) then
              groupTick[i].alpha = 1
              if (_G.LastPageLevel[contLetter].page == limitPages[i+1]) then -- _G.lastPageLevel[1] can never be largue than 34  
                     groupTick[i+1].alpha = 1
              end
       end
       contLetter = contLetter + 1
end
timerStash.soundSelLevel = timer.performWithDelay( 800, playAnySound ) 

       -- Capa_1 positioning 
       Capa_1 = display.newImageRect( imgDir.. "p11_capa_1.png", 0, 0 ); 
       Capa_1.x = 0; Capa_1.y = 0; Capa_1.alpha = 1; Capa_1.oldAlpha = 1 
       Capa_1.oriX = Capa_1.x; Capa_1.oriY = Capa_1.y 
       Capa_1.name = "Capa_1" 
       menuGroup:insert(1,Capa_1); menuGroup.Capa_1 = Capa_1 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
