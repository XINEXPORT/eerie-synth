(
SynthDef("eerie", {arg out = 0, freq=300, pan = 0, rate=5, amp=0.2, gate=1;
	var acco, snd;
	acco = Env.adsr(
		attackTime:0.2,
		decayTime:0.8,
		sustainLevel:0.3,
		releaseTime:0.5,
		peakLevel:2,
		curve:-4.0,
		bias:0).kr(gate: gate, doneAction:2);
	snd = BRF.ar(
		in: SinOscFB.ar(freq: [freq,100]));
	snd = snd*acco;
	snd = Mix.ar(snd);
	snd = BPF.ar(
		in: SinOscFB.ar(freq: freq));
	Out.ar([0,1],Pan2.ar (snd, pan, amp));
}).add;
)

(
Synth(\eerie);
)

(
{a = Pbind(
	TempoClock (60/60);
	\scale, Scale.harmonicMajor,
	\instrument, \eerie,
	\degree, Pwhite(0, 30.5,inf),
	\dur, 0.3,
	\mul, 2,
	\amp, 0.2,
	// \legato, 1,
	// \ctranspose, 0.8
).trace.play;
8.wait;

b =
Pbind(
	TempoClock (60/60);
	\scale, Scale.harmonicMajor,
	\instrument, \eerie,
	\degree, Prand([0,-1,-2,-3,-4,-5,-6,-7],inf),
	\dur, Pseq([0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7], inf),
	\mul, 2,
	\amp, 0.4,
	\legato, 0.8,
	\ctranspose, 0.3
).trace.play;
8.wait;

c =
Pbind(
	TempoClock (60/60);
	\scale, Scale.harmonicMajor,
	\instrument, \eerie,
	\degree, Pwhite (-10, 0,inf),
	\dur, 2 ,
	\mul, 1,
	\amp, 0.4,
	\legato, 0.5,
	\ctranspose, 0.1
).play;
}.fork;
)

a.stop;
b.stop;
c.stop;

{SinOsc.ar ([100,200,300])}.scope.play;














