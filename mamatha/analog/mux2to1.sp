VDD vdd 0 1.8

VD0 d0 0 PULSE(0 1.8 0 1n 1n 20n 40n)
VD1 d1 0 PULSE(0 1.8 0 1n 1n 40n 80n)
VS s 0 PULSE(0 1.8 0 1n 1n 40n 80n)

MP1 sbar s vdd vdd PMOS W=2u L=0.18u
MN1 sbar s 0 0 NMOS W=1u L=0.18u

MN2 out d0 sbar 0 NMOS W=1u L=0.18u
MP2 out d0 s vdd PMOS W=2u L=0.18u

MN3 out d1 s 0 NMOS W=1u L=0.18u
MP3 out d1 sbar vdd PMOS W=2u L=0.18

.model NMOS NMOS LEVEL=1 VTO=0.7 KP=120u LAMBDA=0.02
.model PMOS PMOS LEVEL=1 VTO=-0.7 KP=60u LAMBDA=0.02

.tran 0.1n 80n
.end



