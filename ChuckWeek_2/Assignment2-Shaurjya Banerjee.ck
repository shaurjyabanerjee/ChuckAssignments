//          Shaurjya Banerjee - Assignment 2
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

<<< " Shaurjya Banerjee - Assignment 2 " >>>;
<<< " J A M B I - 09 / 25 / 2014" >>>; 

//The supersaw sound network
SawOsc s1 => dac.left;
SawOsc s2 => Pan2 p1 => dac;
SawOsc s3 => dac;
SawOsc s4 => Pan2 p2 => dac;
SawOsc s5 => dac.right;
SawOsc s6 => dac.left;
SawOsc s7 => dac.right;

//Kik sound network
SinOsc kik => dac;
SqrOsc kik2 => dac;

//Set the tempo of the song
200 => float tempo;
tempo * 2 => float BPM;

//Calclate the required beat durations relative to the BPM
120 / BPM => float hf;
60 / BPM => float qr;
30 / BPM => float ei;
(( 30/BPM ) * 0.6667) => float eT;
15 / BPM => float sx;

//Initialize The Supersaw gain network, but without any real values yet
0.0 => s1.gain;
0.0 => s2.gain;
0.0 => s3.gain;
0.0 => s4.gain;
0.0 => s5.gain;
0.0 => s6.gain;
0.0 => s7.gain;
0.0 => kik.gain;
0.0 => kik2.gain;

//Initalize The Supersaw detune network, but without any real values yet
0 => float detune1;
0 => float detune2;
0 => float detune3;
0 => float detune4;
0 => float detune5;
0 => float detune6;
0 => float detune7;

//Riff 1 (four and a half)
[ 53,52,50, 50,50,50,50, 55,53,50, 50,50, 53,51,50, 50,50, 60,58,50, 50,50 ] @=> int R1N[];
[ eT,eT,eT, ei,ei,ei,ei, eT,eT,eT, ei,ei, eT,eT,eT, ei,ei, eT,eT,eT, ei,ei ] @=> float R1T[];

for ( 0 => int loop; loop < 4; loop++ )
{    
    for ( 0 => int i; i < R1N.cap(); i++ )
    {//Supply the detune variables with random float values between 1.0 & 3.0
        Math.random2f( 1.0, 3.0) => detune1;
        Math.random2f( 1.0, 3.0) => detune2;
        Math.random2f( 1.0, 3.0) => detune3;
        Math.random2f( 1.0, 3.0) => detune4;
        Math.random2f( 1.0, 3.0) => detune5;
        Math.random2f( 1.0, 3.0) => detune6;
        Math.random2f( 1.0, 3.0) => detune7;
        //Supply the pan variables with a random float between -0.8 & 0.8
        Math.random2f(-0.8, 0.0) => p1.pan;
        Math.random2f( 0.0, 0.8) => p2.pan;
        
        //The envelope section
        0 => int ii;
        (R1T[i] * 1000.0) $ int => int mills; //convert to ms
        1 => float delay;
        mills - delay => float decay;
        while (ii < mills)
        {
            if (ii > delay)
            {
                (ii-delay) / (decay $ float) => float current;
                0 => kik.gain;
                0 => kik2.gain;
                (1.0 - current) => s1.gain;
                (1.0 - current) => s2.gain;
                (1.0 - current) => s3.gain;
                (1.0 - current) => s4.gain;
                (1.0 - current) => s5.gain;
                (1.0 - current) => s6.gain;
                (1.0 - current) => s7.gain;
                
            }
            
            ii++;
            .75::ms => now;
        }
        
        //This is the heart of The Supersaw.
        //The octave detune and fine detune of the oscillators are specified here
        
        (Std.mtof( R1N[i] - 12 ) - detune1) => s1.freq; // -1 Oct, - detune1
        (Std.mtof( R1N[i] + 24 ) - detune2) => s2.freq; // +2 Oct, - detune2
        (Std.mtof( R1N[i] - 0  ) - detune3) => s3.freq; // +/- 0 Oct, -detune3
        (Std.mtof( R1N[i] + 12 ) + detune4) => s4.freq; // +1 Oct, + detune4
        (Std.mtof( R1N[i] - 12 ) + detune5) => s5.freq; // -1 Oct, + detune5
        (Std.mtof( R1N[i] - 24 ) - detune6) => s6.freq; // -2 Oct, - detune6
        (Std.mtof( R1N[i] - 24 ) + detune7) => s7.freq; // -2 Oct, + detune7
        R1T[i]::second => now;  
    }
}

//Riff 2 (four and a half)
[ 50, -300, 53,52,50, 50,50,50,50, -300, 53,52,50, 50,50,50,50 ] @=> int R2N[];
[ qr,  qr,  eT,eT,eT, ei,ei,ei,ei,  qr,  eT,eT,eT, ei,ei,ei,ei ] @=> float R2T[];

for ( 0 => int loop; loop < 4; loop++ )
{    
    for ( 0 => int i; i < R2N.cap(); i++ )
    {//Supply the detune variables with random float values between 1.0 & 3.0
        Math.random2f( 1.0, 3.0) => detune1;
        Math.random2f( 1.0, 3.0) => detune2;
        Math.random2f( 1.0, 3.0) => detune3;
        Math.random2f( 1.0, 3.0) => detune4;
        Math.random2f( 1.0, 3.0) => detune5;
        Math.random2f( 1.0, 3.0) => detune6;
        Math.random2f( 1.0, 3.0) => detune7;
        //Supply the pan variables with a random float between -0.8 & 0.8
        Math.random2f(-0.8, 0.0) => p1.pan;
        Math.random2f( 0.0, 0.8) => p2.pan;
        
        //The envelope section
        0 => int ii;
        (R1T[i] * 1000.0) $ int => int mills; //convert to ms
        1 => float delay;
        mills - delay => float decay;
        while (ii < mills)
        {
            if (ii > delay)
            {
                (ii-delay) / (decay $ float) => float current;
                0.0 => kik.gain;
                0.0 => kik2.gain;
                (1.0 - current) => s1.gain;
                (1.0 - current) => s2.gain;
                (1.0 - current) => s3.gain;
                (1.0 - current) => s4.gain;
                (1.0 - current) => s5.gain;
                (1.0 - current) => s6.gain;
                (1.0 - current) => s7.gain;
                
            }
            
            ii++;
            .75::ms => now;
        }
        
        //This is the heart of The Supersaw.
        //The octave detune and fine detune of the oscillators are specified here
        
        (Std.mtof( R1N[i] - 12 ) - detune1) => s1.freq; // -1 Oct, - detune1
        (Std.mtof( R1N[i] + 24 ) - detune2) => s2.freq; // +2 Oct, - detune2
        (Std.mtof( R1N[i] - 0  ) - detune3) => s3.freq; // +/- 0 Oct, -detune3
        (Std.mtof( R1N[i] + 12 ) + detune4) => s4.freq; // +1 Oct, + detune4
        (Std.mtof( R1N[i] - 12 ) + detune5) => s5.freq; // -1 Oct, + detune5
        (Std.mtof( R1N[i] - 24 ) - detune6) => s6.freq; // -2 Oct, - detune6
        (Std.mtof( R1N[i] - 24 ) + detune7) => s7.freq; // -2 Oct, + detune7
        R1T[i]::second => now;
    }
}


//6 Riff
[ 50,50,50,50, -300, 50,50,50,50, -300, 50,50, -300, 50,50,50,50,50, 50 ] @=> int R6N[];
[ sx,sx,sx,sx,  ei,  sx,sx,sx,sx,  ei,  sx,sx,  sx,  sx,sx,sx,sx,sx, qr] @=> float R6T[];

for ( 0 => int loop; loop < 4; loop++ )
{    
    for ( 0 => int i; i < R6N.cap(); i++ )
    {
        //Supply the detune variables with random float values between 1.0 & 3.0
        Math.random2f( 1.0, 3.0) => detune1;
        Math.random2f( 1.0, 3.0) => detune2;
        Math.random2f( 1.0, 3.0) => detune3;
        Math.random2f( 1.0, 3.0) => detune4;
        Math.random2f( 1.0, 3.0) => detune5;
        Math.random2f( 1.0, 3.0) => detune6;
        Math.random2f( 1.0, 3.0) => detune7;
        //Supply the pan variables with a random float between -0.8 & 0.8
        Math.random2f(-0.8, 0.0) => p1.pan;
        Math.random2f( 0.0, 0.8) => p2.pan;
        
        //The envelope section
        0 => int ii;
        (R1T[i] * 1000.0) $ int => int mills; //convert to ms
        1 => float delay;
        mills - delay => float decay;
        while (ii < mills)
        {
            if (ii > delay)
            {
                (ii-delay) / (decay $ float) => float current;
                0.0 => kik.gain;
                0.0 => kik2.gain;
                (1.0 - current) => s1.gain;
                (1.0 - current) => s2.gain;
                (1.0 - current) => s3.gain;
                (1.0 - current) => s4.gain;
                (1.0 - current) => s5.gain;
                (1.0 - current) => s6.gain;
                (1.0 - current) => s7.gain;
                
            }
            
            ii++;
            .75::ms => now;
        }
        
        //This is the heart of The Supersaw.
        //The octave detune and fine detune of the oscillators are specified here
        
        (Std.mtof( R1N[i] - 12 ) - detune1) => s1.freq; // -1 Oct, - detune1
        (Std.mtof( R1N[i] + 24 ) - detune2) => s2.freq; // +2 Oct, - detune2
        (Std.mtof( R1N[i] - 0  ) - detune3) => s3.freq; // +/- 0 Oct, -detune3
        (Std.mtof( R1N[i] + 12 ) + detune4) => s4.freq; // +1 Oct, + detune4
        (Std.mtof( R1N[i] - 12 ) + detune5) => s5.freq; // -1 Oct, + detune5
        (Std.mtof( R1N[i] - 24 ) - detune6) => s6.freq; // -2 Oct, - detune6
        (Std.mtof( R1N[i] - 24 ) + detune7) => s7.freq; // -2 Oct, + detune7
        R1T[i]::second => now;
    }
}
        {
        1.0 => float kikVol;
        
        kikVol => kik.gain;
        (kikVol/20) => kik2.gain;
        
        //Drop the pitch of the kik oscillator quickly from 100Hz to 20Hz
        for ( 100 => int i; i >= 20; i--)
        {
            //for ( )
            i => kik.freq;
            i/4 => kik2.freq;
            .09::second => now;
        }   
    }
