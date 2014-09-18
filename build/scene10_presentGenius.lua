require( "ControlScene" )
require("viewGenius")

local gpGenius = createGenius( )
menuGroup:insert( gpGenius )
gpGenius.genius:pause( )

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
_G.StoreToysUnlocked = true
_G.FirstVisitMap = true

local aud = {"genio_1.mp3", "genio_2.mp3", "genio_3.mp3", "genio_introTesoro.mp3", "genio_4.mp3"}
local sub = {"Hola, soy el genio mágico Ali encerrado en esta tablet mágica. ¿Qué puedo hacer por ti?",
			"Sí. es cierto, pero yo soy un genio moderno. Así que un explorador... creo que puedo ayudarte, tengo por aquí un mapa misterioso con el que podrás encontrar algunos tesoros. He oído antes que el Jefe te pagará cada vez que descubras un nuevo tesoro, yo me encargaré de que te llegue el dinero. Cuando tengas suficientes monedas te podré conseguir juguetes mágicos como estos",
			"Este es el mapa que te ha enviado el jefe para tu aventura. Tiene todos los lugares a donde puedes viajar para conseguir todos los tesoros. Si consigues viajar a todos estos lugares y encontrar todos los tesoros te recompensaré con un cofre misterioso.",
			"Este cofre misterioso jamás ha sido abierto y nadie sabe que puede contener. !Me muero por ver que contiene! Así que pongámonos en marcha ahora mismo.",
			"¿Bueno, por dónde quieres comenzar tu aventura?"}

addCharacter(gpGenius.genius, aud, sub)

aud = {"exp_2.mp3", "exp_3.mp3"}
sub = {"!Qué sorpresa, un genio! Yo acabo de convertirme en explorador y deseo viajar por todo el mundo para buscar tesoros ocultos. Pero una pregunta, ¿los genios no estáis siempre escondidos en una lámpara?.",
	  "!Genial! Muchas gracias genio."}

addCharacter(nil, aud, sub)

local sec = {1, 2, 1, 2, 1, 1, 1}
setSecuence( sec )

local img = {path = imgDir.."continentes.jpg"}
local imgStore = {path = imgDir.."storeToys.jpg"}
local imgCofre = {path = imgDir.."cofre.png", w = 342, h = 272}
local events = {nil, nil, {mytype = "image", value = {1, imgStore } }, nil, {mytype = "image", value = {0, img } }, {mytype = "image", value = {0, imgCofre } }, nil}
setEventsControlScene(events)

playScene( "page_11" )
