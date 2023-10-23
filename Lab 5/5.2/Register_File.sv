`timescale 1ns / 1ps

module Register_File(input logic Clk, LD_REG,Reset,
                     input logic [2:0] DR_REG, SR1, SR2,
                     input logic [15:0] BUS_REG,
                     output logic [15:0] SR1OUT, SR2OUT, R0,R1,R2,R3,R4,R5,R6,R7);
      
        always_ff @ (posedge Clk)
		begin
		if(Reset)
			begin
				R0 <= 16'h0000;
				R1 <= 16'h0000;
				R2 <= 16'h0000;
				R3 <= 16'h0000;
				R4 <= 16'h0000;
				R5 <= 16'h0000;
				R6 <= 16'h0000;
				R7 <= 16'h0000;
			end
		else if(LD_REG)
			begin
				case(DR_REG)
					3'b000 : 			R0 [15:0] <= BUS_REG;
					3'b001 : 			R1 [15:0] <= BUS_REG;
					3'b010 : 			R2 [15:0] <= BUS_REG;
					3'b011 : 			R3 [15:0] <= BUS_REG;
					3'b100 : 			R4 [15:0] <= BUS_REG;
					3'b101 : 			R5 [15:0] <= BUS_REG;
					3'b110 : 			R6 [15:0] <= BUS_REG;
					3'b111 : 			R7 [15:0] <= BUS_REG;		
				endcase
			end
		end
           
           always_comb
		      begin
			case(SR1)
					3'b000 : 			SR1OUT = R0;
					3'b001 : 			SR1OUT = R1;
					3'b010 : 			SR1OUT = R2;
					3'b011 : 			SR1OUT = R3;
					3'b100 : 			SR1OUT = R4;
					3'b101 : 			SR1OUT = R5;
					3'b110 : 			SR1OUT = R6;
					3'b111 : 			SR1OUT = R7;
					default: 			SR1OUT = 16'hxxxx ;
			endcase
			
		
			case(SR2)
					3'b000 : 			SR2OUT = R0;
					3'b001 : 			SR2OUT = R1;
					3'b010 : 			SR2OUT = R2;
					3'b011 : 			SR2OUT = R3;
					3'b100 : 			SR2OUT = R4;
					3'b101 : 			SR2OUT = R5;
					3'b110 : 			SR2OUT = R6;
					3'b111 : 			SR2OUT = R7;
					default: 			SR2OUT = 16'hxxxx;
			endcase
		end
endmodule 

