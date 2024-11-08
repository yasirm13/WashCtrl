module memory_fsm (
	input wire cs,
	input wire wr_en,
	input wire rd_en,
	input wire clk,
	input wire reset,
	output reg  wr_enb,
	output reg  rd_enb
);

	parameter [1:0] IDLE= 2'b00,
					ACTIVE = 2'b01,
					READ = 2'b10,
					WRITE = 2'b11;


	reg [2:0] pstate, nstate;

	always @(*) begin

		begin : NSL
			case ( pstate)
				IDLE : nstate= (cs&&~wr_en&&~rd_en) ? ACTIVE : IDLE;
				ACTIVE : nstate= (cs&&wr_en) ? WRITE : ( (cs&&rd_en) ? READ : IDLE  );
				WRITE : nstate=IDLE;
				READ : nstate=IDLE;
			endcase
		end : NSL
			
		begin : OL
			case (pstate)
				IDLE : begin
					wr_enb=0;
					rd_enb=0;
				end
				ACTIVE :  begin
					wr_enb=0;
					rd_enb=0;
				end				
				WRITE :  begin
					wr_enb=1;
					rd_enb=0;
				end
				READ :  begin
					wr_enb=0;
					rd_enb=1;
				end
			endcase 
		end : OL
	end 



	always @ ( posedge clk, posedge reset ) begin
		if (reset) pstate <= 2'b0;
		else pstate <= nstate; 
	end


endmodule