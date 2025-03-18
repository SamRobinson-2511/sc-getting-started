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



