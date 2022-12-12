; Message d'accueil
Msg := "Bonjour,`r`r"
Msg .= "Voici mon scrip AutoHotKey pour répéter plusieurs fois l'action du personnage principale sur Dofus.`r"
Msg .= "Appuyez sur <ESC> pour fermer le programme.`r`r`r"
Msg .= "Les fonctionnalités:`r`r"
Msg .= "1) Click molette permet de faire les déplacements de toute sa team.`r`r"
Msg .= "2) Click <Suivant> de la souris permet de switch au perso suivant`r`r"
Msg .= "3) En appuyant sur <CTRL> + <NUMPAD> vous pouvez switch de personnage sur celui que vous voulez.`r`r"
Msg .= "4) Pour déplacer sa team avec les flèches du clavier:`r"
Msg .= "- Setup le curseur pour chaque direction: <Alt> + <Flèche directionnelle>`r"
Msg .= "- Se déplacer avec: <Ctrl> + <Flèche directionnelle>`r`r"
MsgBox, % Msg
;******************


;delayTime := 250
; Message demandant de renseigner le delais entre chaque action
InputBox, delayTime, Temps entre chaque action,`rRenseignez le temps (en miliseconde soit 1000 = 1sec) entre chaque action.`r`rPour un ordinateur puissant je recommende 250 ou 300 sinon je vous conseil 500`, c'est une bonne moyenne, , 480, 240
if ErrorLevel
	ExitApp
;******************

index := 1

;############################### Fonctions ###############################

; Cette partie permet de lister les fenetres windows ouvertes.
i := 0
WinGet windows, List
Loop %windows%
{
	id := windows%A_Index%
	WinGetTitle wt, ahk_id %id%
	if (wt)
	{
		IfInString, wt,	- Dofus
		{
			if (i > 0) {
				result .= "|"
			}
			result .= wt
			i += 1
		}
	}
}
;******************



; Choix de l'ordre des fenetres Dofus (Le mieux est de les mettres par ordre d'initiative)
Gui, Add, Text,, Selectionne ton personnage principal :
Gui, Add, DDL, w250 vFirst, %result%
Gui, Add, Text,, Selectionne ton deuxieme personnage :
Gui, Add, DDL, w250 vSecond, %result%
Gui, Add, Text,, Selectionne ton troisieme personnage :
Gui, Add, DDL, w250 vThird, %result%
Gui, Add, Text,, Selectionne ton quatrieme personnage :
Gui, Add, DDL, w250 vFourth, %result%
Gui, Add, Text,, Selectionne ton cinquieme personnage :
Gui, Add, DDL, w250 vFifth, %result%
Gui, Add, Text,, Selectionne ton sixieme personnage :
Gui, Add, DDL, w250 vSixth, %result%
Gui, Add, Text,, Selectionne ton septieme personnage :
Gui, Add, DDL, w250 vSeventh, %result%
Gui, Add, Text,, Selectionne ton huitieme personnage :
Gui, Add, DDL, w250 vEighth, %result%

Gui, Add, Button, default, OK
Gui, Margin, 30, 30
Gui, Show,, Ordre d'initiative
return

ButtonOK:
Gui, Submit
comptes := [First, Second, Third, Fourth, Fifth, Sixth, Seventh, Eighth]
if WinExist(comptes[1]) {
	WinActivate
}
ArrowUp := []
ArrowDown := []
ArrowLeft := []
ArrowRight := []
;******************



; Cette fonction qui permet de switch entre chaque compte pour le deplacement de toute sa team
move(d, comptes, x, y)
{
	res := 0
	if (x && y)
	{
		for Ind, compte in comptes
		{
			if (compte)
			{
				if WinExist(compte) 
				{
					WinActivate
					Random, ad, 50, 150
					d2 := d + ad
					Random, delay, % d, % d2
					Sleep % delay
					Click %x% %y%
					;Random, ShortDelay, 40, 95
					;Sleep % ShortDelay
					;Click %x% %y%
					res = % Ind
				}
			}
		}
	}
	return res
}
;******************



; Cette fonction permet de switch de fenetre sur le perso que l'on veut
goto(name_page)
{
	if WinExist(name_page) {
		WinActivate
	}
}
;******************




;############################### Mouse Shortcuts ###############################

	; Assignation des positions pour deplacer ses persos avec les fleches: <ALT> + <Fleche Up/Down/Left/Right>
	Alt & Up::
		MouseGetPos, x, y
		ArrowUp[1] := x
		ArrowUp[2] := y
		;MsgBox, setup ArrowUp
		return
		
	Alt & Down::
		MouseGetPos, x, y
		ArrowDown[1] := x
		ArrowDown[2] := y
		;MsgBox, setup ArrowDown
		return
		
	Alt & Left::
		MouseGetPos, x, y
		ArrowLeft[1] := x
		ArrowLeft[2] := y
		;MsgBox, setup ArrowLeft
		return
		
	Alt & Right::
		MouseGetPos, x, y
		ArrowRight[1] := x
		ArrowRight[2] := y
		;MsgBox, setup ArrowRight
		return


	; Deplacement de la team vec les fleches <CTRL> + <UP, DOWN, LEFT, RIGHT>
	LCtrl & Up::index = % move(delayTime, comptes, ArrowUp[1], ArrowUp[2])
	LCtrl & Down::index = % move(delayTime, comptes, ArrowDown[1], ArrowDown[2])
	LCtrl & Left::index = % move(delayTime, comptes, ArrowLeft[1], ArrowLeft[2])
	LCtrl & Right::index = % move(delayTime, comptes, ArrowRight[1], ArrowRight[2])

	; Click Molette permet de deplacer toute sa team a la position du curseur
	MButton::
		MouseGetPos, x, y
		index = % move(delayTime, comptes, x, y)
		return


	; Bouton souris <Suivant>, c'est celui qui permet de revenir en avant sur les navigateurs (chrome, firefox, etc..)
	; Switch de fenetre pour aller au perso suivant
	XButton2::
		index += 1
		if WinExist(comptes[index]) {
			WinActivate
		}
		else {
			index = 1
			if WinExist(comptes[index]) {
				WinActivate
			}
		}
		return

	; Switch de fenetre pour aller au perso suivant
	;&::
	;	index += 1
	;	if WinExist(comptes[index]) {
	;		WinActivate
	;	}
	;	else {
	;		index = 1
	;		if WinExist(comptes[index]) {
	;			WinActivate
	;		}
	;	}
	;	return

	; La touche <(> permet de faire un Alt + Esc
	;(::Send, !{Esc}


	;Ouvre la fenetre du perso 1
	^Numpad1::
		goto(comptes[1])
		index = 1
		return
	;Ouvre la fenetre du perso 2
	^Numpad2::
		goto(comptes[2])
		index = 2
		return
	;Ouvre la fenetre du perso 3
	^Numpad3::
		goto(comptes[3])
		index = 3
		return
	;Ouvre la fenetre du perso 4
	^Numpad4::
		goto(comptes[4])
		index = 4
		return
	;Ouvre la fenetre du perso 5
	^Numpad5::
		goto(comptes[5])
		index = 5
		return
	;Ouvre la fenetre du perso 6
	^Numpad6::
		goto(comptes[6])
		index = 6
		return
	;Ouvre la fenetre du perso 7
	^Numpad7::
		goto(comptes[7])
		index = 7
		return
	;Ouvre la fenetre du perso 8
	^Numpad8::
		goto(comptes[8])
		index = 8
		return
	

	; Touche Echap permet de fermer le script
	Esc::
	MsgBox, A Bientot :)
	ExitApp

;******************	