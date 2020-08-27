




; ==============================================================
; Grupo que manipula un reverbsc
;
; xpos : posición horizontal del grupo dentro del panel
; ypos : posición vertical del grupo dentro del panel
; 
; Amount : (gkrevsc_amount) cantidad de señal que se le envía al reverb
; Feedback : (gkrevsc_fb)
; Cutoff : (gkrevsc_fco) frecuencia de corte del filtro lowpass 
; ==============================================================
#define FLGROUP_REVERBSC(xpos'ypos)
#
	idespl = 65
	iw = idespl * 6 + 10
	ih = 95
	$GROUP_HEAD($xpos'$ypos'iw)
	FLgroup "   R e v e r b s c", iw, ih, $xpos, $ypos, 0
			ix = $xpos + 10
			iy = $ypos + 8
		$KNOB(revsc_amt'"amount"'ix'iy'.001'.999'.5'0)
			ix = ix + idespl
		$KNOB(revsc_fblvl'"feedback"'ix'iy'.001'.997'.65'0)
			ix = ix + idespl
		$KNOB(revsc_fco'"cutoff"'ix'iy'16'21000'7023'-1)
			ix = ix + idespl
		$KNOB(revsc_sr'"sr"'ix'iy'2000'96000'44100'0)
			ix = ix + idespl
		$KNOB(revsc_pv'"pitch-var"'ix'iy'.001'10'.6'-1)
			ix = ix + idespl
			iy = iy + 13
			iwidth = 60
			iheight = 30	
			FLcolor -1
		gkrevsc_skip, ihrevsc_ FLbutton "skip", 1, 0, 3, iwidth, iheight, ix, iy, -1, 1, 0, 0
		FLsetVal_i 1, ihrevsc_
	FLgroupEnd
        ix = $xpos + iw - 24
        iy = $ypos - 18
    $BUTTON_ON_OFF(revsc_x'ix'iy)
#