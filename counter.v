module counter (
	input wire clear,
	input wire clk,
	input wire reset,
	output reg [7:0] count 
);

	
	always @ ( posedge clk , posedge reset ) begin
		if ( reset )
			count <= 8'b0;
		else 
			count = clear ? 8'b0 : count+1;
	end



endmodule
