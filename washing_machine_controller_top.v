module washing_machine_controller_top (
	input wire cs,
	input wire wr_en,
	input wire rd_en,
	input wire [7:0] wr_data,
	input wire [1:0] addr,
	input wire door,
	input wire clk,
	input wire reset,
	output wire [7:0] rd_data,
	output wire  washing_done,
	output wire light,
	output wire water_pump,
	output wire paused,
	output wire drying_fan
);

wire wr_enb;
wire rd_enb;
wire control_drying;
wire control_start;
wire [1:0] control_preset;
wire [7:0] washing_time;
wire [7:0] count;
wire comp_time;
wire comp_time2;


comparator comparator1 (
	.washing_time(washing_time),
	.control_preset(control_preset),
	.count(count),
	.comp_time(comp_time),
	.comp_time2(comp_time2)
);

memory_fsm memory_fsm1 (
	.cs(cs),
	.wr_en(wr_en),
	.rd_en(rd_en),
	.clk(clk),
	.reset(reset),
	.wr_enb(wr_enb),
	.rd_enb(rd_enb)
);



washing_fsm washing_fsm1 (
	.door(door),
	.control_drying(control_drying),
	.control_start(control_start),
	.comp_time(comp_time),
	.comp_time2(comp_time2),
	.clk(clk),
	.reset(reset),
	.washing_done(washing_done),
	.light(light),
	.water_pump(water_pump),
	.paused(paused),
	.drying_fan(drying_fan),
	.clear(clear)
);


 memory memory1 (
	.wr_enb( wr_enb ),
	.rd_enb ( rd_enb ),
	.wr_data (wr_data),
	.addr(addr),
	.clk(clk),
	.control_drying(control_drying),
	.control_start(control_start),
	.control_preset(control_preset),
	.washing_time(washing_time),
	.rd_data(rd_data)
);





 counter counter1 (
	.clear(clear),
	.clk(clk),
	.reset(reset),
	.count(count) 
);

endmodule