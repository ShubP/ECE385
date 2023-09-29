module testbench(

    );
logic [15:0] A;
logic [15:0] B;
logic cin;

logic [15:0] S; 
logic cout;

// Instantiating the DUT
// Make sure the module and signal names match with those in your design
lookahead_adder la0(.*);

// Toggle the clock
// #1 means wait for a delay of 1 timeunit

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program

initial begin: TEST_VECTORS

A = 16'hECEB;
B = 16'h4072;
cin = 0;


end
endmodule
