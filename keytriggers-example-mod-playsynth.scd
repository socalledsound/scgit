(
SynthDef(\sinTest, {
	arg freq;
	var sig;
	sig = SinOsc.ar(freq, 0, 1);
	Out.ar(0, sig);
}).add;
)

(
a=Synth(\sinTest);


w = Window.new("play", Rect(0, 0, 70, 70));

w.view.keyDownAction_({ arg view, char;

    if(char == $a, {
        a.play;
    });

    if(char == $z, {
        a.stop;
    });

});

w.front;

)