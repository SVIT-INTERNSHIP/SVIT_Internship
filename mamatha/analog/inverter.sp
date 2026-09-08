VDD vdd 0 1.8
VIN in 0 PULSE(0 1.8 0 1n 1n 10n 20n)
MP1 out in vdd vdd PMOS W=2u L=0.18u
MN1 out in 0 0 NMOS W=1u L=0.18u
.model NMOS NMOS LEVEL=1 VTO=0.7 KP=120u LAMBDA=0.02
.model PMOS PMOS LEVEL=1 VTO=-0.7 KP=60u LAMBDA=0.02
.tran 0.1n 40n
.end
