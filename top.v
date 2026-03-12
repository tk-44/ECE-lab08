module mux(
    input [3:0] CEO, You, Fred, Jill,
    input [1:0] Sel,
    input Enable,
    output [3:0] Y
);

    assign Y = (~Enable) ?4'b0000: 
    (Sel == 2'b00) ?CEO :
    (Sel == 2'b01) ?You :
    (Sel == 2'b10) ?Fred :Jill;
     
endmodule

module demux(
    input [3:0] In,
    input [1:0] Sel,
    input Enable,
    output [3:0] Local_Lib,
    output [3:0] FireDept,
    output [3:0] School,
    output [3:0] RibShack
);

    assign Local_Lib = (Enable && Sel == 2'b00) ? In : 4'b0000; 
    assign FireDept = (Enable && Sel == 2'b01) ? In : 4'b0000; 
    assign School = (Enable && Sel == 2'b10) ? In : 4'b0000; 
    assign RibShack = (Enable && Sel == 2'b11) ? In : 4'b0000; 

endmodule

module top (
input [15:0] sw,
input btnL, btnU,
input btnD, btnR, 
input btnC,
output [15:0] led
);

wire [1:0] muxSel;
wire [1:0] demuxSel;
wire [3:0] bus;

assign muxSel = {btnU, btnL};
assign demuxSel = {btnR, btnD};

mux my_mux (
.CEO(sw[3:0]),
.You(sw[7:4]),
.Fred(sw[11:8]),
.Jill(sw[15:12]),
.Sel(muxSel),
.Enable(btnC),
.Y(bus)
);

demux my_demux (
.In(bus),
.Sel(demuxSel),
.Enable(btnC),
.Local_Lib(led[3:0]),
.FireDept(led[7:4]),
.School(led[11:8]),
.RibShack(led[15:12])
);

endmodule


 