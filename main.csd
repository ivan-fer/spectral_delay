<CsoundSynthesizer>
<CsOptions>
    -odac -iadc -b512 -B1024 
</CsOptions>
<CsInstruments>

    sr = 44100
    ksmps = 16
    nchnls = 2
    0dbfs = 1

    #include "lib/wdg_main.udo"
    
    garevL init 0
    garevR init 0

	alwayson "spectral"
	alwayson "Reverb"


instr spectral
    kfft_size = gkfft_size
	kfft_size init 1
	kamp_t = gkamp_table
	kamp_t init 1
	kfreq_t = gkfreq_table
	kfreq_t init 4
	kmax_delay = gkspd_mdel
	kmix = gkspd_mix
	kfeedback = gkspd_fb
	klevel = gkspd_level
	
	ifftsizes[] fillarray 64, 128, 256, 512, 1024, 2048

	aL, aR ins

	ktrig changed kfft_size, kamp_t, kfreq_t, kmax_delay
	if ktrig == 1 then
		reinit UPDATE
	endif
	UPDATE:

	ifft = ifftsizes[i(kfft_size)]
	imax_delay limit i(kmax_delay), ifft / sr, 8

 	iftamps1 ftgen 1, 0, ifft, -7, imax_delay, ifft, 0                                      ; Hi to Lo
 	iftamps2 ftgen 2, 0, ifft, -7, 0, ifft, imax_delay                                      ; Lo to Hi
 	iftamps3 ftgen 3, 0, ifft, -21, 1, imax_delay                                           ; Random
 	iftamps4 ftgen 4, 0, ifft, -16, 0, ifft * 0.25, -4, imax_delay, ifft * 0.75, 4, 0       ; Peak 1
 	iftamps5 ftgen 5, 0, ifft, -16, 0, ifft * 0.125, -4, imax_delay, ifft * 0.75, 4, 0      ; Peak 2
 	iftamps6 ftgen 6, 0, ifft, -16, 0, ifft * 0.0125, -4, imax_delay, ifft * 0.075, 4, 0    ; Peak 3
 	iftamps7 ftgen 7, 0, ifft, -19, 8, imax_delay * 0.5, 0, imax_delay * 0.5                ; Comb 1
 	iftamps8 ftgen 8, 0, ifft, -19, 16, imax_delay * 0.5, 0, imax_delay * 0.5               ; Comb 2
 	iftamps9 ftgen 9, 0, ifft, -7, imax_delay - (imax_delay * 0.1), ifft, imax_delay        ; Spring
 	iftamps10 ftgen 10, 0, ifft, -7, ifft, ifft, ifft                                       ; Flat
  
 	iftfrqs1 ftgen 51, 0, ifft, -7, imax_delay, ifft, 0							            ; Hi to Lo		
 	iftfrqs2 ftgen 52, 0, ifft, -7, 0, ifft, imax_delay							            ; Lo to hi
 	iftfrqs3 ftgen 53, 0, ifft, -21, 1, imax_delay								            ; Random
 	iftfrqs4 ftgen 54, 0, ifft, -16, 0, ifft * 0.25, -4, imax_delay, ifft * 0.75, 4, 0	    ; Peak 1
 	iftfrqs5 ftgen 55, 0, ifft, -16, 0, ifft * 0.125, -4, imax_delay, ifft * 0.75, 4, 0	    ; Peak 2
 	iftfrqs6 ftgen 56, 0, ifft, -16, 0, ifft * 0.0125, -4, imax_delay, ifft * 0.075, 4, 0   ; Peak 3
 	iftfrqs7 ftgen 57, 0, ifft, -19, 8, imax_delay * 0.5, 0, imax_delay * 0.5               ; Comb 1
 	iftfrqs8 ftgen 58, 0, ifft, -19, 16, imax_delay * 0.5, 0, imax_delay * 0.5              ; Comb 2
 	iftfrqs9 ftgen 59, 0, ifft, -7, imax_delay - (imax_delay * 0.1), ifft, imax_delay       ; Spring
 	iftfrqs10 ftgen 60, 0, ifft, -7, ifft, ifft, ifft                                       ; Flat

	foutL pvsinit ifft, ifft / 4, ifft, 1
	finL pvsanal aL, ifft, ifft / 4, ifft, 1
	ffbL pvsgain foutL, kfeedback
	fmixL pvsmix finL, ffbL
	ihL, ktimeL pvsbuffer fmixL, imax_delay
	foutL pvsbufread2 ktimeL, ihL, i(kamp_t), 50 + i(kfreq_t)
	awetL pvsynth foutL
	amixL ntrpol aL, awetL, kmix

	foutR pvsinit ifft, ifft / 4, ifft, 1
	finR pvsanal aR, ifft, ifft / 4, ifft, 1
	ffbR pvsgain foutR, kfeedback
	fmixR pvsmix finR, ffbR
	ihR, ktimeR pvsbuffer fmixR, imax_delay
	foutR pvsbufread2 ktimeR, ihR, i(kamp_t), 50 + i(kfreq_t)
	awetR pvsynth foutR
	amixR ntrpol aR, awetR, kmix
		outs amixL * klevel, amixR * klevel
	rireturn
endin


instr Reverb
    if gkrevsc_x == 0 goto SKIP

    	kporttime linseg 0, 0.001, 0.02
	kfblvl portk gkrevsc_fblvl, kporttime
	kfco portk gkrevsc_fco, kporttime

	ktrig changed gkrevsc_sr, gkrevsc_pv, gkrevsc_skip
	if ktrig == 1 then
		reinit UPDATE
	endif
	UPDATE:
			israte init i(gkrevsc_sr)
			ipitchm init i(gkrevsc_pv)
			iskip init i(gkrevsc_skip)
		aL, aR reverbsc garevL, garevR, kfblvl, kfco, israte, ipitchm, iskip
	rireturn
		outs aL, aR
	clear garevL, garevR

    SKIP:
endin

</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>