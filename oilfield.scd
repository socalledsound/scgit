
p.push;
(
        ~oilfield = Server.local.boot;
)

(
        ~ma = Group.tail(~oilfield);
)

(
        ~root = 27.5 * (2 ** (5 / 12));
)

----------

(
SynthDef("song2ma", {arg freq, cov, den;
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
}).load(~oilfield);
)

-----

// ( // ma.bass
var freq, cov, den;
freq = ~root;
cov = 25;
den = 45;
~oilfield.sendMsg("/s_new", "song2ma", 3241, 1, ~ma.nodeID, "freq", freq, "cov", cov, "den", den / 4);
~oilfield.sendMsg("/s_new", "song2ma", 3242, 1, ~ma.nodeID, "freq", freq * 10 / 8, "cov", cov, "den", den / 4);
~oilfield.sendMsg("/s_new", "song2ma", 3243, 1, ~ma.nodeID, "freq", freq * 2 *11 / 8, "cov", cov, "den", den / 4);
~oilfield.sendMsg("/s_new", "song2ma", 3244, 1, ~ma.nodeID, "freq", freq * 2 * 12 / 8, "cov", cov, "den", den / 4);
)

(
~oilfield.sendMsg("/n_free", 3241);
~oilfield.sendMsg("/n_free", 3242);
~oilfield.sendMsg("/n_free", 3243);
~oilfield.sendMsg("/n_free", 3244);
)

-----

( // ma.sho
var freq, cov, den;
freq = ~root;
cov = 50;
den = 5;
~oilfield.sendMsg("/s_new", "song2ma", 3245, 1, ~ma.nodeID, "freq", freq * 8, "cov", cov, "den", den / 4);
~oilfield.sendMsg("/s_new", "song2ma", 3246, 1, ~ma.nodeID, "freq", freq * 4 * 10 / 8, "cov", cov, "den", den / 4);
~oilfield.sendMsg("/s_new", "song2ma", 3247, 1, ~ma.nodeID, "freq", freq * 16 * 11 / 8, "cov", cov, "den", den / 4);
~oilfield.sendMsg("/s_new", "song2ma", 3248, 1, ~ma.nodeID, "freq", freq * 8 * 12 / 8, "cov", cov, "den", den / 4);
)

(
~oilfield.sendMsg("/n_free", 3245);
~oilfield.sendMsg("/n_free", 3246);
~oilfield.sendMsg("/n_free", 3247);
~oilfield.sendMsg("/n_free", 3248);
)

--------

(
~ma.free;
)

(
~oilfield.quit;
)
