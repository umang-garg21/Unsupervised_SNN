// Code your design here
`timescale 1ns/100ps

module Module_IF #( parameter input_neurons = 25) (
  
  input wire s1, s2, s3, s4, s5,        // All inputs to the neuron
  input wire s6, s7, s8, s9, s10,
  input wire s11, s12, s13, s14, s15,
  input wire s16, s17, s18, s19, s20,
  input wire s21, s22, s23, s24, s25,
  
  input clk,
  
  input wire [3:0] wi1, wi2, wi3, wi4, wi5,         // All 25 weights corresponding to input neurons
  input wire [3:0] wi6, wi7, wi8, wi9, wi10,
  input wire [3:0] wi11, wi12, wi13, wi14, wi15,
  input wire [3:0] wi16, wi17, wi18, wi19, wi20, 
  input wire [3:0] wi21, wi22, wi23, wi24, wi25,
  
  input wire [6:0] Vth, Vrest, Vleak, // Neuron parameters for membrane update
  input wire [4:0] Ksyn,              // Neuron parameter for membrane update

  input wire reset,                 // reset
  input wire lat_inhibit,           // inhibit signal

  output reg[6:0] Vmem,              // Membrane potential
  output reg out_spikes          // output in form of spilkes
 
);

  reg [6:0] Vmem_update;
  reg inhibit_signal;

	// Combinational Logic Evaluation
  
  always @(*) begin
    
    if (reset) Vmem_update = 0;
    else 
      Vmem_update = Vmem + (Ksyn * (
        
        (wi1*s1) + (wi2*s2) + (wi3*s3) + (wi4*s4) + (wi5*s5) +
        (wi6*s6) + (wi7*s7) + (wi8*s8) + (wi9*s9) + (wi10*s10) +
        (wi11*s11) + (wi12*s12) + (wi13*s13) + (wi14*s14) + (wi15*s15) +
        (wi16*s16) + (wi17*s17) + (wi18*s18) + (wi19*s19) + (wi20*s20) +
        (wi21*s21) + (wi22*s22) + (wi23*s23) + (wi24*s24) + (wi25*s25)     ) ) ;
        
       inhibit_signal = lat_inhibit ;
       
  end
  
  
 	 // Sequential Logic
   always @(posedge clk)
   
     begin
     
     if (reset) begin
        Vmem <= Vrest; 
        out_spikes <= 0;
        
     end
       
     else 
          begin
   
           if (inhibit_signal == 1) // If inhibit signal evaulates to 1, reset this neuron 
           begin 
            Vmem <= Vrest;
            Vmem_update <= Vrest;
            out_spikes <= 0;
            end
            
           else if (Vmem >= Vth)  // Reset the membrane potential at next clock edge
          begin  
            Vmem <= Vrest;
            Vmem_update <= Vrest;
            out_spikes <= 0;
          end

          else if( Vmem_update < Vrest ) // Reset the membrane if evaulation goes below Vrest
            begin
                 Vmem <= Vrest;
            end  

          else if( Vmem_update >= Vth ) // If evaulation goes above Vth, output spike, Vmem updated to the evaulation
            begin
                // Vmem <= Vrest;
                 Vmem <= Vmem_update;
                 out_spikes <= 1;
                 
            end

          else                          // Update Vmem to evaluation and output spike to 0
            begin
                 Vmem <= Vmem_update;
                 out_spikes <= 0;   
            end   

          end           
                  
     end
                 
                    
endmodule   