`timescale 1ns / 1ps

//PC INPUT MUX
module PCMux(input logic [15:0] PCin,Bus_PC,ADDR_PC,
             input logic [1:0] PCSelect,
             output logic [15:0] PCout
    );
    logic [15:0] PC_next;
    assign PC_next = PCin + 1'b1;
    
    always_comb
        begin

            unique case(PCSelect)
                
                2'b00 : PCout = PC_next;
                
                2'b01 : PCout = Bus_PC;
                
                2'b10 : PCout = ADDR_PC;
                                
                default : PCout = 16'bxxxx;
                
            endcase	
        end
endmodule

//MDR INPUT MUX
module MDRMux(input logic [15:0] CPU_MDR,Bus_MDR,
             input logic MDRSelect,
             output logic [15:0] MDRout
    );
    
    always_comb
        begin
            unique case(MDRSelect)
                
                1'b0 : MDRout = Bus_MDR;
                
                1'b1 : MDRout = CPU_MDR;
                
                default : MDRout = 16'hxxxx;
                
            endcase	
        end
endmodule

//BUS INPUT MUX
module BusMux(input logic GateMDR, GatePC, GateMARMUX, GateALU,
              input logic [15:0] MDR, PC, ADDROUT, ALU,
              output logic [15:0] BUSout );
              
              logic [3:0] bus_select;
              always_comb
                begin
                    bus_select = {GateMDR,GatePC,GateMARMUX,GateALU};
            
                    unique case(bus_select)
            
                    4'b0001 : BUSout = ALU; //PC register driven to CPU bus
            
                    4'b0010 : BUSout = ADDROUT;
                    
                    4'b0100 : BUSout = PC; //PC register driven to CPU bus
            
                    4'b1000 : BUSout = MDR;
            
                    default : BUSout = 16'hzzzz;
            
                    endcase	
                end
endmodule

module DRMux(input logic [2:0] IR_DR,
              input logic DR,
              output logic [2:0] DRout );
              
              always_comb
                begin
                    unique case(DR)
            
                    1'b0 : DRout = IR_DR; //IR register driven to DR
            
                    1'b1 : DRout = 3'b111;
            
                    default : DRout = 3'hx;
            
                    endcase	
                end
endmodule

module SR1Mux(input logic [2:0] IR_SR1,IR_SR2,
              input logic SR1,
              output logic [2:0] SR1out );
              
              always_comb
                begin
                    unique case(SR1)
            
                    1'b0 : SR1out = IR_SR1; //IR register driven to SR1
            
                    1'b1 : SR1out = IR_SR2;
            
                    default : SR1out = 3'hx;
            
                    endcase	
                end
endmodule

module SR2Mux(input logic [15:0] SR2OUT,
              input logic [4:0] IR_SR2,
              input logic SR2,
              output logic [15:0] SR2out );
              
              logic [15:0] SEXT_SR2;
              always_comb
                begin
                    if (IR_SR2[4])
                    SEXT_SR2 = {11'b11111111111,IR_SR2};
                    else
                    SEXT_SR2 = {11'b00000000000,IR_SR2};
                    
                    unique case(SR2)
                    
                    1'b0 : SR2out = SR2OUT; //SR2 register driven to SR2mux
            
                    1'b1 : SR2out = SEXT_SR2;
            
                    default : SR2out = 16'hxxxx;
            
                    endcase	
                end
endmodule

module ADDR1Mux(input logic [15:0] PC_ADDR1,SR1OUT,
                input logic ADDR1,
                output logic [15:0] ADDR1out );

              always_comb
                begin
                    
                    unique case(ADDR1)
                    
                    1'b0 : ADDR1out = PC_ADDR1; //PC register driven to ADDR1
            
                    1'b1 : ADDR1out = SR1OUT;
            
                    default : ADDR1out = 16'hxxxx;
            
                    endcase	
                end
endmodule

module ADDR2Mux(input logic [15:0] IR_ADDR2,
                input logic [1:0] ADDR2,
                output logic [15:0] ADDR2out );

          logic [15:0] SEXT6_ADDR2, SEXT9_ADDR2, SEXT11_ADDR2;
          
              always_comb
                begin
                    if (IR_ADDR2[5])
                     SEXT6_ADDR2 = {10'b1111111111,IR_ADDR2[5:0]};
                    else
                     SEXT6_ADDR2 = {10'b0000000000,IR_ADDR2[5:0]};
                    if (IR_ADDR2[8])
                     SEXT9_ADDR2 = {7'b1111111,IR_ADDR2[8:0]};
                    else
                     SEXT9_ADDR2 = {7'b0000000,IR_ADDR2[8:0]};
                    if (IR_ADDR2[10])
                     SEXT11_ADDR2 = {5'b11111,IR_ADDR2[10:0]};
                    else
                     SEXT11_ADDR2 = {5'b00000,IR_ADDR2[10:0]};
                     
                    unique case(ADDR2)
                    
                    2'b00 : ADDR2out = 16'h0000; 
            
                    2'b01 : ADDR2out = SEXT6_ADDR2;
                    
                    2'b10 : ADDR2out = SEXT9_ADDR2;
                    
                    2'b11 : ADDR2out = SEXT11_ADDR2;
            
                    default : ADDR2out = 16'hxxxx;
                    
                    endcase	
                end
endmodule



