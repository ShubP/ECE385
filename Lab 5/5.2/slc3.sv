//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Given Code - SLC-3 core
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//    Revised 06-09-2020
//	  Revised 03-02-2021
//    Xilinx vivado
//    Revised 07-25-2023 
//------------------------------------------------------------------------------


module slc3(
	input logic [15:0] SW,
	input logic	Clk, Reset, Run, Continue,
	output logic [15:0] LED,
	input logic [15:0] Data_from_SRAM,
	output logic OE, WE,
	output logic [7:0] hex_seg,
	output logic [3:0] hex_grid,
	output logic [7:0] hex_segB,
	output logic [3:0] hex_gridB,
	output logic [15:0] ADDR,
	output logic [15:0] Data_to_SRAM
);

// Internal connections
logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED;
logic GatePC, GateMDR, GateALU, GateMARMUX;
logic SR2MUX, ADDR1MUX, MARMUX;
logic BEN, MIO_EN, DRMUX, SR1MUX;
logic [1:0] PCMUX, ADDR2MUX, ALUK;
logic [15:0] SR2MUXOUT, MDR_In, SR1OUT, SR2OUT, ADDR1, ADDR2, ADDROUT, R0,R1,R2,R3,R4,R5,R6,R7;
logic [15:0] MAR, MDR, IR, PC, ALU;
logic [3:0] hex_4[3:0]; 
logic [2:0] DR, SR1MUXOUT, NZP;

HexDrivertop HexA (
    .clk(Clk),
    .reset(Reset),
    .in({hex_4[3][3:0],  hex_4[2][3:0], hex_4[1][3:0], hex_4[0][3:0]}),
    .hex_seg(hex_seg),
    .hex_grid(hex_grid)
);

// You may use the second (right) HEX driver to display additional debug information
// For example, Prof. Cheng's solution code has PC being displayed on the right HEX


HexDrivertop HexB (
    .clk(Clk),
    .reset(Reset),
    .in({IR[15:12],IR[11:8],IR[7:4],IR[3:0]}),
    .hex_seg(hex_segB),
    .hex_grid(hex_gridB)
);

// Connect MAR to ADDR, which is also connected as an input into MEM2IO
//	MEM2IO will determine what gets put onto Data_CPU (which serves as a potential
//	input into MDR)
assign ADDR = MAR; 
assign MIO_EN = OE;
assign LED = PC;

// Instantiate the rest of your modules here according to the block diagram of the SLC-3
// including your register file, ALU, etc..

logic [15:0] BUSin, BUSout; //contains the data currently on the bus
logic [15:0] PC_muxout, MDR_muxout;

reg_16 IR_reg(.*, .Load(LD_IR), .DIn(BUSin), .DOut(IR));
reg_16 PC_reg(.*, .Load(LD_PC), .DIn(PC_muxout), .DOut(PC));
reg_16 MAR_reg(.*, .Load(LD_MAR), .DIn(BUSin), .DOut(MAR));
reg_16 MDR_reg(.*, .Load(LD_MDR), .DIn(MDR_muxout), .DOut(MDR));
    
BusMux cpu_mux (.*,.BUSout(BUSin));
PCMux pc_mux (.PCin(PC),.Bus_PC(BUSin),.ADDR_PC(ADDROUT),.PCSelect(PCMUX),.PCout(PC_muxout));
MDRMux mdr_mux (.Bus_MDR(BUSin),.CPU_MDR(MDR_In),.MDRSelect(MIO_EN),.MDRout(MDR_muxout));
DRMux dr_mux (.IR_DR(IR[11:9]),.DR(DRMUX),.DRout(DR));

SR1Mux sr1_mux (.IR_SR1(IR[11:9]),.IR_SR2(IR[8:6]),.SR1(SR1MUX),.SR1out(SR1MUXOUT));
SR2Mux sr2_mux (.SR2OUT, .IR_SR2(IR[4:0]),.SR2(SR2MUX),.SR2out(SR2MUXOUT));

ADDR1Mux addr1_mux (.PC_ADDR1(PC), .SR1OUT,.ADDR1(ADDR1MUX),.ADDR1out(ADDR1));
ADDR2Mux addr2_mux (.IR_ADDR2(IR), .ADDR2(ADDR2MUX), .ADDR2out(ADDR2));
assign ADDROUT = ADDR1 + ADDR2;

ALUUnit alu_unit (.*,.ALUOUT(ALU));

Register_File reg_file (.*,.SR1(SR1MUXOUT),.SR2(IR[2:0]),.DR_REG(DR),.BUS_REG(BUSin));

always_ff @ (posedge Clk)
    begin
	 	if (Reset) 
                begin
                    NZP <= 3'h0; // updated when gets to next clock cycle
                end 			
		else  if (LD_CC) 
                begin 
                    if (BUSin[15]) 
                        begin
                            NZP <= 3'b100;
                        end 
                    else if (BUSin == 16'h0000) 
                        begin 
                            NZP <= 3'b010;
                        end 
                    else 
                        begin 
                            NZP <= 3'b001; 
                    end
                end  
    end


always_ff @ (posedge Clk)
    begin
	 	if (Reset) 
                begin
                    BEN <= 1'b0; 
                end 			
		else  if (LD_BEN) 
                begin 
                    BEN <= (IR[11] & NZP[2]) | (IR[10] & NZP[1]) | (IR[9] & NZP[0]) ;
                end
    end



// Our I/O controller (note, this plugs into MDR/MAR)

Mem2IO memory_subsystem(
    .*, .Reset(Reset), .ADDR(ADDR), .Switches(SW),
    .HEX0(hex_4[0][3:0]), .HEX1(hex_4[1][3:0]), .HEX2(hex_4[2][3:0]), .HEX3(hex_4[3][3:0]), 
    .Data_from_CPU(MDR), .Data_to_CPU(MDR_In),
    .Data_from_SRAM(Data_from_SRAM), .Data_to_SRAM(Data_to_SRAM)
);

// State machine, you need to fill in the code here as well
ISDU state_controller(
	.*, .Reset(Reset), .Run(Run), .Continue(Continue),
	.Opcode(IR[15:12]), .IR_5(IR[5]), .IR_11(IR[11]),
   .Mem_OE(OE), .Mem_WE(WE)
);
	
endmodule
