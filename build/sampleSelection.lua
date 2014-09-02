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
       local act_letraCorrec 
       local act_posicionarO 
       local act_addObjetosI
       local act_pause 
       local act_play  
       local statisticsUpdate
       local createHiddenPanel
       local removeHiddenPanel
       local nextSoundExp
       local playSoundExpInic
       local finalizarEjercicio
       local generateLetter
       local addNuevoObj
       local activeNegacion

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
       --local n_fallos = 3 -- Fallos al seleccionar 
       local nivelActual = 0-- Nievel de ejercicio, MAX = 20 
       local vidas = 6 --
       local TotalVidas = vidas  
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
       local isTimerNegacion = false
       local resultsTest = {} -- number of failures for this exercices for each level : resultsTest[1] == X failure for level 1
       local timerTest = {}
       local maxNivel = 10
       local contadorTiempo 
       _G.TotalAddCoinEx = 0
       local l
       local soundExp
       local soundExp4
       local hiddenPanel = nil
       local handle 
       local ch = 1
       local nextSoundExp
       local mySoundsExp
       local contExp = 1
       local handleAplausos

       menuGroup:insert( createTextCoin( ) )

       if(_G.Level==1) then
        l = "A"
        soundExp = ""
       elseif(_G.Level==2) then
        l = "E"
       elseif(_G.Level==3) then
        l = "I"
       elseif(_G.Level==4) then
        l = "A"
       else
        l = "U"
       end

       soundExp = "geniusIM"..l
       soundExp4 = "geniusIM4"..l

       local textCorrect = display.newText( "Letra "..l, display.contentCenterX, 5, native.systemFont, 38 )
       textCorrect.x = display.contentCenterX
       textCorrect:setFillColor( 0, 0, 0 )
       menuGroup:insert(textCorrect)


       objetoCorrect = display.newImageRect( imgDir.. "objeto".._G.Level.._G.Level.._G.Phase..".png", 120, 80 ); 
       objetoCorrect.x = display.contentCenterX; objetoCorrect.y = 90;
       menuGroup:insert(objetoCorrect); 

       textLevel = display.newText( "Nivel : "..nivelActual , display.contentCenterX, 134, native.systemFont, 28 ) 
       textLevel.x = display.contentCenterX
       textLevel:setTextColor (229, 185, 89)
       menuGroup:insert(textLevel)

       backgroundLower = display.newImageRect( imgDir.. "backgroundLower".._G.Level.._G.Phase..".png", 1280, 660 ); 
       backgroundLower.x = 640; backgroundLower.y = 470; backgroundLower.alpha = 1; backgroundLower.oldAlpha = 1 
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

       local function cancel_timer_Negacion(  )
          if (isTimerNegacion) then
             if (timerStash.timer_negacion) then
               timer.cancel(timerStash.timer_negacion)
               timerStash.timer_negacion = nil
             end
             isTimerNegacion = false
             if (negacion) then
               if gtStash.gt_linearNegacion then
                  gtStash.gt_linearNegacion:pause()
                  gtStash.gt_linearNegacion = nil
               end
                  --menuGroup:remove(negacion)
                negacion:removeSelf()
                negacion = nil
             end
          end
       end

       function activeNegacion( )
         -- body
          if timerApplause then
            cancel_timer_Applause()
          end

          if isTimerNegacion then
            cancel_timer_Negacion()
          end

          negacion = display.newImageRect( imgDir.. "p15_negacion.png", 139, 163 ); 
          negacion.x = 644; negacion.y = 307; negacion.alpha = 1; negacion.oldAlpha = 1 
          negacion.oriX = negacion.x; negacion.oriY = negacion.y 
          negacion.name = "negacion" 
          --menuGroup:insert(negacion)

          negacion:setReferencePoint(display.BottomCenterReferencePoint); 

          timerStash.timer_negacion = timer.performWithDelay( 2000, cancel_timer_Negacion, 1 )
          isTimerNegacion = true
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
            gtStash.gt_linear_sup = nil
         end 
         if gtStash.gt_linearInf then 
            gtStash.gt_linearInf:pause() 
            gtStash.gt_linearInf = nil
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
         if (audio.isChannelPlaying(ch)) then 
           audio.stop( ch ) 
         end
         audio.dispose( handleAplausos )
         handleAplausos = nil
            
       end 

       function cancel_timer_Applause(  )
          if (timerApplause) then
            if (timerStash.timer_249) then
              timer.cancel(timerStash.timer_249)
              timerStash.timer_249 = nil
            end
            timerApplause = false
            if (ManoInfer and ManoSup) then
              act_pause()
            end  
          end
       end

       function act_play()
           if timerApplause then
              cancel_timer_Applause()
           end
           if isTimerNegacion then
              cancel_timer_Negacion(  )
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

            timerStash.timer_249 = timer.performWithDelay( 2000, cancel_timer_Applause, 1 )
            timerApplause = true
            handleAplausos = audio.loadSound( audioDir.."geniusIM5.mp3" ) 
            audio.play( handleAplausos, {channel=ch} )  
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
                _G.goBackForExercise = true
                deleteMyDialog( myDialog )
                cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
                director:changeScene( "page_11", "fade" ) 
            end
           end
           return true
        end
        if (kwkvida[vidas]) then
          kwkvida[vidas]:removeSelf( );
          kwkvida[vidas]=nil
        end
        vidas = vidas - 1

        if (vidas > 0) then
          activeNegacion() 
      
          if (vidas == math.floor(TotalVidas/2) ) then
            createHiddenPanel( )
            contExp = 1
            mySoundsExp = { soundExp4 }
            nextSoundExp()
            if (nivelActual > 1) then
              statisticsUpdate() 
              nivelActual = nivelActual - 1
              textLevel.text =  "Nivel : "..nivelActual 
            end 
            act_cambiarAlph()
          end
        else
          if timerApplause then
              cancel_timer_Applause()
          end
          if isTimerNegacion then
              cancel_timer_Negacion(  )
          end
          --transitionStash.newTransition_577 = transition.to( TextoFinalIncor, {alpha=TextoFinalIncor.oldAlpha, time=1000, delay=0}) 
          myDialog = createMyDialog( "Ejercicio no superado", "¿ Deseas repetir el ejercicio ?", nil, "Si", listenerC, "No", listenerD)
        end
      end 

       local function actualizarEspacio(  )
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
              t2[i].y = 483 --212 411 607
            elseif (i/2 < n_objetosFila * 2) then
              t2[i].y = 284
            elseif (i/2 < n_objetosFila * 3) then
              t2[i].y = 679
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
          local nameImgLetter 

          objetoN = display.newImageRect( imgDir.."objeto"..nuevaLetra.._G.Level.._G.Phase..".png" , 190, 145 );
          objetoN.alpha = 1 - levelAlpha
          objetoN.oldAlpha = objetoN.alpha
          objetoN.name = "objeto"..nuevaLetra..contador ; contador = contador + 1

          if (not _G.LetterInSyllable or nuevaLetra==_G.Level) then
            nameImgLetter = "letra"..nuevaLetra..".png"
          else
            nameImgLetter = "letra"..nuevaLetra.._G.Level.._G.Phase..".png"
          end
          letraN = display.newImageRect( imgDir..nameImgLetter, 120, 145 );
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

      function createHiddenPanel( )
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

      function removeHiddenPanel( )
        -- body
        if (hiddenPanel) then
          menuGroup:remove(hiddenPanel)
          hiddenPanel:removeSelf( )
          hiddenPanel = nil
        end
      end

      local function onCompleteSoundExp( event )
          -- body
        audio.dispose( handle )
        handle = nil
        nextSoundExp()
      end

      local function playSoundExp( name )
        -- body
        handle = audio.loadSound( audioDir..name..".mp3" )
        audio.play( handle, {channel = ch, onComplete = onCompleteSoundExp} )
      end

      function nextSoundExp( )
          -- body
          if (contExp <= #mySoundsExp) then
            playSoundExp( mySoundsExp[contExp] )
            contExp = contExp + 1
          else
            removeHiddenPanel()
          end
      end

      function playSoundExpInic( )
        -- body 
        if (_G.firstSampleSel) then
          _G.firstSampleSel = false
          mySoundsExp = { soundExp, "geniusIM2", "geniusIM3", soundExp4 }
        else
          mySoundsExp = { soundExp4 }
        end
        contExp = 1
        act_addObjetosI()
        createHiddenPanel( )
        nextSoundExp()
      end

       function act_addObjetosI() 
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
          _G.Results[index] = nil
          _G.TimerResults[index] = nil
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
            number = 56  
          else
            number = 60
          end
        end
        cancelAllTweens() ; cancelAllTimers(); cancelAllTransitions() 
        dispose(); director:changeScene( "page_"..number, "fade" ) 
      end


       function statisticsUpdate()
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
          n_fallosNivel = n_fallosNivel + 1
          n_aciertosSegTotales = 0
          
          act_posicionarO()  

          act_eliminarVid() 
       end 

       function act_letraCorrec(event)
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
       timerStash.timer_addObjeto = timer.performWithDelay( 0, playSoundExpInic, 1 ) 

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