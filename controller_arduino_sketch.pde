//
Retro online game player - play online games with an arduino controller 

	Author:		tobie.nortje@navitas.co.za
	My bio:		www.navitas.co.za/tobienortje
	Project:	https://github.com/Tooblippe/retrogame
//

int rightPin = 2;         // the number of the input pins. Right button connected
int leftpin = 3;			// left button


int counter_right_right = 0;       // how many times we have seen new value
int reading_right;           // the current value read from the input pin
int current_state_right_right = LOW;    // the debounced input value

int counter_left_left = 0;       // how many times we have seen new value
int reading_left;           // the current value read from the input pin
int current_state_left_left = LOW;    // the debounced input value

// the following variable is a long because the time, measured in milliseconds,
// will quickly become a bigger number than can be stored in an int.
long time_right = 0;         // the last time the output pin was sampled
long time_left = 0;         // the last time the output pin was sampled
int debounce_count_right_right = 10; // number of millis/samples to consider before declaring a debounced input
int debounce_count_left_left = 10; // number of millis/samples to consider before declaring a debounced input


void setup() 
{ 
  Serial.begin(9600); 
  pinMode(rightPin, INPUT);
  pinMode(leftpin, INPUT);
  Serial.println("start"); 
} 


void loop() {
  
    // If we have gone on to the next millisecond
	// read and debounce right key
	
  if(millis() != time_right)
  {
    reading_right = digitalRead(rightPin);

    if(reading_right == current_state_right_right && counter_right_right > 0)
    {
      counter_right_right--;
    }
    if(reading_right != current_state_right_right)
    {
       counter_right_right++; 
    }
    // If the Input has shown the same value for long enough let's switch it
    if(counter_right_right >= debounce_count_right_right && !current_state_right_right)
    {
      counter_right_right = 0;
      current_state_right_right = reading_right;
      Serial.println("r");
    }
    if(counter_right_right >= debounce_count_right_right && current_state_right_right)
    {
      current_state_right_right = reading_right;
    }
    time_right = millis();
  }
  
  // read and debounce left key
  if(millis() != time_left){
    //----------
    reading_left  = digitalRead(leftpin);

    if(reading_left == current_state_left_left && counter_left_left > 0)
    {
      counter_left_left--;
    }
    if(reading_left != current_state_left_left)
    {
       counter_left_left++; 
    }
    // If the Input has shown the same value for long enough let's switch it
    if(counter_left_left >= debounce_count_left_left && !current_state_left_left)
    {
      counter_left_left = 0;
      current_state_left_left = reading_left;
      Serial.println("l");
    }
    if(counter_left_left >= debounce_count_left_left && current_state_left_left)
    {
      current_state_left_left = reading_left;
    }
     time_left = millis();
  }
    //----------
    
}
  

