module memory (
	input wire wr_enb,
	input wire rd_enb,
	input wire [7:0] wr_data,
	input wire [1:0] addr,
	input wire clk,
	output reg control_drying,
	output reg control_start,
	output reg [1:0] control_preset,
	output reg [7:0] washing_time,
	output reg [7:0] rd_data
);

	reg [7:0] mem [3:0] ;		

	always @ ( posedge clk ) begin
		if (wr_enb) mem[addr] <= wr_data;
	end

	always @ (*) begin
		if (rd_enb) rd_data = mem[addr];
	end

	always @ (*) begin
		control_drying = mem [0] [1];
		control_start = mem [0] [0];
		washing_time = mem [2];
		control_preset = mem [1] [1:0];
	end

endmodule

