//Two-always example for state machine

module control (input  logic Clk, Reset, Run, M,
                output logic Reset_A, Reset_X, Ld_A, sub, Add_En, Shift_En);

    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [4:0] {start_load, new_mult, shift0, add0, 
                       shift1,add1,shift2,add2,
                       shift3,add3,shift4,add4,
                       shift5,add5,shift6,add6,
                       shift7,add7,complete}   curr_state, next_state; 

	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (Reset)
            curr_state <= start_load;
        else 
            curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
		next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 
 
            start_load: if (Run)
                            next_state = new_mult;
                            
            new_mult:   next_state = add0;
            
            add0 :     
                        next_state = shift0;
            shift0 :    
                        next_state = add1;
            add1 :      
                        next_state = shift1;
            shift1 :    
                        next_state = add2;
            add2 :     
                        next_state = shift2;
            shift2 :    
                        next_state = add3;
            add3 :      
                        next_state = shift3;
            shift3 :    
                        next_state = add4;
            add4 :      
                        next_state = shift4;
            shift4 :   
                        next_state = add5;
            add5 :      
                        next_state = shift5;
            shift5 :   
                        next_state = add6;
            add6 :      
                        next_state = shift6;
            shift6 :    
                        next_state = add7;
            add7 :      
                        next_state = shift7;
            shift7 :    
                        next_state = complete;
                        
            complete:   if(~Run)
                           next_state = start_load;
        endcase
   
		  // Assign outputs based on state
        case (curr_state)
           start_load:
               begin
                 Reset_A = 1'b0;
                 Reset_X = 1'b0;
                 sub = 1'b0;
                 Ld_A = 1'b0;
                 Shift_En = 1'b0;
                 Add_En = 1'b0;
               end
               
	   	   new_mult:
	   	       begin 
	   	         sub = 1'b0;
                 Ld_A = 1'b0;
                 Shift_En = 1'b0;
	   	         Reset_A = 1'b1;
	   	         Reset_X = 1'b1;
	   	         Add_En = 1'b0;
	   	       end
	   	       
           add0,add1,add2,add3,add4,add5,add6: 
	         begin
	           Reset_A = 1'b0;
	           Reset_X = 1'b0;
	           sub = 1'b0;
	           Shift_En = 1'b0;
	           if (M)
	               Add_En = 1'b1;
	           else
	               Add_En = 1'b0;
	           if (M)
	               Ld_A = 1'b1;
	           else
	               Ld_A = 1'b0;
		     end
		     
		   add7:
		      begin
		          Shift_En = 1'b0;
		          Ld_A = 1'b0;
		          Reset_A = 1'b0;
		          Reset_X = 1'b0;
		          if (M)
		              sub = 1'b1;
		          else
		              sub = 1'b0;
		          if(M)
		              Add_En = 1'b1;
		          else
		              Add_En = 1'b0;
		          if (M)
	               Ld_A = 1'b1;
	              else
	               Ld_A = 1'b0;
		      end
		      
		   shift0,shift1,shift2,shift3,shift4,shift5,shift6,shift7: 
	         begin
	           Reset_A = 1'b0;
	           Reset_X = 1'b0;
	           Ld_A = 1'b0;
	           Add_En = 1'b0;
	           sub = 1'b0;
               Shift_En = 1'b1;
		     end
		     
		   complete: 
		      begin
		       Ld_A = 1'b0;
	           sub = 1'b0;
               Shift_En = 1'b0;
               Reset_A = 1'b0;
               Reset_X = 1'b0;
               Add_En = 1'b0;
              end
           
	   	   default:  //default case, can also have default assignments for Ld_A and Ld_B before case
		      begin 
                Ld_A = 1'b0;
                Shift_En = 1'b0;
                sub = 1'b0;
                Reset_A = 1'b0;
                Reset_X = 1'b0;
                Add_En = 1'b0;
		      end
        endcase
    end

endmodule
