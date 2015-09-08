//          Shaurjya Banerjee - Assignment 1
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

<<< "Shaurjya Banerjee - Assignment 1" >>>;
<<< "           9/18/2014" >>>;
<<< "Please plug into a monitoring system with BASS" >>>;

//Sound Network
SawOsc FuqOne => dac;
SinOsc FuqTwo => dac;
TriOsc FuqThree => dac;
SinOsc kik => dac;
SqrOsc kik2 => dac;
TriOsc one => dac;
SqrOsc two => dac;

//Set the tempo of the piece
150.0 => float BPM;

//Set the tuning of the piece (eg. A4 = 440)
432.0 => float Tune; 

//Initializing & defining half, quarter, eighth, etc.. notes etc in terms of the BPM 
120 / BPM => float half;
60 / BPM => float qrtr;
30 / BPM => float eight;
15 / BPM => float sxtn;
7.5 / BPM => float thirtytwo;
3.75 / BPM => float sixtyfour;

//Initalizing & defining variables to control the length of the kik drum
half / 80 => float khalf;
qrtr / 80 => float kqrtr;
eight / 80 => float keight;
sxtn / 80 => float ksxtn;
thirtytwo / 80 => float kthirtytwo;
sixtyfour / 80 => float ksixtyfour;

//Initializing the 12th root of 2 (needed to calculate frequency intervals)
1.059463094359 => float a;

//Initalize the frequency of note A3
Tune/2 => float A3;

//Calculate an octave of pitches using fn = f0 * (a)^n where f0 = A3
(( a ) * A3 )/220 => float Bf3;
(( a*a ) * A3 )/220 => float B3;
(( a*a*a ) * A3 )/220 => float C4;
(( a*a*a*a ) * A3 )/220 => float Cs4;
(( a*a*a*a*a ) * A3 )/220 => float D4;
(( a*a*a*a*a*a ) * A3 )/220 => float Ds4;
(( a*a*a*a*a*a*a ) * A3 )/220 => float E4;
(( a*a*a*a*a*a*a*a ) * A3 )/220 => float F4;
(( a*a*a*a*a*a*a*a*a ) * A3 )/220 => float Fs4;
(( a*a*a*a*a*a*a*a*a*a ) * A3 )/220 => float G4;
(( a*a*a*a*a*a*a*a*a*a*a ) * A3 )/220 => float Gs4;
(( a*a*a*a*a*a*a*a*a*a*a*a ) * A3 )/220 => float A4;
(( a*a*a*a*a*a*a*a*a*a*a*a*a ) * A3 )/220 => float Bf4;
(( a*a*a*a*a*a*a*a*a*a*a*a*a*a ) * A3 )/220 => float B4;
(( a*a*a*a*a*a*a*a*a*a*a*a*a*a*a ) * A3 )/220 => float C5;

//This is my weird intro of three stacked Fuq oscillators
{   //Setting the 'mix' of my three Fuq oscillators and to silence te others
    0.1 => FuqOne.gain;
    0.3 => FuqTwo.gain;
    0.25 => FuqThree.gain;
    0 => one.gain;
    0 => two.gain;
    0 => kik.gain;
    0 => kik2.gain;
    
    
    //This for loop alters the frequency of the three oscillators in different ways
    for ( 6000 => int j; j > 5000; j--)
    {
        j => FuqOne.freq;
        (j-- / 7) => FuqTwo.freq;
        ((j++/12) / 4) => FuqThree.freq;
        (.000001 * j)::second => now;
    }   
}

//Initialize kikVolume
 1 => float kikVol;

 0 => one.gain;
 0 => two.gain;
 0 => FuqOne.gain;
 0 => FuqTwo.gain;
 0 => FuqThree.gain;


//Here begins kik riser 
//( whats electronic music without kik risers right?! )

    //Half note kiks
    for ( 1 => int count; count <= 4; count++ ) 
        
        { 
            1 => kikVol;
            kikVol => kik.gain;
            (kikVol/20) => kik2.gain;
            
            //Drop the pitch of the kik oscillator quickly from 100Hz to 20Hz
            for ( 100 => int i; i >= 20; i--)
            {
                i => kik.freq;
                (i/4) => kik2.freq;
                khalf::second => now;
            }   
            
        }
        
        //Quarter note kiks
        for ( 1 => int count; count <= 4; count++ ) 
            
            { 
                1 => kikVol;
                kikVol => kik.gain;
                (kikVol/20) => kik2.gain;
                //Drop the pitch of the kik oscillator 100Hz to 20Hz
                for ( 100 => int i; i >= 20; i--)
                {
                    i => kik.freq;
                    (i/4) => kik2.freq;
                    kqrtr::second => now;
                }   
                
            } 
            
            //Eighth note kiks
            for ( 1 => int count; count <= 8; count++ ) 
                
                { 
                    1 => kikVol;
                    kikVol => kik.gain;
                    (kikVol/20) => kik2.gain;
                    //Drop the pitch of the kik from 100Hz to 20Hz
                    for ( 100 => int i; i >= 20; i--)
                    {
                        i => kik.freq;
                        (i/4) => kik2.freq;
                        keight::second => now;
                    }   
                    
                }
                
                //Sixteenth note kiks
                for ( 1 => int count; count <= 16; count++ ) 
                    
                    { 
                        1 => kikVol;
                        kikVol => kik.gain;
                        (kikVol/20) => kik2.gain;
                        //Drop the pitch of the kik from 100Hz to 20Hz
                        for ( 100 => int i; i >= 20; i--)
                        {
                            i => kik.freq;
                            (i/4) => kik2.freq;
                            ksxtn::second => now;
                        }   
                        
                    }  
                    
                    //Thirty second note kiks
                    for ( 1 => int count; count <= 32; count++ ) 
                        
                        { 
                            1 => kikVol;
                            kikVol => kik.gain;
                            (kikVol/20) => kik2.gain;
                            //Drop the pitch of the kik 100Hz to 20Hz
                            for ( 100 => int i; i >= 20; i--)
                            {
                                i => kik.freq;
                                (i/4) => kik2.freq;
                                kthirtytwo::second => now;
                            }   
                            
                        } 
                        
                        //Sixty fourth note kiks
                        for ( 1 => int count; count <= 32; count++ ) 
                            
                            { 
                                1 => kikVol;
                                kikVol => kik.gain;
                                (kikVol/20) => kik2.gain;
                                //Drop the pitch of the kik from 100Hz to 20Hz
                                for ( 100 => int i; i >= 20; i--)
                                {
                                    i => kik.freq;
                                    (i/4) => kik2.freq;
                                    (ksixtyfour)::second => now;
                                }   
                                
                            }                                                                                       

 0 => one.gain;
 0 => two.gain;
 0 => kik.gain;
 0 => kik2.gain;
 0 => FuqOne.gain;
 0 => FuqTwo.gain;
 0 => FuqThree.gain;

                        
//Initialize the 'Transpose' variable
220.0 => float Trans;
Trans / 2 => float TransOct;


//HERE COMES BACH!
//Play measures 1-4

for ( 1 => int c; c < 3; c++ )
{ <<< " fuck chuck" >>>;
    0.3 => one.gain;
    0.1 => two.gain;
    
    //Measure 1
    Trans * D4 => one.freq;
    TransOct * D4 => two.freq;
    half::second => now;
    
    Trans * A4 => one.freq;
    TransOct * A4 => two.freq;
    half::second => now;
    
    //Measure 2
    Trans * F4 => one.freq;
    TransOct * F4 => two.freq;
    half::second => now;
    
    Trans * D4 => one.freq;
    TransOct * D4 => two.freq;
    half::second => now;
    
    //Measure 3
    Trans * Cs4 => one.freq;
    TransOct * Cs4 => two.freq;
    half::second => now;
    
    Trans * D4 => one.freq;
    TransOct * D4 => two.freq;
    qrtr::second => now;
    
    Trans * E4 => one.freq;
    TransOct * E4 => two.freq;
    qrtr::second => now;
    
    //Measure 4
    Trans * F4 => one.freq;
    TransOct * F4 => two.freq;
    (half + qrtr)::second => now;
    
    Trans * G4 => one.freq;
    TransOct * G4 => two.freq;
    eight::second => now;
    
    Trans * F4 => one.freq;
    TransOct * F4 => two.freq;
    eight::second => now;
    
    Trans * E4 => one.freq;
    TransOct * E4 => two.freq;
    eight::second => now;
    
    //Raise the melody by a fifth every time it loops back
    Trans * 1.5 => Trans;
    TransOct * 1.5 => TransOct;
}

220 => Trans;

//Play measures 5-8

{
    0.3 => one.gain;
    0.1 => two.gain;
    
    
    //Measure 5
    Trans * D4 => one.freq;
    TransOct * D4 => two.freq;
    qrtr::second => now;
    
    Trans * E4 => one.freq;
    TransOct * E4 => two.freq;
    qrtr::second => now;
    
    Trans * F4 => one.freq;
    TransOct * F4 => two.freq;
    qrtr::second => now;
    
    Trans * G4 => one.freq;
    TransOct * G4 => two.freq;
    qrtr::second => now;
    
    //Measure 6
    Trans * A4 => one.freq;
    TransOct * A4 => two.freq;
    qrtr::second => now;
    
    Trans * (A3/220) => one.freq;
    TransOct * (A3/220) => two.freq;
    eight::second => now;
    
    Trans * B3 => one.freq;
    TransOct * B3 => two.freq;
    eight::second => now;
    
    Trans * C4 => one.freq;
    TransOct * C4 => two.freq;
    eight::second => now;
    
    Trans * F4 => one.freq;
    TransOct * F4 => two.freq;
    (qrtr + eight)::second => now;
    
    //Measure 7
    Trans * B3 => one.freq;
    TransOct * B3 => two.freq;
    eight::second => now;
    
    Trans * E4 => one.freq;
    TransOct * E4 => two.freq;
    (qrtr + eight)::second => now;
    
    Trans * F4 => one.freq;
    TransOct * F4 => two.freq;
    eight::second => now;
    
    Trans * E4 => one.freq;
    TransOct * E4 => two.freq;
    eight::second => now;
    
    Trans * D4 => one.freq;
    TransOct * D4 => two.freq;
    eight::second => now;
    
    //Measure 8
    Trans * E4 => one.freq;
    TransOct * E4 => two.freq;
    qrtr::second => now;
    
    Trans * Fs4 => one.freq;
    TransOct * Fs4 => two.freq;
    qrtr::second => now;
    
    Trans * G4 => one.freq;
    TransOct * G4 => two.freq;
    qrtr::second => now;
      
} 
