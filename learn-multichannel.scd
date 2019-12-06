
SynthDef.new(\multi, {
	var sig, amp, freq, env;

	//	amp = SinOsc.kr(7).ran{ge(0,1);

	env = Env

	freq = 120;
	amp = SinOsc.kr([7,14]).range(0,1);
	sig = SinOsc.ar([freq, freq*2, freq*4*0.6, freq*8*0.3, freq*16*0.15]);
	sig*amp;
	sig = Splay.ar(sig)*0.5;
	Out.ar(0, sig) ;
}).add;

x = Synth.new(\multi);


//SynthDe

