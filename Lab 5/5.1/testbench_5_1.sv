module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.


logic [15:0] SW;
logic	Clk, Reset, Run, Continue;
logic [7:0] hex_seg;
logic [3:0] hex_grid;
logic [7:0] hex_segB;
logic [3:0] hex_gridB;
logic [15:0] LED;
//logic [6:0] HEX0, HEX1, HEX2, HEX3;
assign Reset = Run & Continue;
//logic [15:0] ans;

slc3_sramtop slc3_testtop0(.*);

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


//press reset and release reset (press run and continue at the same time)
//wait a bit
//press run, release run
//wait a bit
//press continue, release continue
//wait a bit
//press continue again (can repeat multiple times)




// ----------IO Test 1----------

Run = 1;
Continue = 1;

#2
Run = 0;
Continue = 0;
SW [15:0] = 16'b0000000000000000;

#2 Run = 1;
#2 Run =0 ;

#20 Continue =1;	

#2 Continue = 0;

//#20 Continue =1;	

//#2 Continue = 0;

//#20 Continue =1;	

//#2 Continue = 0;

//#20 Continue =1;	

//#2 Continue = 0;





//// --------IO Test 2---------

//#2
//Run = 0;
//Continue = 0;

//#2
//Run = 1;
//Continue = 1;



//#6 Run = 0;
//#2 Run = 1;		

//#100
//SW [9:0] = 10'b0000000111;

//#6 Continue = 0;
//#2 Continue = 1;	


//#100
//SW [9:0] = 10'b0000001000;

//#6 Continue = 0;
//#2 Continue = 1;	


//#100
//SW [9:0] = 10'b0000001010;

//#6 Continue = 0;
//#2 Continue = 1;	


//#100
//SW [9:0] = 10'b0000001011;

//#6 Continue = 0;
//#2 Continue = 1;	

////// ----------IO Test 3 -----------
////
////#2
////Run = 0;
////Continue = 0;
////
////#2
////Run = 1;
////Continue = 1;
////
////
////#10
////SW [9:0] = 10'b0000000111;
////
////#6 Continue = 0;
////#2 Continue = 1;	
////
////
////#10
////SW [9:0] = 10'b0000001000;
////
////#6 Continue = 0;
////#2 Continue = 1;	
////
////
////#10
////SW [9:0] = 10'b0000011000;
////
////#6 Continue = 0;
////#2 Continue = 1;	


end
endmodule