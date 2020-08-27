/**********************************************************************
*	iván fernández la banca 
*	2019
* 	wdg_general.udo
*	Setup de los widgets en general.
*
*	última modificación: 13.5.2019
**********************************************************************/


; ============================================================
; Paleta de colores para las diferentes partes de los widgets
; ============================================================
#define ColorWithe #255, 255, 255#

#define ColorPanel #0, 128, 255#                      ; color general del panel
#define ColorGroup #0, 89, 179#                       ; color de los group panels
#define ColorWidget #0, 115, 230#                     ; color principal de los widgets
#define ColorLabelGroup #$ColorWithe#                 ; color de las etiquetas de los grupos
#define LabelGroup #16, 1, 6, $ColorLabelGroup#       ; fuente y color del título del grupo
#define LabelWidget #13, 1, 1, $ColorWithe#           ; fuente y color de las etiquetas de los widgets

; ============================================================
; Encabezado genérico para cada grupo de controles
;
; xpos : posición horizontal del grupo dentro del panel
; ypos : posición vertical del grupo dentro del panel
; width : ancho del grupo
; ============================================================
#define GROUP_HEAD(xpos'ypos'width)
#
		FLlabel $LabelGroup
		FLcolor $ColorGroup
		iheight = 22
	FLgroup "", $width, iheight, $xpos, $ypos - iheight, 0
	FLgroupEnd
#

; ============================================================
; Un Knob medianamente personalizable con un box que muestra el valor
;
; name : nombre del knob. Identificador ... 'gk$name' es el identificador global
; label : Etiqueta para el knob
; xpos : posición horizontal del knob dentro del grupo
; ypos : posición vertical del knob dentro del grupo
; vmin : valor mínimo
; vmax : valor máximo
; vini : valor inicial
; texp : tipo de curva del knob. 0 es lineal, -1 es exponencial
; ============================================================
#define KNOB(name'label'xpos'ypos'vmin'vmax'vini'texp)
#
		FLcolor $ColorWithe
		iwidth = 56
		iheight = 18
	iDisp$name FLvalue "", iwidth, iheight, $xpos - 3, $ypos + 60
		FLlabel $LabelWidget
		FLcolor $ColorWidget
		itype = 4
		iwidth = 40
	gk$name, ih$name FLknob $label, $vmin, $vmax, $texp, itype, iDisp$name, iwidth, $xpos + 5, $ypos
	FLsetVal_i $vini, ih$name
#

; SLIDERS================================================================================================================
; ============================================================
; Un slider vertical medianamente personalizable con un box que muestra el valor.
; Los valores se leen de abajo hacia arriba. Esto impide que se pueda asignar el valor
; inicial aquí y además la curva tiene que ser lineal
;
; name : nombre del slider. Identificador ... 'gk$name' es el identificador global
; label : Etiqueta para el slider
; xpos : posición horizontal del slider dentro del grupo
; ypos : posición vertical del slider dentro del grupo
; vmin : valor mínimo
; vmax : valor máximo
; type : apariencia del slider -> 2, 4 o 6
; ============================================================
#define VSLIDER_BOX(name'label'xpos'ypos'vmin'vmax'type)
#
	FLcolor $ColorWidget, $ColorGroup 
		iwidth = 50
		iheight = 18
	iDisp$name FLvalue "", iwidth - 5, iheight, $xpos, $ypos + 68
	gk$name, ih$name FLslider $label, $vmax, $vmin, 0, $type, iDisp$name, iheight, iwidth, $xpos + 13, $ypos
#
; este slider vertical no tiene box
#define VSLIDER(name'label'xpos'ypos'vmin'vmax'vini'type)
#
		FLlabel 13, 1, 3, 255, 255, 255
		FLcolor $ColorGroup, $ColorWidget 
	gk$name, ih$name FLslider $label, $vmin, $vmax, 0, $type, -1, 18, 70, $xpos, $ypos
	FLsetVal_i ($vmax - $vini), ih$name
#
; ============================================================
; Un slider horizontal medianamente personalizable con un box que muestra el valor.
;
; name : nombre del slider. Identificador ... 'gk$name' es el identificador global
; label : etiqueta para el slider
; xpos : posición horizontal del slider dentro del grupo
; ypos : posición vertical del slider dentro del grupo
; vmin : valor mínimo
; vmax : valor máximo
; texp : tipo de curva del knob. 0 es lineal, -1 es exponencial
; type : apariencia del slider -> 1, 3 o 5
; ============================================================
#define HSLIDER_BOX(name'label'xpos'ypos'vmin'vmax'vini'texp'type)
#
		FLcolor $ColorGroup, $ColorWidget 
		iwidth = 50
		iheight = 18
	iDisp$name FLvalue "", iwidth, iheight, $xpos, $ypos + 22
		iwidth = 200
	gk$name, ih$name FLslider $label, $vmin, $vmax, $texp, $type, iDisp$name, iwidth, 18, $xpos, $ypos
	FLsetVal_i $vini, ih$name
#
; ============================================================
; Un slider horizontal medianamente personalizable.
;
; name : nombre del slider. Identificador ... 'gk$name' es el identificador global
; label : etiqueta para el slider
; xpos : posición horizontal del slider dentro del grupo
; ypos : posición vertical del slider dentro del grupo
; vmin : valor mínimo
; vmax : valor máximo
; texp : tipo de curva del knob. 0 es lineal, -1 es exponencial
; type : apariencia del slider -> 1, 3 o 5
; ============================================================
#define HSLIDER(name'label'xpos'ypos'vmin'vmax'vini'texp'type)
#
		FLcolor $ColorGroup, $ColorWidget 
		iheight = 18
		iwidth = 200
	gk$name, ih$name FLslider $label, $vmin, $vmax, $texp, $type, -1, iwidth, iheight, $xpos, $ypos
	FLsetVal_i $vini, ih$name
#
; FIN SLIDERS============================================================================================================

#define BUTTON_ON_OFF(name'xpos'ypos)
#
    FLcolor -1
    gk$name,ih$name FLbutton "", 1, 0, 3, 15, 15, $xpos, $ypos, -1
    FLsetColor2	255, 0, 0, ih$name
    FLsetVal_i 1, ih$name
#

; ==============================================================
; Grupo que prende y apaga un instrumento
;
; xpos : posición horizontal del grupo dentro del panel
; ypos : posición vertical del grupo dentro del panel
; instrplay : número del instrumento a prender y apagar
; instrstop : número del instrumento que apaga a 'ninstr'
; ==============================================================
#define FLGROUP_PLAY_STOP(xpos'ypos'instrplay'instrstop)
#
	iwidth = 73
	$GROUP_HEAD($xpos'$ypos'iwidth)
		iheight = 39
		ix = $xpos
		iy = $ypos
		iborder = 0
	FLgroup " Play", iwidth, iheight, ix, iy, iborder
			ion = 0
			ioff = 0
			itype = 1
			iwidth = 30
			iheight = 30	
			ix = ix + 5
			iy = iy + 5
			iplayopcode = 0
			istarttim = 0
			idur = -1                    ;Turn instruments on idefinitely
			FLlabel 12, 1, 1, 1, 50, 32
			FLcolor $ColorWidget
		gkplay, ihb1 FLbutton "@>", ion, ioff, itype, iwidth, iheight, ix, iy, iplayopcode, $instrplay, istarttim, idur 
			ix = ix + iwidth + 3
		gkstop, ihb2 FLbutton "@square", ion,ioff, itype, iwidth, iheight, ix, iy, iplayopcode, $instrstop, istarttim, idur
	FLgroupEnd
#

