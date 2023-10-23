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

//logic [15:0] ans;

slc3_testtop slc3_testtop0(.*);

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




//// ----------Test 3----------
//#2 Continue = 0;
//Reset = 1;
//#2 Reset = 0;

//#3 SW [15:0] = 16'h000B;
//#2 Run = 1;
//#2 Run = 0;

//#80 Continue = 1;
//#3 Continue = 0;

//#120 Continue = 1;
//#3 Continue = 0;

//#120 Continue = 1;
//#3 Continue = 0;

//// ----------Test 4----------
//#2 Continue = 0;
//Reset = 1;
//#2 Reset = 0;

//#3 SW [15:0] = 16'h009C;
//#2 Run = 1;
//#2 Run = 0;

//// ----------Test 5----------
//#2 Continue = 0;
//Reset = 1;
//#2 Reset = 0;

//#3 SW [15:0] = 16'h0014;
//#2 Run = 1;
//#2 Run = 0;

//#80 SW[15:0] = 16'hF0FF;
//#20 Continue = 1;
//#2 Continue = 0;

//#50 SW[15:0] = 16'h00F0;
//#10 Continue = 1;
//#2 Continue = 0;

//Expected Result of F00F after XOR

//// ----------Test 6----------
//#2 Continue = 0;
//Reset = 1;
//#2 Reset = 0;

//#3 SW [15:0] = 16'h0031;
//#2 Run = 1;
//#2 Run = 0;

//#160 SW[15:0] = 16'h0005;
//#14 Continue = 1;
//#2 Continue = 0;

//#50 SW[15:0] = 16'h0002;
//#14 Continue = 1;
//#2 Continue = 0;

//Expected Result of 000A after Multiply

//// ----------Test 7----------
#2 Continue = 0;
Reset = 1;
#2 Reset = 0;

#3 SW [15:0] = 16'h005A;
#2 Run = 1;
#2 Run = 0;

#140 SW[15:0] = 16'h0003;
#14 Continue = 1;
#2 Continue = 0;

#385 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#190 Continue = 1;
#2 Continue = 0;

#175 SW[15:0] = 16'h0002;
#10 Continue = 1;
#2 Continue = 0;

#27400 SW[15:0] = 16'h0003;
#10 Continue = 1;
#2 Continue = 0;

#385 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#175 Continue = 1;
#2 Continue = 0;
#190 Continue = 1;
#2 Continue = 0;

end
endmodule