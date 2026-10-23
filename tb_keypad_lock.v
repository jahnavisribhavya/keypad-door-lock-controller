`timescale 1ns/1ps

module tb_keypad_lock;

    reg clk = 0;
    reg rst_n = 0;
    reg key_valid = 0;
    reg [3:0] key = 0;
    reg clear = 0;
    reg prog = 0;

    wire unlock, lockout, wrong, prog_active;

    keypad_lock #(
        .UNLOCK_CYCLES(10),
        .LOCKOUT_CYCLES(15)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .key_valid(key_valid),
        .key(key),
        .clear(clear),
        .prog(prog),
        .unlock(unlock),
        .lockout(lockout),
        .wrong(wrong),
        .prog_active(prog_active)
    );

    always #5 clk = ~clk;

    task press_digit(input [3:0] digit);
        begin
            @(negedge clk);
            key = digit;
            key_valid = 1;
            @(negedge clk);
            key_valid = 0;
        end
    endtask

    task enter_code(
        input [3:0] d3,
        input [3:0] d2,
        input [3:0] d1,
        input [3:0] d0
    );
        begin
            press_digit(d3);
            press_digit(d2);
            press_digit(d1);
            press_digit(d0);
            repeat (3) @(negedge clk);
        end
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_keypad_lock);

        $display("Starting keypad lock tests");

        repeat (2) @(negedge clk);
        rst_n = 1;
        repeat (2) @(negedge clk);

        if (!unlock && !lockout)
            $display("PASS: Reset state");
        else
            $display("FAIL: Reset state");

        $display("Test: Correct default password 1234");
        enter_code(1, 2, 3, 4);

        if (unlock)
            $display("PASS: Correct password unlocks");
        else
            $display("FAIL: Correct password did not unlock");

        repeat (12) @(negedge clk);

        if (!unlock)
            $display("PASS: Automatic relock");
        else
            $display("FAIL: Automatic relock");

        $display("Test: Three incorrect passwords");

        enter_code(9, 9, 9, 9);
        enter_code(9, 9, 9, 9);
        enter_code(9, 9, 9, 9);

        repeat (2) @(negedge clk);

        if (lockout)
            $display("PASS: Lockout after three wrong codes");
        else
            $display("FAIL: Lockout not asserted");

        repeat (18) @(negedge clk);

        if (!lockout)
            $display("PASS: Lockout expires");
        else
            $display("FAIL: Lockout did not expire");

        $display("Tests finished");
        $finish;
    end

    initial begin
        $monitor("t=%0t rst_n=%b unlock=%b lockout=%b wrong=%b prog=%b",
                 $time, rst_n, unlock, lockout, wrong, prog_active);
    end

endmodule
