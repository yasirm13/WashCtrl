module comparator (
	input wire [7:0] washing_time,
	input wire [1:0] control_preset,
	input wire [7:0] count,
	output reg comp_time,
	output reg comp_time2
);

	always @ (*) begin
		case ( control_preset ) 
			2'b00 : comp_time = (washing_time == count);
			2'b01 : comp_time = (10 == count);
			2'b10 : comp_time = (16 == count);
			2'b00 : comp_time = (21 == count);
		endcase
	end

	always @ (*) begin
		comp_time2 = (count == 5);
	end
endmodule
