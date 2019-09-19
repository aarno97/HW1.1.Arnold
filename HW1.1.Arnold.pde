import processing.sound.*; //import the sound library  //<>//

PImage img; //declare a variable of type PImage //<>//
int CircleX, CircleY; //position of the circle button
int circleSize = 295; //diameter of circle
boolean circleOver = false; //used to tell whether or not the mouse is over the button
boolean guestVerified = false; //used to decide if a floor has been chosen by a guest placing their keycard on the button
boolean finalScreen = false; //used to decide if the floor has been reached, and if so say goodbye
PFont SensationsQualities, ArialUnicode, GreetingSign, GetOuttaHere; //Used to format text
int i = 5; //how many seconds it takes to travel from ground floor to Mrs. Smith's floor
SoundFile Welcome, Travelling, Exit; 
boolean FirstTime = true; 
boolean SecondScreen = true; 
boolean Bye = true; 




void setup() {
  size(1000, 500); //set up a canvas
  img = loadImage("WelcomeHome2.png"); //load the welcome home image
  CircleX = 750; //indicate where the circle will be 
  CircleY = 250; 
  SensationsQualities = createFont("Sensations and Qualities.ttf", 72); //used throughout the program as a font for text
  ArialUnicode = createFont("Arial Unicode.ttf", 28); //used throughout the program as a font for text
  GreetingSign = createFont("Arial Unicode.ttf", 24); //used to tell passengers where to place their keycard
  GetOuttaHere = createFont("Sensations and Qualities.ttf", 100); //used for the goodbye message
  textFont(SensationsQualities); //sets the inital font
  Welcome = new SoundFile(this, "WelcomeHome.wav"); 
  Travelling = new SoundFile(this, "TravelingSound.wav"); 
  Exit = new SoundFile(this, "ExitSound.wav"); 
}

void draw() {
  update(mouseX, mouseY); //calls update to see where the mouse is currently at and if it is inside the border of the inner circle on the home screen. 
  background(209, 226, 225); //set the background
  img.resize(400, 0); //resize the image used on the home screen to where it fits
  image(img, 50, 150); //display the image
  if(FirstTime) { //welcomes the user into the elevator one time only. 
    Welcome.play(); 
    FirstTime = false; 
  }
  fill(72, 128, 212); //fill the outer ring
  ellipse(750, 250, 350, 350); //draw the outer ring
  textFont(GreetingSign); //change the font to GreetingSign to tell the passenger where to place keycard
  String HomeScreen = "Place your keycard here."; //visual identification of where to place keycard
  if (circleOver) { // either white out the inner circle or make it dark to signify that the mouse is on top of a button
    fill(168, 203, 255); 
    ellipse(750, 250, 300, 300); //currently on top of the button
  } else {
    fill(255); //fill the inner ring
    ellipse(750, 250, 300, 300); //display the inner ring (this is where the first button will be)
  }
  fill(0); 
  text(HomeScreen, 625, 250); //display the text to say "put your keycard here" 
  if (guestVerified) {
    background(209, 226, 225); 
    String greet = "Welcome to the Building,"; //create Strings that will be used in the rest of the program.  
    String name = "Mrs. Smith."; 
    String firstL;
    firstL = "Heading to your floor, please wait. "; 
    if(SecondScreen) { //tells the guest they are traveling one time only. 
      Travelling.play(); 
      SecondScreen = false; 
    }
    fill(0); // the following lines of code create the text on the second screen when the elevator is moving. 
    textAlign(CENTER);
    textFont(SensationsQualities); 
    text(greet, 250, 150); 
    text(name, 250, 200); 
    textFont(ArialUnicode); 
    text(firstL, 250, 300);
    fill(255); 
    ellipse(750, 250, 375, 375);
    fill(0); //the following code acts as a countdown timer
    String num = str(i); 
    textFont(SensationsQualities); 
    text(num, 730, 225); 
    text("seconds remaining.", 750, 275); 
    i = i - 1; 
    println(i); 
    if(i == -2) { //if the countdown has finished move to the good-bye message screen
      guestVerified = false;
      finalScreen = true; 
      i = 5; 
    }
    delay(1000); 
  }
  if(finalScreen == true) { //this code is used to say goodbye to the guest. 
    background(209, 226, 225); //set the background
    String GoodBye = "Welcome to your floor, Mrs. Smith."; 
    if(Bye) { //tells the user Goodbye one time only. 
      Exit.play(); 
      Bye = false; 
    }
    textFont(GetOuttaHere);
    fill(0); 
    text(GoodBye, 500, 250); 
  }
}

void mousePressed() {
  if (circleOver) {
    //this section signals the draw() function to move to the next screen
    guestVerified = true;
  }
}

//update() tells draw() where the mouse currently is, and if it is inside the inner circle on the home screen or not. 
void update(int x, int y) {
  if ( overCircle(CircleX, CircleY, circleSize) ) {
    circleOver = true;
  } else {
    circleOver = false;
  }
}

//overCircle is the calculation used to determine if the mouse is on top of the button. 
boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
