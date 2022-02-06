

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Umang Garg
// 
// Create Date: 24.01.2022 15:37:14
// Design Name: TestBench for LIF Neuron
// Module Name: testbench
// Project Name: Spiking Network
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module testbench ( );

parameter input_neurons = 25;
parameter total_timesteps = 22;
parameter pixel_types = 2;
  
  // Output stream from input neurons
  reg s1, s2, s3, s4, s5;
  reg s6, s7, s8, s9, s10;
  reg s11, s12, s13, s14, s15;
  reg s16, s17, s18, s19, s20;
  reg s21, s22, s23, s24, s25;
  
  wire[6:0] Vmem1;     // For receiving Membrane potential output from Module LIF Nueorons
  wire[6:0] Vmem2;
  
  wire out_spikes_n1;    // Output spike data from Module LIF
  wire out_spikes_n2;    // Output spike data from Module LIF
  reg training;
  reg testing;
  

// Toggle Clock
reg clk;
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

   
// Clear Signal
// Functionality not included in the LIF Module yet
reg reset;
initial begin
    reset = 1;
    #15 reset = 0; 
    #500 reset = 1;
end

// Defining the weight inputs to the LIF
 // My Weight convention is wij
 
  reg [3:0] w1_1, w1_2, w1_3, w1_4, w1_5;
  reg [3:0] w1_6, w1_7, w1_8, w1_9, w1_10;
  reg [3:0] w1_11, w1_12, w1_13, w1_14, w1_15;
  reg [3:0] w1_16, w1_17, w1_18, w1_19, w1_20;
  reg [3:0] w1_21, w1_22, w1_23, w1_24, w1_25;
  
  reg [3:0] w2_1, w2_2, w2_3, w2_4, w2_5;
  reg [3:0] w2_6, w2_7, w2_8, w2_9, w2_10;
  reg [3:0] w2_11, w2_12, w2_13, w2_14, w2_15;
  reg [3:0] w2_16, w2_17, w2_18, w2_19, w2_20;
  reg [3:0] w2_21, w2_22, w2_23, w2_24, w2_25;

initial begin
  
   

 // Initial weights before training 
   // Note: First '0' is used for training and hence, the weights corresponding to output neurons don't change as an artifact of lateral inhibition
   
   // Initial weights for output neuron 1
   
   /*   w1_1 <= 4'd1 ;
      w1_2 <= 4'd0 ;
      w1_3 <= 4'd0 ;
      w1_4 <= 4'd1 ;
      w1_5 <= 4'd2 ;
      
      w1_6 <= 4'd0 ;
      w1_7 <= 4'd3 ;
      w1_8 <= 4'd2 ;
      w1_9 <= 4'd3 ;
      w1_10 <= 4'd0 ;
      
      w1_11 <= 4'd2 ;
      w1_12 <= 4'd2 ;
      w1_13 <= 4'd1 ;
      w1_14 <= 4'd3 ;
      w1_15 <= 4'd3 ;
     
      w1_16 <= 4'd1 ; 
      w1_17 <= 4'd3 ;
      w1_18 <= 4'd0 ;
      w1_19 <= 4'd0 ;
      w1_20 <= 4'd2 ;
      
      w1_21 <= 4'd3 ;
      w1_22 <= 4'd1 ;
      w1_23 <= 4'd1 ;
      w1_24 <= 4'd0 ;
      w1_25 <= 4'd1 ;
    */  
      // Weight values after training on '0' dataset
      
      w1_1 <= 4'd0 ;
      w1_2 <= 4'd0 ;
      w1_3 <= 4'd0 ;
      w1_4 <= 4'd0 ;
      w1_5 <= 4'd1 ;
      
      w1_6 <= 4'd0 ;
      w1_7 <= 4'd3 ;
      w1_8 <= 4'd3 ;
      w1_9 <= 4'd3 ;
      w1_10 <= 4'd0 ;
      
      w1_11 <= 4'd1 ;
      w1_12 <= 4'd3 ;
      w1_13 <= 4'd0 ;
      w1_14 <= 4'd3 ;
      w1_15 <= 4'd2 ;
     
      w1_16 <= 4'd0 ; 
      w1_17 <= 4'd3 ;
      w1_18 <= 4'd3 ;
      w1_19 <= 4'd3 ;
      w1_20 <= 4'd1 ;
      
      w1_21 <= 4'd2 ;
      w1_22 <= 4'd0 ;
      w1_23 <= 4'd0 ;
      w1_24 <= 4'd0 ;
      w1_25 <= 4'd0 ;
      
  // Initial weights for output neuron 2
 /* 
      w2_1 <= 4'd0 ;
      w2_2 <= 4'd2 ;
      w2_3 <= 4'd3 ;
      w2_4 <= 4'd0 ;
      w2_5 <= 4'd1 ;
      
      w2_6 <= 4'd2 ;
      w2_7 <= 4'd0 ;
      w2_8 <= 4'd2 ;
      w2_9 <= 4'd0 ;
      w2_10 <= 4'd0 ;
      
      w2_11 <= 4'd1 ;
      w2_12 <= 4'd2 ;
      w2_13 <= 4'd3 ;
      w2_14 <= 4'd1 ;
      w2_15 <= 4'd2 ;
     
      w2_16 <= 4'd0 ;
      w2_17 <= 4'd1 ;
      w2_18 <= 4'd1 ;
      w2_19 <= 4'd0 ;
      w2_20 <= 4'd1 ;
      
      w2_21 <= 4'd2 ;
      w2_22 <= 4'd3 ;
      w2_23 <= 4'd1 ;
      w2_24 <= 4'd3 ;
      w2_25 <= 4'd0 ;

*/

 // Weight values after training on '1' dataset

      w2_1 <= 4'd0 ;
      w2_2 <= 4'd3 ;
      w2_3 <= 4'd3 ;
      w2_4 <= 4'd0 ;
      w2_5 <= 4'd0 ;
      
      w2_6 <= 4'd1 ;
      w2_7 <= 4'd0 ;
      w2_8 <= 4'd3 ;
      w2_9 <= 4'd0 ;
      w2_10 <= 4'd0 ;
      
      w2_11 <= 4'd0 ;
      w2_12 <= 4'd1 ;
      w2_13 <= 4'd3 ;
      w2_14 <= 4'd0 ;
      w2_15 <= 4'd1 ;
     
      w2_16 <= 4'd0 ;
      w2_17 <= 4'd0 ;
      w2_18 <= 4'd3 ;
      w2_19 <= 4'd0 ;
      w2_20 <= 4'd0 ;
      
      w2_21 <= 4'd1 ;
      w2_22 <= 4'd3 ;
      w2_23 <= 4'd3 ;
      w2_24 <= 4'd3 ;
      w2_25 <= 4'd0 ;

end

// Defining the constants to the LIF
  reg [6:0] Vth, Vrest, Vleak;
  reg [4:0] Ksyn;
initial begin
    Vth <= 7'd65;
    Vrest <= 7'd6;
    Vleak <= 7'd1;
    Ksyn <= 5'd1;
end

// Pre and post synpatic firing time capture for STDP update
// Bitwidth corresponding to timestep scale

  reg [6:0] time_pre_n1;
  reg [6:0] time_pre_n2;
  reg [6:0] time_pre_n3;
  reg [6:0] time_pre_n4;
  reg [6:0] time_pre_n5;

  reg [6:0] time_pre_n6;
  reg [6:0] time_pre_n7;
  reg [6:0] time_pre_n8;
  reg [6:0] time_pre_n9;
  reg [6:0] time_pre_n10;

  reg [6:0] time_pre_n11;
  reg [6:0] time_pre_n12;
  reg [6:0] time_pre_n13;
  reg [6:0] time_pre_n14;
  reg [6:0] time_pre_n15;

  reg [6:0] time_pre_n16;
  reg [6:0] time_pre_n17;
  reg [6:0] time_pre_n18;
  reg [6:0] time_pre_n19;
  reg [6:0] time_pre_n20;

  reg [6:0] time_pre_n21;
  reg [6:0] time_pre_n22;
  reg [6:0] time_pre_n23;
  reg [6:0] time_pre_n24;
  reg [6:0] time_pre_n25;

  reg [6:0] time_post_n1; 
  reg [6:0] time_post_n2; 

// Simulation time : 250ns
initial begin
    
    #250 $finish;
    
end

  reg [total_timesteps-1:0] mem_load [0:pixel_types -1];
initial begin
  $display(" Loading pixel types and their firing encodings from file");
    //$readmemb("mem_load.mem", mem_load);
  
 // Here 0 corresponds to black pixel, 1 corresponds to white pixel
 
  mem_load[0] <= 22'b 0001010100010101000101 ;
  mem_load[1] <= 22'b 0001000000100000000010 ;
    
end


integer k;
initial begin    
    $display("Contents of Mem after reading data file:");
  for (k=0; k<pixel_types; k=k+1) $display("%d:%h", 0, mem_load[k]);
end

// Dump all variables
initial begin
    $dumpfile("dump.vcd"); $dumpvars;
end

  
// Assigning input spike train values to each neuron at each clock update
   
reg [6:0] i;
initial begin
    s1 <= 0;
    s2 <= 0;
    s3 <= 0;
    s4 <= 0;
    s5 <= 0;
  
    s6 <= 0;
    s7 <= 0;
    s8 <= 0;
    s9 <= 0;
    s10 <= 0;
  
    s11 <= 0;
    s12 <= 0;
    s13 <= 0;
    s14 <= 0;
    s15 <= 0;
  
    s16 <= 0;
    s17 <= 0;
    s18 <= 0;
    s19 <= 0;
    s20 <= 0;
  
    s21 <= 0;
    s22 <= 0;
    s23 <= 0;
    s24 <= 0;
    s25 <= 0;
  
    i <= 0;
end    

// Adding time step functionality for clarity
// Adding the training and test toggle functionality
  reg signed [6:0] timestep;  
  initial begin
    timestep <= -2;
    training <= 0;
    testing <= 1;
    
  end 
  
always @(posedge clk) begin
      
  	 timestep <= timestep + 1;   
  
  // Reset synaptic weights if reset is high
  if (reset)
  begin
   
   // Initial weights before training 
   // Note: First '0' is used for training and hence, the weights corresponding to output neurons don't change as an artifact of lateral inhibition
   
   /*   w1_1 <= 4'd1 ;
      w1_2 <= 4'd0 ;
      w1_3 <= 4'd0 ;
      w1_4 <= 4'd1 ;
      w1_5 <= 4'd2 ;
      
      w1_6 <= 4'd0 ;
      w1_7 <= 4'd3 ;
      w1_8 <= 4'd2 ;
      w1_9 <= 4'd3 ;
      w1_10 <= 4'd0 ;
      
      w1_11 <= 4'd2 ;
      w1_12 <= 4'd2 ;
      w1_13 <= 4'd1 ;
      w1_14 <= 4'd3 ;
      w1_15 <= 4'd3 ;
     
      w1_16 <= 4'd1 ; 
      w1_17 <= 4'd3 ;
      w1_18 <= 4'd0 ;
      w1_19 <= 4'd0 ;
      w1_20 <= 4'd2 ;
      
      w1_21 <= 4'd3 ;
      w1_22 <= 4'd1 ;
      w1_23 <= 4'd1 ;
      w1_24 <= 4'd0 ;
      w1_25 <= 4'd1 ;
    */  
      // Weight values after training on '0' dataset
      
      w1_1 <= 4'd0 ;
      w1_2 <= 4'd0 ;
      w1_3 <= 4'd0 ;
      w1_4 <= 4'd0 ;
      w1_5 <= 4'd1 ;
      
      w1_6 <= 4'd0 ;
      w1_7 <= 4'd3 ;
      w1_8 <= 4'd3 ;
      w1_9 <= 4'd3 ;
      w1_10 <= 4'd0 ;
      
      w1_11 <= 4'd1 ;
      w1_12 <= 4'd3 ;
      w1_13 <= 4'd0 ;
      w1_14 <= 4'd3 ;
      w1_15 <= 4'd2 ;
     
      w1_16 <= 4'd0 ; 
      w1_17 <= 4'd3 ;
      w1_18 <= 4'd3 ;
      w1_19 <= 4'd3 ;
      w1_20 <= 4'd1 ;
      
      w1_21 <= 4'd2 ;
      w1_22 <= 4'd0 ;
      w1_23 <= 4'd0 ;
      w1_24 <= 4'd0 ;
      w1_25 <= 4'd0 ;
      
        // Initial weights for output neuron 2
  /*
      w2_1 <= 4'd0 ;
      w2_2 <= 4'd2 ;
      w2_3 <= 4'd3 ;
      w2_4 <= 4'd0 ;
      w2_5 <= 4'd1 ;
      
      w2_6 <= 4'd2 ;
      w2_7 <= 4'd0 ;
      w2_8 <= 4'd2 ;
      w2_9 <= 4'd0 ;
      w2_10 <= 4'd0 ;
      
      w2_11 <= 4'd1 ;
      w2_12 <= 4'd2 ;
      w2_13 <= 4'd3 ;
      w2_14 <= 4'd1 ;
      w2_15 <= 4'd2 ;
     
      w2_16 <= 4'd0 ;
      w2_17 <= 4'd1 ;
      w2_18 <= 4'd1 ;
      w2_19 <= 4'd0 ;
      w2_20 <= 4'd1 ;
      
      w2_21 <= 4'd2 ;
      w2_22 <= 4'd3 ;
      w2_23 <= 4'd1 ;
      w2_24 <= 4'd3 ;
      w2_25 <= 4'd0 ;
  */
      // Trained weights for output neuron 2 on '1' dataset
     
      w2_1 <= 4'd0 ;
      w2_2 <= 4'd3 ;
      w2_3 <= 4'd3 ;
      w2_4 <= 4'd0 ;
      w2_5 <= 4'd0 ;
      
      w2_6 <= 4'd1 ;
      w2_7 <= 4'd0 ;
      w2_8 <= 4'd3 ;
      w2_9 <= 4'd0 ;
      w2_10 <= 4'd0 ;
      
      w2_11 <= 4'd0 ;
      w2_12 <= 4'd1 ;
      w2_13 <= 4'd3 ;
      w2_14 <= 4'd0 ;
      w2_15 <= 4'd1 ;
     
      w2_16 <= 4'd0 ;
      w2_17 <= 4'd0 ;
      w2_18 <= 4'd3 ;
      w2_19 <= 4'd0 ;
      w2_20 <= 4'd0 ;
      
      w2_21 <= 4'd1 ;
      w2_22 <= 4'd3 ;
      w2_23 <= 4'd3 ;
      w2_24 <= 4'd3 ;
      w2_25 <= 4'd0 ;
  
  end
  
  
  if(i < total_timesteps) begin
       
       
  // Input neuron streams corresponding to '0' training
  
  /*     s1 <= mem_load[1][total_timesteps- i-1];
       s2 <= mem_load[1][total_timesteps- i-1];
       s3 <= mem_load[1][total_timesteps- i-1];
       s4 <= mem_load[1][total_timesteps- i-1];
       s5 <= mem_load[1][total_timesteps- i-1];
       
       s6 <= mem_load[1][total_timesteps- i-1];
       s7 <= mem_load[0][total_timesteps- i-1];
       s8 <= mem_load[0][total_timesteps- i-1];
       s9 <= mem_load[0][total_timesteps- i-1];
       s10 <= mem_load[1][total_timesteps- i-1];
       
       s11 <= mem_load[1][total_timesteps- i-1];
       s12 <= mem_load[0][total_timesteps- i-1];
       s13 <= mem_load[1][total_timesteps- i-1];
       s14 <= mem_load[0][total_timesteps- i-1];
       s15 <= mem_load[1][total_timesteps- i-1];
       
       s16 <= mem_load[1][total_timesteps- i-1];
       s17 <= mem_load[0][total_timesteps- i-1];
       s18 <= mem_load[0][total_timesteps- i-1];
       s19 <= mem_load[0][total_timesteps- i-1];
       s20 <= mem_load[1][total_timesteps- i-1];
       
       s21 <= mem_load[1][total_timesteps- i-1];
       s22 <= mem_load[1][total_timesteps- i-1];
       s23 <= mem_load[1][total_timesteps- i-1];
       s24 <= mem_load[1][total_timesteps- i-1];
       s25 <= mem_load[1][total_timesteps- i-1];
       
   */    
 
 // Input neuron streams corresponding to '1' training
      
    /*   s1 <= mem_load[1][total_timesteps- i-1];
       s2 <= mem_load[0][total_timesteps- i-1];
       s3 <= mem_load[0][total_timesteps- i-1];
       s4 <= mem_load[1][total_timesteps- i-1];
       s5 <= mem_load[1][total_timesteps- i-1];
       
       s6 <= mem_load[1][total_timesteps- i-1];
       s7 <= mem_load[1][total_timesteps- i-1];
       s8 <= mem_load[0][total_timesteps- i-1];
       s9 <= mem_load[1][total_timesteps- i-1];
       s10 <= mem_load[1][total_timesteps- i-1];
       
       s11 <= mem_load[1][total_timesteps- i-1];
       s12 <= mem_load[1][total_timesteps- i-1];
       s13 <= mem_load[0][total_timesteps- i-1];
       s14 <= mem_load[1][total_timesteps- i-1];
       s15 <= mem_load[1][total_timesteps- i-1];
       
       s16 <= mem_load[1][total_timesteps- i-1];
       s17 <= mem_load[1][total_timesteps- i-1];
       s18 <= mem_load[0][total_timesteps- i-1];
       s19 <= mem_load[1][total_timesteps- i-1];
       s20 <= mem_load[1][total_timesteps- i-1];
       
       s21 <= mem_load[1][total_timesteps- i-1];
       s22 <= mem_load[0][total_timesteps- i-1];
       s23 <= mem_load[0][total_timesteps- i-1];
       s24 <= mem_load[0][total_timesteps- i-1];
       s25 <= mem_load[1][total_timesteps- i-1];
   
    */   
  // Input neuron streams corresponding to 1st testdata 
      
    /*   s1 <= mem_load[1][total_timesteps- i-1];
       s2 <= mem_load[1][total_timesteps- i-1];
       s3 <= mem_load[1][total_timesteps- i-1];
       s4 <= mem_load[1][total_timesteps- i-1];
       s5 <= mem_load[1][total_timesteps- i-1];
       
       s6 <= mem_load[1][total_timesteps- i-1];
       s7 <= mem_load[0][total_timesteps- i-1];
       s8 <= mem_load[1][total_timesteps- i-1];
       s9 <= mem_load[0][total_timesteps- i-1];
       s10 <= mem_load[1][total_timesteps- i-1];
       
       s11 <= mem_load[1][total_timesteps- i-1];
       s12 <= mem_load[0][total_timesteps- i-1];
       s13 <= mem_load[1][total_timesteps- i-1];
       s14 <= mem_load[0][total_timesteps- i-1];
       s15 <= mem_load[1][total_timesteps- i-1];
       
       s16 <= mem_load[1][total_timesteps- i-1];
       s17 <= mem_load[0][total_timesteps- i-1];
       s18 <= mem_load[0][total_timesteps- i-1];
       s19 <= mem_load[0][total_timesteps- i-1];
       s20 <= mem_load[1][total_timesteps- i-1];
       
       s21 <= mem_load[1][total_timesteps- i-1];
       s22 <= mem_load[1][total_timesteps- i-1];
       s23 <= mem_load[1][total_timesteps- i-1];
       s24 <= mem_load[1][total_timesteps- i-1];
       s25 <= mem_load[1][total_timesteps- i-1];  
   */    
       // Input neuron streams corresponding to 2nd testdata 
       
       s1 <= mem_load[1][total_timesteps- i-1];
       s2 <= mem_load[0][total_timesteps- i-1];
       s3 <= mem_load[0][total_timesteps- i-1];
       s4 <= mem_load[1][total_timesteps- i-1];
       s5 <= mem_load[1][total_timesteps- i-1];
       
       s6 <= mem_load[1][total_timesteps- i-1];
       s7 <= mem_load[1][total_timesteps- i-1];
       s8 <= mem_load[0][total_timesteps- i-1];
       s9 <= mem_load[1][total_timesteps- i-1];
       s10 <= mem_load[1][total_timesteps- i-1];
       
       s11 <= mem_load[1][total_timesteps- i-1];
       s12 <= mem_load[1][total_timesteps- i-1];
       s13 <= mem_load[0][total_timesteps- i-1];
       s14 <= mem_load[1][total_timesteps- i-1];
       s15 <= mem_load[1][total_timesteps- i-1];
       
       s16 <= mem_load[1][total_timesteps- i-1];
       s17 <= mem_load[1][total_timesteps- i-1];
       s18 <= mem_load[0][total_timesteps- i-1];
       s19 <= mem_load[1][total_timesteps- i-1];
       s20 <= mem_load[1][total_timesteps- i-1];
       
       s21 <= mem_load[1][total_timesteps- i-1];
       s22 <= mem_load[1][total_timesteps- i-1];
       s23 <= mem_load[0][total_timesteps- i-1];
       s24 <= mem_load[1][total_timesteps- i-1];
       s25 <= mem_load[1][total_timesteps- i-1];
      
       
       i=i+1;
     end
     else begin
       
        s1 <= 0;
        s2 <= 0;
        s3 <= 0;
        s4 <= 0;
        s5 <= 0;

        s6 <= 0;
        s7 <= 0;
        s8 <= 0;
        s9 <= 0;
        s10 <= 0;

        s11 <= 0;
        s12 <= 0;
        s13 <= 0;
        s14 <= 0;
        s15 <= 0;

        s16 <= 0;
        s17 <= 0;
        s18 <= 0;
        s19 <= 0;
        s20 <= 0;

        s21 <= 0;
        s22 <= 0;
        s23 <= 0;
        s24 <= 0;
        s25 <= 0;
  
     end   
     
end

//reg update_needed_synapse_1 ;

// Updating presynaptic and postsynaptic neuron times if spike is '1'
always @(*)
begin
 // Presynaptic 
    if (s1 == 1) 
    time_pre_n1 = timestep;  
    
    if (s2 == 1)
    time_pre_n2 = timestep;
    
     if (s3 == 1)
    time_pre_n3 = timestep;
    
     if (s4 == 1)
    time_pre_n4 = timestep;
    
     if (s5 == 1)
    time_pre_n5 = timestep;
    
     if (s6 == 1)
    time_pre_n6 = timestep;
    
     if (s7 == 1)
    time_pre_n7 = timestep;
    
     if (s8 == 1)
    time_pre_n8 = timestep;
    
     if (s9 == 1)
    time_pre_n9 = timestep;
    
     if (s10 == 1)
    time_pre_n10 = timestep;
    
     if (s11 == 1)
    time_pre_n11 = timestep;
    
    if (s12 == 1)
    time_pre_n12 = timestep;
    
     if (s13 == 1)
    time_pre_n13 = timestep;
    
     if (s14 == 1)
    time_pre_n14 = timestep;
    
     if (s15 == 1)
    time_pre_n15 = timestep;
    
     if (s16 == 1)
    time_pre_n16 = timestep;
    
     if (s17 == 1)
    time_pre_n17 = timestep;
    
     if (s18 == 1)
    time_pre_n18 = timestep;
    
     if (s19 == 1)
    time_pre_n19 = timestep;
    
     if (s20 == 1)
    time_pre_n20 = timestep;
    
    if (s21 == 1)
    time_pre_n21 = timestep;
    
    if (s22 == 1)
    time_pre_n22 = timestep;
    
    if (s23 == 1)
    time_pre_n23 = timestep;
    
    if (s24 == 1)
    time_pre_n24 = timestep;
    
    if (s25 == 1)
    time_pre_n25 = timestep;
    
    
 end
 
 // Postsynaptic
 always @(out_spikes_n1) begin   
    if(out_spikes_n1 == 1)
    time_post_n1 = timestep;
    end
    
    always @(out_spikes_n2) begin   
    if(out_spikes_n2 == 1)
    time_post_n2 = timestep;
    end
       
  // Update_weight definitions for output neuron 1     
  wire [3:0] w1_1_update; 
  wire [3:0] w1_2_update; 
  wire [3:0] w1_3_update; 
  wire [3:0] w1_4_update; 
  wire [3:0] w1_5_update; 
  
  wire [3:0] w1_6_update; 
  wire [3:0] w1_7_update; 
  wire [3:0] w1_8_update; 
  wire [3:0] w1_9_update; 
  wire [3:0] w1_10_update; 
  
  wire [3:0] w1_11_update; 
  wire [3:0] w1_12_update; 
  wire [3:0] w1_13_update; 
  wire [3:0] w1_14_update; 
  wire [3:0] w1_15_update; 
  
  wire [3:0] w1_16_update; 
  wire [3:0] w1_17_update; 
  wire [3:0] w1_18_update; 
  wire [3:0] w1_19_update; 
  wire [3:0] w1_20_update; 
  
  wire [3:0] w1_21_update; 
  wire [3:0] w1_22_update; 
  wire [3:0] w1_23_update; 
  wire [3:0] w1_24_update; 
  wire [3:0] w1_25_update; 
  
  // Update_weight definitions for output neuron 2
  wire [3:0] w2_1_update; 
  wire [3:0] w2_2_update; 
  wire [3:0] w2_3_update; 
  wire [3:0] w2_4_update; 
  wire [3:0] w2_5_update; 
  
  wire [3:0] w2_6_update; 
  wire [3:0] w2_7_update; 
  wire [3:0] w2_8_update; 
  wire [3:0] w2_9_update; 
  wire [3:0] w2_10_update; 
  
  wire [3:0] w2_11_update; 
  wire [3:0] w2_12_update; 
  wire [3:0] w2_13_update; 
  wire [3:0] w2_14_update; 
  wire [3:0] w2_15_update; 
  
  wire [3:0] w2_16_update; 
  wire [3:0] w2_17_update; 
  wire [3:0] w2_18_update; 
  wire [3:0] w2_19_update; 
  wire [3:0] w2_20_update; 
  
  wire [3:0] w2_21_update; 
  wire [3:0] w2_22_update; 
  wire [3:0] w2_23_update; 
  wire [3:0] w2_24_update; 
  wire [3:0] w2_25_update; 
  
  // Update the weights at all times
always @(*)
begin
    w1_1 <= w1_1_update ;
    w1_2 <= w1_2_update ;
    w1_3 <= w1_3_update ;
    w1_4 <= w1_4_update ;
    w1_5 <= w1_5_update ;
    
    w1_6 <= w1_6_update ;
    w1_7 <= w1_7_update ;
    w1_8 <= w1_8_update ;
    w1_9 <= w1_9_update ;
    w1_10 <= w1_10_update ;
    
    w1_11 <= w1_11_update ;
    w1_12 <= w1_12_update ;
    w1_13 <= w1_13_update ;
    w1_14 <= w1_14_update ;
    w1_15 <= w1_15_update ;
    
    w1_16 <= w1_16_update ;
    w1_17 <= w1_17_update ;
    w1_18 <= w1_18_update ;
    w1_19 <= w1_19_update ;
    w1_20 <= w1_20_update ;
    
    w1_21 <= w1_21_update ;
    w1_22 <= w1_22_update ;
    w1_23 <= w1_23_update ;
    w1_24 <= w1_24_update ;
    w1_25 <= w1_25_update ;
    
    
    w2_1 <= w2_1_update ;
    w2_2 <= w2_2_update ;
    w2_3 <= w2_3_update ;
    w2_4 <= w2_4_update ;
    w2_5 <= w2_5_update ;
    
    w2_6 <= w2_6_update ;
    w2_7 <= w2_7_update ;
    w2_8 <= w2_8_update ;
    w2_9 <= w2_9_update ;
    w2_10 <= w2_10_update ;
   
    w2_11 <= w2_11_update ;
    w2_12 <= w2_12_update ;
    w2_13 <= w2_13_update ;
    w2_14 <= w2_14_update ;
    w2_15 <= w2_15_update ;
    
    w2_16 <= w2_16_update ;
    w2_17 <= w2_17_update ;
    w2_18 <= w2_18_update ;
    w2_19 <= w2_19_update ;
    w2_20 <= w2_20_update ;
    
    w2_21 <= w2_21_update ;
    w2_22 <= w2_22_update ;
    w2_23 <= w2_23_update ;
    w2_24 <= w2_24_update ;
    w2_25 <= w2_25_update ;
    
end
  
  Module_IF #(.input_neurons(input_neurons))
                op_neuron1 (.s1(s1), .s2(s2), .s3(s3), .s4(s4), .s5(s5), 
                            .s6(s6), .s7(s7), .s8(s8), .s9(s9), .s10(s10),
                            .s11(s11), .s12(s12), .s13(s13), .s14(s14), .s15(s15),
                            .s16(s16), .s17(s17), .s18(s18), .s19(s19), .s20(s20),
                            .s21(s21), .s22(s22), .s23(s23), .s24(s24), .s25(s25), 
                                        
                            .clk(clk), .Vmem(Vmem1), .out_spikes(out_spikes_n1),
                            
                            .wi1(w1_1), .wi2(w1_2), .wi3(w1_3), .wi4(w1_4), .wi5(w1_5),
                            .wi6(w1_6), .wi7(w1_7), .wi8(w1_8), .wi9(w1_9), .wi10(w1_10),
                            .wi11(w1_11), .wi12(w1_12), .wi13(w1_13), .wi14(w1_14), .wi15(w1_15),
                            .wi16(w1_16), .wi17(w1_17), .wi18(w1_18), .wi19(w1_19), .wi20(w1_20),
                            .wi21(w1_21), .wi22(w1_22), .wi23(w1_23), .wi24(w1_24), .wi25(w1_25),
            
                            .Vrest(Vrest), .Vleak (Vleak), .Vth(Vth), 
                            .Ksyn(Ksyn), .reset(reset), .lat_inhibit(out_spikes_n2) );

  Module_IF #(.input_neurons(input_neurons))
   			    op_neuron2 (.s1(s1), .s2(s2), .s3(s3), .s4(s4), .s5(s5), 
                            .s6(s6), .s7(s7), .s8(s8), .s9(s9), .s10(s10),
                            .s11(s11), .s12(s12), .s13(s13), .s14(s14), .s15(s15),
                            .s16(s16), .s17(s17), .s18(s18), .s19(s19), .s20(s20),
                            .s21(s21), .s22(s22), .s23(s23), .s24(s24), .s25(s25), 
                
                            .clk(clk), .Vmem(Vmem2), .out_spikes(out_spikes_n2),

                            .wi1(w2_1), .wi2(w2_2), .wi3(w2_3), .wi4(w2_4), .wi5(w2_5),
                            .wi6(w2_6), .wi7(w2_7), .wi8(w2_8), .wi9(w2_9), .wi10(w2_10),
                            .wi11(w2_11), .wi12(w2_12), .wi13(w2_13), .wi14(w2_14), .wi15(w2_15),
                            .wi16(w2_16), .wi17(w2_17), .wi18(w2_18), .wi19(w2_19), .wi20(w2_20),
                            .wi21(w2_21), .wi22(w2_22), .wi23(w2_23), .wi24(w2_24), .wi25(w2_25),

                            .Vrest(Vrest), .Vleak (Vleak), .Vth(Vth), 
                            .Ksyn(Ksyn), .reset(reset), .lat_inhibit(out_spikes_n1) );
                            
                                              // STDP Update definitions for Output Neuron 1                             
                            
  STDP_update w1_1_STDP (.weight(w1_1), .time_pre(time_pre_n1), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_1_update), .reset(reset), .testing(testing)  )     ;                  
                              
  STDP_update w1_2_STDP (.weight(w1_2), .time_pre(time_pre_n2), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_2_update), .reset(reset), .testing(testing)  )     ;       
                            
  STDP_update w1_3_STDP (.weight(w1_3), .time_pre(time_pre_n3), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_3_update), .reset(reset), .testing(testing)  )     ; 

  STDP_update w1_4_STDP (.weight(w1_4), .time_pre(time_pre_n4), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_4_update), .reset(reset), .testing(testing)  )     ; 
                                                       
  STDP_update w1_5_STDP (.weight(w1_5), .time_pre(time_pre_n5), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_5_update), .reset(reset), .testing(testing)  )     ;                           

  STDP_update w1_6_STDP (.weight(w1_6), .time_pre(time_pre_n6), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_6_update), .reset(reset), .testing(testing)  )     ;                  
                              
  STDP_update w1_7_STDP (.weight(w1_7), .time_pre(time_pre_n7), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_7_update), .reset(reset), .testing(testing)  )     ;       
                            
  STDP_update w1_8_STDP (.weight(w1_8), .time_pre(time_pre_n8), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_8_update), .reset(reset), .testing(testing)  )     ; 

  STDP_update w1_9_STDP (.weight(w1_9), .time_pre(time_pre_n9), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_9_update), .reset(reset), .testing(testing)  )     ; 
                                                       
  STDP_update w1_10_STDP (.weight(w1_10), .time_pre(time_pre_n10), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_10_update), .reset(reset), .testing(testing)  )     ;                           
                                                        
  STDP_update w1_11_STDP (.weight(w1_11), .time_pre(time_pre_n11), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_11_update), .reset(reset), .testing(testing)  )     ;                  
                              
  STDP_update w1_12_STDP (.weight(w1_12), .time_pre(time_pre_n12), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_12_update), .reset(reset), .testing(testing)  )     ;       
                            
  STDP_update w1_13_STDP (.weight(w1_13), .time_pre(time_pre_n13), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_13_update), .reset(reset), .testing(testing)  )     ; 

  STDP_update w1_14_STDP (.weight(w1_14), .time_pre(time_pre_n14), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_14_update), .reset(reset), .testing(testing)  )     ; 
                                                       
  STDP_update w1_15_STDP (.weight(w1_15), .time_pre(time_pre_n15), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_15_update), .reset(reset), .testing(testing)  )     ;                           

  STDP_update w1_16_STDP (.weight(w1_16), .time_pre(time_pre_n16), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_16_update), .reset(reset), .testing(testing)  )     ;                  
                              
  STDP_update w1_17_STDP (.weight(w1_17), .time_pre(time_pre_n17), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_17_update), .reset(reset), .testing(testing)  )     ;                     
                            
  STDP_update w1_18_STDP (.weight(w1_18), .time_pre(time_pre_n18), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_18_update), .reset(reset), .testing(testing)  )     ; 

  STDP_update w1_19_STDP (.weight(w1_19), .time_pre(time_pre_n19), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_19_update), .reset(reset), .testing(testing)  )     ; 
                                                       
  STDP_update w1_20_STDP (.weight(w1_20), .time_pre(time_pre_n20), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_20_update), .reset(reset), .testing(testing)  )     ;                                    
                              
  STDP_update w1_21_STDP (.weight(w1_21), .time_pre(time_pre_n21), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_21_update), .reset(reset), .testing(testing)  )     ; 
                            
  STDP_update w1_22_STDP (.weight(w1_22), .time_pre(time_pre_n22), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_22_update), .reset(reset), .testing(testing)  )     ; 
                            
  STDP_update w1_23_STDP (.weight(w1_23), .time_pre(time_pre_n23), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_23_update), .reset(reset), .testing(testing)  )     ;                             
                            
  STDP_update w1_24_STDP (.weight(w1_24), .time_pre(time_pre_n24), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_24_update), .reset(reset), .testing(testing)  )     ;                             
                            
  STDP_update w1_25_STDP (.weight(w1_25), .time_pre(time_pre_n25), .time_post(time_post_n1), 
                            .clk(clk), .w(w1_25_update), .reset(reset), .testing(testing)  )     ;                             
                            

                                    // STDP Update definitions for Output Neuron 2                            
                           
  STDP_update w2_1_STDP (.weight(w2_1), .time_pre(time_pre_n1), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_1_update), .reset(reset), .testing(testing)  )     ;                  
                              
  STDP_update w2_2_STDP (.weight(w2_2), .time_pre(time_pre_n2), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_2_update), .reset(reset), .testing(testing)  )     ;       
                            
  STDP_update w2_3_STDP (.weight(w2_3), .time_pre(time_pre_n3), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_3_update), .reset(reset), .testing(testing)  )     ; 

  STDP_update w2_4_STDP (.weight(w2_4), .time_pre(time_pre_n4), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_4_update), .reset(reset), .testing(testing)  )     ; 
                                                       
  STDP_update w2_5_STDP (.weight(w2_5), .time_pre(time_pre_n5), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_5_update), .reset(reset), .testing(testing)  )     ;                           

  STDP_update w2_6_STDP (.weight(w2_6), .time_pre(time_pre_n6), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_6_update), .reset(reset), .testing(testing)  )     ;                  
                              
  STDP_update w2_7_STDP (.weight(w2_7), .time_pre(time_pre_n7), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_7_update), .reset(reset), .testing(testing)  )     ;       
                            
  STDP_update w2_8_STDP (.weight(w2_8), .time_pre(time_pre_n8), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_8_update), .reset(reset), .testing(testing)  )     ; 

  STDP_update w2_9_STDP (.weight(w2_9), .time_pre(time_pre_n9), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_9_update), .reset(reset), .testing(testing)  )     ; 
                                                       
  STDP_update w2_10_STDP (.weight(w2_10), .time_pre(time_pre_n10), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_10_update), .reset(reset), .testing(testing)  )     ;                           
                                                        
  STDP_update w2_11_STDP (.weight(w2_11), .time_pre(time_pre_n11), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_11_update), .reset(reset), .testing(testing)  )     ;                  
                              
  STDP_update w2_12_STDP (.weight(w2_12), .time_pre(time_pre_n12), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_12_update), .reset(reset), .testing(testing)  )     ;       
                            
  STDP_update w2_13_STDP (.weight(w2_13), .time_pre(time_pre_n13), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_13_update), .reset(reset), .testing(testing)  )     ; 

  STDP_update w2_14_STDP (.weight(w2_14), .time_pre(time_pre_n14), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_14_update), .reset(reset), .testing(testing)  )     ; 
                                                       
  STDP_update w2_15_STDP (.weight(w2_15), .time_pre(time_pre_n15), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_15_update), .reset(reset), .testing(testing)  )     ;                           

  STDP_update w2_16_STDP (.weight(w2_16), .time_pre(time_pre_n16), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_16_update), .reset(reset), .testing(testing)  )     ;                  
                              
  STDP_update w2_17_STDP (.weight(w2_17), .time_pre(time_pre_n17), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_17_update), .reset(reset), .testing(testing)  )     ;       
                            
  STDP_update w2_18_STDP (.weight(w2_18), .time_pre(time_pre_n18), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_18_update), .reset(reset), .testing(testing)  )     ; 

  STDP_update w2_19_STDP (.weight(w2_19), .time_pre(time_pre_n19), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_19_update), .reset(reset), .testing(testing) )     ; 
                                                       
  STDP_update w2_20_STDP (.weight(w2_20), .time_pre(time_pre_n20), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_20_update), .reset(reset), .testing(testing)  )     ;                                    
                              
  STDP_update w2_21_STDP (.weight(w2_21), .time_pre(time_pre_n21), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_21_update), .reset(reset), .testing(testing)  )     ; 
                            
  STDP_update w2_22_STDP (.weight(w2_22), .time_pre(time_pre_n22), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_22_update), .reset(reset), .testing(testing)  )     ; 
                            
  STDP_update w2_23_STDP (.weight(w2_23), .time_pre(time_pre_n23), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_23_update), .reset(reset), .testing(testing)  )     ;                             
                           
  STDP_update w2_24_STDP (.weight(w2_24), .time_pre(time_pre_n24), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_24_update), .reset(reset), .testing(testing)  )     ;                             
                            
  STDP_update w2_25_STDP (.weight(w2_25), .time_pre(time_pre_n25), .time_post(time_post_n2), 
                            .clk(clk), .w(w2_25_update), .reset(reset), .testing(testing)  )     ;                                
                     
                            
                                                        
endmodule
