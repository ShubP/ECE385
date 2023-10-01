module testbench_8();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic Clk = 0;
logic Reset_Load_Clear,Run,Xval;
logic [7:0] SW;
logic [7:0]S;
logic [7:0] Aval,
		 Bval;
logic [7:0] hex_segA;
logic [3:0] hex_gridA;


// Instantiating the DUT
// Make sure the module and signal names match with those in your design
Multiply mult0(.*);	

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS
//S = 8'b00000000;
//#5 SW = 8'b00111011 ;//59
//#2Reset_Load_Clear = 1;		// Toggle Reset
//	// Specify Din, F, and R

//#2 Reset_Load_Clear = 0;
//#2 SW = 8'b00000111;//7
//#2 Run = 1;

//#2 Run = 0;

//#2 #5 SW = 8'b11000101 ;//-59
//#2Reset_Load_Clear = 1;		// Toggle Reset
//	// Specify Din, F, and R

//#2 Reset_Load_Clear = 0;
//#2 SW = 8'b11111001;//-7
//#2 Run = 1;

//#2 Run = 0;

//#5 SW = 8'b00111011 ;//59
//#2Reset_Load_Clear = 1;		// Toggle Reset
//	// Specify Din, F, and R

//#2 Reset_Load_Clear = 0;
//#2 SW = 8'b11111001;//-7
//#2 Run = 1;

//#22 Run = 0;

//#5 SW = 8'b11000101 ;//-59
//#2Reset_Load_Clear = 1;		// Toggle Reset
//	// Specify Din, F, and R

//#2 Reset_Load_Clear = 0;
//#2 SW = 8'b00000111;//7
//#2 Run = 1;

//#2 Run = 0;

#5 SW = 8'h8c ;//-59
#2Reset_Load_Clear = 1;		// Toggle Reset
	// Specify Din, F, and R

#2 Reset_Load_Clear = 0;
#2 SW = 8'h8c;//7
#2 Run = 1;

#2 Run = 0;
end
endmodule
