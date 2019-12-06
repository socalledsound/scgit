(
SynthDef("thanks-synth1", {arg freq, cov, den;
        var vol, phase, here, there, lifecyclel, lifecycler, trigl, trigr, hzl, hzr, osc1, osc2;
        hzl =  [8,20,11,24,16] * freq / 8;
        hzr =  [8,10,22,12,32] * freq / 8;
        phase = (2.5 - (cov / 100)) * pi;
        vol = 1 / (1 - phase.sin);
        lifecyclel = ((den / 100) / 5) * SinOsc.kr(27.5 / hzl, phase, vol, 0 - (vol * phase.sin));
        lifecycler = ((den / 100) / 5) * SinOsc.kr(36.7 / hzr, phase, vol, 0 - (vol * phase.sin));
        trigl = lifecyclel > 0;
        trigr = lifecycler > 0;
        here = [0, 0.3pi, 0.6pi, 0.9pi, 1.2pi];
        there = [0.2pi, 0.5pi, 0.8pi, 1.1pi, 1.4pi];
        osc1 = SinOsc.ar(hzl, here, trigl * lifecyclel).sum;
        osc2 = SinOsc.ar(hzr, there, trigr * lifecycler).sum;
        Out.ar(0,[osc1,osc2]);
}).add;
)



Synth("thanks-synth1", "freq", 27.5 * (2 ** (5 / 12))*3;, "cov", 25, "den", 10);


SynthDef("test-osc", {
	var sig;
	sig = SinOsc.ar(400, [0, 0.3pi, 1.2pi], 0.25).sum;
	Out.ar(0, sig)

}).add;

Synth("test-osc");

{SinOsc.ar([25, 50, 100, 200,400,600,800,1200,2400,3600,7200,14400], [0,0.3pi, 1.2pi], ((20 / 100) / 5) * SinOsc.kr(0.5 / 60, 2pi, 0.1, 0 - (0.5 * 120.sin))).sum}.play


{SinOsc.ar([25, 50, 100], [0,0.3pi, 1.2pi], ((20 / 100) / 5) * SinOsc.kr(20/ 60, 2pi, 0.1, 0 - (0.5 * 120.sin))).sum}.play