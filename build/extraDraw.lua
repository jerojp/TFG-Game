local lineTable = {}
local linePoints = {}
local numPointPressed = 0
local pressedPointLeft = false
local isErase = false
local faultCounter = 1 -- Misses out of the drawing area 
local MAX_FAULT = 2 --

local function finalizeLevel( )
  -- body
  local number
  print( "FINALIZADO" )
  local screenCap = display.captureScreen( false )
  display.save( screenCap, { filename="screen".._G.Level.._G.Phase..".jpg", baseDir=system.DocumentsDirectory, isFullResolution=true } )
  --[[
        if (_G.Level == 1) then
          if (_G.Phase == 1) then
            number = 1  
          else
            number = 1
          end
        elseif (_G.Level == 2) then
          if (_G.Phase == 1) then
            number = 18  
          else
            number = 1
          end
        elseif (_G.Level == 3) then
          if (_G.Phase == 1) then
            number = 1  
          else
            number = 1
          end
        elseif (_G.Level == 3) then
          if (_G.Phase == 1) then
            number = 1  
          else
            number = 1
          end
        elseif (_G.Level == 4) then
          if (_G.Phase == 1) then
            number = 1  
          else
            number = 1
          end
        elseif (_G.Level == 5) then
          if (_G.Phase == 1) then
            number = 1  
          else
            number = 1
          end
        end
  --]]
  _G.SecondFaseDraw[_G.Level] = true
  number = 18
  director:changeScene( "page_"..number, "fade" ) 
end

local function checkPoint( groupPoint, x, y, radiusPincel, maxChildren )
  local localX
  local localY
  local dx
  local dy
  local distance
  local objectSize

  for i=1,maxChildren do
    if (groupPoint[i]~=nil) then
      localX, localY = groupPoint[i]:localToContent( 0, 0 )
      
      dx = x - localX
      dy = y - localY

      distance = math.sqrt( dx*dx + dy*dy )
      objectSize = radiusPincel + groupPoint[i].contentWidth/2

      if ( distance < objectSize ) then
        if (not pressedPointLeft and i~=1) then
          print( "--------BORRA Y REINICIAR---------" )
            --Reproducir audio para correccion
          isErase = true
          numPointPressed = 0
        else
          if ( i == 1) then
            pressedPointLeft = true
          end
          print( "--------ENTRAA "..i.."---------" )
          groupPoint[i] = nil
          numPointPressed = numPointPressed + 1
  
        end
      end  
    end
    
  end

end


function addExtra( menuGroup, Letra, groupPointOrigin, radius )
      --Groups
      local groupPoint = {}

      if(_G.DifficultLevel == 1) then  -- Easy
        Letra:scale( 1.5, 1.5 )
        groupPointOrigin:scale( 1.5, 1.5 )
        radius = radius * 1.5
      elseif (_G.DifficultLevel == 3) then  -- Hard
        Letra:scale( 0.7, 0.7 )      
        groupPointOrigin:scale( 0.7, 0.7 )
        radius = radius * 0.7
      end

      if (_G.SecondFaseDraw[_G.Level]) then
        Letra:scale( 0.85, 0.85 )
        groupPointOrigin:scale( 0.85, 0.85 )
        radius = radius * 0.85
      end

      --Function extra
      local function copyToTable()
        if (table.maxn(groupPoint) ~= 0) then
          for i=1,table.maxn(groupPoint) do
            groupPoint[i] = nil
          end  
        end
        for i=1,groupPointOrigin.numChildren do
          table.insert( groupPoint, groupPointOrigin[i] )
        end
      end

      local function resetVar()
        -- body
        numPointPressed = 0
        pressedPointLeft = false
        --faultCounter = 0
        copyToTable()
      end

      copyToTable()

      -- Button names 
       local but_Black
       local but_Blue
       local but_Green
       local but_Pink
       local but_Red
       local but_Yellow
       local but_Palette
       local but_Letter

       -- Action names 
       local act_CreateSlide 
       local act_draw 

       -- Layer names 
       local PanelDibujo  
       local Paleta  
       local Rojo  
       local Verde  
       local Azul  
       local Rosa  
       local Negro  
       local Amarillo  
       local ElegirColor  
       local ElegirTamPincel  
       local TxtPincel  
       local Pincel  

       -- Added variables before layers render 
       local lineWidth = 25 -- brush with   
       local lineColor = {R=255, G=0, B=0} -- Color for the brush 
       local widget = require "widget"
       local enterPaleta = false

    -- This is only included because I used the widget.newButton API for the example "undo" & "erase" buttons. It's not required for the drawing functionality.


       -- (TOP) External code will render here 

       --[[local undo = function()
          if #lineTable>0 then
                lineTable[#lineTable]:removeSelf()
                lineTable[#lineTable]=nil
          end
          return true
        end
 
       local undoButton = widget.newButton{
        left = 25,
        top = 50,
        label = "Deshacer",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.3 } },
        width = 150, height = 50,
        cornerRadius = 8,
        defaultFile = imgDir.."button.png",
        onRelease = undo 
       }--]]
      
      local function erase()
          for i = 1, #lineTable do
                lineTable[i]:removeSelf()
                lineTable[i] = nil
          end
          isErase = false
          resetVar()
          return true
      end
      
       -- PanelDibujo positioning 
       PanelDibujo = display.newImageRect( imgDir.. "paneldibujo.png", 1280, 600 ); 
       PanelDibujo.x = 640; PanelDibujo.y = 300; PanelDibujo.alpha = 1; PanelDibujo.oldAlpha = 1 
       PanelDibujo.oriX = PanelDibujo.x; PanelDibujo.oriY = PanelDibujo.y 
       PanelDibujo.name = "PanelDibujo"
       Letra.name = "Letra"
       menuGroup:insert(PanelDibujo)
 
       local eraseButton = widget.newButton{
        left = display.contentWidth-175,
        top = 50,
        label = "Borrar",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.3 } },
        width = 150, height = 50,
        cornerRadius = 8,
        defaultFile = imgDir.."button.png",
        onRelease = erase
       }
       menuGroup:insert(eraseButton)

                    -- Paleta positioning 
       Paleta = display.newImageRect( imgDir.. "paleta.png", 1280, 200 ); 
       Paleta.x = 640; Paleta.y = 700; Paleta.alpha = 1; Paleta.oldAlpha = 1 
       Paleta.oriX = Paleta.x; Paleta.oriY = Paleta.y 
       Paleta.name = "Paleta" 
       menuGroup:insert(Paleta)

       -- Rojo positioning 
       Rojo = display.newImageRect( imgDir.. "rojo.png", 49, 48 ); 
       Rojo.x = 53; Rojo.y = 700; Rojo.alpha = 1; Rojo.oldAlpha = 1 
       Rojo.oriX = Rojo.x; Rojo.oriY = Rojo.y 
       Rojo.name = "Rojo"
       menuGroup:insert(Rojo)


       -- Verde positioning 
       Verde = display.newImageRect( imgDir.. "verde.png", 49, 48 ); 
       Verde.x = 122; Verde.y = 700; Verde.alpha = 1; Verde.oldAlpha = 1 
       Verde.oriX = Verde.x; Verde.oriY = Verde.y 
       Verde.name = "Verde" 
       menuGroup:insert(Verde)


       -- Azul positioning 
       Azul = display.newImageRect( imgDir.. "azul.png", 49, 48 ); 
       Azul.x = 191; Azul.y = 700; Azul.alpha = 1; Azul.oldAlpha = 1 
       Azul.oriX = Azul.x; Azul.oriY = Azul.y 
       Azul.name = "Azul" 
       menuGroup:insert(Azul)


       -- Rosa positioning 
       Rosa = display.newImageRect( imgDir.. "rosa.png", 49, 48 ); 
       Rosa.x = 261; Rosa.y = 700; Rosa.alpha = 1; Rosa.oldAlpha = 1 
       Rosa.oriX = Rosa.x; Rosa.oriY = Rosa.y 
       Rosa.name = "Rosa" 
       menuGroup:insert(Rosa)

       -- Negro positioning 
       Negro = display.newImageRect( imgDir.. "negro.png", 49, 48 ); 
       Negro.x = 407; Negro.y = 700; Negro.alpha = 1; Negro.oldAlpha = 1 
       Negro.oriX = Negro.x; Negro.oriY = Negro.y 
       Negro.name = "Negro" 
       menuGroup:insert(Negro)

       -- Amarillo positioning 
       Amarillo = display.newImageRect( imgDir.. "amarillo.png", 49, 48 ); 
       Amarillo.x = 332; Amarillo.y = 700; Amarillo.alpha = 1; Amarillo.oldAlpha = 1 
       Amarillo.oriX = Amarillo.x; Amarillo.oriY = Amarillo.y 
       Amarillo.name = "Amarillo"
       menuGroup:insert(Amarillo) 

       -- ElegirColor positioning 
       ElegirColor = display.newImageRect( imgDir.. "elegircolor.png", 120, 22 ); 
       ElegirColor.x = 79; ElegirColor.y = 645; ElegirColor.alpha = 1; ElegirColor.oldAlpha = 1 
       ElegirColor.oriX = ElegirColor.x; ElegirColor.oriY = ElegirColor.y 
       ElegirColor.name = "ElegirColor" 
       menuGroup:insert(ElegirColor)

       -- ElegirTamPincel positioning 
       ElegirTamPincel = display.newImageRect( imgDir.. "elegirtampincel.png", 250, 22 ); 
       ElegirTamPincel.x = 1071; ElegirTamPincel.y = 650; ElegirTamPincel.alpha = 1; ElegirTamPincel.oldAlpha = 1 
       ElegirTamPincel.oriX = ElegirTamPincel.x; ElegirTamPincel.oriY = ElegirTamPincel.y 
       ElegirTamPincel.name = "ElegirTamPincel" 
       menuGroup:insert(ElegirTamPincel)

       -- TxtPincel positioning 
       TxtPincel = display.newImageRect( imgDir.. "txtpincel.png", 70, 17 ); 
       TxtPincel.x = 665; TxtPincel.y = 647; TxtPincel.alpha = 1; TxtPincel.oldAlpha = 1 
       TxtPincel.oriX = TxtPincel.x; TxtPincel.oriY = TxtPincel.y 
       TxtPincel.name = "TxtPincel" 
       menuGroup:insert(TxtPincel)

       -- Pincel positioning 
       Pincel = display.newCircle( 664, 703, lineWidth/2 ) 
       Pincel.oriX = Pincel.x; Pincel.oriY = Pincel.y 
       Pincel:setFillColor (255, 0, 0) 
       Pincel.alpha = 1; Pincel.oldAlpha = 1 
       menuGroup:insert(Pincel)

       local function sliderListener( event )

        lineWidth = event.value * 0.45
        menuGroup:remove( Pincel )
        Pincel:removeSelf( )
        Pincel = display.newCircle( 664, 703, lineWidth/2 ) 
        Pincel.oriX = Pincel.x; Pincel.oriY = Pincel.y 
        Pincel:setFillColor (lineColor.R, lineColor.G, lineColor.B) 
        Pincel.alpha = 1; Pincel.oldAlpha = 1 
        menuGroup:insert(Pincel)

        --Pincel:scale( lineWidth, lineWidth ) 
      end


      -- Create the widget
      local slider = widget.newSlider
      {
      top = 695,
      left = 900,
      width = 350,
      value = 25,  
      listener = sliderListener
      }
      menuGroup:insert(slider)

      local function inicDraw( event )
        -- body
        i = #lineTable+1
        lineTable[i]=display.newGroup()
        --display.getCurrentStage():setFocus(event.target)
                
        local circle = display.newCircle(event.x,event.y,lineWidth/2)
        circle:setFillColor(lineColor.R, lineColor.G, lineColor.B)
        lineTable[i]:insert(circle)
                
        linePoints = nil
        linePoints = {};
                
        local pt = {}
        pt.x = event.x;
        pt.y = event.y;
        table.insert(linePoints,pt);
      end

      local function finalizeDraw( event )
        -- body
        i=nil
      end
      
       function act_draw(event) 

        local function drawLine()

                local line = display.newLine(linePoints[#linePoints-1].x,linePoints[#linePoints-1].y,linePoints[#linePoints].x,linePoints[#linePoints].y)
                        line:setColor(lineColor.R, lineColor.G, lineColor.B);
                        line.width=lineWidth;
                        lineTable[i]:insert(line)
 
                local circle = display.newCircle(linePoints[#linePoints].x,linePoints[#linePoints].y,lineWidth/2)
                        circle:setFillColor(lineColor.R, lineColor.G, lineColor.B)
                        lineTable[i]:insert(circle)
        end
 
        if event.phase=="began" then
                inicDraw(event)          
        elseif event.phase=="moved" then
              if (lineTable[i]) then
                local pt = {}
                        pt.x = event.x;
                        pt.y = event.y;
                                
                if not (pt.x==linePoints[#linePoints].x and pt.y==linePoints[#linePoints].y) then
                        table.insert(linePoints,pt)
                        drawLine()
                        checkPoint(groupPoint, pt.x, pt.y, lineWidth/2, groupPointOrigin.numChildren)
                end                
              else
                print( "INICIOOOOOOOOOOOOOOOO" )
                --inicDraw(event)
              end
        
        elseif event.phase=="cancelled" or "ended" then
                --display.getCurrentStage():setFocus(nil)
                print( "FINALIZADO POR : "..event.target.name )
                if(numPointPressed == groupPointOrigin.numChildren) then
                  -- Mostrar audio de ejercicio acabado correctamente y cambiar pagina
                  finalizeLevel()    
                end
                if (isErase) then
                  erase()
                end
                finalizeDraw(event)
                enterPaleta = false
        end
 
       end 

 
      --End Actions (functions) 

 
       -- Timers 
       timerStash.timer_slide = timer.performWithDelay( 0, act_CreateSlide, 1 ) 

       -- Button event listeners 
       local function onNegroEvent(event) 
          but_Black(Negro) 
          return true 
       end 
       Negro:addEventListener("tap", onNegroEvent ) 
       local function onAzulEvent(event) 
          but_Blue(Azul) 
          return true 
       end 
       Azul:addEventListener("tap", onAzulEvent ) 
       local function onVerdeEvent(event) 
          but_Green(Verde) 
          return true 
       end 
       Verde:addEventListener("tap", onVerdeEvent ) 
       local function onRosaEvent(event) 
          but_Pink(Rosa) 
          return true 
       end 
       Rosa:addEventListener("tap", onRosaEvent ) 
       local function onRojoEvent(event) 
          but_Red(Rojo) 
          return true 
       end 
       Rojo:addEventListener("tap", onRojoEvent ) 
       local function onAmarilloEvent(event) 
          but_Yellow(Amarillo) 
          return true 
       end 
       Amarillo:addEventListener("tap", onAmarilloEvent ) 

       local function onPaletaEvent(event)

        if (event.phase=="began" or event.phase=="moved") then
          if (not enterPaleta) then
            enterPaleta = true
       	    if (faultCounter < MAX_FAULT) then 
              --Reproducir audio de ayuda
              print( "Cuenta FALTAAAAAAA" )
              print( enterPaleta )
              faultCounter = faultCounter + 1  
            else 
              if (Letra.contentHeight*1.05 < 600) then
                print( "ESCALAAAAAAA" )
                Letra:scale( 1.05, 1.05 )
                groupPointOrigin:scale( 1.05, 1.05 )
                radius = radius * 1.05
              end
              faultCounter = 1
              --Reproducir audio explicativo de subida de nivel 
            end 
            erase()
            finalizeDraw()
          end
        elseif (event.phase=="cancelled" or "ended") then
          print( "REINICIAR FALTAAAAAAA" )
          enterPaleta = false
        end 
        return true 
       end

       PanelDibujo:addEventListener("touch", onPaletaEvent ) 
       local function onLetraEvent(event) 
          act_draw(event) 
          return true 
       end 
       Letra:addEventListener("touch", onLetraEvent ) 

       
       function but_Black(self) 
           lineColor = {R=0, G=0, B=0}
 
           --External code 
           Pincel:setFillColor (0, 0, 0)  
       end 

       function but_Blue(self) 
           lineColor = {R=0, G=0, B=255}
      
           --External code 
           Pincel:setFillColor (0, 0, 255)  
       end 

       function but_Green(self) 
           lineColor = {R=0, G=255, B=0}
         
           --External code 
           Pincel:setFillColor (0, 255, 0)  
       end 
        function but_Pink(self) 
           lineColor = {R=254, G=0, B=255}

           --External code 
           Pincel:setFillColor (254, 0, 255)  
       end 

       function but_Red(self) 
           lineColor = {R=255, G=0, B=0}

           --External code 
           Pincel:setFillColor (255, 0, 0)  
       end 

       function but_Yellow(self) 
           lineColor = {R=254, G=238, B=0}
           --External code 
           Pincel:setFillColor (254, 234, 0)  
       end 
end