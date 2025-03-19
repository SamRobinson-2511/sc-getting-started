In.ar(0,1); //this will return 'an OutputProxy'
In.ar(0, 4); //this will return an Array of 4 OutputProxies

{|out| Out.ar(out, SinOsc.kr)}.play; //error
{|out| Out.kr(out, SinOsc.ar)}.scope; //audio rate signal downsampled to control rate

(
SynthDef("tutorial-args", {
	|freq = 440, out = 0|
	Out.ar(out, SinOsc.ar(freq, 0, 0.2))
}).add;
)

//both write to bus 1 and their output is mixed
x = Synth("tutorial-args", ["out", 1, "freq", 660]);
y = Synth("tutorial-args", ["out", 1, "freq", 770]);
x.free; y.free;

//Creating a Bus object
b = Bus.control(s, 2);
c = Bus.audio(s);

s.reboot;
b = Bus.control(s, 2);
b.index;
b.numChannels;
c = Bus.control(s);
c.numChannels;
c.index;
b.free;

//Busses in Action
(
SynthDef("tutorial-Infreq", {
	|bus, freqOffset = 0, out|
	Out.ar(out, SinOsc.ar(In.kr(bus) + freqOffset, 0, 0.5))
}).add;

SynthDef("tutorial-Outfreq", {
	|freq=400, bus|
	Out.kr(bus, SinOsc.ar(1, 0, freq/40, freq))
}).add;

b = Bus.control(s, 1);
)
(
x = Synth("tutorial-Outfreq", [\bus, b]);
y = Synth.after(x, "tutorial-Infreq", [\bus, b]);
z = Synth.after(x, "tutorial-Infreq", [\bus, b, \freqOffset, 200]);
)
x.free; y.free; z.free; b.free;


(
SynthDef("tutorial-DecayPink", {
	|outBus=0, effectBus, direct=0.5|
	var source;
	source = Decay2.ar(Impulse.ar(1, 0.25), 0.01, 0.2, PinkNoise.ar);
	Out.ar(outBus, source * direct);
	Out.ar(effectBus, source * (1 - direct));
}).add;


SynthDef("tutorial-DecaySin", {
	|outBus = 0, effectBus, direct = 0.5|
	var source;
	source = Decay2.ar(Impulse.ar(0.3, 0.25), 0.3, 1, SinOsc.ar(SinOsc.kr(0.2, 0, 110, 440)));
	Out.ar(outBus, source * direct);
	Out.ar(effectBus, source * (1-direct));
}).add;

SynthDef("tutorial-Reverb", {
	|outBus = 0, inBus|
	var input;
	input = In.ar(inBus, 1);
	16.do({ input = AllpassC.ar(input, 0.04, {Rand(0.001, 0.04)}.dup, 3)});
	Out.ar(outBus, input);

}).add;

b = Bus.audio(s, 1);
)

(
x = Synth("tutorial-Reverb", [\inBus, b]);
y = Synth.before(x, "tutorial-DecayPink", [\effectBus, b]);
z = Synth.before(x, "tutorial-DecaySin", [\effectBus, b, \outBus, 1]);
)

y.set(\direct, 1);
z.set(\direct, 1);
y.set(\direct, 0);
z.set(\direct, 0);
x.free; y.free; z.free; b.free;


//More fun with control busses
(
b = Bus.control(s, 1); b.set(880);
c = Bus.control(s, 1); c.set(884);
x = SynthDef("tutorial-map", {
	|freq1 = 440, freq2 = 440, out|
	Out.ar(out, SinOsc.ar([freq1, freq2], 0, 0.1));
}).play(s);
)
x.map(\freq1, b, \freq2, c);
y = {Out.kr(b, SinOsc.kr(1, 0, 50, 880))}.play(addAction: \addToHead);
y.free;
b.get({|val| val.postln; f = val;});
x.set(\freq2, f / 2);
c.set(200);
x.free; b.free; c.free;

b = Bus.control(s, 1); b.set(880);
(
f = nil;
b.get({|val| f = val;});
f.postln;
)
f.postln;

x = Synth("default", [\freq, 300]);
y = Synth("default", [\freq, 450], x, \addAfter);
x.free; y.free;


//these two lines of code are equivalent
y = Synth.new("default", [\freq, 450], x, \addAfter);
y = Synth.after(x, "default", [\freq, 450]);






