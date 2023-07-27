; Message d'accueil
Msg := "Bonjour,`r`r"
Msg .= "Voici mon scrip AutoHotKey pour rajouter du confort à la forgemagie sur Dofus.`r"
Msg .= "Appuyez sur <CTRL> + <ESC> pour fermer le programme.`r`r`r"
Msg .= "Les fonctionnalités:`r`r"
Msg .= "1) <ALT> + <ESPACE> prmet de memoriser la position d'ou le click doit être effectué (Bouton Fusionner).`r`r"
Msg .= "2) <CTRL> + <ESPACE> permet de cliquer a la position memorisée et remettre le curseur la ou il se trouvait.`r`r"
MsgBox, % Msg
;******************


;Initialisation des variables
ValidPosition := []
;******************

Move_click(x, y, Positionx, Positiony)
{
	if (Positionx && Positiony)
	{
		Click %Positionx%, %Positiony%
		MouseMove x, y
	}
	else {
		MsgBox, Veuillez renseigner l'emplacement ou le curseur doit cliquer en appuyant sur <Alt> + <ESPACE>
	}
}

;############################### Mouse Shortcuts ###############################
	Alt & Space::
		MouseGetPos, x, y
		ValidPosition[1] := x
		ValidPosition[2] := y
		return
	

	; Click sur ValidPosition et reviens a l'ancienne position du curseur

	LCtrl & Space::
		MouseGetPos, x, y
		move_click(x, y, ValidPosition[1], ValidPosition[2])
		return


	; <Ctrl> + <Esc> permet de fermer le script
	^Esc::
		MsgBox, à bientot :)
		ExitApp

;******************	