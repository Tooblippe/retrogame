//
//      Retro online game player - play online games with an arduino controller 
//
//	Author:		tobie.nortje@navitas.co.za
//	My bio:		www.navitas.co.za/tobienortje
//	Project:	https://github.com/Tooblippe/retrogame
//	Debouncing:	http://www.labbookpages.co.uk/electronics/debounce.html
//	Debouncing: http://www.arduino.cc/playground/Learning/SoftwareDebounce
//	
//	Debouncing based on :
//			http://www.arduino.cc/en/Tutorial/Debounce
//			by, Jon Schlueter
//			30 December 2008


int RIGHT_pin = 2;         	// the number of the input pins. RIGHT button connected
int LEFT_pin = 3;			// LEFT button


int counter_RIGHT = 0;       			// how many times we have seen new value
int reading_RIGHT;           			// the current value read from the input pin
int current_state_RIGHT = LOW;    		// the debounced input value

int counter_LEFT = 0;       			// how many times we have seen new value
int reading_LEFT;           			// the current value read from the input pin
int current_state_LEFT = LOW;    		// the debounced input value

long time_RIGHT = 0;         			// the last time the output pin was sampled
long time_LEFT = 0;         			// the last time the output pin was sampled
int debounce_count_RIGHT = 10; 			// number of millis/samples to consider before declaring a debounced input
int debounce_count_LEFT = 10; 			// number of millis/samples to consider before declaring a debounced input


void setup() 
{ 
  Serial.begin(9600); 					// start serial comms 
  pinMode(RIGHT_pin, INPUT);			// set left button pin to an input
  pinMode(LEFT_pin, INPUT);
  Serial.println("arduino controller started"); 				//why not...lets just print start....
} 


void loop() {  
    
	// If we have gone on to the next millisecond
	// read and debounce RIGHT key
  if(millis() != time_RIGHT)
  {
    reading_RIGHT = digitalRead(RIGHT_pin);

    if(reading_RIGHT == current_state_RIGHT && counter_RIGHT > 0)
    {
      counter_RIGHT--;
    }
    if(reading_RIGHT != current_state_RIGHT)
    {
       counter_RIGHT++; 
    }
    // If the Input has shown the same value for long enough let's switch it
    if(counter_RIGHT >= debounce_count_RIGHT && !current_state_RIGHT)
    {
      counter_RIGHT = 0;
      current_state_RIGHT = reading_RIGHT;
      Serial.println("r");
    }
    if(counter_RIGHT >= debounce_count_RIGHT && current_state_RIGHT)
    {
      current_state_RIGHT = reading_RIGHT;
    }
    time_RIGHT = millis();
  }
  
  // read and debounce LEFT key
  if(millis() != time_LEFT){
    //----------
    reading_LEFT  = digitalRead(LEFT_pin);

    if(reading_LEFT == current_state_LEFT && counter_LEFT > 0)
    {
      counter_LEFT--;
    }
    if(reading_LEFT != current_state_LEFT)
    {
       counter_LEFT++; 
    }
    // If the Input has shown the same value for long enough let's switch it
    if(counter_LEFT >= debounce_count_LEFT && !current_state_LEFT)
    {
      counter_LEFT = 0;
      current_state_LEFT = reading_LEFT;
      Serial.println("l");
    }
    if(counter_LEFT >= debounce_count_LEFT && current_state_LEFT)
    {
      current_state_LEFT = reading_LEFT;
    }
     time_LEFT = millis();
  }   
}
  

