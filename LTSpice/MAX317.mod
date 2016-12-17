* MAX317 MACROMODEL
* ------------------------------
* Revision 0, 09/2009
* ------------------------------
* MAX317 features precision CMOS monolithic analog switches.
* ------------------------------
*Note:
**       Macro model is developed using the typical device parameters given in the data sheet with 12V volts power supply.  Model does not take care of the device non-linearity with temperature variations.  Model characteristics may not match actual device behavior at abnormal operating conditions.
** Parameters which are not modeled: 
*  1. Crosstalk
*
* Connections
*      1  = COM
*      2  = N.C
*      3  = GND
*      4  = V+
*      5  = VL
*      6  = IN
*      7  = V-
*      8  = NC
****************
.subckt MAX317 1 2 3 4 5 6 7 8

E_MAX317_E5         VCC 3 MAX317_N12590604 3 1
C_MAX317_C13         3 1  8p  
D_MAX317_D3         MAX317_N12590150 MAX317_N125900381 diodemacro_ideal 
D_MAX317_CO2_D2         3 MAX317_N12589760 diodemacro_mostideal 
G_MAX317_CO2_G1         MAX317_N12589760 3 6 MAX317_N12589884 -1E6
D_MAX317_CO2_D1         MAX317_N12589760 VCCR diodemacro_mostideal 
R_MAX317_R1         MAX317_N12590598 MAX317_N12590604  1k  
D_MAX317_D4         MAX317_N125901040 MAX317_N12590150 diodemacro_ideal 
I_MAX317_I3         1 3 DC 0.1nA  
C_MAX317_C16         8 1  1.3p  
V_MAX317_V2         MAX317_N12589884 3 1.6V
R_MAX317_R5         MAX317_N125901040 MAX317_N12590146  150  
M_MAX317_M12         MAX317_N12590604 MAX317_N12590420 3 3 NJNT L=1u W=2u
M_MAX317_M14         MAX317_N12589732 MAX317_N12590904 3 3 NJNT L=1u W=2u
C_MAX317_C11         3 8  8pF  
E_MAX317_E8         VCCR 3 MAX317_N12589732 3 1
M_MAX317_M13         MAX317_N12590604 MAX317_N12590440 3 3 NJNT L=1u W=2u
M_MAX317_M15         MAX317_N12589732 MAX317_N12590920 3 3 NJNT L=1u W=2u
V_MAX317_V6         MAX317_N12590598 3 41V
I_MAX317_I5         8 3 DC 0.25nA  
E_MAX317_E4         MAX317_N12590150 3 MAX317_N12589760 3 1
R_MAX317_R3         VCC MAX317_N12589732  1k  
I_MAX317_I12         4 3 DC 0.1nA  
M_MAX317_INV2_M1         MAX317_ENC MAX317_N12590146 3 3 NMOS L=1u W=2u
M_MAX317_INV2_M2         MAX317_ENC MAX317_N12590146 VCCR VCCR PMOS L=1u W=4u
E_MAX317_EL1         MAX317_N12590904 3 1 7 -1E3
E_MAX317_EL         MAX317_N12590420 3 MAX317_N12590616 MAX317_N125904761 -1E3
I_MAX317_I13         7 3 DC 0.1nA  
E_MAX317_E9         MAX317_N12589534 MAX317_N12589474 MAX317_ENC 3 2
E_MAX317_EH         MAX317_N12590440 3 MAX317_N12590616 MAX317_N125905001 1E3
E_MAX317_EH1         MAX317_N12590920 3 1 4 1E3
E_MAX317_E6         MAX317_N12590616 MAX317_N12590810 4 3 1
I_MAX317_I2         6 3 DC 5nA  
V_MAX317_V4         3 MAX317_N12589474 41V
I_MAX317_I14         5 3 DC 0.1nA  
R_MAX317_R2         MAX317_N125900381 MAX317_N12590146  120  
V_MAX317_VH         MAX317_N125905001 3 40V
E_MAX317_E7         MAX317_N12590810 3 7 3 -1
M_MAX317_M2         8 MAX317_N12589534 1 MAX317_N12589474 NCHJ L=1u W=12u
V_MAX317_VL         MAX317_N125904761 3 9V
C_MAX317_C1         3 MAX317_N12590146  1n  
C_MAX317_C4         3 MAX317_N12589760  10n  
******************
.model diodemacro_ideal d(n=0.001)
.model diodemacro_mostideal d(IS=1E-12 N=0.000001 BV=42 IBV=1)
.model NJNT nmos(VTO=0.5 KP=50E-2)
.model NMOS nmos(VTO=0.5 KP=100E-6)
.model PMOS pmos(VTO=-0.5 KP=50E-6)
.model NCHJ nmos(VTO=0.5 KP=100E-6 CGDo=2.75E-9)
.ends MAX317
******************


* Copyright (c) 2003-2012 Maxim Integrated Products.  All Rights Reserved.
