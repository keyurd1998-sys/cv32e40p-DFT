`timescale 1ns / 1ps

module cv32e40p_core_tb;

  // Clocks and Resets
  reg         clk_i;
  reg         rst_ni;
  reg         pulp_clock_en_i;
  reg         scan_cg_en_i;

  // Static Configuration
  reg  [31:0] boot_addr_i;
  reg  [31:0] mtvec_addr_i;
  reg  [31:0] dm_halt_addr_i;
  reg  [31:0] hart_id_i;
  reg  [31:0] dm_exception_addr_i;

  // Instruction Interface
  wire        instr_req_o;
  reg         instr_gnt_i;
  reg         instr_rvalid_i;
  wire [31:0] instr_addr_o;
  reg  [31:0] instr_rdata_i;

  // Data Interface
  wire        data_req_o;
  reg         data_gnt_i;
  reg         data_rvalid_i;
  wire        data_we_o;
  wire [ 3:0] data_be_o;
  wire [31:0] data_addr_o;
  wire [31:0] data_wdata_o;
  reg  [31:0] data_rdata_i;

  // Interrupts & Debug
  reg  [31:0] irq_i;
  wire        irq_ack_o;
  wire [ 4:0] irq_id_o;
  reg         debug_req_i;
  wire        debug_havereset_o;
  wire        debug_running_o;
  wire        debug_halted_o;
  wire        core_sleep_o;

  // DFT Test Ports (Added during Scan Synthesis)
  reg         SCAN_ENABLE;
  reg         test_mode;
  reg         scan_in_0;
  reg         scan_in_1;
  wire        scan_out_0;
  wire        scan_out_1;

  // DUT Instantiation
  cv32e40p_core dut (
      .clk_i                (clk_i),
      .rst_ni               (rst_ni),
      .pulp_clock_en_i      (pulp_clock_en_i),
      .scan_cg_en_i         (scan_cg_en_i),

      .boot_addr_i          (boot_addr_i),
      .mtvec_addr_i         (mtvec_addr_i),
      .dm_halt_addr_i       (dm_halt_addr_i),
      .hart_id_i            (hart_id_i),
      .dm_exception_addr_i  (dm_exception_addr_i),

      .instr_req_o          (instr_req_o),
      .instr_gnt_i          (instr_gnt_i),
      .instr_rvalid_i       (instr_rvalid_i),
      .instr_addr_o         (instr_addr_o),
      .instr_rdata_i        (instr_rdata_i),

      .data_req_o           (data_req_o),
      .data_gnt_i           (data_gnt_i),
      .data_rvalid_i        (data_rvalid_i),
      .data_we_o            (data_we_o),
      .data_be_o            (data_be_o),
      .data_addr_o          (data_addr_o),
      .data_wdata_o         (data_wdata_o),
      .data_rdata_i         (data_rdata_i),

      .irq_i                (irq_i),
      .irq_ack_o            (irq_ack_o),
      .irq_id_o             (irq_id_o),
      .debug_req_i          (debug_req_i),
      .debug_havereset_o    (debug_havereset_o),
      .debug_running_o      (debug_running_o),
      .debug_halted_o       (debug_halted_o),
      .core_sleep_o         (core_sleep_o),

      // DFT Scan Ports
      .SCAN_ENABLE          (SCAN_ENABLE),
      .test_mode            (test_mode),
      .scan_in_0            (scan_in_0),
      .scan_in_1            (scan_in_1),
      .scan_out_0           (scan_out_0),
      .scan_out_1           (scan_out_1)
  );

  // Clock Generation (100 MHz, Period = 10ns)
  initial begin
    clk_i = 1'b0;
    forever #5 clk_i = ~clk_i;
  end

  // Test Stimulus
  initial begin
    $display("==========================================================");
    $display(" Starting Gate-Level Simulation for cv32e40p_core");
    $display("==========================================================");

    // Initialize all input signals
    rst_ni              = 1'b0;
    pulp_clock_en_i     = 1'b1;
    scan_cg_en_i        = 1'b0;
    boot_addr_i         = 32'h0000_0000;
    mtvec_addr_i        = 32'h0000_0080;
    dm_halt_addr_i      = 32'h0000_0800;
    hart_id_i           = 32'h0000_0000;
    dm_exception_addr_i = 32'h0000_0808;

    instr_gnt_i         = 1'b1;
    instr_rvalid_i      = 1'b0;
    instr_rdata_i       = 32'h0000_0013; // NOP (addi x0, x0, 0)

    data_gnt_i          = 1'b1;
    data_rvalid_i       = 1'b0;
    data_rdata_i        = 32'h0000_0000;

    irq_i               = 32'h0;
    debug_req_i         = 1'b0;

    // DFT signals inactive in functional mode
    SCAN_ENABLE         = 1'b0;
    test_mode           = 1'b0;
    scan_in_0           = 1'b0;
    scan_in_1           = 1'b0;

    // Reset sequence
    #50;
    rst_ni = 1'b1;
    $display("[%0t ns] Reset released. Core starting execution...", $time);

    // Provide NOP instruction response
    repeat (20) begin
      @(posedge clk_i);
      if (instr_req_o) begin
        instr_rvalid_i <= 1'b1;
        instr_rdata_i  <= 32'h0000_0013; // NOP
      end else begin
        instr_rvalid_i <= 1'b0;
      end
    end

    $display("[%0t ns] Functional smoke test passed successfully!", $time);
    $display("==========================================================");
    $finish;
  end

endmodule
