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

local function removeStatitics(  )
  -- body
  --Exercise Sample-Selection
  local index = (_G.Level*2 - 1)
  if (_G.Results[index] and _G.Results[index+1]) then
    print( "Borradas estadisticas ejercicio IGUALACION-MUESTRA" )
    table.remove( _G.Results, index )
    table.remove( _G.Results, index+1 )
    table.remove( _G.TimerResults, index )
    table.remove( _G.TimerResults, index+1 )
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
            if (_G.LastPageLevel[obj.index] <= limitPages[obj.index*2 - 1]) then
              _G.Phase = 1
            else
              _G.Phase = 2
            end
             
            if (_G.LastPageLevel[obj.index] == limitPages[obj.index*2]) then
              myDialog = createMyDialog( "ADVERTENCIA", "Ya has completado este nivel, si inicias de nuevo este nivel perderás todos los resultados obtenidos en él.", nil, "Confirmar", listenerC, "Cancelar", listenerD)
              page = inicPages[obj.index]
            else
              goToPage(_G.LastPageLevel[obj.index])    
            end
        end
       end
       return true
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
        print( "Pagina ".._G.LastPageLevel[contLetter] )
        print( "Limit "..limitPages[i] )
       if (_G.LastPageLevel[contLetter] > limitPages[i]) then
              groupTick[i].alpha = 1
              if (_G.LastPageLevel[contLetter] >= limitPages[i+1]) then -- _G.lastPageLevel[1] can never be largue than 34  
                     groupTick[i+1].alpha = 1
              end
       end
       contLetter = contLetter + 1
end