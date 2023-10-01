`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Course: ECE385 FA23 
// Engineers: shubbp2, ykko2
// 
// Design Name: 8-bit Multiplier in System Verilog
// Module Name: Multiply(Top-level)
//////////////////////////////////////////////////////////////////////////////////


module Multiply(input Clk, Reset_Load_Clear, Run, 
						input  logic [7:0] SW,
                        output logic [7:0] hex_segA,
                        output logic [3:0] hex_gridA,
                        output logic [7:0] Aval, Bval,
                        output logic       Xval
					   );

    // Declare temporary values used by other modules
	   logic Reset_SH, Run_SH; //FPGA sync high  button inputs
	   logic [7:0] SW_SH;       //FPGA sync high switch inputs
	   logic [7:0] SW_sub;
	//Out;
	   logic Reset_A, Reset_X, Ld_A, A_Clear, Add_En, sub, Shift_En; //outputs from Control unit
	   logic Shift_Out_A,Shift_Out_B; //outputs from Reg Unit
	   logic [7:0] S;
	   logic S_X, cout, Xval_reset; //outputs from 9-bit Adder
        	 	
	// Misc logic
        assign SW_sub = {sub ^ SW_SH[7], sub ^ SW_SH[6],
                         sub ^ SW_SH[5], sub ^ SW_SH[4],  sub ^ SW_SH[3],
                         sub ^ SW_SH[2],  sub ^ SW_SH[1],  sub ^ SW_SH[0]};
        assign ResetA = (Reset_SH | Reset_A);
        assign ResetX = (Reset_SH | Reset_X);
        always_ff @ (posedge Clk)  
            begin
                if (ResetX)
                Xval= 1'b0;
                if (Add_En)
                Xval = S_X;
            end
            

		
    //Control unit allows the register to load once, and not during full duration of button press
      control run_once (.Clk,.Reset_A, .Reset_X, .Ld_A,.Run(Run_SH),
		                  .sub,.Add_En, .Shift_En, .Reset(Reset_SH),
		                  .M(Bval[0]));
        
    //Addition unit
      adder ad1        (.A(Aval[7:0]), .B(SW_sub [7:0]), .cin(sub), 
                          .cout(cout), .S_Add(S[7:0]),.X_Add(S_X));
	//Registers A B	 
      reg_8 reg_A (.Clk,.Reset(ResetA),.D(S[7:0]), .Shift_In(Xval), .Load(Ld_A),
	               .Shift_En, .Shift_Out(A_out), .Data_Out(Aval));
	  
	  reg_8 reg_B (.Clk,.Reset(1'b0),.D(SW_SH[7:0]), .Shift_In(Aval[0]),.Load(Reset_SH),
	               .Shift_En, .Shift_Out(B_out), .Data_Out(Bval));
		

		// Hex units that display contents of A and B in hex
	    HexDriver HexA (
			.clk(Clk),
			.reset(Reset_SH),
			.in({Aval[7:4],  Aval[3:0], Bval[7:4], Bval[3:0]}),
			.hex_seg(hex_segA),
			.hex_grid(hex_gridA)
		);

								
		
		
		sync button_sync[1:0] (Clk, {Reset_Load_Clear,Run}, {Reset_SH,Run_SH});
	    sync SW_sync[7:0] (Clk, SW, SW_SH);
endmodule
