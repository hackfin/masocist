
module dpram_init_hex_12_32_72e37af6608168e44579987c78f6ad378f80083d #(
	parameter DATA = 32,
	parameter ADDR = 12
) (

	// Port A
	input	wire				clk,
	input	wire				a_ce,
	input	wire				a_we,
	input	wire	[ADDR-1:0]	a_addr,
	input	wire	[DATA-1:0]	a_write,
	output	reg		[DATA-1:0]	a_read,

	// Port B
	input	wire				b_ce,
	input	wire				b_we,
	input	wire	[ADDR-1:0]	b_addr,
	input	wire	[DATA-1:0]	b_write,
	output	reg		[DATA-1:0]	b_read
);

// Shared memory
(* ramstyle = "block_ram" *) reg [DATA-1:0] mem [(2**ADDR)-1:0] /* synthesis syn_ramstyle="block_ram" */;

initial begin
	$readmemh("../sw/bootrom32.hex", mem);
end

reg [ADDR-1:0] addr_b;
reg [ADDR-1:0] addr_a;


// Note we got A/B ports swapped to support writing to ROM, for the
// time being

assign a_read = mem[addr_a];
assign b_read = mem[addr_b];

always @(posedge clk) begin: DUAL_RAW_PORT_A_PROC
    addr_a <= a_addr;
end


always @(posedge clk) begin: DUAL_RAW_PORT_B_PROC
    addr_b <= b_addr;
    if (b_we) begin
        mem[b_addr] <= b_write;
    end
end


endmodule


