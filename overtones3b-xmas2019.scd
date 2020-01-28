s.boot;
s.meter;
s.options.memSize_(2.pow(20));
s.quit



(
SynthDef.new(\overtonez, {
	arg freq = 200, dev = 1.02, amp = 1.0, atk= 60.0, sus=240.0, rel = 60.0, waveSpeed = 0.001;
	var temp, sum, env;
	sum = 0;

	env = EnvGen.ar(Env.new([0,1,1,0],[atk, sus, rel]), doneAction: 2);

	10.do{
		arg i;
		temp = SinOsc.ar(freq * ((i+1)) * LFNoise1.kr({Rand(0.05, 0.2)}!2).range(dev.reciprocal, dev), 0 + i/20, 0.5 + 1.0*SinOsc.kr(waveSpeed));
		temp = temp * LFNoise1.kr({Rand(0.5, 0.8)}!2).exprange(0.01,1.0);
		sum = sum + temp
	};
		sum = sum * 0.05 * env;
		Out.ar(0, sum * amp);
}).add;

SynthDef(\bpfSawEQ, {
	arg freq=500, atk=3, sus=0, rel=3, c1=1, c2=(-1), cf=1500, rq=0.2, amp=1, out = ~reverbBus, detune = 0.2, cfmin=1800, cfmax=2000, cfhzmin=0.1, cfhzmax=0.3, rqmin=0.01, rqmax=0.2, pan=0, lsf=200, ldb=0, centerVal = 1000;
	var sig, env, verb;
	env = EnvGen.kr(Env([0,1,1,0],[atk, sus, rel],[c1, 0, c2]), doneAction: 2);
	sig  = Saw.ar(freq * LFNoise1.kr(0.5, detune).midiratio);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin, cfhzmax)
		).exprange(cfmin, cfmax)}!2,
		{LFNoise1.kr(0.4).exprange(rqmin, rqmax)}!2
	);

	sig = BPeakEQ.ar(sig, centerVal, 0.002, 12, 0.5);
	sig = BPeakEQ.ar(sig, centerVal-1000, 0.02, -12, 0.5);
	sig = BPeakEQ.ar(sig, centerVal+1000, 0.02, -12, 0.5);

	sig = BLowShelf.ar(sig, lsf, 0.5, ldb);
	//sig = Decay2.ar(sig, 0.5,0.6);

	//sig = DelayL.ar(sig, 1.0, 0.1);
	//sig = FreeVerb.ar(sig, 0.3, 0.99, 0.001);
	sig = Pan2.ar(sig, pan);
	sig = sig * env *amp;
	Out.ar(out, sig);

}).add;
)
~period_today = 15;
~current_tide = 0.1;

(


Routine.run({
~sevenLowBegin.play;
60.wait;
//Synth.new(\overtonez,[freq:400, amp: 0.05]);
	Synth.new(\overtonez,[freq:25, amp: 0.5, waveSpeed: ~period_today/1000]);
30.wait;
Synth.new(\overtonez,[freq:50, amp: 0.5, waveSpeed: ~period_today/1000]);
30.wait;
Synth.new(\overtonez,[freq:100, amp: 0.25, sus:60, waveSpeed: ~period_today/1000]);
	//360.wait;
	//Synth.new(\overtonez,[freq:1200, amp: 0.05]);
60.wait;
	Synth.new(\overtonez,[freq:600, amp: 0.05, sus:0, waveSpeed: ~period_today/500]);
	30.wait;
	//Synth.new(\overtonez,[freq:200]);=`
	30.wait;
	Synth.new(\overtonez,[freq:400, amp: 0.25, sus:0, waveSpeed: ~period_today/500]);
	30.wait;
	Synth.new(\overtonez,[freq:800, amp: 0.1, waveSpeed: ~period_today/500]);
	30.wait;
	Synth.new(\overtonez,[freq:300, amp: 0.4, waveSpeed: ~period_today/1000]);
	30.wait;
	Synth.new(\overtonez,[freq:150, amp:0.4, waveSpeed: ~period_today/1000]);
	30.wait;
	Synth.new(\overtonez,[freq:50, amp:0.7, waveSpeed: ~period_today/1000]);
	30.wait;
	Synth.new(\overtonez,[freq:800, amp:0.2, waveSpeed: ~period_today/1000]);
	30.wait;
	Synth.new(\overtonez,[freq:788, dev: 1.01 + ~current_tide, amp: 0.2, atk:exprand(5.0,20.0), sus:exprand(5.0,20.0), rel: exprand(5.0,20.0)]);
	Synth.new(\overtonez,[freq:800, dev: 1.01 + ~current_tide, amp: 0.2, atk:exprand(5.0,20.0), sus:exprand(5.0,20.0), rel: exprand(5.0,20.0)]);
	30.wait;



});



Synth.new(\overtonez,[freq:788/4, dev: (1.01 + ~current_tide), amp: 0.4, atk:exprand(5.0,20.0), sus:exprand(5.0,20.0), rel: exprand(5.0,20.0)]);
Synth.new(\overtonez,[freq:800/4, dev: (1.01 + ~current_tide), amp: 0.4, atk:exprand(5.0,20.0), sus:exprand(5.0,20.0), rel: exprand(5.0,20.0)]);










//
// ~sevenLow = Routine({
// 	var i=1;
// 	7.do{
// 		Pbind(
// 			\instrument, \bpfSawEQ,
// 			//\dur, Pseq([Pexprand(0.1, 4.0, 1), Pexprand(4.0, 8.0, 5)], inf),
// 			/*\dur, Pseq([1.0]++(0.5!12),inf),*/
// 			\dur, Pexprand(1.0, 10.0),
// 			//			\freq, Pexprand(50*2,50, 120),
// 			\freq,Pseq([[25,50,100,200,400, 800].choose!2,[25,62/2, 50, 62, 100, 62*2,200,62*4,400,62*8, 800,62*16].choose], inf),
// 			/*\freq,Pseq([[25,50,100,200,400, 800].choose], inf),*/
// 			\detune, 0.1,
// 			\centerVal, Pexprand(8000,10000, inf),
// 			\atk, Pexprand(3.0,1.0, inf),
// 			\rel, Pexprand(3.0,1.0, inf),
// 			//\cfmin, Pexprand(40000, 80000, inf),
// 			\cfmin, Pseq([([25, 100, 200, 400].choose), 50],inf),
// 			\cfmax, Pkey(\cfmin) * Pwhite(1.0001,1.2, inf),
// 			\amp, Pexprand(0.5,0.8) * 20,
// 			\rqmin, 0.0002,
// 			\rqmax, 0.0005,
// 			\pan, Pexprand(-1.0,1.0),
// 			\out, 0
//
// 		).play;
// 		i=i*1.618;
// 		i.postln;
// 		(rrand(0.1,0.5)).wait;
// 	}
// });


~sevenLowBegin = Routine({
var i=1;
	7.do{
		Pbind(
			\instrument, \bpfSawEQ,
			//\dur, Pseq([Pexprand(0.1, 4.0, 1), Pexprand(4.0, 8.0, 5)], inf),
			\dur, Pseq([1.0]++(0.5!12),inf),
			//\dur, Pexprand(3.0, 10.0),
//			\freq, Pexprand(50*2,50, 120),
			\freq,Pseq([[25,50,100,200,400, 800].choose!2,[25,62/2, 50, 62, 100, 62*2,200,62*4,400,62*8, 800,62*16].choose], inf),
			/*\freq,Pseq([[25,50,100,200,400, 800].choose], inf),*/
			\detune, 0.1,
			\centerVal, Pexprand(8000,10000, inf),
			\atk, Pexprand(3.0,1.0, inf),
			\rel, Pexprand(3.0,1.0, inf),
			//\cfmin, Pexprand(40000, 80000, inf),
			\cfmin, Pseq([([25, 100, 200, 400].choose), 50],inf),
			\cfmax, Pkey(\cfmin) * Pwhite(1.0001,1.2, inf),
			\amp, Pexprand(0.5,0.8) * 10,
			\rqmin, 0.0002,
			\rqmax, 0.0005,
			\pan, Pexprand(-1.0,1.0),
			\out, 0

		).play;
		i=i*1.618;
		i.postln;
		(rrand(0.1,0.5)).wait;
	}
});


)

//x.set(\freq, 100);


// (
// Routine.run({
//
//
// 	10.do{arg i;
// 		Synth.new(\overtonez,[freq:100*(i+1), amp:0.25, atk:3.0, sus:0, rel:3.0*i]);
//
// 		0.1.wait;
// 	}
// })
// )

