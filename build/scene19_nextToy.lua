_G.Level = 2
_G.Phase = 2
local parameters = {nameToy="Elefante", pathToy="objeto241.png", costToy=_G.PriceToys.elephant, widthToy = 233*1.5 , heightToy = 168*1.5, nextPage = "page_20", indexToy = 3}
dispose(); director:changeScene( parameters, "viewNewToy", "fade" )