const int msgPIN = 12;
const int trgPIN = 13;
const int stream[8] = {128,64,32,16,8,4,2,1};

String cmdString = "";
String propString = "";
String buffString = "";
char char2send = 'G';
char cmdCHAR = 0;
char mode = 0;

float period = 1000;
float width = 1;
unsigned long preCLK = 0;


boolean CMDReady = false;
boolean startsend = false;
boolean pulsesend = false;
int msgARRAY[9] = {LOW,LOW,LOW,LOW,LOW,LOW,LOW,LOW,LOW};

void BuildSend()
{
  char next = 0;
  for (int i = 0;i < 8;i++)
  {
    next = char2send/stream[i];
    if(next%2 == 1)
    {
      msgARRAY[i] = HIGH;
    }
    else
    {
      msgARRAY[i] = LOW;
    }
  }
}

void setup()
{
	// start serial
	Serial.begin(9600);
	cmdString.reserve(10);
	propString.reserve(10);
	buffString.reserve(10);
	pinMode(msgPIN, OUTPUT);
	pinMode(trgPIN, OUTPUT);
	digitalWrite(trgPIN,HIGH);
}
void loop()
{
	if (CMDReady)
	{
		CMDReady = false;
		
		switch (cmdCHAR) {
			case 'f':
				if(propString.toInt() > 0)
				{
					period = (float)propString.toInt();
				}
				break;
			case 'm':
				char2send = propString.charAt(0);
//        Serial.println(propString.charAt(0));
				break;
			case 'w':
				if(propString.toInt() > 0)
				{
					width = ((float)propString.toInt())/100;
//          Serial.println(width);
				}
				break;
      case 'd':
        if(propString.toInt() == 1)
        {
          mode = 1;
        }
        else
        {
          mode = 0;
        }
        break;
			case '!':
        if(mode == 0)
        {
				  startsend = true;
        }
        else
        {
          pulsesend = true;
        }
				break;
				
	}
	}
	if (startsend)
	{
    BuildSend();
		int count = 0;
		preCLK = millis();
		digitalWrite(trgPIN,LOW);
		digitalWrite(msgPIN,msgARRAY[0]);
		delay(250);
		digitalWrite(trgPIN,HIGH);
		while(startsend)
		{
			if(count < 8)
			{
				if(width < 1 && width > 0)
				{
					if(millis()-preCLK > period*width && millis()-preCLK < period)
					{
						digitalWrite(msgPIN,LOW);
					}
					else if(millis()-preCLK > period)
					{
						count++;
						digitalWrite(msgPIN,msgARRAY[count]);
						preCLK = millis();
					}
				}
				else
				{
					if(millis()-preCLK > period)
					{
						count++;
						digitalWrite(msgPIN,msgARRAY[count]);
						preCLK = millis();
					}	
				}
			}
			else
			{
				startsend = false;
			}
		}
	}
   
  if (pulsesend)
  {
    int count = 0;
    int look = LOW;
    preCLK = millis();
    digitalWrite(trgPIN,LOW);
    digitalWrite(msgPIN,look);
    delay(250);
    digitalWrite(trgPIN,HIGH);
    while(pulsesend)
    {
      if(count < 20)
      {
          if(millis()-preCLK > period)
          {
            count++;
            if(look == LOW)
            {
              look = HIGH;
            }
            else
            {
              look = LOW;
            }
            digitalWrite(msgPIN,look);
            preCLK = millis();
          } 
      }
      else
      {
        pulsesend = false;
      }
    }
	}
}

void serialEvent()
{
	char inChar = (char)Serial.read();
	
	if (inChar == ':')
	{
		cmdString = buffString;
		buffString = "";
		
		if(cmdString == "period")
		{
			cmdCHAR = 'f';
		}
		else if(cmdString == "message")
		{
			cmdCHAR = 'm';
		}
		else if(cmdString == "width")
		{
			cmdCHAR = 'w';
		}
    else if(cmdString == "mode")
    {
      cmdCHAR = 'd';
    }
		else
		{
			cmdCHAR = 0;
		}
		
	}
	else if(inChar == '\n')
	{
    //digitalWrite(trgPIN,LOW);
		propString = buffString;
		buffString = "";
		//Serial.println(propString);
    //Serial.println(propString.length());
		if(propString == "start")
		{
      //digitalWrite(trgPIN,LOW);
			CMDReady = true;
			cmdCHAR = '!';
		}
		else
		{
			if(cmdCHAR == 0 || propString == "")
			{
				propString = "";
				CMDReady = false;
			}
			else
			{
				CMDReady = true;
			}
		}
	}
	else
	{
		buffString += inChar;
	}
}
