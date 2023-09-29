module lookahead_adder (
	input  [15:0] A, B,
	input         cin,
	output logic [15:0] S,
	output logic cout
);

    module FA_CLA                       //individual 2bit full adder with p,g signals module
        (
            input x,y,z,
            output logic s,p,g
        );
        assign s = x^y^z;
        assign p = x^y;
        assign g = x & y;
    endmodule

    module CLA4bit(input [3:0] CLA_A, CLA_B, //individual 4-bit adder module
				input CLA_cin,
				output [3:0] CLA_S,
				output CLA_PG, CLA_GG);

    logic [3:0] CLA_p, CLA_g, CLA_pg,CLA_gg;				
    logic CLA_c1,CLA_c2,CLA_c3;
    FA_CLA fa1(.x(CLA_A[0]), .y(CLA_B[0]), .z(CLA_cin), .s(CLA_S[0]), .p(CLA_pg[0]), .g(CLA_gg[0]));
    assign CLA_c1 = (cin & CLA_pg[0]) | CLA_gg[0];
    FA_CLA fa2(.x(CLA_A[1]), .y(CLA_B[1]), .z(CLA_c1), .s(CLA_S[1]), .p(CLA_pg[1]), .g(CLA_gg[1]));
    assign CLA_c2 = (cin & CLA_pg[0] & CLA_pg[1]) | (CLA_gg[0] & CLA_pg[1]) | CLA_gg[1];
    FA_CLA fa3(.x(CLA_A[2]), .y(CLA_B[2]), .z(CLA_c2), .s(CLA_S[2]), .p(CLA_pg[2]), .g(CLA_gg[2]));
    assign CLA_c3 = (cin & CLA_pg[0] & CLA_pg[1] & CLA_pg[2]) | (CLA_gg[0] & CLA_pg[1]) | (CLA_gg[1] & CLA_pg[2]) | CLA_gg[2];
    FA_CLA fa4(.x(CLA_A[3]), .y(CLA_B[3]), .z(CLA_c3), .s(CLA_S[3]), .p(CLA_pg[3]), .g(CLA_gg[3]));
    
    assign CLA_PG = CLA_pg[0] & CLA_pg[1] & CLA_pg[2] & CLA_pg[3];
    assign CLA_GG = CLA_gg[3] | (CLA_gg[2] & CLA_pg[3]) | (CLA_gg[1] & CLA_pg[3] & CLA_pg[2]) | (CLA_gg[0] & CLA_pg[3] & CLA_pg[2] & CLA_pg[1]);
    
    endmodule

    logic[3:0] PGout,GGout;
    logic PG,GG,Pg0,Pg4,Pg8,Pg12,Gg0,Gg4,Gg8,Gg12,c4,c8,c12;
    CLA4bit cla0(.CLA_A(A[3:0]),.CLA_B(B[3:0]),.CLA_cin(cin),.CLA_S(S[3:0]),.CLA_PG(Pg0),.CLA_GG(Gg0));
    assign c4 = Gg0 | (cin & Pg0);
    CLA4bit cla1(.CLA_A(A[7:4]),.CLA_B(B[7:4]),.CLA_cin(c4),.CLA_S(S[7:4]),.CLA_PG(Pg4),.CLA_GG(Gg4));
    assign c8 = Gg4 | (Gg0 & Pg4) | (cin & Pg0 & Pg4);
    CLA4bit cla2(.CLA_A(A[11:8]),.CLA_B(B[11:8]),.CLA_cin(c8),.CLA_S(S[11:8]),.CLA_PG(Pg8),.CLA_GG(Gg8));
    assign c12 = Gg8 | (Gg4 & Pg8) | (Gg0 & Pg8 & Pg4) | (cin & Pg8 & Pg4 & Pg0);
    CLA4bit cla3(.CLA_A(A[15:12]),.CLA_B(B[15:12]),.CLA_cin(c12),.CLA_S(S[15:12]),.CLA_PG(Pg12),.CLA_GG(Gg12));
    
    assign PGout = {Pg0,Pg4,Pg8,Pg12};
    assign GGout = {Gg0,Gg4,Gg8,Gg12};
    assign cout = Gg12 | (Gg8 & Pg12) | (Gg4 & Pg12 & Pg8) |(Gg0 & Pg12 & Pg8 & Pg4 ) | (cin & Pg12 & Pg8 & Pg4 & Pg0);
    
    assign PG = PGout[0] & PGout[1] & PGout[2] & PGout[3];
    assign GG = GGout[3] | (GGout[2] & PGout[3]) | (GGout[1] & PGout[3] & PGout[2]) | (GGout[0] & PGout[3] & PGout[2] & PGout[1]);
    
endmodule