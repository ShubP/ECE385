module BEN_reg(input logic Clk, Reset, Load,
					input logic [2:0] IRIn,NZPIn,
					output logic DOut
					);
always_ff @ (posedge Clk)
    begin
	 	if (Reset) 
                begin
                    DOut <= 1'b0; 
                end 			
		else  if (Load) 
                begin 
                    DOut <= (IRIn[2] & NZPIn[2]) | (IRIn[1] & NZPIn[1]) | (IRIn[0] & NZPIn[0]) ;
                end
    end
endmodule
