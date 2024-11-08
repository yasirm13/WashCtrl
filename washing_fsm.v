module washing_fsm (
	input wire door,
	input wire control_drying,
	input wire control_start,
	input wire comp_time,
	input wire comp_time2,
	input wire clk,
	input wire reset,
	output reg  washing_done,
	output reg light,
	output reg water_pump,
	output reg paused,
	output reg drying_fan,
	output reg clear
);

	parameter [2:0] IDLE= 3'b000,
					WASHING = 3'b001,
					LIGHT = 3'b010,
					PAUSED = 3'b011,	
					WASHED = 3'b100,
					DRYING = 3'b101;

	reg [2:0] pstate, nstate;

	always @(*) begin

		begin : NSL
			case ( pstate)
				IDLE :	nstate=door?(control_start? WASHING: IDLE) : LIGHT;		
				WASHING : nstate=(~door) ? PAUSED : (comp_time? (control_drying ? DRYING : WASHED) : WASHING );
				LIGHT : nstate= door ? IDLE : LIGHT;
				PAUSED : nstate=door ? WASHING : PAUSED;
				WASHED : nstate= door ? WASHED : IDLE;
				DRYING : nstate= comp_time2 ? IDLE : DRYING;				
			endcase
		end : NSL


		begin : OL
			case ( pstate)
				IDLE : begin
					washing_done=0;
					light=0;
					water_pump=0;
					paused=0;
					drying_fan=0;
					clear=1;   		
				end
			
				LIGHT : begin
					washing_done=0;
					light=1;
					water_pump=0;
					paused=0;
					drying_fan=0;
					clear=0;   		
				end

				WASHING : begin
					washing_done=0;
					light=1;
					water_pump=1;
					paused=0;
					drying_fan=0;
					clear=comp_time;   		
				end

				PAUSED : begin
					washing_done=0;
					light=0;
					water_pump=0;
					paused=1;
					drying_fan=0;
					clear=comp_time;   		
				end
				
				DRYING : begin
					washing_done=1;
					light=0;
					water_pump=0;
					paused=0;
					drying_fan=1;
					clear=comp_time2;   		
				end


				WASHED : begin
					washing_done=1;
					light=0;
					water_pump=0;
					paused=0;
					drying_fan=0;
					clear=1;   		
				end
			endcase

		end :OL

	end 


	always @ ( posedge clk, posedge reset ) begin
		if (reset) pstate <= 3'b0;
		else pstate <= nstate; 
	end


endmodule
