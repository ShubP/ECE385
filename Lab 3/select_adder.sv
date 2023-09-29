module select_adder (   
	input  [15:0] A, B,
	input         cin,
	output logic [15:0] S,
	output logic  cout
);
    module mux_sa (input [3:0] DinA,DinB, //2-1mux
                   input logic sel,
                   output logic [3:0] Dout);
        always_comb
        begin
            case (sel)
            1'b1 : Dout = {DinA[3],DinA[2],DinA[1],DinA[0]};
            default : Dout = {DinB[3],DinB[2],DinB[1],DinB[0]};
            endcase
        end
    endmodule
    
    module CRA4bit         //4-bit carry ripple adder with final carry out output
    (
        input[3:0] x,y,
        input z,
        output logic [3:0] s,
        output logic CRA_c
    );
    logic [3:0] c;
    assign s[0] = x[0]^ y[0] ^ z;
    assign c[0] = (x[0]& y[0])|(y[0]&z)|(x[0]&z);
    assign s[1] = x[1]^ y[1] ^ c[0];
    assign c[1] = (x[1]&y[1])|(y[1]&c[0])|(x[1]&c[0]);
    assign s[2] = x[2]^ y[2] ^ c[1];
    assign c[2] = (x[2]&y[2])|(y[2]&c[1])|(x[2]&c[1]);
    assign s[3] = x[3]^ y[3] ^ c[2];
    assign c[3] = (x[3]&y[3])|(y[3]&c[2])|(x[3]&c[2]);
    assign CRA_c = c[3];
    
    endmodule  

logic[3:0] CRAout1a,CRAout1b,CRAout2a,CRAout2b,CRAout3a,CRAout3b; 
logic c4,c8,c12,or1,and1a,or2,and2a,or3,and3a;
CRA4bit cra1(.x(A[3:0]),.y(B[3:0]),.z(cin),.s(S[3:0]),.CRA_c(c4));

CRA4bit cra2a(.x(A[7:4]),.y(B[7:4]),.z(0),.s(CRAout1a[3:0]),.CRA_c(or1));
CRA4bit cra2b(.x(A[7:4]),.y(B[7:4]),.z(1),.s(CRAout1b[3:0]),.CRA_c(and1a));
assign c8 = or1 | (and1a & c4);
 
CRA4bit cra3a(.x(A[11:8]),.y(B[11:8]),.z(0),.s(CRAout2a[3:0]),.CRA_c(or2));
CRA4bit cra3b(.x(A[11:8]),.y(B[11:8]),.z(1),.s(CRAout2b[3:0]),.CRA_c(and2a));
assign c12 = or2 | (and2a & c8);
 
CRA4bit cra4a(.x(A[15:12]),.y(B[15:12]),.z(0),.s(CRAout3a[3:0]),.CRA_c(or3));
CRA4bit cra4b(.x(A[15:12]),.y(B[15:12]),.z(1),.s(CRAout3b[3:0]),.CRA_c(and3a));
assign cout = or3 | (and3a & c12);

mux_sa mux1(.DinA(CRAout1b[3:0]),.DinB(CRAout1a[3:0]),.sel(c4),.Dout(S[7:4]));
mux_sa mux2(.DinA(CRAout2b[3:0]),.DinB(CRAout2a[3:0]),.sel(c8),.Dout(S[11:8]));
mux_sa mux3(.DinA(CRAout3b[3:0]),.DinB(CRAout3a[3:0]),.sel(c12),.Dout(S[15:12]));


endmodule
