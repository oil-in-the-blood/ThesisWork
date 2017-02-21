const int msgPIN = 12;
const int trgPIN = 13;
const int stream[8] = {128,64,32,16,8,4,2,1};

String cmdString = "";
String propString = "";
String buffString = "";
char char2send = 'G';
char cmdCHAR = 0;

float period = 1000;
float width = 1;
unsigned long preCLK = 0;


boolean CMDReady = false;
boolean startsend = false;
int msgARRAY[2] = {HIGH,LOW};

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
			case '!':
				startsend = true;
				break;
				
	}
	if (startsend)
	{
    BuildSend();
		int count = 0;
    int look = 0;
		preCLK = millis();
		digitalWrite(trgPIN,LOW);
		digitalWrite(msgPIN,msgARRAY[0]);
//    Serial.print(msgARRAY[0]);
//    Serial.print('-');
//    Serial.print(preCLK);
		delay(250);
		digitalWrite(trgPIN,HIGH);
		while(startsend)
		{
//      Serial.print(count);
//      Serial.print('-');
//      Serial.print(millis()-preCLK);
//      Serial.print('\n');
			if(count < 20)
			{
				else
				{
					if(millis()-preCLK > period)
					{
						count++;
            look++;
            if(look > 1)
            {
              look = 0;
            }
						digitalWrite(msgPIN,msgARRAY[count]);
//            Serial.println(msgARRAY[count]);
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
      digitalWrite(trgPIN,LOW);
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
