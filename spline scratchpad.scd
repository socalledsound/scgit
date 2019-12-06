(
SynthDef(\bpfSinDeTune2, {
	arg freq=500, atk=3, sus=0, rel=3, c1=1, c2=(-1), cf=1500, rq=0.2, amp=1, out = 0, detune = 0.2, cfmin=1800, cfmax=2000, rqmin=0.01, rqmax=0.2, pan=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk, sus, rel],[c1, 0, c2]), doneAction: 2);
	sig  = SinOsc.ar(freq * LFNoise1.kr(0.5, detune).midiratio);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(0.2).exprange(cfmin, cfmax)}!2,
			{LFNoise1.kr(0.4).exprange(rqmin, rqmax)}!2
	);
	sig = Pan2.ar(sig, pan);
	sig = sig * env *amp;
	Out.ar(out, sig);

}).add;
)







(
	10..20.do{
	var freq = [50,62,75].choose;
		Synth(
			\bpfSinDeTune2,
			[
				\freq, freq*8/2,
				\amp, 0.05,
				\atk, exprand(1.0, 2.0),
				\rel, exprand(10.0, 20.0),
				\cfmin, freq*2,
			    \cfmax, freq*10,
				\rqmin, 0.01,
		        \rqmax, 0.1,
				\detune, exprand(0.01, 0.1),
			    \pan, rrand(-1.0, 1.0);
			]
		);
	};
)


(
	10..20.do{
	var freq = [50,58,72].choose;
		Synth(
			\bpfSinDeTune2,
			[
				\freq, freq*8,
				\amp, 0.05,
				\atk, exprand(1.0, 2.0),
				\rel, exprand(10.0, 20.0),
				\cfmin, freq*2,
			    \cfmax, freq*10,
				\rqmin, 0.01,
		        \rqmax, 0.1,
				\detune, exprand(0.01, 0.1),
			    \pan, rrand(-1.0, 1.0);
			]
		);
	};
)


