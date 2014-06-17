tablaEstadistic = display.newImageRect( imgDir.. "p22_tablaestadistic.png", 727, 403 ); 
       tablaEstadistic.x = 640; tablaEstadistic.y = 400; tablaEstadistic.alpha = 1; tablaEstadistic.oldAlpha = 1 
       tablaEstadistic.oriX = tablaEstadistic.x; tablaEstadistic.oriY = tablaEstadistic.y 
       tablaEstadistic.name = "tablaEstadistic" 
       menuGroup:insert(1,tablaEstadistic); menuGroup.tablaEstadistic = tablaEstadistic 

       -- ralladoError positioning 
       ralladoError = display.newImageRect( imgDir.. "p22_ralladoerror.png", 75, 41 ); 
       ralladoError.x = 460; ralladoError.y = 257; ralladoError.alpha = 1; ralladoError.oldAlpha = 1 
       ralladoError.oriX = ralladoError.x; ralladoError.oriY = ralladoError.y 
       ralladoError.name = "ralladoError" 
       menuGroup:insert(ralladoError); menuGroup.ralladoError = ralladoError 

       -- CruzAcierto positioning 
       CruzAcierto = display.newImageRect( imgDir.. "p22_cruzacierto.png", 75, 38 ); 
       CruzAcierto.x = 460; CruzAcierto.y = 289; CruzAcierto.alpha = 1; CruzAcierto.oldAlpha = 1 
       CruzAcierto.oriX = CruzAcierto.x; CruzAcierto.oriY = CruzAcierto.y 
       CruzAcierto.name = "CruzAcierto" 
       menuGroup:insert(CruzAcierto); menuGroup.CruzAcierto = CruzAcierto 

       -- FlechaSubida positioning 
       FlechaSubida = display.newImageRect( imgDir.. "p22_flechasubida.png", 22, 21 ); 
       FlechaSubida.x = 317; FlechaSubida.y = 257; FlechaSubida.alpha = 1; FlechaSubida.oldAlpha = 1 
       FlechaSubida.oriX = FlechaSubida.x; FlechaSubida.oriY = FlechaSubida.y 
       FlechaSubida.name = "FlechaSubida" 
       menuGroup:insert(FlechaSubida); menuGroup.FlechaSubida = FlechaSubida 

       -- numberLev positioning 
       numberLev = display.newImageRect( imgDir.. "p22_numberlev.png", 9, 19 ); 
       numberLev.x = 385; numberLev.y = 256; numberLev.alpha = 1; numberLev.oldAlpha = 1 
       numberLev.oriX = numberLev.x; numberLev.oriY = numberLev.y 
       numberLev.name = "numberLev" 
       menuGroup:insert(numberLev); menuGroup.numberLev = numberLev 

       -- numberTime positioning 
       numberTime = display.newImageRect( imgDir.. "p22_numbertime.png", 14, 19 ); 
       numberTime.x = 901; numberTime.y = 256; numberTime.alpha = 1; numberTime.oldAlpha = 1 
       numberTime.oriX = numberTime.x; numberTime.oriY = numberTime.y 
       numberTime.name = "numberTime" 
       menuGroup:insert(numberTime); menuGroup.numberTime = numberTime 

       -- seg positioning 
       seg = display.newImageRect( imgDir.. "p22_seg.png", 41, 20 ); 
       seg.x = 948; seg.y = 260; seg.alpha = 1; seg.oldAlpha = 1 
       seg.oriX = seg.x; seg.oriY = seg.y 
       seg.name = "seg" 
       menuGroup:insert(seg); menuGroup.seg = seg 