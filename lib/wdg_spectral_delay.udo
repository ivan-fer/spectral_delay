
#define CHOICE_FFT_SIZE(xpos'ypos)
#
        ix = $xpos
        iy = $ypos
        iwidth = 150
        iheight = 80
    ih FLbox "", 8, 5, 14, iwidth, iheight, ix, iy + 10    
    ih2 FLbox "FFT Size", 8, 5, 14, 75, 20, ix + 8, iy
    FLlabel 12, 1, 1, $ColorPanel
    FLcolor -1
        ix = $xpos + 6
        iy = $ypos + 23
    gkfft_size, ihfft_size FLbutBank 4, 2, 3, 140, 60, ix, iy, -1 
    FLsetVal_i 1, ihfft_size
    FLlabel 12, 1, 1, $ColorWithe
    FLcolor $ColorGroup
        ix = ix + 21
        idespl = 20
        iwidth = 40
        iheight = 22
    ih FLbox "128 ", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "256 ", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "512 ", 1, 5, 14, iwidth, iheight, ix, iy
        ix = ix + 70
        iy = $ypos + 23
    ih FLbox "1024", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "2048", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "4096", 1, 5, 14, iwidth, iheight, ix, iy
#

#define FLGROUP_SPECTRAL_DELAY(xpos'ypos)
#
	idespl = 75
	iw = 550
	ih = 105
	$GROUP_HEAD($xpos'$ypos'iw)
	FLgroup "    S  p  e  c  t  r  a  l    d  e  l  a  y", iw, ih, $xpos, $ypos, 0
        $CHOICE_FFT_SIZE($xpos+10'$ypos+8)
        	idespl = 75
			ix = ix + idespl
			iy = $ypos + 16
		$KNOB(spd_mdel'"max.delay"'ix'iy'.1'8'1'0)
			ix = ix + idespl
		$KNOB(spd_mix'"dry/wet"'ix'iy'0'1'1'0)
			ix = ix + idespl
		$KNOB(spd_fb'"feedback"'ix'iy'0'1'.85'0)
			ix = ix + idespl
		$KNOB(spd_level'"level"'ix'iy'0'1'.5'0)
	FLgroupEnd
        ix = $xpos + iw - 24
        iy = $ypos - 18
    $BUTTON_ON_OFF(trn_x'ix'iy)
#

#define CHOICE_TABLE_AMPS(label'ident'xpos'ypos'vini)
#
        ix = $xpos
        iy = $ypos
        iwidth = 260
        iheight = 120
    ih FLbox "", 8, 5, 14, iwidth, iheight, ix, iy + 10    
    ih FLbox $label, 8, 5, 14, 95, 20, ix + 8, iy
    FLlabel 12, 1, 1, $ColorGroup
    FLcolor -1
        ix = $xpos + 6
        iy = $ypos + 23
    gk$ident, ih$ident FLbutBank 4, 2, 5, 250, 100, ix, iy, -1 
    FLsetVal_i $vini, ih$ident
    FLlabel 12, 1, 1, $ColorWithe
    FLcolor $ColorGroup
        ix = ix + 21
        idespl = 20
        iwidth = 70
        iheight = 22
    ih FLbox "Hi to Lo", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "Lo to Hi", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "Random  ", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "Peak 1  ", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "Peak 2  ", 1, 5, 14, iwidth, iheight, ix, iy
        ix = ix + 125
        iy = $ypos + 23
    ih FLbox "Peak 3  ", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "Comb 1  ", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "Comb 2  ", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "Spring  ", 1, 5, 14, iwidth, iheight, ix, iy
        iy = iy + idespl
    ih FLbox "Flata   ", 1, 5, 14, iwidth, iheight, ix, iy
#

#define FLGROUP_TABLES(xpos'ypos)
#
	idespl = 75
	iw = 550
	ih = 145
	$GROUP_HEAD($xpos'$ypos'iw)
	FLgroup "    T  a  b  l  e  s", iw, ih, $xpos, $ypos, 0
        isx = $xpos + 10
        isy = $ypos + 8
        $CHOICE_TABLE_AMPS("Amps"'amp_table'isx'isy'1)
        isx = $xpos + 280
        $CHOICE_TABLE_AMPS("Freqs"'freq_table'isx'isy'4)
	FLgroupEnd
        ix = $xpos + iw - 24
        iy = $ypos - 18
    $BUTTON_ON_OFF(tables_x'ix'iy)
#

