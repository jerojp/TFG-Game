-- Code created by Kwik - Copyright: kwiksher.com 
-- Version: 2.7.6b 
module(..., package.seeall) 

function new() 
    local numPages = 65 
    local menuGroup = display.newGroup() 
    local dispose 
    local _W = display.contentWidth; 
    local _H = display.contentHeight; 

    -- Audio callings 
    local aplausos =  audio.loadStream( audioDir.."aplausos.mp3") 


    local drawScreen = function() 

       local curPage = 15 

       Navigation.new("page", { backColor = {255, 255, 255}, anim=1, timer=1,  totPages = numPages, curPage = curPage, thumbW = 200, thumbH = 125, alpha = 1, imageDir = imgDir, dire = "top", audio={{ 1, "aplausos"},} } ) 
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
       local kwkrectangleW  
       local explSobered  
       local explHappy  

       -- (TOP) External code will render here 
              require( "textCoin" )
       --functions
       local ongp_letrasIncorrEvent
       local ongp_letrasCorrectasEvent

       --buttons
       local but_392
       local but_letraIncorr

       -- Action names 
       local act_cambiarAlph 
       local act_eliminarVid 
       local act_letraIncorr 
       local act_posicionarO 
       local act_addObjetosI
       local act_pause 
       local act_play  
       --local act_addNuevoObj 
       -- Group names 
       local letrasCorGroup = display.newGroup() 
       local gp_letrasIncorr = display.newGroup() 
       -- Layer names 
       local objetoCorrect
       local backgroundLower
       local backgroundTop
       local objeto4  
       local objeto3  
       local objeto2  
       local letra2  
       local letra3  
       local letra4  
       local TextoFinal  
       local ExplicacionFall  
       local TextoFinalIncor  
       local kwkvida
       local ManoInfer  
       local ManoSup  
       local textLevel
       local negacion
       local textDescriptionActivity

       -- Added variables before layers render 
       local incrementoAlpha --  
       local n_fallos = 3 -- Fallos al seleccionar 
       local nivelActual = 0-- Nievel de ejercicio, MAX = 20 
       local vidas = 6 --  
       local n_fallosNivel = 0 -- Numero de fallos totales para una letra 
       local objetos = {} -- Todos los objetos del ejercicio 
       local n_objetosFila = 3 -- Numero de objetos por fila 
       local n_aciertosSeg = 1 -- Numero de aciertos seguidos 
       local contador = 0 --  
       local intervaloNuevoO = 0 -- Numero de aciertos seguidos para insertar una nueva letra 
       local nuevaLetra = 0 --  
       local letraN = 0 --
       local numLetrasCor = 0
       local numLetrasInc = 0
       local maxLetrasCor = 1
       local maxLetrasInc = 4
       local maxObjectos = 12
       local proporcion = 4  
       local levelAlpha = 0.01 
       local maxAciertosSeguidosIncremento = 3
       local n_aciertosSegTotales = 0
       local n_objetos_nuevos
       local incrementCoin = 25
       local timerApplause = false
       local resultsTest = {} -- number of failures for this exercices for each level : resultsTest[1] == X failure for level 1
       local timerTest = {}
       local maxNivel = 10
       local contadorTiempo 
       _G.TotalAddCoinEx = 0
       
       textLevel = display.newText( "Nivel : "..nivelActual , 20, 170, native.systemFont, 30 ) 
       textLevel:setTextColor (229, 185, 89)
       menuGroup:insert(textLevel)
   

       menuGroup:insert( createTextCoin( ) )

       objetoCorrect = display.newImageRect( imgDir.. "objeto".._G.Level.._G.Level.._G.Phase..".png", 150, 135 ); 
       objetoCorrect.x = 680; objetoCorrect.y = 91; objetoCorrect.alpha = 1; objetoCorrect.oldAlpha = 1 
       objetoCorrect.oriX = objetoCorrect.x; objetoCorrect.oriY = objetoCorrect.y 
       objetoCorrect.name = "objetoCorrect" 
       menuGroup:insert(objetoCorrect); menuGroup.objetoCorrect = objetoCorrect

       local l
       if(_G.Level==1) then
        l = "A"
       elseif(_G.Level==2) then
        l = "E"
       elseif(_G.Level==3) then
        l = "I"
       elseif(_G.Level==4) then
        l = "A"
       else
        l = "U"
       end

       local textCorrect = display.newText( "Letra "..l, 630, 180, native.systemFont, 30 )
       textCorrect:setFillColor( 0, 0, 0 )
       menuGroup:insert(textCorrect)

       backgroundLower = display.newImageRect( imgDir.. "backgroundLower".._G.Level.._G.Phase..".png", 1280, 551 ); 
       backgroundLower.x = 640; backgroundLower.y = 524; backgroundLower.alpha = 1; backgroundLower.oldAlpha = 1 
       backgroundLower.oriX = backgroundLower.x; backgroundLower.oriY = backgroundLower.y 
       backgroundLower.name = "backgroundLower" 
       menuGroup:insert(1,backgroundLower); menuGroup.backgroundLower = backgroundLower 

       -- TextoFinal positioning 
       TextoFinal = display.newImageRect( imgDir.. "textofinal.png", 515, 21 ); 
       TextoFinal.x = 669; TextoFinal.y = 39; TextoFinal.alpha = 1; TextoFinal.oldAlpha = 1 
       TextoFinal.oriX = TextoFinal.x; TextoFinal.oriY = TextoFinal.y 
       TextoFinal.name = "TextoFinal" 
       menuGroup:insert(TextoFinal); menuGroup.TextoFinal = TextoFinal 

       -- ExplicacionFall positioning 
       ExplicacionFall = display.newImageRect( imgDir.. "explicacionfall.png", 137, 28 ); 
       ExplicacionFall.x = 675; ExplicacionFall.y = 117; ExplicacionFall.alpha = 1; ExplicacionFall.oldAlpha = 1 
       ExplicacionFall.oriX = ExplicacionFall.x; ExplicacionFall.oriY = ExplicacionFall.y 
       ExplicacionFall.name = "ExplicacionFall" 
       menuGroup:insert(ExplicacionFall); menuGroup.ExplicacionFall = ExplicacionFall 

       -- TextoFinalIncor positioning 
       TextoFinalIncor = display.newImageRect( imgDir.. "textofinalincor.png", 543, 21 ); 
       TextoFinalIncor.x = 657; TextoFinalIncor.y = 76; TextoFinalIncor.alpha = 1; TextoFinalIncor.oldAlpha = 1 
       TextoFinalIncor.oriX = TextoFinalIncor.x; TextoFinalIncor.oriY = TextoFinalIncor.y 
       TextoFinalIncor.name = "TextoFinalIncor" 
       menuGroup:insert(TextoFinalIncor); menuGroup.TextoFinalIncor = TextoFinalIncor


       -- Hiding elements 
       TextoFinal.alpha = 0; 
       ExplicacionFall.alpha = 0; 
       TextoFinalIncor.alpha = 0; 

       -- kwkvida positioning 
       kwkvida = {} 
       local gp_kwkvida = display.newGroup() 
       local c_kwkvida = 0 
       local kwkvida_m_loop = 0 --1 plays multiplier forever 
       local kwkvida_m_counter = 6; kwkvida_m_restart = 6 
       function mt_kwkvida(counter) 
          kwkvida[counter] = display.newImageRect( imgDir.. "kwkvida.png", 47, 33 ); 
          kwkvida[counter].x = 200 + ((counter-1) * 45) 
          kwkvida[counter].y = 34 + ((counter -1)* 0) 
          kwkvida[counter].alpha = math.random(100,100) / 100 
          kwkvida[counter].oldAlpha = 1
          kwkvida[counter].xScale = math.random(100,100) / 100 
          kwkvida[counter].yScale = kwkvida[counter].xScale 
          kwkvida[counter].rotation = math.random(0,0)  
          kwkvida[counter].myName = "kwkvida"..counter 
          menuGroup:insert(kwkvida[counter]) 
          gp_kwkvida:insert(kwkvida[counter]) 
       end 

       local function ct_kwkvida() 
          c_kwkvida = c_kwkvida + 1 
          if mt_kwkvida ~= nil then 
             mt_kwkvida( c_kwkvida) 
          end 
          if (c_kwkvida == kwkvida_m_restart and kwkvida_m_loop == 1)  then 
             timerStash.mt = timer.performWithDelay( 0, ct_kwkvida, 6 )   
             kwkvida_m_restart = c_kwkvida + kwkvida_m_counter 
          end 
       end 
       local function multi_kwkvida()   
          timerStash.mt = timer.performWithDelay( 0, ct_kwkvida, 6 )   
       end   
       multi_kwkvida()   
       menuGroup:insert(gp_kwkvida) 

       -- Clean up memory for Multiplier set to forever 
       -- control variable to dispose kClean via kNavi 
       _G.disposeMultiplier = nil 
       local function kClean() 
          if _G.disposeMultiplier == 1 then 
             -- remove all past listeners 
             mt_kwkvida = nil; Runtime:removeEventListener("enterFrame", kClean)  
             _G.disposeMultiplier = nil 
          else 
             -- runs normal code 
             for i = 1, kwkvida_m_restart do  
                  if kwkvida[i] ~= nil then 
                       if kwkvida[i].y ~= nil then 
                         if  kwkvida[i].y > _H then 
                             display.remove(kwkvida[i]) 
                             kwkvida[i] = nil 
                         end 
                       end  
                  end 
             end  
          end  
       end 
       Runtime:addEventListener("enterFrame", kClean) 
 

       -- (MIDDLE) External code will render here 

       -- Wait request for linearNegacion
       local linearNegacion = function(event)
          if gtStash.gt_linearNegacion then 
              gtStash.gt_linearNegacion:toBeginning() 
          end 
          gtStash.gt_linearNegacion = gtween.new( negacion, 0.3, {  x=644.5, y=388.5,  alpha=1, rotation=35, xScale=1, yScale=1,}, {ease = gtween.easing.linear, repeatCount = 8, reflect = true,  delay=0.1, ""}) 
       end --closes function linearNegacion

       local function pauseNegacion()
         -- body
         if gtStash.gt_linearNegacion then
            gtStash.gt_linearNegacion:pause()
         end

         if (negacion) then
            --menuGroup:remove(negacion)
            negacion:removeSelf()
            negacion = nil
         end
       end

       local function cancel_timer_Negacion(  )
         timer.cancel(timerStash.timer_negacion)
         if (negacion) then
           pauseNegacion()
         end     
       end

       local function activeNegacion( )
         -- body
          if ManoSup then
            act_pause()
          end

          if negacion then
            pauseNegacion()
          end

          negacion = display.newImageRect( imgDir.. "p15_negacion.png", 139, 163 ); 
          negacion.x = 644; negacion.y = 307; negacion.alpha = 1; negacion.oldAlpha = 1 
          negacion.oriX = negacion.x; negacion.oriY = negacion.y 
          negacion.name = "negacion" 
          --menuGroup:insert(negacion)

          negacion:setReferencePoint(display.BottomCenterReferencePoint); 

          timerStash.timer_negacion = timer.performWithDelay( 2000, cancel_timer_Negacion, 1 )

          linearNegacion()        
       end
       -- animation to applaud

       local linear_sup = function(event)
          if gtStash.gt_linear_sup then 
              gtStash.gt_linear_sup:toBeginning() 
          end 
          gtStash.gt_linear_sup = gtween.new( ManoSup, 0.1, {  x=620, y=398,  alpha=1, rotation=0, xScale=1.09, yScale=1.09,}, {ease = gtween.easing.linear, repeatCount = math.huge, reflect = true,  delay=0.1, ""}) 

       end --closes function linear_sup

       -- Wait request for linearInf
       local linearInf = function(event)
          if gtStash.gt_linearInf then 
              gtStash.gt_linearInf:toBeginning() 
          end 
          gtStash.gt_linearInf = gtween.new( ManoInfer, 0.1, {  x=670, y=381,  alpha=1, rotation=0, xScale=0.94, yScale=0.94,}, {ease = gtween.easing.linear, repeatCount = math.huge, reflect = true,  delay=0.1, ""}) 

       end --closes function linearInf

 
       -- Actions (functions) 
       function act_pause(event)
          timerApplause = false 

           if gtStash.gt_linear_sup then 
              gtStash.gt_linear_sup:pause() 
           end 
           if gtStash.gt_linearInf then 
              gtStash.gt_linearInf:pause() 
           end

           if (ManoInfer and ManoSup) then
            --menuGroup:remove(ManoInfer)
           -- menuGroup:remove(ManoSup)
            
            ManoInfer:removeSelf()
            ManoInfer = nil
            ManoSup:removeSelf()
            ManoSup = nil
           end

           explHappy.alpha = 0
           if (audio.isChannelPlaying(1)) then
             audio.rewind( 1 ) 
             audio.stop( 1 ) 
           end
            
       end 

       function cancel_timer_Applause(  )
          timer.cancel(timerStash.timer_249)
          timerApplause = false
          if (ManoInfer and ManoSup) then
            act_pause()
          end

       end

       function act_play()
           if negacion then
            pauseNegacion()
           end
           
           explHappy.alpha = 1
           
           -- ManoInfer positioning 
           ManoInfer = display.newImageRect( imgDir.. "manoinfer.png", 229, 208 ); 
           ManoInfer.x = 670; ManoInfer.y = 381; ManoInfer.alpha = 1; ManoInfer.oldAlpha = 1 
           ManoInfer.oriX = ManoInfer.x; ManoInfer.oriY = ManoInfer.y
           --menuGroup:insert(ManoInfer) 

           -- ManoSup positioning 
           ManoSup = display.newImageRect( imgDir.. "manosup.png", 156, 243 ); 
           ManoSup.x = 620; ManoSup.y = 398; ManoSup.alpha = 1; ManoSup.oldAlpha = 1 
           ManoSup.oriX = ManoSup.x; ManoSup.oriY = ManoSup.y 
           --menuGroup:insert(ManoSup)

           linear_sup() 
           linearInf()

            timerStash.timer_249 = timer.performWithDelay( 2000, act_pause, 1 )
            timerApplause = true
            audio.setVolume(0.3, {channel=1} ) 
           audio.play( aplausos, {channel=1, loops = 0 } )  
       end 


 
       -- Actions (functions) 
      function act_cambiarAlph(event) 
           --External code 
        levelAlpha = (incrementoAlpha * nivelActual)
        if (levelAlpha >= 1) then
          levelAlpha = 1
        end

        if (levelAlpha == 0) then
           levelAlpha = 0.01
        end

        local n = table.maxn( objetos )
        for i=1, n, 2 do
           objetos[i].alpha = levelAlpha
           objetos[i+1].alpha = 1 - levelAlpha  
        end
        print( "Alpha : "..levelAlpha )
 
      end 

       function act_eliminarVid(event) 
           --External code 
        local myDialog
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
                deleteMyDialog( myDialog )
                cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
                director:changeScene( "page_15", "fade" ) 
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
                cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
                director:changeScene( "page_11", "fade" ) 
            end
           end
           return true
        end

        if (vidas > 0) then
         kwkvida[vidas]:removeSelf( );
         kwkvida[vidas]=nil
         vidas = vidas - 1
         saveKwikVars({"vidas",vidas - 1}) 
         if (vidas == 0) then
            transitionStash.newTransition_577 = transition.to( TextoFinalIncor, {alpha=TextoFinalIncor.oldAlpha, time=1000, delay=0}) 
            myDialog = createMyDialog( "Nivel no superado", "Â¿Deseas repetir el ejercicio?", nil, "Si", listenerC, "No", listenerD)
         end
       end 
      end 

       function actualizarEspacio(  )
          if (letrasCorGroup.numChildren + gp_letrasIncorr.numChildren >= n_objetosFila*3) then
            n_objetosFila = n_objetosFila + 1
            actualizarEspacio()
          end
       end

       function act_posicionarO(event) 

          actualizarEspacio()
           --External code 
           local n = table.maxn( objetos ) / 2
          local r
          local t = table.copy( objetos )
          local t2 = {}
          local contador = 0

          math.randomseed( system.getTimer( ) )

      -- Desordenamos la tabla de forma aleatoria
          for i=n, 1, -1 do
            r = math.random( i )
            table.insert( t2, t[(r*2) - 1] )
            table.insert( t2, t[r*2] )
            table.remove( t, (r*2) - 1 )
            table.remove( t, (r*2) - 1 )
          end

          n = table.maxn( t2 )

          for i=1 , n, 2 do
            t2[i].x = (display.contentWidth/n_objetosFila) * (math.fmod(contador, n_objetosFila) + 1) -  (display.contentWidth/n_objetosFila)/2
            t2[i+1].x = t2[i].x
            if (i/2 < n_objetosFila) then
              t2[i].y = 510 --510
            elseif (i/2 < n_objetosFila * 2) then
              t2[i].y = 330
            elseif (i/2 < n_objetosFila * 3) then
              t2[i].y = 690
            end
  
          t2[i+1].y = t2[i].y
          contador = contador + 1
          end
               
       end 

       function generateLetter()
        local letra = math.random( 1, 5 )

       -- print( "Antes -> lorrectas "..numLetrasCor )
        --print( "Antes -> lncorrectas "..numLetrasInc )
        if (numLetrasCor == 0 and (nivelActual == 1 or nivelActual == 11)) then
            letra = _G.Level
            numLetrasCor = numLetrasCor + 1
        else
          if (letra == _G.Level) then
            if(numLetrasCor == maxLetrasCor) then
              letra = generateLetter(); --!!!!
            else
              numLetrasCor = numLetrasCor + 1
            end
          else
            if(numLetrasInc == maxLetrasInc) then
                letra = _G.Level
                numLetrasCor = numLetrasCor + 1
            else 
              numLetrasInc = numLetrasInc + 1
            end
          end
        end

        --print( "Despues -> letra correctas "..numLetrasCor )
        --print( "Despues -> letra incorrectas "..numLetrasInc )
        if(numLetrasCor == maxLetrasCor and numLetrasInc == maxLetrasInc) then
          numLetrasCor = 0
          numLetrasInc = 0
        end

        return letra
      end

       function addNuevoObj() 
           --External code
          --menuGroup:remove(letrasCorGroup)
          --menuGroup:remove(gp_letrasIncorr)
           
          nuevaLetra = generateLetter()
          local objetoN 

          objetoN = display.newImageRect( imgDir.. "objeto"..nuevaLetra.._G.Level.._G.Phase..".png", 190, 145 );
          objetoN.alpha = 1 - levelAlpha
          objetoN.oldAlpha = objetoN.alpha
          objetoN.name = "objeto"..nuevaLetra..contador ; contador = contador + 1

          letraN = display.newImageRect( imgDir.. "letra"..nuevaLetra..".png", 120, 145 );
          letraN.alpha = levelAlpha
          if (letraN.alpha == 0) then
            letraN.alpha = 0.01
          end
          letraN.oldAlpha = letraN.alpha
          letraN.name = "letra"..nuevaLetra..contador ; contador = contador + 1

          if(nuevaLetra == _G.Level) then
            letrasCorGroup:insert(letraN)
           else
            gp_letrasIncorr:insert(letraN)
          end

          table.insert( objetos, letraN)
          table.insert( objetos, objetoN)

          --menuGroup:insert(letrasCorGroup)
          --menuGroup:insert(gp_letrasIncorr)         
 
      end 

       function act_addObjetosI(event) 
           --External code 
          local objetosIniciales

          if(_G.DifficultLevel == 1) then
            objetosIniciales = 2
            n_objetosFila = 2
            intervaloNuevoOb = 4
            n_objetos_nuevos = 1
            incrementoAlpha = 0.04
          elseif (_G.DifficultLevel == 2) then
            objetosIniciales = 3
            n_objetosFila = 3
            intervaloNuevoOb = 2
            n_objetos_nuevos = 1 
            incrementoAlpha = 0.05
          elseif (_G.DifficultLevel == 3) then
            objetosIniciales = 4
            n_objetosFila = 5
            intervaloNuevoOb = 2
            n_objetos_nuevos = 2 
            incrementoAlpha = 0.06
          else
            print( "ERROR AL OBETENER LA FICICULTAD" )
          end

          if(_G.Phase == 1) then 
            nivelActual = 1
          else
            nivelActual = 11
          end
          maxNivel = nivelActual + maxNivel

          _G.UpLevelSample[_G.Level*2 - (math.fmod(_G.Phase, 2))] = {_G.DifficultLevel}

          print( "Maximo Nivel "..maxNivel )
          for i=nivelActual,maxNivel,1 do
            table.insert( resultsTest, -1 )
            table.insert( timerTest, -1 )
          end

          menuGroup:insert(letrasCorGroup)
          menuGroup:insert(gp_letrasIncorr)         
 
          contadorTiempo = system.getTimer( )
          textLevel.text =  "Nivel : "..nivelActual

          for i=1,objetosIniciales do
            addNuevoObj()
          end
          
          numLetrasCor = letrasCorGroup.numChildren
          numLetrasInc = gp_letrasIncorr.numChildren

          act_cambiarAlph() 
           act_posicionarO() 
      end 

      function finalizarEjercicio( )
        -- body
        local name = _G.Level.._G.Phase
        local number
        local index = (_G.Level*2 - 1)+(_G.Phase-1)

        transitionStash.newTransition_975 = transition.to( TextoFinal, {alpha=TextoFinal.oldAlpha, time=1000, delay=0})

        --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Hay que hacer esto independiente del numero de letras: guardar letras en una tabla y quitar el 5
        
        if (_G.Results[index]) then
          table.remove( _G.Results, index )
          table.remove( _G.TimerResults, index )
        end
        table.insert( _G.Results, index, resultsTest )
        table.insert( _G.TimerResults, index, timerTest )
        
        letrasCorGroup:removeEventListener("tap", ongp_letrasCorrectasEvent ) 
        gp_letrasIncorr:removeEventListener("tap", ongp_letrasIncorrEvent )

        if (_G.Level == 1) then
          if (_G.Phase == 1) then
            number = 28  
          else
            number = 33
          end
        elseif (_G.Level == 2) then
          if (_G.Phase == 1) then
            number = 16  
          else
            number = 21
          end
        elseif (_G.Level == 3) then
          if (_G.Phase == 1) then
            number = 37  
          else
            number = 42
          end
        elseif (_G.Level == 4) then
          if (_G.Phase == 1) then
            number = 46  
          else
            number = 52
          end
        elseif (_G.Level == 5) then
          if (_G.Phase == 1) then
            number = 1  
          else
            number = 1
          end
        end
        cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
        dispose(); director:changeScene( "page_"..number, "fade" ) 
      end


       local function statisticsUpdate()
          local auxLevel = math.fmod(nivelActual, 11)
          if (_G.Phase == 2) then
            auxLevel = auxLevel + 1
          end
          print( "Statitics LEVEL : "..auxLevel )
          if (resultsTest[auxLevel] > 0) then
              resultsTest[auxLevel] = resultsTest[auxLevel] + n_fallosNivel
          else
              resultsTest[auxLevel] = n_fallosNivel
          end

          n_fallosNivel = 0

          local tiempo = (system.getTimer( ) - contadorTiempo) / 1000 -- In seconds

          if (timerTest[auxLevel] > 0 ) then
            timerTest[auxLevel] = timerTest[auxLevel] + tiempo
          else
            timerTest[auxLevel] = tiempo
          end

          contadorTiempo = system.getTimer( ) 
       end

       function act_letraIncorr(event)
          if (timerApplause) then
             cancel_timer_Applause()
          end

          n_fallosNivel = n_fallosNivel + 1
          saveKwikVars({"n_fallosNivel",n_fallosNivel + 1}) 
          n_fallos = n_fallos - 1
          saveKwikVars({"n_fallos",n_fallos - 1})
          n_aciertosSegTotales = 0
          
          act_posicionarO() 

          if (n_fallos == 0) then 
           transitionStash.newTransition_692 = transition.to( ExplicacionFall, {alpha=ExplicacionFall.oldAlpha, time=1000, delay=0}) 
           n_fallos = 3
           saveKwikVars({"n_fallos",3}) 
           if (nivelActual > 1) then
            statisticsUpdate() 
            nivelActual = nivelActual - 1
            saveKwikVars({"nivelActual",nivelActual - 1})
            textLevel.text =  "Nivel : "..nivelActual 
           end 
           act_cambiarAlph() 
          end 

          act_eliminarVid() 
          activeNegacion() 
       end 

       function act_letraCorrec(event)
           if (timerApplause) then
             cancel_timer_Applause()
           end

           statisticsUpdate()

           if (nivelActual+1 == maxNivel) then 
            finalizarEjercicio() 
           else
            --Increment and actually coint
            
            textCoinUpdate( incrementCoin, "add" )
            _G.TotalAddCoinEx = _G.TotalAddCoinEx + incrementCoin

            if (n_aciertosSegTotales == maxAciertosSeguidosIncremento) then
              if (intervaloNuevoOb == 1) then
                n_objetos_nuevos = n_objetos_nuevos + 1
              else
                intervaloNuevoOb = math.floor(intervaloNuevoOb / 2) -- division integer
                n_aciertosSegTotales = 0
              end
              local auxLevel = math.fmod(nivelActual, 11)
              if (_G.Phase == 2) then
                auxLevel = auxLevel + 1
              end
              table.insert( _G.UpLevelSample[_G.Level*2 - (math.fmod(_G.Phase, 2))], auxLevel)
            else
              n_aciertosSegTotales = n_aciertosSegTotales + 1  
            end

            if (n_aciertosSeg >= intervaloNuevoOb) then
              if (letrasCorGroup.numChildren + gp_letrasIncorr.numChildren <= maxObjectos) then
                for i=1,n_objetos_nuevos do
                  addNuevoObj()
                end    
              end       
              n_aciertosSeg = 1
              saveKwikVars({"n_aciertosSeg",1}) 
            else 
              n_aciertosSeg = n_aciertosSeg + 1
              saveKwikVars({"n_aciertosSeg",n_aciertosSeg + 1}) 
            end
            nivelActual = nivelActual + 1
            textLevel.text =  "Nivel : "..nivelActual

            act_cambiarAlph() 
            act_posicionarO() 
            act_play() -- Animation to applaud
          end 
       end 

 
      --End Actions (functions) 

 
       -- Timers 
       timerStash.timer_addObjeto = timer.performWithDelay( 0, act_addObjetosI, 1 ) 

       -- Button event listeners 
       ongp_letrasCorrectasEvent = function (event) 
          but_392(letrasCorGroup) 
          return true 
       end

       letrasCorGroup:addEventListener("tap", ongp_letrasCorrectasEvent ) 
       
       ongp_letrasIncorrEvent = function (event) 
          but_letraIncorr(gp_letrasIncorr) 
          return true 
       end 

       gp_letrasIncorr:addEventListener("tap", ongp_letrasIncorrEvent ) 

       -- Button functions 
       function but_392(self) 
           act_letraCorrec() 
       end 

       function but_letraIncorr(self) 
           act_letraIncorr() 
       end  
       _G.CurrentPage = curPage 
       _G.LastPage = curPage  
       _G.LastPageLevel[_G.Level] = curPage 

       -- kwkrectangleW positioning 
       kwkrectangleW = display.newImageRect( imgDir.. "kwkrectanglew.png", 1280, 800 ); 
       kwkrectangleW.x = 640; kwkrectangleW.y = 400; kwkrectangleW.alpha = 1; kwkrectangleW.oldAlpha = 1 
       kwkrectangleW.oriX = kwkrectangleW.x; kwkrectangleW.oriY = kwkrectangleW.y 
       kwkrectangleW.name = "kwkrectangleW" 
       menuGroup:insert(1,kwkrectangleW); menuGroup.kwkrectangleW = kwkrectangleW 

       -- explSobered positioning 
       explSobered = display.newImageRect( imgDir.. "p15_explsobered.png", 83, 111 ); 
       explSobered.x = 1199; explSobered.y = 84; explSobered.alpha = 1; explSobered.oldAlpha = 1 
       explSobered.xScale = 1.3; 
       explSobered.yScale = 1.3; 
       explSobered.oriX = explSobered.x; explSobered.oriY = explSobered.y 
       explSobered.name = "explSobered" 
       menuGroup:insert(explSobered); menuGroup.explSobered = explSobered 

       -- explHappy positioning 
       explHappy = display.newImageRect( imgDir.. "p15_explhappy.png", 83, 111 ); 
       explHappy.x = 1199; explHappy.y = 84; explHappy.alpha = 0; explHappy.oldAlpha = 0 
       explHappy.xScale = 1.3; 
       explHappy.yScale = 1.3; 
       explHappy.oriX = explHappy.x; explHappy.oriY = explHappy.y 
       explHappy.name = "explHappy" 
       menuGroup:insert(explHappy); menuGroup.explHappy = explHappy 
 
       -- Group(s) creation 

       -- (MIDDLE) External code will render here 

       -- do not swipe this page 

       dispose = function(event) 
          cancelAllTimers(); cancelAllTransitions() 
          if audio.isChannelActive ( 1 ) then 
   audio.stop(1); 
 end 
 audio.dispose(aplausos); aplausos = nil 
       end 

       -- (BOTTOM) External code will render here 


    end 
    drawScreen() 

    return menuGroup 
end 
