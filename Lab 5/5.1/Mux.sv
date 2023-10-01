`timescale 1ns / 1ps

//PC INPUT MUX
module PCMux(input logic [15:0] PCin,Bus_PC,
             input logic [1:0] PCSelect,
             output logic [15:0] PCout
    );
    logic [15:0] PC_next;
    assign PC_next = PCin + 1;
    
    always_comb
        begin

            unique case(PCSelect)
                
                2'b00 : PCout = PC_next;
                
                2'b01 : PCout = Bus_PC;
                                
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
                
                default : MDRout = Bus_MDR;
                
            endcase	
        end
endmodule

//BUS INPUT MUX
module BusMux(input logic GateMDR, GatePC, GateMARMUX, GateALU,
              input logic [15:0] MDR, PC,
              output logic [15:0] BUSout );
              
              logic [1:0] bus_select;
              always_comb
                begin
                    bus_select = {GateMDR,GatePC};
            
                    unique case(bus_select)
            
                    2'b01 : BUSout = PC; //PC register driven to CPU bus
            
                    2'b10 : BUSout = MDR;
            
                    default : BUSout = PC;
            
                    endcase	
                end

endmodule
