/**
* Program developed to simulate the
* game Genius. Basically it consists
* of four leds and for switches. 
* A randon sequence of leds is generated 
* and the user have to memorize and reproduce it.
*/


#include <stdio.h>
#include <stdlib.h>


//Different notes to use 
#define NOTE_E6  1319
#define NOTE_FS6 1480
#define NOTE_D7  2349       
#define NOTE_DS8 4978

//Pin numbers of Leds
#define red 2
#define blue 3
#define yellow 5
#define highLight 6

//Pin numbers of the keys
#define keyRed 8
#define keyBlue 9
#define keyYellow 10
#define keyHighLight 11

int melody[] = {
  NOTE_E6, NOTE_FS6,NOTE_D7, NOTE_DS8};

//Count the number of leds in the radom sequence 
int count = 1; 

//sequence of leds generated
int sequence[15];

int number;

void setup(){
  pinMode(red, OUTPUT);
  pinMode(blue,OUTPUT);
  pinMode(yellow, OUTPUT);
  pinMode(highLight, OUTPUT);
  pinMode(keyRed, INPUT);
  pinMode(keyBlue, INPUT);
  pinMode(keyYellow, INPUT);
  pinMode(keyHighLight, INPUT);
  Serial.begin(9600);
  randomSeed(analogRead(5));
}


void loop(){  
  
  //the bigest sequence generated consist of 15 leds.
  if(count < 16){
    number = randomNumber(); //generate a random number.
    sequence[count] = number;
    printSequence(); //prints the sequence
    delay(500);
    readSequence(); //read the sequence entered by the user.
    count++;
  }
  else{
    winnerAnimation();
//    if(digitalRead(key) == 0) count = 0;
  }
}

//Generates a random number from 0 to 3
int randomNumber(){
  return random() % 4;
}

//Turn a led on, beeps and then turn it off again.
int ledUp(int led, int ton){
  digitalWrite(led, HIGH);
  tone(12, melody[ton], 30);
  delay(1000);
  digitalWrite(led, LOW);
  delay(500);
}

//Prints all the sequence already generated.
void printSequence(){
  int i;
//  Serial.print("Sequence: ");
  for(i=0; i<count; i++){
         switch(sequence[i]){
      case 0:    
          ledUp(red,0);
//          Serial.print("red ");
          break;        
      case 1:
          ledUp(blue,1);
//          Serial.print("blue ");
          break;
      case 2:
          ledUp(yellow,2);
//          Serial.print("yellow ");
          break;
      case 3:
          ledUp(highLight,3);
//          Serial.print("highlight ");
    }
    
  }
//  Serial.println();
}

/**
* Reads the sequence entered by the user. If a wrong input is entered
* it beeps a "error sound" and starts from the begining.
*/
void readSequence(){
  int i;
  int redIn, blueIn, yellowIn, highLightIn;
  boolean waitingInput;
  
//  Serial.print("Count: ");
//  Serial.println(count);
  for(i=0; i<count; i++){
//          Serial.print(" i: ");
//      Serial.print(i);
//      Serial.print(" sequence[i]: ");
//      Serial.println(sequence[i]);
      waitingInput = true;
    while(waitingInput){
      redIn = digitalRead(keyRed);
      blueIn = digitalRead(keyBlue);
      yellowIn = digitalRead(keyYellow);
      highLightIn = digitalRead(keyHighLight);
      
//      Serial.print(" Input: ");
//      Serial.print("red: ");
//      Serial.print(redIn);
//      Serial.print(" blue: ");
//      Serial.print(blueIn);
//      Serial.print(" yellow: ");
//      Serial.print(yellowIn);
//      Serial.print(" highLight: ");
//      Serial.print(highLightIn);
//      Serial.println();
  
     if(redIn == 0 && blueIn == 0 && yellowIn == 0 && highLightIn == 0){
//       Serial.println("continue");
       continue;
     } 
     
     if(redIn) {
       ledUp(red,0);
     } else if(blueIn) {
        ledUp(blue,1);
     } else if(yellowIn) {
       ledUp(yellow,2);
     } else if(highLightIn) {
       ledUp(highLight,3);
     }
     
     switch(sequence[i]){
        case 0:
            if(redIn){
              Serial.println("leu red");
//              ledUp(red,0);
            } else{
              reset();
            }
            break;        
        case 1:
            if(blueIn){
              Serial.println("leu blue");
//              ledUp(blue,1);
            } else{
              reset();
            }
            break;
        case 2:
            if(yellowIn){
              Serial.println("leu yellow");
//              ledUp(yellow,2);
            } else{
              reset();
            }
            break;
        case 3:
            if(highLightIn){
              Serial.println("leu highLight");
//              ledUp(highLight,3);
            } else{
              reset();
            }
     }
     waitingInput = false;
  }
}
}

//starts the game all over again.
void reset(){
//  Serial.println("Reset");
    count = 0;
    delay(200);
      tone(12, melody[0], 30);
      delay(200);
      tone(12, melody[1], 30);
            delay(200);
      tone(12, melody[2], 30);
            delay(200);
      tone(12, melody[3], 30);
      delay(1000);
    
}
  

void winnerAnimation(){
    digitalWrite(red, HIGH);
    digitalWrite(blue, HIGH);
    digitalWrite(yellow, HIGH);
    digitalWrite(highLight, HIGH);
    delay(1000);
    digitalWrite(red, LOW);
    digitalWrite(blue, LOW);
    digitalWrite(yellow, LOW);
    digitalWrite(highLight, LOW);
    delay(1000);
}

