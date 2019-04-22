module display7segment(
	input [31:0]dataa,
	input [31:0]datab,
	input clk,
	input en,
	
	output reg [6:0]display,
	output cat
);

	assign cat = 1'b1;
	reg [6:0] auxSegment;
	always @(posedge clk) begin
		if(en) begin
			case (datab[3:0])
				 //4'b0000: auxSegment = 7'b1111110;
				 4'b0001: auxSegment = 7'b0110000;
				 4'b0010: auxSegment = 7'b1101101;
				 4'b0011: auxSegment = 7'b1111001;
				 4'b0100: auxSegment = 7'b0110011;
				 4'b0101: auxSegment = 7'b1011011;
				 //4'b0110: auxSegment = 7'b0011111;
				 //4'b0111: auxSegment = 7'b1110000;
				 //4'b1000: auxSegment = 7'b1111111;
				 //4'b1001: auxSegment = 7'b1110011;
				 //4'b1010: auxSegment = 7'b1110111;
				 //4'b1011: auxSegment = 7'b0011111;
				 //4'b1100: auxSegment = 7'b1001110;
				 //4'b1101: auxSegment = 7'b0111101;
				 //4'b1110: auxSegment = 7'b1001111;
				 //4'b1111: auxSegment = 7'b1000111;
				 default: auxSegment = 7'b0000000;
			endcase
		end
		display <= auxSegment[6:0];
	end
endmodule	