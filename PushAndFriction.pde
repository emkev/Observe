
/* 2017.07.14 , for a simulation to view */

class Mover
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float topspeed , mass;
  float wd , hg ;
  
  Mover()
  {
    wd = width/10 ;
    hg = height/10 ;

    location = new PVector( width/2 , height-hg-10 );
    velocity = new PVector(0 , 0);
    acceleration = new PVector(0 , 0);
    
    topspeed = 10.0;  
    mass = 1.0;
        
  }
  
  
  void update()
  {
    velocity.add(acceleration);
    //velocity.limit(topspeed);
    location.add(velocity);
    
    acceleration.mult(0);
  }
  
  
  void applyForce(PVector force)
  {
    PVector f = force.get();
    f.div(mass);
    acceleration.add(f);
  }
  
  void checkEdge()
  {
    if(location.x <= 0 || location.x+wd >= width)
    {
      velocity.x = (-1) * velocity.x;  
    } 
    if(location.y <= 0 || location.y+hg >= height)
    {
      velocity.y = (-1) * velocity.y;
    } 
  }
  
  void display()
  {
    rect( location.x , location.y , wd , hg ) ;
  }
  
}


/************* main part ************/

Mover m ;

PVector frc ;
float mewSet ;
float g ;

void setup() {
  
  size( 640 , 320 ) ;
  
  m = new Mover() ;
  frc = new PVector( 0 , 0 ) ;
  mewSet = 0.01 ;
  g = 9.8 ;
}


void draw() {
  
  background(200);
  
  frc = Friction( m , mewSet ) ;
  m.applyForce( frc ) ;
  
  m.update() ;
  m.checkEdge() ;
  m.display() ;

  text("mewSet = " + mewSet , 10 , 30 );
}


/********** Interactive part ************/

void mousePressed() {

  PVector push = new PVector( mouseX/50.0 , 0 ) ;
  m.applyForce( push ) ;
}


void keyPressed() {

  if ( key == CODED & keyCode == UP ) {
    mewSet += 0.01 ;
  }
  else if ( key == CODED & keyCode == DOWN & mewSet >= 0.01) {
    mewSet -= 0.01 ;
  }
  
}


PVector Friction( Mover mv , float mew ) {
  
  float N ;
  
  N = mv.mass * g ;
  
  PVector fric = mv.velocity.get() ;
  fric.normalize() ;
  fric.mult(-1) ;
  
  fric.mult( mew * N ) ;
  
  return fric ;
  
}

