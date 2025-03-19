//Making a Buffer Object and Allocating Memory
s.boot;
b = Buffer.alloc(s, 100, 2);
b.free;

//allocate in terms of seconds
b = Buffer.alloc(s, s.sampleRate * 8.0, 2);
b.free;

//using Buffers with Sound Files

//read a soundfile
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");
(
x = SynthDef("tutorial-PlayBuf", {
	|out=0, bufnum|
	Out.ar(out,
		PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum))
	)
}).play(s,[\bufnum, b]);
)
x.free; b.free;


//Streaming a File in From Disk
(
SynthDef("tutorial-Buffer-cue", {
	|out=0, bufnum|
	Out.ar(out,
		DiskIn.ar(1, bufnum)
	)
}).add;
)

b = Buffer.cueSoundFile(s, Platform.resourceDir +/+ "sounds/a11wlk01-44_1.aiff", 0, 1);
y = Synth("tutorial-Buffer-cue", [\bufnum, b], s);
b.free; y.free;



//More on Instance Variables and Action Functions
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");
b.bufnum;
b.numFrames;
b.numChannels;
b.sampleRate;
b.free;

//action functions as arguments
(
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav", action: {
	|buffer|
	("numFrames after update:" + buffer.numFrames).postln;
	x = { PlayBuf.ar(1, buffer, BufRateScale.kr(buffer))}.play;
});

("numFrames before update:" + b.numFrames).postln;
)
x.free; b.free;


// Recording into Buffers

b = Buffer.alloc(s, s.sampleRate * 5, 1); //5 second / 1 channel buffer

//record 4 seconds
(
x = SynthDef("tutorial-RecordBuf", {
	|out=0, bufnum=0|
	var noise;
	noise = PinkNoise.ar(0.3);
	RecordBuf.ar(noise, bufnum);
}).play(s,[\out, 0, \bufnum, b]);
)
x.free;

//playback
(
SynthDef("tutorial-playback", {
	|out=0, bufnum=0|
	var playbuf;
	playbuf = PlayBuf.ar(1, bufnum);
	FreeSelfWhenDone.kr(playbuf);
	Out.ar(out, playbuf);
}).play(s, [\out, 0, \bufnum, b]);
)
b.free;

//Accessing Data
b = Buffer.alloc(s, 8, 1);
b.set(7, 0.5); //set the value at 7 to 0.5
b.get(7, {|msg| msg.postln});
b.free;

//methods getn and setn get and set adjacent values
b = Buffer.alloc(s, 16);
b.setn(0, [1, 2, 3]); //set the first 3 values
b.getn(0, 3, {|msg| msg.postln}); //get them
b.setn(0, Array.fill(b.numFrames, {1.0.rand})); //fill the buffer with random values
b.getn(0, b.numFrames, {|msg| msg.postln}); //get them


(
//make some white noise
v = FloatArray.fill(44100, {1.0.rand2});
b = Buffer.alloc(s, 44100);
)
(
b.loadCollection(v, //load the FloatArray into b, then play it
	action: {
		|buf|
		x = { PlayBuf.ar(buf.numChannels, buf, BufRateScale.kr(buf), loop: 1)
		* 0.2
		}.play;
})
)
x.free;

b.loadToFloatArray(0, -1, {|floatArray| (floatArray == v).postln});
b.free;

//Plotting and Playing

//see the waveform
b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");
b.plot;
b.play; //frees itself
x = b.play(true);  //loops so doesn't free
x.free; b.free;

//Other Uses for Buffers
b = Buffer.alloc(s, 512, 1);
b.cheby([1,0,1,1,0,1]);
(
x = play({
	Shaper.ar(
		b,
		SinOsc.ar(300, 0, Line.kr(0, 1, 6)),
		0.5
	)
});
)
x.free; b.free;