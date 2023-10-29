module tb_vending_machine ();
wire x,y;
reg clk,rst,i,j;

vending_machine DUT( clk,rst,i,j,x,y );

initial 
begin
clk = 0;
forever #10 clk = ~clk;
end

task rst_t ();
begin
@(negedge clk);
rst = 1'b1;
@(negedge clk);
rst = 1'b0;
end
endtask

task initialise();
begin
i = 0;
j = 0;
end
endtask

task stimulus_i (input in);
begin
@(negedge clk);
i = in;
end
endtask

task stimulus_j (input jn);
begin
@(negedge clk);
j = jn;
end
endtask

always @( DUT.ps or x or y)
begin
begin
if (x==1)
$display ("Product delivered");
else 
$display ("Product not delivered");
end
begin
if (y==1)
$display ("Return coin required");
else
$display ("Return coin not required");
end
end

initial 
begin
initialise;
rst_t;
stimulus_i(0);
stimulus_j(0);
stimulus_i(0);
stimulus_j(1);
stimulus_i(1);
stimulus_j(0);
stimulus_i(1);
stimulus_j(1);
rst_t;
stimulus_i(0);
stimulus_j(0);
stimulus_i(0);
stimulus_j(1);
stimulus_i(1);
stimulus_j(0);
stimulus_i(1);
stimulus_j(1);
#100;
$finish;
end

initial
$monitor ("clk=%b, rst=%b, i=%b, j=%b, x=%b, y=%b", clk,rst,i,j,x,y);

endmodule
