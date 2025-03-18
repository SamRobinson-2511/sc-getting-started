{PinkNoise.ar(0.2)  + SinOsc.ar(440, 0, 0.2) + Saw.ar(660, 0.2)}.plot;
{PinkNoise.ar(0.2)  + SinOsc.ar(440, 0, 0.2) + Saw.ar(660, 0.2)}.plot(1);

{PinkNoise.ar(0.2)  + SinOsc.ar(440, 0, 0.2) + Saw.ar(660, 0.2)}.scope;

//Multi-channel scope
{[SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)]}.scope;
{[SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)]}.scope(zoom: 10);

//Scope server
{[SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)]}.play;
s.scope;