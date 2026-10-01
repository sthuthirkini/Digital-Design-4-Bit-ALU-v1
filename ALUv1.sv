```systemverilog
`timescale 1ns/1ps

// ========================================
// 1-BIT FULL ADDER
// ========================================

module full_adder (
    input  logic A,
    input  logic B,
    input  logic Cin,
    output logic Sum,
    output logic Cout
);

    assign Sum  = A ^ B ^ Cin;
    assign Cout = (A & B) | (A & Cin) | (B & Cin);

endmodule


// ========================================
// 4-BIT ADDER / SUBTRACTOR
// ========================================

module add_sub (
    input  logic [3:0] A,
    input logic [3:0] B,
    input logic SUB,

    output logic [3:0] Y,
    output logic Cout
);

    logic [3:0] B_modified;
    logic [4:0] carry;

    // If SUB = 0:
    // B_modified = B
    //
    // If SUB = 1:
    // B_modified = ~B
    assign B_modified = B ^ {4{SUB}};

    // SUB = 0 → Cin = 0 → A + B
    // SUB = 1 → Cin = 1 → A + ~B + 1
    assign carry[0] = SUB;


    // Bit 0
    full_adder FA0 (
        .A(A[0]),
        .B(B_modified[0]),
        .Cin(carry[0]),
        .Sum(Y[0]),
        .Cout(carry[1])
    );


    // Bit 1
    full_adder FA1 (
        .A(A[1]),
        .B(B_modified[1]),
        .Cin(carry[1]),
        .Sum(Y[1]),
        .Cout(carry[2])
    );


    // Bit 2
    full_adder FA2 (
        .A(A[2]),
        .B(B_modified[2]),
        .Cin(carry[2]),
        .Sum(Y[2]),
        .Cout(carry[3])
    );


    // Bit 3
    full_adder FA3 (
        .A(A[3]),
        .B(B_modified[3]),
        .Cin(carry[3]),
        .Sum(Y[3]),
        .Cout(carry[4])
    );


    // Final carry
    assign Cout = carry[4];

endmodule


// ========================================
// 4-BIT ALU
// ========================================

module alu (
    input  logic [3:0] A,
    input  logic [3:0] B,
    input  logic [2:0] OP,

    output logic [3:0] Y
);

    // Results of individual operations
    logic [3:0] add_sub_result;
    logic [3:0] and_result;
    logic [3:0] or_result;
    logic [3:0] xor_result;
    logic [3:0] not_result;
    logic [3:0] left_shift_result;
    logic [3:0] right_shift_result;

    // Carry from arithmetic unit
    logic Cout;


    // ========================================
    // ADD / SUB UNIT
    // ========================================

    add_sub arithmetic_unit (
        .A(A),
        .B(B),

        // OP = 001 means subtraction
        .SUB(OP == 3'b001),

        .Y(add_sub_result),
        .Cout(Cout)
    );


    // ========================================
    // LOGIC OPERATIONS
    // ========================================

    assign and_result = A & B;

    assign or_result = A | B;

    assign xor_result = A ^ B;

    assign not_result = ~A;


    // ========================================
    // SHIFT OPERATIONS
    // ========================================

    assign left_shift_result = A << 1;

    assign right_shift_result = A >> 1;


    // ========================================
    // OUTPUT MUX
    // ========================================

    always_comb begin

        case (OP)

            3'b000: Y = add_sub_result;       // ADD
            3'b001: Y = add_sub_result;       // SUB
            3'b010: Y = and_result;           // AND
            3'b011: Y = or_result;            // OR
            3'b100: Y = xor_result;           // XOR
            3'b101: Y = not_result;           // NOT A
            3'b110: Y = left_shift_result;    // A << 1
            3'b111: Y = right_shift_result;   // A >> 1

        endcase

    end

endmodule
```
