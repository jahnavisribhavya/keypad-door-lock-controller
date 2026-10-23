`timescale 1ns/1ps

module keypad_lock #(
    parameter UNLOCK_CYCLES = 20,
    parameter LOCKOUT_CYCLES = 50
)(
    input clk,
    input rst_n,
    input key_valid,
    input [3:0] key,
    input clear,
    input prog,
    output reg unlock,
    output reg lockout,
    output reg wrong,
    output reg prog_active
);

    localparam ENTRY   = 3'd0;
    localparam CHECK   = 3'd1;
    localparam OPEN    = 3'd2;
    localparam LOCKOUT = 3'd3;
    localparam PROG    = 3'd4;

    reg [2:0] state;
    reg [15:0] entry;
    reg [15:0] stored_code;
    reg [2:0] digit_count;
    reg [1:0] fail_count;
    reg [15:0] timer;

    wire [15:0] next_entry = {entry[11:0], key};

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state       <= ENTRY;
            entry       <= 16'd0;
            stored_code <= 16'h1234;
            digit_count <= 0;
            fail_count  <= 0;
            timer       <= 0;
            unlock      <= 0;
            lockout     <= 0;
            wrong       <= 0;
            prog_active <= 0;
        end else begin
            wrong <= 0;

            case (state)
                ENTRY: begin
                    unlock      <= 0;
                    lockout     <= 0;
                    prog_active <= 0;

                    if (clear) begin
                        entry       <= 0;
                        digit_count <= 0;
                    end else if (key_valid) begin
                        entry <= next_entry;

                        if (digit_count == 3) begin
                            digit_count <= 0;
                            state <= CHECK;
                        end else begin
                            digit_count <= digit_count + 1'b1;
                        end
                    end
                end

                CHECK: begin
                    if (entry == stored_code) begin
                        unlock     <= 1;
                        fail_count <= 0;
                        timer      <= UNLOCK_CYCLES;
                        state      <= OPEN;
                    end else begin
                        wrong <= 1;
                        if (fail_count == 2) begin
                            fail_count <= 0;
                            timer      <= LOCKOUT_CYCLES;
                            lockout    <= 1;
                            state      <= LOCKOUT;
                        end else begin
                            fail_count <= fail_count + 1'b1;
                            state      <= ENTRY;
                        end
                    end
                    entry       <= 0;
                    digit_count <= 0;
                end

                OPEN: begin
                    unlock  <= 1;
                    lockout <= 0;

                    if (prog) begin
                        state       <= PROG;
                        entry       <= 0;
                        digit_count <= 0;
                        prog_active <= 1;
                    end else if (timer <= 1) begin
                        timer       <= 0;
                        unlock      <= 0;
                        prog_active <= 0;
                        state       <= ENTRY;
                    end else begin
                        timer <= timer - 1'b1;
                    end
                end

                PROG: begin
                    unlock      <= 1;
                    prog_active <= 1;

                    if (clear) begin
                        entry       <= 0;
                        digit_count <= 0;
                    end else if (key_valid) begin
                        entry <= next_entry;

                        if (digit_count == 3) begin
                            stored_code <= next_entry;
                            entry       <= 0;
                            digit_count <= 0;
                            prog_active <= 0;
                            timer       <= UNLOCK_CYCLES;
                            state       <= OPEN;
                        end else begin
                            digit_count <= digit_count + 1'b1;
                        end
                    end
                end

                LOCKOUT: begin
                    unlock      <= 0;
                    lockout     <= 1;
                    prog_active <= 0;

                    if (timer <= 1) begin
                        timer       <= 0;
                        lockout     <= 0;
                        entry       <= 0;
                        digit_count <= 0;
                        state       <= ENTRY;
                    end else begin
                        timer <= timer - 1'b1;
                    end
                end

                default: begin
                    state <= ENTRY;
                end
            endcase
        end
    end
endmodule
