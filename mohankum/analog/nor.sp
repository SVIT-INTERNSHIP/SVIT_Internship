VDD vdd 0 DC 1.8
VA A 0 PULSE(0 1.8 0 1n 1n 10n 20n)
VB B 0 PULSE(0 1.8 0 1n 1n 20n 40n)
MP1 out A n1 vdd PMOS W=2u L=0.18u
MP2 n1 B vdd vdd PMOS W=2u L=0.18u
MN1 out A 0 0 NMOS W=1u L=0.18u
MN2 out B 0 0 NMOS W=1u L=0.18u
.model PMOS PMOS (LEVEL=1 VTO=-0.7 KP=50u)
.model NMOS NMOS (LEVEL=1 VTO=0.7 KP=100u)
.tran 0.1n 80n
.end
