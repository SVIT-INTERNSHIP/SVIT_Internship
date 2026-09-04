VDD vdd 0 DC 1.8
VIN in 0 PULSE(0 1.8 0 1n 1n 5n 10n)
MP1 out in vdd vdd PMOS W=2u L=0.18u
MN1 out in 0 0 NMOS W=1u L=0.18u
.model PMOS PMOS (LEVEL=1 VTO=-0.7 KP=50u)
.model NMOS NMOS (LEVEL=1 VTO=0.7 KP=100u)
.tran 0.1n 30n
.control
run
plot v(in) v(out)
.endc
.end
