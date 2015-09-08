//          Shaurjya Banerjee - Assignment 3
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

//10/02/2014 - IHateChuck Records
//TechnoTechnoTechnoTechnoTechnoTechno
//No reversing or anything because miniAudicle BROKE. (As usual)

//sound network
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

2 => master.gain;
 
//Defining the tempo of the piece
127 => float BPM;

//Initializing & defining half, quarter, eighth, etc.. notes etc in terms of the BPM 
120 / BPM => float half;
( half/2 ) => float qrtr;
( qrtr/2 ) => float eight;
( eight * 0.6667) => float eightT;
( eight/2 ) => float sxtn;
( sxtn * 0.6667 ) => float sxtnT;
( sxtn/2 ) => float thirtytwo;
( thirtytwo * 0.6667 ) => float thirtytwoT;
( thirtytwo/2 ) => float sixtyfour;

[ half, qrtr, eight, sxtn, thirtytwo, sixtyfour ] @=> float beat_array[];

//Load samples
me.dir() + "/audio/kick_03.wav" => kik.read;
me.dir() + "/audio/kick_04.wav" => kik2.read;
me.dir() + "/audio/snare_01.wav" => snr.read;
me.dir() + "/audio/snare_02.wav" => snr2.read;
me.dir() + "/audio/hihat_02.wav" => hat.read;
me.dir() + "/audio/hihat_01.wav" => hat2.read;
me.dir() + "/audio/stereo_fx_03.wav" => fx1.read;
me.dir() + "/audio/stereo_fx_04.wav" => fx2.read;

//Pattern 1 in arrays for kit pieces
[ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15 ] @=> int ImJustHereToCount[];
[ 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0 ] @=> int kikP1[];
[ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] @=> int snrP1[];


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

//Define the number of steps in the sequencer
16 => int seqStep;
//Define the number of repeats
16 => int rpt;
0   => kAtk.gain; 

for ( 0 => int j; j <= rpt; j++ )
{ 
    for ( 0 => int i; i < seqStep; i ++) //this loop steps through 
    {   
        
        //reset the gain of the kik square oscillator at the begging of the loop
        0   => kAtk.gain;        
        
        //fx1 ( is triggered every second beat ) 
        if ( i%2 == 0 ) 
        {
            0 => fx1.pos;
            1 => fx1.gain;
            r.mix(0.075);
            //updates the pitch of the pad sample relative to the sine function
            Std.fabs( melt * 1.5 ) => fx1.rate;
        }
        
        //fx2
        if ( i%6 == 0 )
        {
            0 => fx2.pos;
            1 => fx2.rate;
            0.6 => fx2.gain;
            
        }
        //kiks ( reading from the kik pattern array )
        if ( kikP1[i] == 1 && j >= 4 )
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
        
       
        //simple hats which play on every other beat
        if ( i%2 == 1)
        {
            0 => hat.pos;
            0.4 => hat.gain;
            3 => hat.rate;
        }
        
        //chaka chaka hats which play on every beat of the sequence
        if ( i > -1 && j >=2 )
        {
            0 => hat2.pos;
            0.3 => hat2.gain;
            //Use the variable returned by the sine function
            Std.fabs( melt*6 ) => hat2.rate;
        }
        
        //snares ( reading from the snare pattern array ) 
        if ( snrP1[i] == 1  && j >= 3 )
        {     
            0 => snr.pos;
            0 => snr2.pos;
            2.4 => snr.rate;
            1.3 => snr.gain;
            1.3 => snr2.gain;
        }
         
        //Use the sine function to melt things using the melt variable
        Math.sin (now/1::second*1*pi) => melt;
        <<< "Bar no: ", (j + 1), "step no:", (i + 1), i%2, i%3, i%4 >>>;
        sxtn::second => now;
    }
}