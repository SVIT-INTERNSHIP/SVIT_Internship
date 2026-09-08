*pure analog r-2r dac circuit
vref ref 0 dc 5v

*digital inputs (5v=logic 1,0v=logic 0)
vbit2 b2 0 dc 5v
vbit1 b1 0 dc 0v
vbit0 b0 0 dc 5v

*r-2r ladder network
r1 b0 n1 2k
r2 n1 0 2k
r3 n1 n2 1k
r4 b1 n2 2k
r5 n2 n3 1k
r6 b2 n3 2k
r7 n3 vout 1k

*load resistor 
rload vout 0 2k

*simulation setup:transient analysis
.tran 0.1ns 10ns

.control
run
plot v(vout)

.endc
.end
