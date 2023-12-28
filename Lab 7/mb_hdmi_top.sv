`timescale 1ns / 1ps


module mb_hdmi_top
   (input  logic Clk,
    input  logic reset_rtl_0,
    output logic hdmi_tmds_clk_n,
    output logic hdmi_tmds_clk_p,
    output logic [2:0]hdmi_tmds_data_n,
    output logic [2:0]hdmi_tmds_data_p,
    input logic uart_rtl_0_rxd,
    output logic uart_rtl_0_txd);
    

  mb_hdmi mb_hdmi_i
       (.clk_100MHz(Clk),
        .HDMI_0_tmds_data_n(hdmi_tmds_data_n),
        .HDMI_0_tmds_data_p(hdmi_tmds_data_p),
        .HDMI_0_tmds_clk_n(hdmi_tmds_clk_n),
        .HDMI_0_tmds_clk_p(hdmi_tmds_clk_p),
        .reset_rtl_0(~reset_rtl_0),      //Note the inversion of the reset button. Buttons are active low, but the MicroBlaze reset is active high
        .uart_rtl_0_rxd(uart_rtl_0_rxd),  //Note the switcheroo between RTX and TXD. This is a common source of confusion in embedded development
        .uart_rtl_0_txd(uart_rtl_0_txd)); //RXD = Received Data, and TXD = Transmitted Data, but whether data is transmitted or received depeneds on the
                                    //perspective. Here, the TXD port means transmitted by the FPGA (but received by the Urbana Board's UART chip)
endmodule