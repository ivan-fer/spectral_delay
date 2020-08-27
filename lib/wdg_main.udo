/**********************************************************************
*	iván fernández la banca 2019
*	wdg_main.csd
*	Setup de los widgets en general.
**********************************************************************/

	#include "wdg_general.udo"
	#include "wdg_spectral_delay.udo"
	#include "wdg_reverb.udo"

		FLcolor $ColorPanel
		Slabel = "spectral delay - iván fernández 2019"
		iwidth = 563          ; width
		iheight = 502         ; height
		ix = 200              ; horizontal position
		iy = 150              ; vertical position
		iborder = 0           ; border type of the container. Integer between 0 and 7
		ikbdcapture = 0       ; if 1, then keyboard events are captured by the window
		iclose = 0            ; if other than 0, the window cannot be closed by the user directly
	FLpanel Slabel, iwidth, iheight, ix, iy, iborder, ikbdcapture, iclose
		$FLGROUP_SPECTRAL_DELAY(6'29)
		$FLGROUP_TABLES(6'160)
		; $FLGROUP_OUTPUT(6'281)
		$FLGROUP_REVERBSC(155'402)
	FLpanelEnd
		FLrun

