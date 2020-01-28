s.boot;
s.meter;
s.options.memSize_(2.pow(20));


s.waitForBoot{(
SynthDef.new(\overtonez, {
	arg freq = 200, dev = 1.02, amp = 1.0, atk= 60.0, sus=240.0, rel = 60.0;
	var temp, sum, env;
	sum = 0;

	env = EnvGen.ar(Env.new([0,1,1,0],[atk, sus, rel]), doneAction: 2);

	10.do{
		arg i;
		temp = SinOsc.ar(freq * ((i+1)) * LFNoise1.kr({Rand(0.05, 0.2)}!2).range(dev.reciprocal, dev), 0 + i/20,1.0);
		temp = temp * LFNoise1.kr({Rand(0.5, 0.8)}!2).exprange(0.01,1.0);
		sum = sum + temp
	};
		sum = sum * 0.05 * env;
		Out.ar(0, sum * amp);
}).add;


)

(
Routine.run({


10.do{arg i;
		Synth.new(\overtonez,[freq:10*(i*i+1), amp:0.25, atk:3.0, sus:0, rel:3.0*i]);

		1.wait;
	}
})
)
(

Routine.run({
~sevenLow2.play;
//60.wait;
//Synth.new(\overtonez,[freq:400, amp: 0.05]);
	Synth.new(\overtonez,[freq:25, amp: 0.5]);
//30.wait;
Synth.new(\overtonez,[freq:50, amp: 0.5]);
30.wait;
Synth.new(\overtonez,[freq:100, amp: 0.5, sus:0]);
	//360.wait;
	//Synth.new(\overtonez,[freq:1200, amp: 0.05]);
30.wait;
	Synth.new(\overtonez,[freq:600]);
	30.wait;
	//Synth.new(\overtonez,[freq:200]);
	30.wait;
	Synth.new(\overtonez,[freq:400]);
	30.wait;
	Synth.new(\overtonez,[freq:800]);
	30.wait;
	Synth.new(\overtonez,[freq:300]);
	30.wait;
	Synth.new(\overtonez,[freq:150]);
	30.wait;
	Synth.new(\overtonez,[freq:50]);
	30.wait;
	Synth.new(\overtonez,[freq:800]);
	30.wait;
	Synth.new(\overtonez,[freq:300]);
	30.wait;
	Synth.new(\overtonez,[freq:150]);
	30.wait;



});






)};







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


~sevenLow2 = Routine({
var i=1;
	7.do{
		Pbind(
			\instrument, \bpfSawEQ,
			//\dur, Pseq([Pexprand(0.1, 4.0, 1), Pexprand(4.0, 8.0, 5)], inf),
			/*\dur, Pseq([1.0]++(0.5!12),inf),*/
			\dur, Pexprand(3.0, 10.0),
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
			\amp, Pexprand(0.5,0.8) * 20,
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