* CMOS invert analog design
VDD vdd 0 DC 1.8
VIN in 0 PULSE(0 1.8 0 1n 1n 5u 10u)
M1 out in vdd vdd PMOS W=2u L=180n
M2 out in 0 0 NMOS W=1u L=180n
.model NMOS NMOS LEVEL=1 VTO=0.7 KP=120u
.model PMOS PMOS LEVEL=1 VTO=-0.7 KP=50u
.tran 10n 30u
.control
run
plot v(in) 
plot v(out)
.endc
.end
