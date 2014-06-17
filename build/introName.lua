 local nameIntro = display.newText( NameUser, 648, 248, native.systemFont, 48 ) 
 nameIntro:setTextColor (255, 255, 255)  
 nameIntro.alpha = 1; nameIntro.oldAlpha = 1 
 menuGroup:insert(nameIntro); menuGroup.nameIntro = nameIntro 