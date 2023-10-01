module reg_16 (input logic Clk, Reset, Load,
					input logic [15:0] DIn,
					output logic [15:0] DOut
					);

always_ff @ (posedge Clk) 
	begin
		if(Reset)
		begin
			DOut <= 16'h0000;
		end
			else if(Load)
			begin
				DOut <= DIn;
			end
	end
endmodule