(
SynthDef.new(\thing, {
	arg out, mod= 3, trigVal = 2;
	var freq, trig, sig;
	freq = LFNoise0.kr(mod).exprange(300,1200).round(300);
	sig = SinOsc.ar(freq)*0.25;
	trig = Dust.kr(trigVal);
	sig = sig * EnvGen.kr(Env.perc(0.01,0.2), trig);
	sig = Pan2.ar(sig, LFNoise1.kr(10));
	Out.ar(out, sig);
}).add;

SynthDef.new(\reverb, {
	arg in, out = 0;
	var sig;
	sig = In.ar(in, 2);
	sig = FreeVerb.ar(sig, 0.7,0.8,0.2);
	Out.ar(out, sig);
}).add;
)


Synth(\thing).play;


y = Synth.new(\reverb, [\in, ~reverb_bus], s, \addToTail);
x = Synth.new(\thing, [\out, ~reverb_bus], s);
x.set(\mod, 100, \trigVal, 2);
x.free;
y.free;


//groups

~src_grp = Group.new;
~fx_grp = Group.after(~src_grp);

y = Synth.new(\reverb, [\in, ~reverb_bus], ~fx_grp);
x = Synth.new(\thing, [\out, ~reverb_bus], ~src_grp);




s.freeAll;

~reverb_bus = Bus.audio(s, 2);
~reverb_bus.index;


s.meter