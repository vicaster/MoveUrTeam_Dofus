; Message d'accueil
Msg := "Bonjour,`r`r"
Msg .= "Voici mon scrip AutoHotKey pour répéter plusieurs fois l'action du personnage principale sur Dofus.`r"
Msg .= "Appuyez sur <ESC> pour fermer le programme.`r`r`r"
Msg .= "Les fonctionnalités:`r`r"
Msg .= "1) Click molette permet de faire les déplacements de toute sa team.`r`r"
Msg .= "2) Click <Suivant> de la souris permet de switch au perso suivant`r`r"
Msg .= "3) En appuyant sur <CTRL> + <NUMPAD> vous pouvez switch de personnage sur celui que vous voulez.`r`r"
Msg .= "4) Pour déplacer sa team avec les flèches du clavier:`r"
Msg .= "- Setup: Placer le curseur de souris a la position voulue pour chaque direction et appuyez sur <Alt> + <Flèche directionnelle>`r"
Msg .= "- Se déplacer avec <Ctrl> + <Flèche directionnelle>`r`r"
Msg .= "5) Pour soigner toute sa team d'un seul click:`r"
Msg .= "- Setup: il faut placer le consommable dans la barre de raccoursi du jeu (a droite des points de vie) puis placer le curseur de souris a l'emplacement et appuyer sur <Alt> + <h>`r"
Msg .= "- Et pour utiliser cette maccro il suffit juste d'appuyer sur <Ctrl> + <h>`r`r"
Msg .= "6) Pour rendre de l'energie a toute sa team d'un seul click c'est comme pour soigner mais avec la touche <g>:`r"
Msg .= "- Setup: il faut placer le consommable dans la barre de raccoursi du jeu (a droite des points de vie) puis placer le curseur de souris a l'emplacement et appuyer sur <Alt> + <g>`r"
Msg .= "- Et pour utiliser cette maccro il suffit juste d'appuyer sur <Ctrl> + <g>`r`r"
Msg .= "PS: pour soigner et rendre de l'energie a sa team la seule contrainte est que l'on peut utiliser uniquement des consommables qui ont des recettes sinon cela ne fonctionne pas car la fenettre du click droit est differente`r"
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
		IfInString, wt, o
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
;******************

;Initialisation des variables
ArrowUp := []
ArrowDown := []
ArrowLeft := []
ArrowRight := []
HealPosition := []
EnergyPosition := []
;******************



; Cette fonction qui permet de switch entre chaque compte pour le deplacement de toute sa team
move(d, comptes, x, y)
{
	res := 0
	if (x && y)
	{
		delay := d
		for Ind, compte in comptes
		{
			if (compte)
			{
				if WinExist(compte) 
				{
					WinActivate
					if (Ind >= 2)
					{
						Random, ad, 150, 250
						delay := delay + ad
					}
					Sleep % delay
					Click %x% %y%
					res = % Ind
				}
			}
		}
	}
	return res
}
;******************



; Cette fonction permet de heal toute sa team
; Conditions d'utilisation :
; il faut que la variable heal soit renseignee en x et y;
heal(d, comptes, x, y)
{
	if(x && y)
	{
		for Ind, compte in comptes
		{
			if (compte)
			{
				if WinExist(compte) 
				{
					WinActivate
					delay := d
					if (Ind >= 2)
					{
						Random, ad, 150, 250
						delay := delay + ad
					}
					Sleep % delay
					Click %x% %y%

					Random, shortDelay, 100, 150
					Sleep % shortDelay
					Click %x% %y% Right

					;Calcul des coordonnées pour utilisation multiples
					xh := % x + 20
					yh := % y - 175
					Sleep % shortDelay
					Click %xh% %yh%

					;Saisie de la quantité à utiliser et validation automatique par la touche <Enter>
					Sleep % shortDelay
					Send, 700
					Sleep, % shortDelay
					Send, {Enter}

					;Calcul des coordonnées pour valider
					;xz := % x + 350
					;yz := % y + 20
					;Sleep % shortDelay
					;MouseMove, xz, yz
					;Click

					res = % Ind
				}
			}
		}
	}
	else
	{
		MsgBox, Veuillez renseigner l'emplacement du pain dans votre barre raccoursi en positionnant le curseur de souris a l'emplacement puis appuyez sur <Alt> + <h>
	}
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
		return
		
	Alt & Down::
		MouseGetPos, x, y
		ArrowDown[1] := x
		ArrowDown[2] := y
		return
		
	Alt & Left::
		MouseGetPos, x, y
		ArrowLeft[1] := x
		ArrowLeft[2] := y
		return
		
	Alt & Right::
		MouseGetPos, x, y
		ArrowRight[1] := x
		ArrowRight[2] := y
		return
		
	Alt & h::
		MouseGetPos, x, y
		HealPosition[1] := x
		HealPosition[2] := y
		return
		
	Alt & g::
		MouseGetPos, x, y
		EnergyPosition[1] := x
		EnergyPosition[2] := y
		return


	; Deplacement de la team avec les fleches <CTRL> + <UP, DOWN, LEFT, RIGHT>
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
	Numpad1::
		goto(comptes[1])
		index = 1
		return
	;Ouvre la fenetre du perso 2
	Numpad2::
		goto(comptes[2])
		index = 2
		return
	;Ouvre la fenetre du perso 3
	Numpad3::
		goto(comptes[3])
		index = 3
		return
	;Ouvre la fenetre du perso 4
	Numpad4::
		goto(comptes[4])
		index = 4
		return
	;Ouvre la fenetre du perso 5
	Numpad5::
		goto(comptes[5])
		index = 5
		return
	;Ouvre la fenetre du perso 6
	Numpad6::
		goto(comptes[6])
		index = 6
		return
	;Ouvre la fenetre du perso 7
	Numpad7::
		goto(comptes[7])
		index = 7
		return
	;Ouvre la fenetre du perso 8
	Numpad8::
		goto(comptes[8])
		index = 8
		return
		
	;<Ctrl> + <h> permet de heal toute sa team
	^h::
		heal(delayTime, comptes, HealPosition[1], HealPosition[2])
		return
		
	;<Ctrl> + <g> permet de heal toute sa team
	^g::
		heal(delayTime, comptes, EnergyPosition[1], EnergyPosition[2])
		return
	
	;<Ctrl> + <Esc> permet de fermer le script
	^Esc::
	MsgBox, à bientot :)
	ExitApp

;******************	