Simulink Files:

-CSK_Std_PulseTrain.slx (added 09-25-2016)
	
	The model for the standard chaotic shift key (CSK) system. Contains both transmitter and receiver. Uses an alternating pulse train

-CSK_TS_MOD_Message.slx (added 09-26-2016)

	The model for the Time Shifted CSK (CSK-TS) system. Time shift is realized with a modulus operation. Takes a predetermined message input rather than an alternating pulse train

-CSK_TS_MOD_	(added 09-26-2016)

	The model for the CSK-TS system. Realized with a modulus operation. Uses an alternating pulse train.






Matlab .m files:

-RTM.m													(added 09-26-2016)	(modified 09-27-2016)
	
	The Return Map function

	[a1,a0,b1,b0,max,min] = RTM(s,m)
		
	INPUTS
		s = signal input, 1 dimensional vector, typically the transmitted state x1

		m = Original message signal

	OUTPUTS
		
		a1 = max + min @ m = 1
		
		a0 = max + min @ m = 0
				
		b1 = max - min @ m = 1

		b0 = max - min @ m = 0

		max = all the local maxima of value vector s

		min = all the local minima of value vector s


-LoadText.m												(added 09-26-2016)

	Function for loading in and setting up a message signal from an ASCII text file

	[message] = LoadText(fName,freq)

	INPUTS
		fName = File Name of desired ASCII signal

		freq = signal running frequency

	OUTPUTS

		message = 2xN array with one column the time, and the next the bit value

-ProcessSync.m												(added 09-26-2016)	

	Function processes the syncronization error signal into a readable bit stream (i.e. message extraction)

	[pdata] = ProcessSync(t,sync,freq,weight,cut)

	INPUTS
		t = Time vector from simulation

		sync = Syncronization signal vector

		freq = signal running frequecny (message frequnecy/baud)

		weight = Center weighting (0 - 1 value)

		cut = level cutoff point for 0 or 1 bit

	OUTPUTS

		pdata = decrypted/extracted signal


-ErrChk.m												(added 09-26-2016)
	
	Function processes extracted message error against original message

	[allbits,misses,hits,lowmiss,bitmiss] = ErrChk(t,pdata,m,freq)

	INPUTS
		t = Time Vector

		pdata = extracted message vector

		m = original message vector

		freq = message baud rate

	OUTPUTS

		allbits = total number of bits

		misses = total number of missed bits

		hits = total number of non missed bits

		lowmiss = missed bit on a 0 value in message

		bitmiss = missed bit on a 1 value in message
		

-buildfile.m												(added 09-26-2016)

	FUnction that takes extracted message and saves to text file as ASCII message

	[] = buildfile(fName,t,pdata,freq)

	INPUTS

		fName = file name to save to

		t = Time Vector

		pdata = extracted message vector

		freq = message baud rate


-SetupConstants.m

        Script file that sets up the constants of the systems.

        Message constants:
	
		delay: For alternating message (pulse train) initial delay till first bit transition (improve immediate synchronization)

		freq: message frequency

        System constants:

		sig: Sigma gain
           
		rho: Rho gain

		beta: beta gain in CSK-TS, beta modulator in std CSK (values are beta1 = beta+.5, beta2 = beta)

		DGain/DOffset: Setup such as that in CSK-TS Delta 0 = DOffset + DGain, and Delta 1 = DOffset

		hGain: h multiplier from CSK-TS system

	Other Constants:

		x0/z0: System initial conditions

		NPower: Transmission noise power (should be << 1)	

-savefileforRTM.m

	Script to save the RTM file in tab deliminated text


	Structure of text file:

	a0 /t b0 /t a1 /t b1 /n 