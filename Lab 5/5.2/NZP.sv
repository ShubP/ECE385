module NZP_reg(input logic Clk, Reset, Load,
					input logic [15:0] DIn,
					output logic [2:0] DOut
					);
always_ff @ (posedge Clk)
    begin
	 	if (Reset) 
                begin
                    DOut <= 3'h0; // updated when gets to next clock cycle
                end 			
		else  if (Load) 
                begin 
                    if (DIn[15]) 
                        begin
                            DOut <= 3'b100;
                        end 
                    else if (DIn == 16'h0000) 
                        begin 
                            DOut <= 3'b010;
                        end 
                    else 
                        begin 
                            DOut <= 3'b001; 
                    end
                end  
    end
endmodule

// For direct implementation into slc3 without NZP file.
// Can make slc3 schematic more congested if directly implemented in slc3.sv
