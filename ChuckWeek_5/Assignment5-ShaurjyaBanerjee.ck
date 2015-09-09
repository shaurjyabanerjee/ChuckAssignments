//          Shaurjya Banerjee - Assignment 5
//
//      $$\      $$\$$$$$$$$\$$$$$$\$$$$$$\ $$$$$$$\         
//      $$$\    $$$ \__$$  __\_$$  _\_$$  _|$$  __$$\        
//      $$$$\  $$$$ |  $$ |    $$ |   $$ |  $$ |  $$ |       
//      $$\$$\$$ $$ |  $$ |    $$ |   $$ |  $$ |  $$ |       
//      $$ \$$$  $$ |  $$ |    $$ |   $$ |  $$ |  $$ |       
//      $$ |\$  /$$ |  $$ |    $$ |   $$ |  $$ |  $$ |       
//      $$ | \_/ $$ |  $$ |  $$$$$$\$$$$$$\ $$$$$$$  |       
//      \__|     \__|  \__|  \______\______|\_______/        
//   $$\   $$\       $$\      $$$$$$\ $$$$$$$$\ $$$$$$$$\ 
//   $$ |  $$ |      $$ |     \_$$  _|$$  _____|$$  _____|
//   $$ |  $$ |      $$ |       $$ |  $$ |      $$ |      
//   $$$$$$$$ |      $$ |       $$ |  $$$$$\    $$$$$\    
//   \_____$$ |      $$ |       $$ |  $$  __|   $$  __|   
//         $$ |      $$ |       $$ |  $$ |      $$ |      
//         $$ |      $$$$$$$$\$$$$$$\ $$ |      $$$$$$$$\ 
//         \__|      \________\______|\__|      \________|
//
// I'm not sure what to call this
// 10/16/2014

//Chord oscillators
TriOsc chord[5];

//Sequencer sound network
Gain master => dac;
SndBuf kik => master;
SndBuf kik2 => master;
SndBuf snr => master;
SndBuf snr2 => master;
SndBuf hat => master;
SndBuf hat2 => master;
SndBuf fx1 => NRev r => master;
SndBuf fx2 => master;
SqrOsc kAtk => master;

//Sound Network for FM synth
SinOsc mod1 => SinOsc car1 => Gain synthBus;
SinOsc mod2 => SinOsc car2 => synthBus;
synthBus => LPF filtFm => ADSR envFm  => Gain synth => master;
ADSR filtEnv => filtFm;
TriOsc fakeFm => synth => master;
0.056 => synth.gain;

//Mandolin
Mandolin m => Gain mandy => master;
0.3 => mandy.gain;

<<< "Hello, I'm printing my name for some reason : Shaurjya Banerjee" >>>;

//Setting ADSR at one time with an array
(0.01::second, 0.4::second, 0.7, 0.8::second) => envFm.set;
(0.06::second, 0.01::second, 0.6, 0.2::second) => filtEnv.set;

//Tempo Declaration network
170 => float BPM;

//Initializing & defining half, quarter, eighth, etc.. notes etc in terms of the BPM
240 / BPM => float whole;
120 / BPM => float half;
(half/2) => float qrtr;
(qrtr/2) => float eight;
(eight*0.6667) => float eightT;
(eight/2) => float sxtn;
(sxtn*0.6667) => float sxtnT;
(sxtn/2) => float thirtytwo;
(thirtytwo * 0.6667) => float thirtytwoT;
(thirtytwo/2) => float sixtyfour;
(sixtyfour*0.6667) => float sixtyfourT;
(sixtyfour/2) => float onetwentyeight;

(sxtn/16) => float masterClock;

//Load samples
me.dir() + "/audio/kick_03.wav" => kik.read;
me.dir() + "/audio/kick_04.wav" => kik2.read;
me.dir() + "/audio/snare_01.wav" => snr.read;
me.dir() + "/audio/hihat_02.wav" => hat.read;
me.dir() + "/audio/hihat_01.wav" => hat2.read;
me.dir() + "/audio/stereo_fx_01.wav" => fx1.read;

//The DJ ShoJoeB Drums & Bass ChucK sequencer library
//!!! With FIVE carefully programmed DnB drum Sequences !!!!

//All sequences are written for 16 step sequencers
//1 = Note ON & 0 = Note OFF

//Sequence 1 in arrays for each kit piece
[ 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0 ] @=> int chakaP1[];
[ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] @=> int snrP1[];
[ 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0 ] @=> int hatP1[];
[ 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0 ] @=> int kikP1[];

//Sequence 2 in arrays for each kit piece
[ 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0 ] @=> int chakaP2[];
[ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ] @=> int snrP2[];
[ 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0 ] @=> int hatP2[];
[ 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0 ] @=> int kikP2[];

//Sequence 3 in arrays for each kit piece
[ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ] @=> int chakaP3[];
[ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ] @=> int snrP3[];
[ 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0 ] @=> int hatP3[];
[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ] @=> int kikP3[];

//Sequence 4 in arrays for each kit piece (this is a fill)
[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] @=> int chakaP4[];
[ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ] @=> int snrP4[];
[ 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1 ] @=> int hatP4[];
[ 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] @=> int kikP4[];

//Sequece 5 in arrays for each kit piece
[ 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0 ] @=> int chakaP5[];
[ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ] @=> int snrP5[];
[ 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0 ] @=> int hatP5[];
[ 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0 ] @=> int kikP5[];

7 => int melodyOct;

[ namToNum("Bb", melodyOct), namToNum("Db", melodyOct), namToNum("Eb", melodyOct), namToNum("E", melodyOct), namToNum("F", melodyOct),namToNum("Ab", melodyOct),namToNum("Bb", melodyOct)] @=> int scale[];

//Defining my chord sequence
[ namToNum("B",3), namToNum("B",3), namToNum("D",3), namToNum("G",3), namToNum("Bb",3), namToNum("Eb",3), namToNum("A",3), namToNum("D",3), namToNum("G",3), namToNum("Bb",3), namToNum("Eb",3), namToNum("F#",3), namToNum("B",3), namToNum("F",3), namToNum("Bb",3), namToNum("Eb",3), namToNum("A",3) ] @=> int chordRoot[];
[ "major7th"     , "major7th"     , "dominant7th"  , "major7th"     , "dominant7th"   , "major7th"      ,"minor7th"      , "dominant7th"  , "major7th"     , "dominant7th"   , "major7th"      , "dominant7th"   , "major7th"     , "minor7th"     , "dominant7th"   , "major7th"      , "minor7th"      ] @=> string quality[];
[ 0              , 1              , 2              , 3              , 4               , 5              , 6              , 7              , 8               , 9               , 10              , 11             , 12             , 13              , 14              , 15              , 16            ] @=> int count[];


//Set plaheads to end of samples
kik.samples() => kik.pos;
kik2.samples() => kik2.pos;
snr.samples() => snr.pos;
snr2.samples() => snr2.pos;
hat.samples() => hat.pos;
hat2.samples() => hat2.pos;
fx1.samples() => fx1.pos;
fx2.samples() => fx2.pos;

//Define the number of steps in the sequencer
16 => int seqStep;
0 => int seqCount;
0 => int chordCount;

//Initialize variable melt, which generally melts things
2.0 => float melt;
4 => int sinewarp;

//Define the number of repeats
16 => int rpt;
0 => kAtk.gain;
//Define two integers
int jump;
int which;
int melodyMaker;
float filterSweep;

//Step through and set the gain etc of the chord oscillators within little for loop
for (0 => int i; i< chord.cap(); i++)
{
    chord[i] => master;
    0.8/chord.cap() => chord[i].gain;
    
}

for (0 => int j; j<10; j++)
{
    for (0 => int i; i<seqStep*16; i++)
    {
        if(jump == 0)
        {   //This random number drives the which argument of the seq function
            Math.random2(0,3) => which;
        }
        
        //i%16 scales our master clock to 16th note steps
        if (i%16 == 0)
        {
            if (seqCount%8 == 1)
            {
                chord5(chordRoot[chordCount], 0, quality[chordCount]);
                chordCount++;
            }
            
            seq (which, seqCount);
            seqCount++;
            seqCount%4 => jump; 
            
            Math.random2(0,scale.cap()-1) => melodyMaker;
            fm4 ( scale[melodyMaker], 1, Std.fabs(filterSweep)*10000); 
            1 => envFm.keyOn;
            1 => filtEnv.keyOn;
            
            0.6 => m.pluckPos;
            1.0 => m.noteOn; //Plucks string
            0.09 => m.stringDetune; //Detune between strings
            Std.mtof(scale[melodyMaker]) => m.freq; 
            0.25 => m.bodySize;
            
            //Limits the value of the variable which steps through the chord array
            if (chordCount > 15)
            {
                0 => chordCount;
            }
            Math.sin (now/1::second*1000*pi) => filterSweep;
            <<<seqCount, jump, which, seqCount%8, chordCount, filterSweep >>>;
        }
        
        
        //This for loop runs at 16 times the "sequencer rate"
        masterClock::second => now;
        
    }
    0 => seqCount; 
}







//LOOK AT ALL MY FUNCTIONS!!!!

// 4 Operator FM synthesis function
// Operator Architechture -
// Modulator1 => Carrier 1 
// Modulator2 => Carrier 2

// Arguments accepted - 
// 1. int note
// 2. float modDepth (goes from 0 to 1)
// 3. float LPFCutoff (in Hz)
//
fun void fm4 (int note, float modDepth, float LpfCutoff)
{
    
    0.6 => car1.gain;
    2 => car1.sync; //set sync mode to FM (2)
    
    0.6 => car2.gain;
    2 => car2.sync; //set sync mode to FM (2)
    
    modDepth * 10000 => mod1.gain; //set modulation depth of FM 
    modDepth * 10000 => mod2.gain; //set modulation depth of FM 
    
    LpfCutoff => filtFm.freq;
    
    Std.mtof(note+7)* 0.43274 => mod1.freq;
    Std.mtof(note+7) => car1.freq;
    
    Std.mtof(note)* 0.126374 => mod2.freq;
    Std.mtof(note) => car2.freq;
    
    Std.mtof(note/1.5) => fakeFm.freq;  
    0.4 => fakeFm.gain;
    
    //Series of if statements that control the volume of the Triangle Oscillator
    if (note <= 49)
    {0.7 => fakeFm.gain;
}

if (note >= 50 && note <= 59)
{0.6 => fakeFm.gain;
}

if (note >= 60 && note <= 69)
{0.4 => fakeFm.gain;
}

if (note >= 70 && note <= 79)
{0.3 => fakeFm.gain;
}

if (note >= 80 && note <= 89)
{0.2 => fakeFm.gain;
} 

if (note >= 90 && note <= 109)
{0.07 => fakeFm.gain;
}  

if (note >= 110)
{0.025 => fakeFm.gain;
}
}

//SEQUENCER STEP INSTRUCTION FUNCTION seq() -
//This function holds a large block of code that is 
//executed at every iteration of the sequencer loop

//This particular version comes with some handy features, like a sine LFO
//This is being used to modulate the rate of the Chaka-Chaka hats.
//It is an improvisational sequencer which picks 4 beat sequences at random out of my
//5 arrays which hold my 5 pre-programmed sequences
//The function accepts two arguments. The first points it to WHICH of the four slices
//is currenly being played. This argument is fed by a random number generator.
//The argument pos specifies which step of the arrays the sequencer is on 
fun void seq(int which, int pos)
{
    //determines which of the four 'slices' are chosen 
    int offset;
    if(which == 0)
    {0 => offset;
}
if(which == 1)
{4 => offset;
}
if(which == 2)
{8 => offset;
}
if(which ==3)
{12 => offset;
}

if (pos%16==0)
{
    
}

//reset the gain of the kik square oscillator at the beggining of the loop
0   => kAtk.gain;

//Chaka Chaka hats which read from the array
if ( chakaP1[pos%4+offset] == 1)
{   0 => hat.pos;
0.3 => hat.gain;

Std.fabs( melt*2 ) => hat.rate;
}
//snares ( reading from the snare pattern array )
if ( snrP1[pos&4+offset] == 1 )
{   0 => snr.pos;
1.8 => snr.rate;
1.3 => snr.gain;
}
//Hats which read from an array
if ( hatP1[pos%4+offset] == 1 )
{   0 => hat2.pos;
0.3 => hat2.gain;
1.7 => hat2.rate;
}
//kiks ( reading from the kik pattern array )
if ( kikP1[pos%4+offset] == 1 )
{
    //set the kik sample playheads to the start
    0 => kik.pos;
    0 => kik2.pos;
    //set the oscillators frequency & gain
    20 => kAtk.freq;
    .03 => kAtk.gain;
    //set the sample's rates & gain
    0.4 => kik.rate;
    0.3 => kik2.rate;
    0.8 => kik2.gain;
}

//Use the sine function to melt things and then pass a value to another melter variable
Math.sin (now/1::second*sinewarp*pi) => melt;
sinewarp++;
}


//5 VOICE CHORD GENERATOR chord5() -
//This funtion accepts 3 arguments

//1.Chord Root Note (MIDI number int)
//2.Chord Bass Note (MIDI number int) Enter 0 to use root note as bass note
//3.Chord Quality(string)

//Chord Quality acceptable values - 
//major7th, dominant7th, minor7th, halfdim7th, dim7th

fun void chord5 (int root, int bass, string description)
{   
    //bass
    if (bass == 0)
    { (root-24) => chord[0].freq;
} 

//root
Std.mtof(root) => chord[1].freq;

//third (major / minor third)
if (description == "major7th"||description == "dominant7th")
{Std.mtof(root+4) => chord[2].freq;
}
else if (description == "minor7th"||description == "halfdim7th"||description == "dim7th")
{Std.mtof(root+3) => chord[2].freq;
}

//fifth (fifth / flat fifth)
if (description == "major7th"||description == "dominant7th"||description=="minor7th")
{Std.mtof(root+7) => chord[3].freq;
}
else if (description == "halfdim7th"||description == "dim7th")
{Std.mtof(root+6) => chord[3].freq;
}

//seventh (seventh / flat seventh / double flat seventh)
if (description == "major7th")
{Std.mtof(root+11) => chord[4].freq;   
}
else if (description == "dominant7th"||description=="minor7th"||description == "halfdim7th")
{Std.mtof(root+10) => chord[4].freq;
}
else if (description == "dim7th")
{Std.mtof(root+9) => chord[4].freq;
}  

//Saftey net from crashing
else 
{ <<< "TELL CHORD5 THE TYPE OF CHORD YOU WANT" >>>;
}  
}

//Note name to MIDI note number fuction - nameToNumber()

//This function accepts note name and returns the corresponding MIDI note number
//It accepts two arguments- notename(string) and register(int)
//Acceptable note names - 
//C, C#, Db, D, D#, Eb, E, E#, Fb, F, F#, Gb, G, G#, Ab, A, A#, Bb, B, Cb, B#

fun int namToNum (string notename, int register)
{
    //create a local variable to store the result
    0 => int ans;
    
    //12 if-for statements to determine the note and multiply it by its register
    if (notename == "C"|| notename == "B#")
    {   for (0 => int i; i < register+1; i++)
    {12 +=> ans;   
} 
0 +=> ans;
}
else if (notename == "C#"||notename == "Db")
{   for (0 => int i; i < register+1; i++)
{12 +=> ans;   
}
1 +=> ans;
}
else if (notename == "D")
{   for (0 => int i; i < register+1; i++)
{12 +=> ans;   
}
2 +=> ans;
}       
else if (notename == "D#"||notename == "Eb")
{   for (0 => int i; i < register+1; i++)
{12 +=> ans;   
}
3 +=> ans;
}
else if (notename == "E"||notename == "Fb")
{   for (0 => int i; i < register+1; i++) 
{12 +=> ans;   
}
4 +=> ans;
}     
else if (notename == "F"||notename == "E#")
{   for (0 => int i; i < register+1; i++)
{12 +=> ans;   
}
5 +=> ans;
}
else if (notename == "F#"||notename == "Gb")
{   for (0 => int i; i < register+1; i++)
{12 +=> ans;   
}
6 +=> ans;
}
else if (notename == "G")
{   for (0 => int i; i < register+1; i++)
{12 +=> ans;   
}
7 +=> ans;
}
else if (notename == "G#"||notename == "Ab")
{   for (0 => int i; i < register+1; i++)
{12 +=> ans;   
}
8 +=> ans;
}
else if (notename == "A")
{   for (0 => int i; i < register+1; i++)
{12 +=> ans;   
}
9 +=> ans;
}
else if (notename == "A#"||notename == "Bb")
{   for (0 => int i; i < register+1; i++)
{12 +=> ans;   
}
10 +=> ans;
}
else if (notename == "B"||notename == "Cb")
{   for (0 => int i; i < register+1; i++)
{12 +=> ans;   
}
11 +=> ans;
}
//Safety net from crashing
else
{<<< "PLEASE CHECK THE INPUT ARGUMENTS OF NAME2NUMBER!" >>>;
}

return ans;
}
