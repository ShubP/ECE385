module adder
(
	input  logic [7:0] A, 
	input  logic [7:0] B,
	input  logic cin,
	output logic [7:0] S_Add,
	output logic cout,X_Add
);
    module full_adder
    (
        input logic x,y,z,
        output logic s,c
    );
        assign s = x^y^z;
        assign c = (x&y)|(y&z)|(x&z);
    endmodule
    
    logic c1,c2,c3,c4,c5,c6,c7,c8;
     
    
    full_adder FA0(.x(A[0]),.y(B[0]),.z(cin),.c(c1),.s(S_Add[0]));
    full_adder FA1(.x(A[1]),.y(B[1]),.z(c1),.c(c2),.s(S_Add[1]));
    full_adder FA2(.x(A[2]),.y(B[2]),.z(c2),.c(c3),.s(S_Add[2]));
    full_adder FA3(.x(A[3]),.y(B[3]),.z(c3),.c(c4),.s(S_Add[3]));
    full_adder FA4(.x(A[4]),.y(B[4]),.z(c4),.c(c5),.s(S_Add[4]));
    full_adder FA5(.x(A[5]),.y(B[5]),.z(c5),.c(c6),.s(S_Add[5]));
    full_adder FA6(.x(A[6]),.y(B[6]),.z(c6),.c(c7),.s(S_Add[6]));
    full_adder FA7(.x(A[7]),.y(B[7]),.z(c7),.c(c8),.s(S_Add[7]));
    full_adder FA8(.x(A[7]),.y(B[7]),.z(c8),.c(cout),.s(X_Add));
    
endmodule