module washing_machine_controller_top_tb;

	reg cs;
	reg wr_en;
	reg rd_en;
	reg [7:0] wr_data;
	reg [1:0] addr;
	reg door;
	reg clk=0;
	reg reset;
	wire [7:0] rd_data;
	wire  washing_done;
	wire light;
	wire water_pump;
	wire paused;
	wire drying_fan;



	always #10 clk=~clk;

	initial begin
		cs <= 0;
		wr_en <= 0;
		rd_en <= 0;
		wr_data <= 0;
		addr <= 0;
		door <= 0;
		reset <= 0;
		
		


	end

endmodule
