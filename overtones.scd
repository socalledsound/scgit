(
SynthDef.new(\overtonez, {
	arg freq = 200, dev = 1.02;
	var temp, sum, env, atk= 60.0, sus=240.0, rel = 60.0;
	sum = 0;

	env = EnvGen.ar(Env.new([0,1,1,0],[atk, sus, rel]), doneAction: 2);

	10.do{
		arg i;
		temp = SinOsc.ar(freq * ((i+1)) * LFNoise1.kr({Rand(0.05, 0.2)}!2).range(dev.reciprocal, dev), 0 + i/20,1.0);
		temp = temp * LFNoise1.kr({Rand(0.5, 0.8)}!2).exprange(0.01,1.0);
		sum = sum + temp
	};
		sum = sum * 0.05 * env;
		Out.ar(0, sum);
}).add;


)


Synth.new(\overtonez,[freq:320]);


(

Routine.run({

Synth.new(\overtonez,[freq:100]);
30.wait;
Synth.new(\overtonez,[freq:600]);
30.wait;
Synth.new(\overtonez,[freq:200]);
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

)

//x.set(\freq, 100);