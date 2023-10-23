
module ALUUnit (input logic [1:0] ALUK,
           input logic [15:0] SR1OUT, SR2MUXOUT,
           output logic [15:0] ALUOUT);
       always_comb
			begin
				case (ALUK)
				
					2'b00 : ALUOUT = SR2MUXOUT + SR1OUT;
					2'b01 : ALUOUT = SR2MUXOUT & SR1OUT;
					2'b10 : ALUOUT = ~SR1OUT;
					2'b11 : ALUOUT = SR1OUT;
					default: ALUOUT = 16'hxxxx;
				endcase
			end    
       
endmodule
