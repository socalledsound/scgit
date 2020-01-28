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



Routine.run({
//~sevenLow2.play;
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





