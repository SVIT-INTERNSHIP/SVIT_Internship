module encoder2 (
input I0,
input I1,
output reg Y
);
always @(*) begin

case ({I0,I1})

2'b00: Y=1'b0;
2'b10: Y=1'b1;
2'b01: Y=1'b0;
2'b11: Y=1'b1;

default: Y=1'bx;
endcase
end
endmodule
