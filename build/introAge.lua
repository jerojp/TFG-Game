 local ageText = display.newText( "Así que tienes :", 648, 190, native.systemFont, 60 ) 
 ageText.x = display.contentCenterX
 ageText:setTextColor (255, 255, 255)  
 menuGroup:insert(ageText);

 local ageIntro = display.newText( _G.Age.." años", 648, 248, native.systemFont, 48 ) 
 ageIntro.x = ageText.x; ageIntro.y = ageText.y + ageText.contentHeight/2 + 45
 ageIntro:setTextColor (255, 255, 255)  
 menuGroup:insert(ageIntro);