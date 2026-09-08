
VDD vdd 0 1.8
VA a 0 PULSE(0 1.8 0 1n 1n 10n 20n)
VB b 0 PULSE(0 1.8 0 1n 1n 20n 40n)
MP1 out a vdd vdd PMOS W=2u L=0.18u
MP2 out b vdd vdd PMOS W=2u L=0.18u

MN1 out a n1 0 NMOS W=1u L=0.18u
MN2 n1 b 0 0 NMOS W=1u L=0.18u
.model NMOS NMOS LEVEL=1 VTO=0.7 KP=120u LAMBDA=0.02
.model PMOS PMOS LEVEL=1 VTO=-0.7 KP=60u LAMBDA=0.02

.tran 0.1n 80n
.end
