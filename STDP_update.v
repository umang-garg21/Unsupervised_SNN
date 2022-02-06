`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2022 07:39:41 PM
// Design Name: 
// Module Name: STDP_update
// Project Name: Unsupervised Spiking Neural Network
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


module STDP_update(

input wire [3:0] weight,
input wire [6:0] time_pre,
input wire [6:0] time_post,
input clk,
input reset,
input wire testing,

output reg [3:0] w
//output reg update_weight_update     // Update the weight_update signal in the top module

);
    
    reg signed [4:0] temp;
    reg signed [4:0] w_update;
    reg signed [31:0] del_time;
    
    always @ (*) 
    begin

      if (reset)
        begin
         w_update <= weight;
        end
        
    end
    
    always @(time_pre, time_post)
    begin
        
        if (reset == 0) begin 
            
            if (testing == 0)
            begin
            
                temp = weight;
                del_time = time_post - time_pre;
                
                if ((del_time < -1) && (del_time >= -2) )
                    w_update = weight - 5'b00001 ;
                
                else if ( (del_time < 0) && (del_time >= -1) )
                    w_update = weight -  5'b00010 ;
                    
                else if (del_time == 0)
                    w_update = weight +  5'b00000 ;
                    
                else if ( (del_time > 0) && (del_time <= 1) )
                    w_update = weight +  5'b00010  ;    
                   
                else if ((del_time > 1) && (del_time <= 2) )
                    w_update = weight +  5'b00001  ;    
                    
                else         
                    w_update = weight;
              end
              
            
                if (w_update < 0) 
                    begin
                        w_update <= 0;
                        w <= 0;        
                    end
                    
                else if (w_update > 3)
                    begin
                        w_update <= 3;
                        w <= 3;
                    end
                else
                 w = w_update;                  
             end
             
             else if (testing ==1)
             begin
             
              w_update <= weight;
              w <= weight;
             end
             
             
         end    


endmodule
