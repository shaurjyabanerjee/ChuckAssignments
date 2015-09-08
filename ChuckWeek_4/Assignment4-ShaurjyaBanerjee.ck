//          Shaurjya Banerjee - Assignment 4
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

//IMPROVISATIONAL DRUMS n BASSS!!!
// 10/09/2014

//Chord function oscillator
TriOsc chord[5];
//Sound network
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

//Tempo Declaration network
175 => float BPM;

0.6=> master.gain;

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

//Load samples
me.dir() + "/audio/kick_03.wav" => kik.read;
me.dir() + "/audio/kick_04.wav" => kik2.read;
me.dir() + "/audio/snare_01.wav" => snr.read;
me.dir() + "/audio/hihat_02.wav" => hat.read;
me.dir() + "/audio/hihat_01.wav" => hat2.read;
me.dir() + "/audio/stereo_fx_01.wav" => fx1.read;

//circle of fifths (for chords)
[ nameToNumber("B", 3), nameToNumber("D", 3), nameToNumber("G", 3), nameToNumber("Bb", 3),
nameToNumber("Eb", 3), nameToNumber("A", 3), nameToNumber("D", 3), nameToNumber("G", 3), 
nameToNumber("Bb", 3), nameToNumber("Eb", 3), nameToNumber("F#", 3), nameToNumber("B", 3),
nameToNumber("F", 3), nameToNumber("Bb", 3), nameToNumber("Eb", 3), nameToNumber("A", 3) ] @=> int C5ths[];

//chord descriptions
["major7th","dominant7th", "major7th", "dominant7th", "major7th","minor7th", "dominant7th",
 "major7th", "dominant7th", "major7th","dominant7th", "major7th","minor7th","dominant7th", "major7th", "minor7th"] @=> string qlty[]; 

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

//Set plaheads to end of samples
kik.samples() => kik.pos;
kik2.samples() => kik2.pos;
snr.samples() => snr.pos;
snr2.samples() => snr2.pos;
hat.samples() => hat.pos;
hat2.samples() => hat2.pos;
fx1.samples() => fx1.pos;
fx2.samples() => fx2.pos;

//Initialize variable melt, which generally melts things
2.0 => float melt;
4 => int sinewarp;

//Define the number of steps in the sequencer
16 => int seqStep;
//Define the number of repeats
16 => int rpt;
0   => kAtk.gain;
//Define two integers
int jump;
int which;

//Step through and set the gain etc of the chord oscillators within littul for loop
for (0 => int i; i< chord.cap(); i++)
{
    chord[i] => master;
    0.8/chord.cap() => chord[i].gain;
    
}

for ( 0 => int j; j < 16; j++ )//this loops through
{

    for ( 0 => int i; i < seqStep; i ++) //this for loop steps through the sequence
    {
        if(jump == 0)
        { //This random number drives the which argument of the seq function
          Math.random2(0,3) => which;
        }
        
        //calling the function seq which executes the code at each step of the sequencer 
        seq(which, i);
        //calling the chord function at the begginning of each 16 beat section
        chord5(C5ths[j], 0, qlty[j]);   
        
        //the time advanced here is the duration of each step of the sequencer
        sxtn::second => now;        
        i%4 => jump;
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

fun int nameToNumber (string notename, int register)
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