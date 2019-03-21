/*
The MIT License (MIT)

Copyright (c) 2019 Yuya Kudo.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

module uart
  #(parameter
    /*
     You can designate under three parameters.
     1. DATA_WIDTH : width of data that is transmited by this module
     2. BAUD_RATE  : baud rate of output uart signal
     3. CLK_FREQ   : freqency of input clock signal
     */
    DATA_WIDTH = 8,
    BAUD_RATE  = 115200,
    CLK_FREQ   = 100_000_000)
   (input  logic                  rxd,
    output logic                  txd,
    input  logic [DATA_WIDTH-1:0] tx_data,
    input  logic                  tx_valid,
    output logic                  tx_ready,
    output logic [DATA_WIDTH-1:0] rx_data,
    output logic                  rx_valid,
    input  logic                  rx_ready,
    input  logic                  clk,
    input  logic                  rstn);

   uart_tx #(DATA_WIDTH, BAUD_RATE, CLK_FREQ)
   uart_tx_inst(.data(tx_data),
                .valid(tx_valid),
                .clk(clk),
                .rstn(rstn),
                .uart_out(txd),
                .ready(tx_ready));

   uart_rx #(DATA_WIDTH, BAUD_RATE, CLK_FREQ)
   uart_rx_inst(.uart_in(rxd),
                .ready(rx_ready),
                .clk(clk),
                .rstn(rstn),
                .data(rx_data),
                .valid(rx_valid));
endmodule
