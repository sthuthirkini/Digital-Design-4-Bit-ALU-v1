```systemverilog
`timescale 1ns/1ps

module alu_tb;

    // Inputs to the ALU
    logic [3:0] A;
    logic [3:0] B;
    logic [2:0] OP;

    // Output from the ALU
    logic [3:0] Y;

    // Instantiate the ALU
    alu DUT (
        .A(A),
        .B(B),
        .OP(OP),
        .Y(Y)
    );

    initial begin

        // =========================
        // ADDITION
        // =========================
//works perfectly:ZERO INPUT SANITY CHECK
        A = 4'b0000;
        B = 4'b0000;
        OP = 3'b000;
        #10;
  
//will hvae a carry overflow:It tells us whether
//carry propagates through all 4 full adders
//the final carry reaches Cout
//the 4-bit result wraps around correctly
        A = 4'b1111;
        B = 4'b0001;
        OP = 3'b000;
        #10;
//will have  a carry too,and overflow
        A = 4'b1111;
        B = 4'b1111;
        OP = 3'b000;
        #10;
//no carry
//but,result is 1000,which is in signed magnitude ,-8 so this tests SIGNED OVERFLOW
        A = 4'b0111;
        B = 4'b0001;
        OP = 3'b000;
        #10;


        // =========================
        // SUBTRACTION
        // =========================
//test for negative result
        A = 4'b0000;
        B = 4'b0001;
        OP = 3'b001;
        #10;
//SIMPLE CHECK FOR EASY VERIFICATION
        A = 4'b1010;
        B = 4'b1010;
        OP = 3'b001;
        #10;
//test for positive result
        A = 4'b1111;
        B = 4'b0001;
        OP = 3'b001;
        #10;
//extreme case:minimum-maximum
        A = 4'b0000;
        B = 4'b1111;
        OP = 3'b001;
        #10;


        // =========================
        // AND//extreme cases 
        // =========================

        A = 4'b0000;
        B = 4'b1111;
        OP = 3'b010;
        #10;

        A = 4'b1111;
        B = 4'b1111;
        OP = 3'b010;
        #10;


        // =========================
        // OR//extreme cases
        // =========================

        A = 4'b0000;
        B = 4'b0000;
        OP = 3'b011;
        #10;

        A = 4'b0000;
        B = 4'b1111;
        OP = 3'b011;
        #10;


        // ========================
      // XOR//basic properties ,A^A=0,A^(NOT A)=1
        // =========================

        A = 4'b1111;
        B = 4'b1111;
        OP = 3'b100;
        #10;

        A = 4'b0000;
        B = 4'b1111;
        OP = 3'b100;
        #10;


        // =========================
        // NOT
        // =========================

        A = 4'b0000;
        OP = 3'b101;
        #10;

        A = 4'b1111;
        OP = 3'b101;
        #10;


        // =========================
        // LEFT SHIFT
        // =========================

        A = 4'b0001;
        OP = 3'b110;
        #10;

        A = 4'b1111;
        OP = 3'b110;
        #10;


        // =========================
        // RIGHT SHIFT
        // =========================

        A = 4'b0001;
        OP = 3'b111;
        #10;

        A = 4'b1111;
        OP = 3'b111;
        #10;


        $finish;

    end

endmodule
```
