int ht=480;
int wd=640;
int last=-1;
int radius=ht/24;
int diam=radius*2;
int c,r;
int count=0;
int seqstate[][];
int cidx;
PGraphics bg;

import ddf.minim.* ;
Minim minim;


AudioPlayer[] mySample;



// draw this once
void setup() {
  minim = new Minim(this);
  mySample = new AudioPlayer[12]; 
  mySample[0] = minim.loadFile("soundsquare0.wav") ;
  mySample[1] = minim.loadFile("soundsquare1.wav") ;
  mySample[2] = minim.loadFile("soundsquare2.wav") ;
  mySample[3] = minim.loadFile("soundsquare3.wav") ;
  mySample[4] = minim.loadFile("soundsquare4.wav") ;
  mySample[5] = minim.loadFile("soundsquare5.wav") ;
  mySample[6] = minim.loadFile("soundsquare6.wav") ;
  mySample[7] = minim.loadFile("soundsquare7.wav") ;
  mySample[8] = minim.loadFile("soundsquare8.wav") ;
  mySample[9] = minim.loadFile("soundsquare9.wav") ;
  mySample[10] = minim.loadFile("soundsquare10.wav") ;
  mySample[11] = minim.loadFile("soundsquare11.wav") ;

 
  size(wd,ht);
  bg = createGraphics(wd, ht, JAVA2D);
  bg.beginDraw();
  bg.background(0,150,0);
  seqstate = new int[wd][ht];
  for (r=0; r<12; r++){
    for (c=0; c<16; c++){
      bg.stroke(0,200,0);
      bg.fill(0);
      bg.ellipse(c*diam+radius,r*diam+radius,diam-4,diam-4);
      seqstate[c][r] = 0;
    }
  }
  bg.endDraw();
}

// draw() loops by default
void draw() {
  background(wd,ht);
  image(bg,0,0);  // draw the setup layer
  stroke(255);
  line(count, 0, count, ht);  // draw the line in this layer (not bg)

  cidx = floor(count/diam);
  if (cidx - floor(last/diam) != 0) {
    //check and play sounds
    for (int i = 0; i < 12; i++) {
      if (seqstate[cidx][i] == 1) {
        //play sound
        mySample[i].play();
        mySample[i].rewind();
      }
    }
  }
  last=count;
  count=count+3;
  if (count > wd) { 
    count = count % wd; 
  }
}

// check for mouse clicks and update bg layer
void mousePressed() {
    c=int(mouseX/diam);
    r=int(mouseY/diam);
    bg.beginDraw();
    bg.stroke(0,200,0);
    if (seqstate[c][r]==0) {
      bg.fill(0,255,0);
      seqstate[c][r]=1;
    } else {
      bg.fill(0);
      seqstate[c][r]=0;
    }
    bg.ellipse(c*diam+radius,r*diam+radius,diam-4,diam-4);
    bg.endDraw();
}

void stop()
{
 minim.stop() ;
 super.stop() ;
}
