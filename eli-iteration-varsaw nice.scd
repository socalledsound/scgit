(
SynthDef.new(\thing, {
	arg freq = 40;
	var temp, sum, env;
	sum = 0;
	env = EnvGen.kr(Env.perc(0.01, 5, 1, -2), doneAction:2);
	10.do{
		temp = VarSaw.ar(freq * Rand(0.99,1.02)!2, Rand(0.0,1.0)!2, {ExpRand(0.005,0.05)}!2);
		sum = sum + temp;
	};
	sum = sum * 0.05 * env;
//	sum = BLowShelf.ar(sum, 100, 1,-24);
	Out.ar(0, sum);
}).add;
)



x.set(\freq, 45);

(
Routine.run({

	100.do{
		arg x, i;
		Synth.new(\thing, [freq: 200 + (i/100)]);
	0.1.wait;
	}

})

)
	