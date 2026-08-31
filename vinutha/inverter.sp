*transister level inverter experiment

*1.power supplies
v_vdd vdd 0 dc 1.2v
v_in in 0 pulse(0v 1.2v 0ns 0.1ns 0.1ns  5ns 10ns)

*2. transistor connections
*pmos:connected to vdd,gate to 'in',drain to 'out',bulk to vdd
m1 out in vdd vdd pmos_model w=2u l=0.18u

*nmos:connected to 'out',gate to 'in',source to 0(gnd),bulk to 0
m2 out in 0 0 nmos_model w=1u l=0.18u

*3.simulation commands
.tran 0.1ns 20ns
.model nmos_model nmos(vt0=0.4)
.model pmos_model pmos(vt0.4)

.end
