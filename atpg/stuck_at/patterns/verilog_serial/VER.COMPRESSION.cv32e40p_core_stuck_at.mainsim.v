//***************************************************************************//
//                           VERILOG MAINSIM FILE                            //
// Modus(TM) DFT Software Solution, Version 25.10-p027_1, built Mar 13 2025  //
//***************************************************************************//
//                                                                           //
//  FILE CREATED..............October 18, 2026 at 18:05:06                   //
//                                                                           //
//  PROJECT NAME..............stuck_at                                       //
//                                                                           //
//  TESTMODE..................COMPRESSION                                    //
//                                                                           //
//  INEXPERIMENT..............cv32e40p_core_stuck_at                         //
//                                                                           //
//  TDR.......................dummy.tdr                                      //
//                                                                           //
//  TEST PERIOD...............80.000   TEST TIME UNITS...........ns          //
//  TEST PULSE WIDTH..........8.000                                          //
//  TEST STROBE OFFSET........72.000   TEST STROBE TYPE..........edge        //
//  TEST BIDI OFFSET..........0.000                                          //
//  TEST PI OFFSET............0.000    X VALUE...................X           //
//                                                                           //
//  SCAN FORMAT...............serial   SCAN OVERLAP..............yes         //
//  SCAN PERIOD...............80.000   SCAN TIME UNITS...........ns          //
//  SCAN PULSE WIDTH..........8.000                                          //
//  SCAN STROBE OFFSET........8.000    SCAN STROBE TYPE..........edge        //
//  SCAN BIDI OFFSET..........0.000                                          //
//  SCAN PI OFFSET............0.000    X VALUE...................X           //
//                                                                           //
//                                                                           //
//   Individually set PIs                                                    //
//  "DFT_mask_clk" (PI # 2)                                                  //
//  TEST OFFSET...............0.000                                          //
//  SCAN OFFSET...............16.000   PULSE WIDTH...............8.000       //
//                                                                           //
//  "clk_i" (PI # 76)                                                        //
//  TEST OFFSET...............8.000    PULSE WIDTH...............8.000       //
//  SCAN OFFSET...............16.000   PULSE WIDTH...............8.000       //
//                                                                           //
//  "rst_ni" (PI # 308)                                                      //
//  TEST OFFSET...............8.000    PULSE WIDTH...............8.000       //
//  SCAN OFFSET...............0.000                                          //
//                                                                           //
//  Active TESTMODEs TM = 1 ..COMPRESSION                                    //
//                                                                           //
//***************************************************************************//

// Command Line: write_vectors -WORKDIR /home/admin/DFT/cv32e40p-DFT/atpg/stuck_at -TESTMODE COMPRESSION -INEXPERIMENT cv32e40p_core_stuck_at -EXPORTDIR ./patterns/verilog_serial -language verilog -scanformat serial

  `timescale 1 ns / 1 ps

  module stuck_at_COMPRESSION_cv32e40p_core_stuck_at ;

//***************************************************************************//
//                DEFINE VARIABLES FOR ALL PRIMARY I/O PORTS                 //
//***************************************************************************//

  reg [1:312] stim_PIs;   
  reg [1:312] part_PIs;   

  reg [1:312] stim_CIs;   

  reg [1:234] meas_POs;   
  wire [1:234] part_POs;   

//***************************************************************************//
//                   DEFINE VARIABLES FOR ALL SHIFT CHAINS                   //
//***************************************************************************//

  reg [1:14] stim_CR_1;   reg [1:14] stim_CR_2;   

  reg [1:14] meas_OR_1;   reg [1:14] meas_OR_2;   


//***************************************************************************//
//       DEFINE VARIABLES FOR ALL CHANNEL MASK AND MASK ENABLE CHAINS        //
//***************************************************************************//

  reg [1:77] stim_CMSR_1;   reg [1:77] stim_CMSR_2;   



  reg [1:14] stim_CME_0;   

//***************************************************************************//
//                             OTHER DEFINITIONS                             //
//***************************************************************************//

  integer  CYCLE, SCANCYCLE, SERIALCYCLE, PInum, POnum, ORnum, MODENUM, EXPNUM, SCANOPNUM, SEQNUM, TASKNUM, START, NUM_SHIFTS, MultiShift, maxMultiShifts, MultiShiftsLeft, forcePointStart, forcePoint, SCANNUM, FREQNUM ; 
  integer  CMD, DATAID, SAVEID, TID, num_files, rc_read, repeat_depth, repeat_heart, MAX, FAILSETID, DIAG_DATAID; 
  integer  test_num, test_num_prev, failed_test_num, num_tests, num_failed_tests, total_num_tests, total_num_failed_tests, total_cycles, scan_num, overlap; 
  integer  repeat_num  [1:15]; 
  integer  num_repeats [1:15]; 
  reg      [1:8185] name_POs [1:234]; 
  reg      [130:0] good_compares, miscompares, miscompare_limit, total_good_compares, total_miscompares, measure_current; 
  reg      [63:0] start_of_repeat [1:15]; 
  reg      [63:0] start_of_current_line, fseek_offset; 
  reg      [130:0] line_number, save_line_number; 
  reg      count_cycles, sim_trace, sim_heart, sim_range, sim_range_measure, failset, global_term, sim_debug, sim_more_debug, diag_debug; 
  reg      [1:800] PATTERN, pattern, TESTFILE, INITFILE, SOD, EOD, eventID, DIAG_DEBUG_FILE; 
  reg      [1:8184] DATAFILE, SAVEFILE, COMMENT, FAILSET; 
  reg      [1:4096] PROCESSNAME; 

//***************************************************************************//
//        INSTANTIATE THE STRUCTURE AND CONNECT TO VERILOG VARIABLES         //
//***************************************************************************//

  cv32e40p_core
    cv32e40p_core_inst (
      .clk_i                  ( part_PIs[0076] ),      // pinName = clk_i;  tf = -ES  ; testOffset = 8.000000;  scanOffset = 16.000000;  
      .rst_ni                 ( part_PIs[0308] ),      // pinName = rst_ni;  tf = +SC  ; testOffset = 8.000000;  scanOffset = 0.000000;  
      .pulp_clock_en_i        ( part_PIs[0307] ),      // pinName = pulp_clock_en_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      .scan_cg_en_i           ( part_PIs[0309] ),      // pinName = scan_cg_en_i;  tf = +TI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      .boot_addr_i            ({part_PIs[0068]  ,      // pinName = boot_addr_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0067]  ,      // pinName = boot_addr_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0065]  ,      // pinName = boot_addr_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0064]  ,      // pinName = boot_addr_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0063]  ,      // pinName = boot_addr_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0062]  ,      // pinName = boot_addr_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0061]  ,      // pinName = boot_addr_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0060]  ,      // pinName = boot_addr_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0059]  ,      // pinName = boot_addr_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0058]  ,      // pinName = boot_addr_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0057]  ,      // pinName = boot_addr_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0056]  ,      // pinName = boot_addr_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0054]  ,      // pinName = boot_addr_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0053]  ,      // pinName = boot_addr_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0052]  ,      // pinName = boot_addr_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0051]  ,      // pinName = boot_addr_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0050]  ,      // pinName = boot_addr_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0049]  ,      // pinName = boot_addr_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0048]  ,      // pinName = boot_addr_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0047]  ,      // pinName = boot_addr_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0046]  ,      // pinName = boot_addr_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0045]  ,      // pinName = boot_addr_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0075]  ,      // pinName = boot_addr_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0074]  ,      // pinName = boot_addr_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0073]  ,      // pinName = boot_addr_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0072]  ,      // pinName = boot_addr_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0071]  ,      // pinName = boot_addr_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0070]  ,      // pinName = boot_addr_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0069]  ,      // pinName = boot_addr_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0066]  ,      // pinName = boot_addr_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0055]  ,      // pinName = boot_addr_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0044]}),      // pinName = boot_addr_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      .mtvec_addr_i           ({part_PIs[0299]  ,      // pinName = mtvec_addr_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0298]  ,      // pinName = mtvec_addr_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0296]  ,      // pinName = mtvec_addr_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0295]  ,      // pinName = mtvec_addr_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0294]  ,      // pinName = mtvec_addr_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0293]  ,      // pinName = mtvec_addr_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0292]  ,      // pinName = mtvec_addr_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0291]  ,      // pinName = mtvec_addr_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0290]  ,      // pinName = mtvec_addr_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0289]  ,      // pinName = mtvec_addr_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0288]  ,      // pinName = mtvec_addr_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0287]  ,      // pinName = mtvec_addr_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0285]  ,      // pinName = mtvec_addr_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0284]  ,      // pinName = mtvec_addr_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0283]  ,      // pinName = mtvec_addr_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0282]  ,      // pinName = mtvec_addr_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0281]  ,      // pinName = mtvec_addr_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0280]  ,      // pinName = mtvec_addr_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0279]  ,      // pinName = mtvec_addr_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0278]  ,      // pinName = mtvec_addr_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0277]  ,      // pinName = mtvec_addr_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0276]  ,      // pinName = mtvec_addr_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0306]  ,      // pinName = mtvec_addr_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0305]  ,      // pinName = mtvec_addr_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0304]  ,      // pinName = mtvec_addr_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0303]  ,      // pinName = mtvec_addr_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0302]  ,      // pinName = mtvec_addr_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0301]  ,      // pinName = mtvec_addr_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0300]  ,      // pinName = mtvec_addr_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0297]  ,      // pinName = mtvec_addr_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0286]  ,      // pinName = mtvec_addr_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0275]}),      // pinName = mtvec_addr_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      .dm_halt_addr_i         ({part_PIs[0168]  ,      // pinName = dm_halt_addr_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0167]  ,      // pinName = dm_halt_addr_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0165]  ,      // pinName = dm_halt_addr_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0164]  ,      // pinName = dm_halt_addr_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0163]  ,      // pinName = dm_halt_addr_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0162]  ,      // pinName = dm_halt_addr_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0161]  ,      // pinName = dm_halt_addr_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0160]  ,      // pinName = dm_halt_addr_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0159]  ,      // pinName = dm_halt_addr_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0158]  ,      // pinName = dm_halt_addr_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0157]  ,      // pinName = dm_halt_addr_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0156]  ,      // pinName = dm_halt_addr_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0154]  ,      // pinName = dm_halt_addr_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0153]  ,      // pinName = dm_halt_addr_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0152]  ,      // pinName = dm_halt_addr_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0151]  ,      // pinName = dm_halt_addr_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0150]  ,      // pinName = dm_halt_addr_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0149]  ,      // pinName = dm_halt_addr_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0148]  ,      // pinName = dm_halt_addr_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0147]  ,      // pinName = dm_halt_addr_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0146]  ,      // pinName = dm_halt_addr_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0145]  ,      // pinName = dm_halt_addr_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0175]  ,      // pinName = dm_halt_addr_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0174]  ,      // pinName = dm_halt_addr_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0173]  ,      // pinName = dm_halt_addr_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0172]  ,      // pinName = dm_halt_addr_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0171]  ,      // pinName = dm_halt_addr_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0170]  ,      // pinName = dm_halt_addr_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0169]  ,      // pinName = dm_halt_addr_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0166]  ,      // pinName = dm_halt_addr_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0155]  ,      // pinName = dm_halt_addr_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0144]}),      // pinName = dm_halt_addr_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      .hart_id_i              ({part_PIs[0201]  ,      // pinName = hart_id_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0200]  ,      // pinName = hart_id_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0198]  ,      // pinName = hart_id_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0197]  ,      // pinName = hart_id_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0196]  ,      // pinName = hart_id_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0195]  ,      // pinName = hart_id_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0194]  ,      // pinName = hart_id_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0193]  ,      // pinName = hart_id_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0192]  ,      // pinName = hart_id_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0191]  ,      // pinName = hart_id_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0190]  ,      // pinName = hart_id_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0189]  ,      // pinName = hart_id_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0187]  ,      // pinName = hart_id_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0186]  ,      // pinName = hart_id_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0185]  ,      // pinName = hart_id_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0184]  ,      // pinName = hart_id_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0183]  ,      // pinName = hart_id_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0182]  ,      // pinName = hart_id_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0181]  ,      // pinName = hart_id_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0180]  ,      // pinName = hart_id_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0179]  ,      // pinName = hart_id_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0178]  ,      // pinName = hart_id_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0208]  ,      // pinName = hart_id_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0207]  ,      // pinName = hart_id_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0206]  ,      // pinName = hart_id_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0205]  ,      // pinName = hart_id_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0204]  ,      // pinName = hart_id_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0203]  ,      // pinName = hart_id_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0202]  ,      // pinName = hart_id_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0199]  ,      // pinName = hart_id_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0188]  ,      // pinName = hart_id_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0177]}),      // pinName = hart_id_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      .dm_exception_addr_i    ({part_PIs[0136]  ,      // pinName = dm_exception_addr_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0135]  ,      // pinName = dm_exception_addr_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0133]  ,      // pinName = dm_exception_addr_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0132]  ,      // pinName = dm_exception_addr_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0131]  ,      // pinName = dm_exception_addr_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0130]  ,      // pinName = dm_exception_addr_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0129]  ,      // pinName = dm_exception_addr_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0128]  ,      // pinName = dm_exception_addr_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0127]  ,      // pinName = dm_exception_addr_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0126]  ,      // pinName = dm_exception_addr_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0125]  ,      // pinName = dm_exception_addr_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0124]  ,      // pinName = dm_exception_addr_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0122]  ,      // pinName = dm_exception_addr_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0121]  ,      // pinName = dm_exception_addr_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0120]  ,      // pinName = dm_exception_addr_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0119]  ,      // pinName = dm_exception_addr_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0118]  ,      // pinName = dm_exception_addr_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0117]  ,      // pinName = dm_exception_addr_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0116]  ,      // pinName = dm_exception_addr_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0115]  ,      // pinName = dm_exception_addr_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0114]  ,      // pinName = dm_exception_addr_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0113]  ,      // pinName = dm_exception_addr_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0143]  ,      // pinName = dm_exception_addr_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0142]  ,      // pinName = dm_exception_addr_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0141]  ,      // pinName = dm_exception_addr_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0140]  ,      // pinName = dm_exception_addr_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0139]  ,      // pinName = dm_exception_addr_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0138]  ,      // pinName = dm_exception_addr_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0137]  ,      // pinName = dm_exception_addr_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0134]  ,      // pinName = dm_exception_addr_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0123]  ,      // pinName = dm_exception_addr_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0112]}),      // pinName = dm_exception_addr_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      .instr_req_o            ( part_POs[0226] ),      // pinName = instr_req_o; 
      .instr_gnt_i            ( part_PIs[0209] ),      // pinName = instr_gnt_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      .instr_rvalid_i         ( part_PIs[0242] ),      // pinName = instr_rvalid_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      .instr_addr_o           ({part_POs[0218]  ,      // pinName = instr_addr_o[31]; 
                                part_POs[0217]  ,      // pinName = instr_addr_o[30]; 
                                part_POs[0215]  ,      // pinName = instr_addr_o[29]; 
                                part_POs[0214]  ,      // pinName = instr_addr_o[28]; 
                                part_POs[0213]  ,      // pinName = instr_addr_o[27]; 
                                part_POs[0212]  ,      // pinName = instr_addr_o[26]; 
                                part_POs[0211]  ,      // pinName = instr_addr_o[25]; 
                                part_POs[0210]  ,      // pinName = instr_addr_o[24]; 
                                part_POs[0209]  ,      // pinName = instr_addr_o[23]; 
                                part_POs[0208]  ,      // pinName = instr_addr_o[22]; 
                                part_POs[0207]  ,      // pinName = instr_addr_o[21]; 
                                part_POs[0206]  ,      // pinName = instr_addr_o[20]; 
                                part_POs[0204]  ,      // pinName = instr_addr_o[19]; 
                                part_POs[0203]  ,      // pinName = instr_addr_o[18]; 
                                part_POs[0202]  ,      // pinName = instr_addr_o[17]; 
                                part_POs[0201]  ,      // pinName = instr_addr_o[16]; 
                                part_POs[0200]  ,      // pinName = instr_addr_o[15]; 
                                part_POs[0199]  ,      // pinName = instr_addr_o[14]; 
                                part_POs[0198]  ,      // pinName = instr_addr_o[13]; 
                                part_POs[0197]  ,      // pinName = instr_addr_o[12]; 
                                part_POs[0196]  ,      // pinName = instr_addr_o[11]; 
                                part_POs[0195]  ,      // pinName = instr_addr_o[10]; 
                                part_POs[0225]  ,      // pinName = instr_addr_o[9]; 
                                part_POs[0224]  ,      // pinName = instr_addr_o[8]; 
                                part_POs[0223]  ,      // pinName = instr_addr_o[7]; 
                                part_POs[0222]  ,      // pinName = instr_addr_o[6]; 
                                part_POs[0221]  ,      // pinName = instr_addr_o[5]; 
                                part_POs[0220]  ,      // pinName = instr_addr_o[4]; 
                                part_POs[0219]  ,      // pinName = instr_addr_o[3]; 
                                part_POs[0216]  ,      // pinName = instr_addr_o[2]; 
                                part_POs[0205]  ,      // pinName = instr_addr_o[1]; 
                                part_POs[0194]}),      // pinName = instr_addr_o[0]; 
      .instr_rdata_i          ({part_PIs[0234]  ,      // pinName = instr_rdata_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0233]  ,      // pinName = instr_rdata_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0231]  ,      // pinName = instr_rdata_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0230]  ,      // pinName = instr_rdata_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0229]  ,      // pinName = instr_rdata_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0228]  ,      // pinName = instr_rdata_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0227]  ,      // pinName = instr_rdata_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0226]  ,      // pinName = instr_rdata_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0225]  ,      // pinName = instr_rdata_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0224]  ,      // pinName = instr_rdata_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0223]  ,      // pinName = instr_rdata_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0222]  ,      // pinName = instr_rdata_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0220]  ,      // pinName = instr_rdata_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0219]  ,      // pinName = instr_rdata_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0218]  ,      // pinName = instr_rdata_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0217]  ,      // pinName = instr_rdata_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0216]  ,      // pinName = instr_rdata_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0215]  ,      // pinName = instr_rdata_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0214]  ,      // pinName = instr_rdata_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0213]  ,      // pinName = instr_rdata_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0212]  ,      // pinName = instr_rdata_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0211]  ,      // pinName = instr_rdata_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0241]  ,      // pinName = instr_rdata_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0240]  ,      // pinName = instr_rdata_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0239]  ,      // pinName = instr_rdata_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0238]  ,      // pinName = instr_rdata_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0237]  ,      // pinName = instr_rdata_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0236]  ,      // pinName = instr_rdata_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0235]  ,      // pinName = instr_rdata_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0232]  ,      // pinName = instr_rdata_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0221]  ,      // pinName = instr_rdata_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0210]}),      // pinName = instr_rdata_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      .data_req_o             ( part_POs[0157] ),      // pinName = data_req_o; 
      .data_gnt_i             ( part_PIs[0077] ),      // pinName = data_gnt_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      .data_rvalid_i          ( part_PIs[0110] ),      // pinName = data_rvalid_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      .data_we_o              ( part_POs[0190] ),      // pinName = data_we_o; 
      .data_be_o              ({part_POs[0156]  ,      // pinName = data_be_o[3]; 
                                part_POs[0155]  ,      // pinName = data_be_o[2]; 
                                part_POs[0154]  ,      // pinName = data_be_o[1]; 
                                part_POs[0153]}),      // pinName = data_be_o[0]; 
      .data_addr_o            ({part_POs[0145]  ,      // pinName = data_addr_o[31]; 
                                part_POs[0144]  ,      // pinName = data_addr_o[30]; 
                                part_POs[0142]  ,      // pinName = data_addr_o[29]; 
                                part_POs[0141]  ,      // pinName = data_addr_o[28]; 
                                part_POs[0140]  ,      // pinName = data_addr_o[27]; 
                                part_POs[0139]  ,      // pinName = data_addr_o[26]; 
                                part_POs[0138]  ,      // pinName = data_addr_o[25]; 
                                part_POs[0137]  ,      // pinName = data_addr_o[24]; 
                                part_POs[0136]  ,      // pinName = data_addr_o[23]; 
                                part_POs[0135]  ,      // pinName = data_addr_o[22]; 
                                part_POs[0134]  ,      // pinName = data_addr_o[21]; 
                                part_POs[0133]  ,      // pinName = data_addr_o[20]; 
                                part_POs[0131]  ,      // pinName = data_addr_o[19]; 
                                part_POs[0130]  ,      // pinName = data_addr_o[18]; 
                                part_POs[0129]  ,      // pinName = data_addr_o[17]; 
                                part_POs[0128]  ,      // pinName = data_addr_o[16]; 
                                part_POs[0127]  ,      // pinName = data_addr_o[15]; 
                                part_POs[0126]  ,      // pinName = data_addr_o[14]; 
                                part_POs[0125]  ,      // pinName = data_addr_o[13]; 
                                part_POs[0124]  ,      // pinName = data_addr_o[12]; 
                                part_POs[0123]  ,      // pinName = data_addr_o[11]; 
                                part_POs[0122]  ,      // pinName = data_addr_o[10]; 
                                part_POs[0152]  ,      // pinName = data_addr_o[9]; 
                                part_POs[0151]  ,      // pinName = data_addr_o[8]; 
                                part_POs[0150]  ,      // pinName = data_addr_o[7]; 
                                part_POs[0149]  ,      // pinName = data_addr_o[6]; 
                                part_POs[0148]  ,      // pinName = data_addr_o[5]; 
                                part_POs[0147]  ,      // pinName = data_addr_o[4]; 
                                part_POs[0146]  ,      // pinName = data_addr_o[3]; 
                                part_POs[0143]  ,      // pinName = data_addr_o[2]; 
                                part_POs[0132]  ,      // pinName = data_addr_o[1]; 
                                part_POs[0121]}),      // pinName = data_addr_o[0]; 
      .data_wdata_o           ({part_POs[0182]  ,      // pinName = data_wdata_o[31]; 
                                part_POs[0181]  ,      // pinName = data_wdata_o[30]; 
                                part_POs[0179]  ,      // pinName = data_wdata_o[29]; 
                                part_POs[0178]  ,      // pinName = data_wdata_o[28]; 
                                part_POs[0177]  ,      // pinName = data_wdata_o[27]; 
                                part_POs[0176]  ,      // pinName = data_wdata_o[26]; 
                                part_POs[0175]  ,      // pinName = data_wdata_o[25]; 
                                part_POs[0174]  ,      // pinName = data_wdata_o[24]; 
                                part_POs[0173]  ,      // pinName = data_wdata_o[23]; 
                                part_POs[0172]  ,      // pinName = data_wdata_o[22]; 
                                part_POs[0171]  ,      // pinName = data_wdata_o[21]; 
                                part_POs[0170]  ,      // pinName = data_wdata_o[20]; 
                                part_POs[0168]  ,      // pinName = data_wdata_o[19]; 
                                part_POs[0167]  ,      // pinName = data_wdata_o[18]; 
                                part_POs[0166]  ,      // pinName = data_wdata_o[17]; 
                                part_POs[0165]  ,      // pinName = data_wdata_o[16]; 
                                part_POs[0164]  ,      // pinName = data_wdata_o[15]; 
                                part_POs[0163]  ,      // pinName = data_wdata_o[14]; 
                                part_POs[0162]  ,      // pinName = data_wdata_o[13]; 
                                part_POs[0161]  ,      // pinName = data_wdata_o[12]; 
                                part_POs[0160]  ,      // pinName = data_wdata_o[11]; 
                                part_POs[0159]  ,      // pinName = data_wdata_o[10]; 
                                part_POs[0189]  ,      // pinName = data_wdata_o[9]; 
                                part_POs[0188]  ,      // pinName = data_wdata_o[8]; 
                                part_POs[0187]  ,      // pinName = data_wdata_o[7]; 
                                part_POs[0186]  ,      // pinName = data_wdata_o[6]; 
                                part_POs[0185]  ,      // pinName = data_wdata_o[5]; 
                                part_POs[0184]  ,      // pinName = data_wdata_o[4]; 
                                part_POs[0183]  ,      // pinName = data_wdata_o[3]; 
                                part_POs[0180]  ,      // pinName = data_wdata_o[2]; 
                                part_POs[0169]  ,      // pinName = data_wdata_o[1]; 
                                part_POs[0158]}),      // pinName = data_wdata_o[0]; 
      .data_rdata_i           ({part_PIs[0102]  ,      // pinName = data_rdata_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0101]  ,      // pinName = data_rdata_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0099]  ,      // pinName = data_rdata_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0098]  ,      // pinName = data_rdata_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0097]  ,      // pinName = data_rdata_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0096]  ,      // pinName = data_rdata_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0095]  ,      // pinName = data_rdata_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0094]  ,      // pinName = data_rdata_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0093]  ,      // pinName = data_rdata_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0092]  ,      // pinName = data_rdata_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0091]  ,      // pinName = data_rdata_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0090]  ,      // pinName = data_rdata_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0088]  ,      // pinName = data_rdata_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0087]  ,      // pinName = data_rdata_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0086]  ,      // pinName = data_rdata_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0085]  ,      // pinName = data_rdata_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0084]  ,      // pinName = data_rdata_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0083]  ,      // pinName = data_rdata_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0082]  ,      // pinName = data_rdata_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0081]  ,      // pinName = data_rdata_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0080]  ,      // pinName = data_rdata_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0079]  ,      // pinName = data_rdata_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0109]  ,      // pinName = data_rdata_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0108]  ,      // pinName = data_rdata_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0107]  ,      // pinName = data_rdata_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0106]  ,      // pinName = data_rdata_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0105]  ,      // pinName = data_rdata_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0104]  ,      // pinName = data_rdata_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0103]  ,      // pinName = data_rdata_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0100]  ,      // pinName = data_rdata_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0089]  ,      // pinName = data_rdata_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0078]}),      // pinName = data_rdata_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      .apu_busy_o             ( part_POs[0097] ),      // pinName = apu_busy_o; 
      .apu_req_o              ( part_POs[0119] ),      // pinName = apu_req_o; 
      .apu_gnt_i              ( part_PIs[0010] ),      // pinName = apu_gnt_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      .\apu_operands_o[0]     ({part_POs[0025]  ,      // pinName = \apu_operands_o[0][31]; 
                                part_POs[0024]  ,      // pinName = \apu_operands_o[0][30]; 
                                part_POs[0022]  ,      // pinName = \apu_operands_o[0][29]; 
                                part_POs[0021]  ,      // pinName = \apu_operands_o[0][28]; 
                                part_POs[0020]  ,      // pinName = \apu_operands_o[0][27]; 
                                part_POs[0019]  ,      // pinName = \apu_operands_o[0][26]; 
                                part_POs[0018]  ,      // pinName = \apu_operands_o[0][25]; 
                                part_POs[0017]  ,      // pinName = \apu_operands_o[0][24]; 
                                part_POs[0016]  ,      // pinName = \apu_operands_o[0][23]; 
                                part_POs[0015]  ,      // pinName = \apu_operands_o[0][22]; 
                                part_POs[0014]  ,      // pinName = \apu_operands_o[0][21]; 
                                part_POs[0013]  ,      // pinName = \apu_operands_o[0][20]; 
                                part_POs[0011]  ,      // pinName = \apu_operands_o[0][19]; 
                                part_POs[0010]  ,      // pinName = \apu_operands_o[0][18]; 
                                part_POs[0009]  ,      // pinName = \apu_operands_o[0][17]; 
                                part_POs[0008]  ,      // pinName = \apu_operands_o[0][16]; 
                                part_POs[0007]  ,      // pinName = \apu_operands_o[0][15]; 
                                part_POs[0006]  ,      // pinName = \apu_operands_o[0][14]; 
                                part_POs[0005]  ,      // pinName = \apu_operands_o[0][13]; 
                                part_POs[0004]  ,      // pinName = \apu_operands_o[0][12]; 
                                part_POs[0003]  ,      // pinName = \apu_operands_o[0][11]; 
                                part_POs[0002]  ,      // pinName = \apu_operands_o[0][10]; 
                                part_POs[0032]  ,      // pinName = \apu_operands_o[0][9]; 
                                part_POs[0031]  ,      // pinName = \apu_operands_o[0][8]; 
                                part_POs[0030]  ,      // pinName = \apu_operands_o[0][7]; 
                                part_POs[0029]  ,      // pinName = \apu_operands_o[0][6]; 
                                part_POs[0028]  ,      // pinName = \apu_operands_o[0][5]; 
                                part_POs[0027]  ,      // pinName = \apu_operands_o[0][4]; 
                                part_POs[0026]  ,      // pinName = \apu_operands_o[0][3]; 
                                part_POs[0023]  ,      // pinName = \apu_operands_o[0][2]; 
                                part_POs[0012]  ,      // pinName = \apu_operands_o[0][1]; 
                                part_POs[0001]}),      // pinName = \apu_operands_o[0][0]; 
      .\apu_operands_o[1]     ({part_POs[0057]  ,      // pinName = \apu_operands_o[1][31]; 
                                part_POs[0056]  ,      // pinName = \apu_operands_o[1][30]; 
                                part_POs[0054]  ,      // pinName = \apu_operands_o[1][29]; 
                                part_POs[0053]  ,      // pinName = \apu_operands_o[1][28]; 
                                part_POs[0052]  ,      // pinName = \apu_operands_o[1][27]; 
                                part_POs[0051]  ,      // pinName = \apu_operands_o[1][26]; 
                                part_POs[0050]  ,      // pinName = \apu_operands_o[1][25]; 
                                part_POs[0049]  ,      // pinName = \apu_operands_o[1][24]; 
                                part_POs[0048]  ,      // pinName = \apu_operands_o[1][23]; 
                                part_POs[0047]  ,      // pinName = \apu_operands_o[1][22]; 
                                part_POs[0046]  ,      // pinName = \apu_operands_o[1][21]; 
                                part_POs[0045]  ,      // pinName = \apu_operands_o[1][20]; 
                                part_POs[0043]  ,      // pinName = \apu_operands_o[1][19]; 
                                part_POs[0042]  ,      // pinName = \apu_operands_o[1][18]; 
                                part_POs[0041]  ,      // pinName = \apu_operands_o[1][17]; 
                                part_POs[0040]  ,      // pinName = \apu_operands_o[1][16]; 
                                part_POs[0039]  ,      // pinName = \apu_operands_o[1][15]; 
                                part_POs[0038]  ,      // pinName = \apu_operands_o[1][14]; 
                                part_POs[0037]  ,      // pinName = \apu_operands_o[1][13]; 
                                part_POs[0036]  ,      // pinName = \apu_operands_o[1][12]; 
                                part_POs[0035]  ,      // pinName = \apu_operands_o[1][11]; 
                                part_POs[0034]  ,      // pinName = \apu_operands_o[1][10]; 
                                part_POs[0064]  ,      // pinName = \apu_operands_o[1][9]; 
                                part_POs[0063]  ,      // pinName = \apu_operands_o[1][8]; 
                                part_POs[0062]  ,      // pinName = \apu_operands_o[1][7]; 
                                part_POs[0061]  ,      // pinName = \apu_operands_o[1][6]; 
                                part_POs[0060]  ,      // pinName = \apu_operands_o[1][5]; 
                                part_POs[0059]  ,      // pinName = \apu_operands_o[1][4]; 
                                part_POs[0058]  ,      // pinName = \apu_operands_o[1][3]; 
                                part_POs[0055]  ,      // pinName = \apu_operands_o[1][2]; 
                                part_POs[0044]  ,      // pinName = \apu_operands_o[1][1]; 
                                part_POs[0033]}),      // pinName = \apu_operands_o[1][0]; 
      .\apu_operands_o[2]     ({part_POs[0089]  ,      // pinName = \apu_operands_o[2][31]; 
                                part_POs[0088]  ,      // pinName = \apu_operands_o[2][30]; 
                                part_POs[0086]  ,      // pinName = \apu_operands_o[2][29]; 
                                part_POs[0085]  ,      // pinName = \apu_operands_o[2][28]; 
                                part_POs[0084]  ,      // pinName = \apu_operands_o[2][27]; 
                                part_POs[0083]  ,      // pinName = \apu_operands_o[2][26]; 
                                part_POs[0082]  ,      // pinName = \apu_operands_o[2][25]; 
                                part_POs[0081]  ,      // pinName = \apu_operands_o[2][24]; 
                                part_POs[0080]  ,      // pinName = \apu_operands_o[2][23]; 
                                part_POs[0079]  ,      // pinName = \apu_operands_o[2][22]; 
                                part_POs[0078]  ,      // pinName = \apu_operands_o[2][21]; 
                                part_POs[0077]  ,      // pinName = \apu_operands_o[2][20]; 
                                part_POs[0075]  ,      // pinName = \apu_operands_o[2][19]; 
                                part_POs[0074]  ,      // pinName = \apu_operands_o[2][18]; 
                                part_POs[0073]  ,      // pinName = \apu_operands_o[2][17]; 
                                part_POs[0072]  ,      // pinName = \apu_operands_o[2][16]; 
                                part_POs[0071]  ,      // pinName = \apu_operands_o[2][15]; 
                                part_POs[0070]  ,      // pinName = \apu_operands_o[2][14]; 
                                part_POs[0069]  ,      // pinName = \apu_operands_o[2][13]; 
                                part_POs[0068]  ,      // pinName = \apu_operands_o[2][12]; 
                                part_POs[0067]  ,      // pinName = \apu_operands_o[2][11]; 
                                part_POs[0066]  ,      // pinName = \apu_operands_o[2][10]; 
                                part_POs[0096]  ,      // pinName = \apu_operands_o[2][9]; 
                                part_POs[0095]  ,      // pinName = \apu_operands_o[2][8]; 
                                part_POs[0094]  ,      // pinName = \apu_operands_o[2][7]; 
                                part_POs[0093]  ,      // pinName = \apu_operands_o[2][6]; 
                                part_POs[0092]  ,      // pinName = \apu_operands_o[2][5]; 
                                part_POs[0091]  ,      // pinName = \apu_operands_o[2][4]; 
                                part_POs[0090]  ,      // pinName = \apu_operands_o[2][3]; 
                                part_POs[0087]  ,      // pinName = \apu_operands_o[2][2]; 
                                part_POs[0076]  ,      // pinName = \apu_operands_o[2][1]; 
                                part_POs[0065]}),      // pinName = \apu_operands_o[2][0]; 
      .apu_op_o               ({part_POs[0118]  ,      // pinName = apu_op_o[5]; 
                                part_POs[0117]  ,      // pinName = apu_op_o[4]; 
                                part_POs[0116]  ,      // pinName = apu_op_o[3]; 
                                part_POs[0115]  ,      // pinName = apu_op_o[2]; 
                                part_POs[0114]  ,      // pinName = apu_op_o[1]; 
                                part_POs[0113]}),      // pinName = apu_op_o[0]; 
      .apu_flags_o            ({part_POs[0103]  ,      // pinName = apu_flags_o[14]; 
                                part_POs[0102]  ,      // pinName = apu_flags_o[13]; 
                                part_POs[0101]  ,      // pinName = apu_flags_o[12]; 
                                part_POs[0100]  ,      // pinName = apu_flags_o[11]; 
                                part_POs[0099]  ,      // pinName = apu_flags_o[10]; 
                                part_POs[0112]  ,      // pinName = apu_flags_o[9]; 
                                part_POs[0111]  ,      // pinName = apu_flags_o[8]; 
                                part_POs[0110]  ,      // pinName = apu_flags_o[7]; 
                                part_POs[0109]  ,      // pinName = apu_flags_o[6]; 
                                part_POs[0108]  ,      // pinName = apu_flags_o[5]; 
                                part_POs[0107]  ,      // pinName = apu_flags_o[4]; 
                                part_POs[0106]  ,      // pinName = apu_flags_o[3]; 
                                part_POs[0105]  ,      // pinName = apu_flags_o[2]; 
                                part_POs[0104]  ,      // pinName = apu_flags_o[1]; 
                                part_POs[0098]}),      // pinName = apu_flags_o[0]; 
      .apu_rvalid_i           ( part_PIs[0043] ),      // pinName = apu_rvalid_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      .apu_result_i           ({part_PIs[0035]  ,      // pinName = apu_result_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0034]  ,      // pinName = apu_result_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0032]  ,      // pinName = apu_result_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0031]  ,      // pinName = apu_result_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0030]  ,      // pinName = apu_result_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0029]  ,      // pinName = apu_result_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0028]  ,      // pinName = apu_result_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0027]  ,      // pinName = apu_result_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0026]  ,      // pinName = apu_result_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0025]  ,      // pinName = apu_result_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0024]  ,      // pinName = apu_result_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0023]  ,      // pinName = apu_result_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0021]  ,      // pinName = apu_result_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0020]  ,      // pinName = apu_result_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0019]  ,      // pinName = apu_result_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0018]  ,      // pinName = apu_result_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0017]  ,      // pinName = apu_result_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0016]  ,      // pinName = apu_result_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0015]  ,      // pinName = apu_result_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0014]  ,      // pinName = apu_result_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0013]  ,      // pinName = apu_result_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0012]  ,      // pinName = apu_result_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0042]  ,      // pinName = apu_result_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0041]  ,      // pinName = apu_result_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0040]  ,      // pinName = apu_result_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0039]  ,      // pinName = apu_result_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0038]  ,      // pinName = apu_result_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0037]  ,      // pinName = apu_result_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0036]  ,      // pinName = apu_result_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0033]  ,      // pinName = apu_result_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0022]  ,      // pinName = apu_result_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0011]}),      // pinName = apu_result_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      .apu_flags_i            ({part_PIs[0009]  ,      // pinName = apu_flags_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0008]  ,      // pinName = apu_flags_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0007]  ,      // pinName = apu_flags_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0006]  ,      // pinName = apu_flags_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0005]}),      // pinName = apu_flags_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      .irq_i                  ({part_PIs[0267]  ,      // pinName = irq_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0266]  ,      // pinName = irq_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0264]  ,      // pinName = irq_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0263]  ,      // pinName = irq_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0262]  ,      // pinName = irq_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0261]  ,      // pinName = irq_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0260]  ,      // pinName = irq_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0259]  ,      // pinName = irq_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0258]  ,      // pinName = irq_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0257]  ,      // pinName = irq_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0256]  ,      // pinName = irq_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0255]  ,      // pinName = irq_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0253]  ,      // pinName = irq_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0252]  ,      // pinName = irq_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0251]  ,      // pinName = irq_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0250]  ,      // pinName = irq_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0249]  ,      // pinName = irq_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0248]  ,      // pinName = irq_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0247]  ,      // pinName = irq_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0246]  ,      // pinName = irq_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0245]  ,      // pinName = irq_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0244]  ,      // pinName = irq_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0274]  ,      // pinName = irq_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0273]  ,      // pinName = irq_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0272]  ,      // pinName = irq_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0271]  ,      // pinName = irq_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0270]  ,      // pinName = irq_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0269]  ,      // pinName = irq_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0268]  ,      // pinName = irq_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0265]  ,      // pinName = irq_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0254]  ,      // pinName = irq_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
                                part_PIs[0243]}),      // pinName = irq_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      .irq_ack_o              ( part_POs[0227] ),      // pinName = irq_ack_o; 
      .irq_id_o               ({part_POs[0232]  ,      // pinName = irq_id_o[4]; 
                                part_POs[0231]  ,      // pinName = irq_id_o[3]; 
                                part_POs[0230]  ,      // pinName = irq_id_o[2]; 
                                part_POs[0229]  ,      // pinName = irq_id_o[1]; 
                                part_POs[0228]}),      // pinName = irq_id_o[0]; 
      .debug_req_i            ( part_PIs[0111] ),      // pinName = debug_req_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      .debug_havereset_o      ( part_POs[0192] ),      // pinName = debug_havereset_o; 
      .debug_running_o        ( part_POs[0193] ),      // pinName = debug_running_o; 
      .debug_halted_o         ( part_POs[0191] ),      // pinName = debug_halted_o; 
      .fetch_enable_i         ( part_PIs[0176] ),      // pinName = fetch_enable_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      .core_sleep_o           ( part_POs[0120] ),      // pinName = core_sleep_o; 
      .SCAN_ENABLE            ( part_PIs[0004] ),      // pinName = SCAN_ENABLE;  tf = +SE  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      .test_mode              ( part_PIs[0312] ),      // pinName = test_mode;  tf = +TI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      .scan_in_0              ( part_PIs[0310] ),      // pinName = scan_in_0;  tf =  SI   CMI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      .scan_out_0             ( part_POs[0233] ),      // pinName = scan_out_0;  tf =  SO  ; 
      .scan_in_1              ( part_PIs[0311] ),      // pinName = scan_in_1;  tf =  SI1  CMI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      .scan_out_1             ( part_POs[0234] ),      // pinName = scan_out_1;  tf =  SO1 ; 
      .DFT_compression_enable ( part_PIs[0001] ),      // pinName = DFT_compression_enable;  tf = +SE  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      .DFT_mask_enable        ( part_PIs[0003] ),      // pinName = DFT_mask_enable;  tf = -TC  -CME  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      .DFT_mask_clk           ( part_PIs[0002] )     // pinName = DFT_mask_clk;  tf = -CML  ; testOffset = 0.000000;  scanOffset = 16.000000;  
      );

//***************************************************************************//
//                        MAKE SOME OTHER CONNECTIONS                        //
//***************************************************************************//

  assign ( weak0, weak1 ) // Termination 
    part_POs [1] = global_term,     // pinName = \apu_operands_o[0][0]; 
    part_POs [2] = global_term,     // pinName = \apu_operands_o[0][10]; 
    part_POs [3] = global_term,     // pinName = \apu_operands_o[0][11]; 
    part_POs [4] = global_term,     // pinName = \apu_operands_o[0][12]; 
    part_POs [5] = global_term,     // pinName = \apu_operands_o[0][13]; 
    part_POs [6] = global_term,     // pinName = \apu_operands_o[0][14]; 
    part_POs [7] = global_term,     // pinName = \apu_operands_o[0][15]; 
    part_POs [8] = global_term,     // pinName = \apu_operands_o[0][16]; 
    part_POs [9] = global_term,     // pinName = \apu_operands_o[0][17]; 
    part_POs [10] = global_term,     // pinName = \apu_operands_o[0][18]; 
    part_POs [11] = global_term,     // pinName = \apu_operands_o[0][19]; 
    part_POs [12] = global_term,     // pinName = \apu_operands_o[0][1]; 
    part_POs [13] = global_term,     // pinName = \apu_operands_o[0][20]; 
    part_POs [14] = global_term,     // pinName = \apu_operands_o[0][21]; 
    part_POs [15] = global_term,     // pinName = \apu_operands_o[0][22]; 
    part_POs [16] = global_term,     // pinName = \apu_operands_o[0][23]; 
    part_POs [17] = global_term,     // pinName = \apu_operands_o[0][24]; 
    part_POs [18] = global_term,     // pinName = \apu_operands_o[0][25]; 
    part_POs [19] = global_term,     // pinName = \apu_operands_o[0][26]; 
    part_POs [20] = global_term,     // pinName = \apu_operands_o[0][27]; 
    part_POs [21] = global_term,     // pinName = \apu_operands_o[0][28]; 
    part_POs [22] = global_term,     // pinName = \apu_operands_o[0][29]; 
    part_POs [23] = global_term,     // pinName = \apu_operands_o[0][2]; 
    part_POs [24] = global_term,     // pinName = \apu_operands_o[0][30]; 
    part_POs [25] = global_term,     // pinName = \apu_operands_o[0][31]; 
    part_POs [26] = global_term,     // pinName = \apu_operands_o[0][3]; 
    part_POs [27] = global_term,     // pinName = \apu_operands_o[0][4]; 
    part_POs [28] = global_term,     // pinName = \apu_operands_o[0][5]; 
    part_POs [29] = global_term,     // pinName = \apu_operands_o[0][6]; 
    part_POs [30] = global_term,     // pinName = \apu_operands_o[0][7]; 
    part_POs [31] = global_term,     // pinName = \apu_operands_o[0][8]; 
    part_POs [32] = global_term,     // pinName = \apu_operands_o[0][9]; 
    part_POs [33] = global_term,     // pinName = \apu_operands_o[1][0]; 
    part_POs [34] = global_term,     // pinName = \apu_operands_o[1][10]; 
    part_POs [35] = global_term,     // pinName = \apu_operands_o[1][11]; 
    part_POs [36] = global_term,     // pinName = \apu_operands_o[1][12]; 
    part_POs [37] = global_term,     // pinName = \apu_operands_o[1][13]; 
    part_POs [38] = global_term,     // pinName = \apu_operands_o[1][14]; 
    part_POs [39] = global_term,     // pinName = \apu_operands_o[1][15]; 
    part_POs [40] = global_term,     // pinName = \apu_operands_o[1][16]; 
    part_POs [41] = global_term,     // pinName = \apu_operands_o[1][17]; 
    part_POs [42] = global_term,     // pinName = \apu_operands_o[1][18]; 
    part_POs [43] = global_term,     // pinName = \apu_operands_o[1][19]; 
    part_POs [44] = global_term,     // pinName = \apu_operands_o[1][1]; 
    part_POs [45] = global_term,     // pinName = \apu_operands_o[1][20]; 
    part_POs [46] = global_term,     // pinName = \apu_operands_o[1][21]; 
    part_POs [47] = global_term,     // pinName = \apu_operands_o[1][22]; 
    part_POs [48] = global_term,     // pinName = \apu_operands_o[1][23]; 
    part_POs [49] = global_term,     // pinName = \apu_operands_o[1][24]; 
    part_POs [50] = global_term,     // pinName = \apu_operands_o[1][25]; 
    part_POs [51] = global_term,     // pinName = \apu_operands_o[1][26]; 
    part_POs [52] = global_term,     // pinName = \apu_operands_o[1][27]; 
    part_POs [53] = global_term,     // pinName = \apu_operands_o[1][28]; 
    part_POs [54] = global_term,     // pinName = \apu_operands_o[1][29]; 
    part_POs [55] = global_term,     // pinName = \apu_operands_o[1][2]; 
    part_POs [56] = global_term,     // pinName = \apu_operands_o[1][30]; 
    part_POs [57] = global_term,     // pinName = \apu_operands_o[1][31]; 
    part_POs [58] = global_term,     // pinName = \apu_operands_o[1][3]; 
    part_POs [59] = global_term,     // pinName = \apu_operands_o[1][4]; 
    part_POs [60] = global_term,     // pinName = \apu_operands_o[1][5]; 
    part_POs [61] = global_term,     // pinName = \apu_operands_o[1][6]; 
    part_POs [62] = global_term,     // pinName = \apu_operands_o[1][7]; 
    part_POs [63] = global_term,     // pinName = \apu_operands_o[1][8]; 
    part_POs [64] = global_term,     // pinName = \apu_operands_o[1][9]; 
    part_POs [65] = global_term,     // pinName = \apu_operands_o[2][0]; 
    part_POs [66] = global_term,     // pinName = \apu_operands_o[2][10]; 
    part_POs [67] = global_term,     // pinName = \apu_operands_o[2][11]; 
    part_POs [68] = global_term,     // pinName = \apu_operands_o[2][12]; 
    part_POs [69] = global_term,     // pinName = \apu_operands_o[2][13]; 
    part_POs [70] = global_term,     // pinName = \apu_operands_o[2][14]; 
    part_POs [71] = global_term,     // pinName = \apu_operands_o[2][15]; 
    part_POs [72] = global_term,     // pinName = \apu_operands_o[2][16]; 
    part_POs [73] = global_term,     // pinName = \apu_operands_o[2][17]; 
    part_POs [74] = global_term,     // pinName = \apu_operands_o[2][18]; 
    part_POs [75] = global_term,     // pinName = \apu_operands_o[2][19]; 
    part_POs [76] = global_term,     // pinName = \apu_operands_o[2][1]; 
    part_POs [77] = global_term,     // pinName = \apu_operands_o[2][20]; 
    part_POs [78] = global_term,     // pinName = \apu_operands_o[2][21]; 
    part_POs [79] = global_term,     // pinName = \apu_operands_o[2][22]; 
    part_POs [80] = global_term,     // pinName = \apu_operands_o[2][23]; 
    part_POs [81] = global_term,     // pinName = \apu_operands_o[2][24]; 
    part_POs [82] = global_term,     // pinName = \apu_operands_o[2][25]; 
    part_POs [83] = global_term,     // pinName = \apu_operands_o[2][26]; 
    part_POs [84] = global_term,     // pinName = \apu_operands_o[2][27]; 
    part_POs [85] = global_term,     // pinName = \apu_operands_o[2][28]; 
    part_POs [86] = global_term,     // pinName = \apu_operands_o[2][29]; 
    part_POs [87] = global_term,     // pinName = \apu_operands_o[2][2]; 
    part_POs [88] = global_term,     // pinName = \apu_operands_o[2][30]; 
    part_POs [89] = global_term,     // pinName = \apu_operands_o[2][31]; 
    part_POs [90] = global_term,     // pinName = \apu_operands_o[2][3]; 
    part_POs [91] = global_term,     // pinName = \apu_operands_o[2][4]; 
    part_POs [92] = global_term,     // pinName = \apu_operands_o[2][5]; 
    part_POs [93] = global_term,     // pinName = \apu_operands_o[2][6]; 
    part_POs [94] = global_term,     // pinName = \apu_operands_o[2][7]; 
    part_POs [95] = global_term,     // pinName = \apu_operands_o[2][8]; 
    part_POs [96] = global_term,     // pinName = \apu_operands_o[2][9]; 
    part_POs [97] = global_term,     // pinName = apu_busy_o; 
    part_POs [98] = global_term,     // pinName = apu_flags_o[0]; 
    part_POs [99] = global_term,     // pinName = apu_flags_o[10]; 
    part_POs [100] = global_term,     // pinName = apu_flags_o[11]; 
    part_POs [101] = global_term,     // pinName = apu_flags_o[12]; 
    part_POs [102] = global_term,     // pinName = apu_flags_o[13]; 
    part_POs [103] = global_term,     // pinName = apu_flags_o[14]; 
    part_POs [104] = global_term,     // pinName = apu_flags_o[1]; 
    part_POs [105] = global_term,     // pinName = apu_flags_o[2]; 
    part_POs [106] = global_term,     // pinName = apu_flags_o[3]; 
    part_POs [107] = global_term,     // pinName = apu_flags_o[4]; 
    part_POs [108] = global_term,     // pinName = apu_flags_o[5]; 
    part_POs [109] = global_term,     // pinName = apu_flags_o[6]; 
    part_POs [110] = global_term,     // pinName = apu_flags_o[7]; 
    part_POs [111] = global_term,     // pinName = apu_flags_o[8]; 
    part_POs [112] = global_term,     // pinName = apu_flags_o[9]; 
    part_POs [113] = global_term,     // pinName = apu_op_o[0]; 
    part_POs [114] = global_term,     // pinName = apu_op_o[1]; 
    part_POs [115] = global_term,     // pinName = apu_op_o[2]; 
    part_POs [116] = global_term,     // pinName = apu_op_o[3]; 
    part_POs [117] = global_term,     // pinName = apu_op_o[4]; 
    part_POs [118] = global_term,     // pinName = apu_op_o[5]; 
    part_POs [119] = global_term,     // pinName = apu_req_o; 
    part_POs [120] = global_term,     // pinName = core_sleep_o; 
    part_POs [121] = global_term,     // pinName = data_addr_o[0]; 
    part_POs [122] = global_term,     // pinName = data_addr_o[10]; 
    part_POs [123] = global_term,     // pinName = data_addr_o[11]; 
    part_POs [124] = global_term,     // pinName = data_addr_o[12]; 
    part_POs [125] = global_term,     // pinName = data_addr_o[13]; 
    part_POs [126] = global_term,     // pinName = data_addr_o[14]; 
    part_POs [127] = global_term,     // pinName = data_addr_o[15]; 
    part_POs [128] = global_term,     // pinName = data_addr_o[16]; 
    part_POs [129] = global_term,     // pinName = data_addr_o[17]; 
    part_POs [130] = global_term,     // pinName = data_addr_o[18]; 
    part_POs [131] = global_term,     // pinName = data_addr_o[19]; 
    part_POs [132] = global_term,     // pinName = data_addr_o[1]; 
    part_POs [133] = global_term,     // pinName = data_addr_o[20]; 
    part_POs [134] = global_term,     // pinName = data_addr_o[21]; 
    part_POs [135] = global_term,     // pinName = data_addr_o[22]; 
    part_POs [136] = global_term,     // pinName = data_addr_o[23]; 
    part_POs [137] = global_term,     // pinName = data_addr_o[24]; 
    part_POs [138] = global_term,     // pinName = data_addr_o[25]; 
    part_POs [139] = global_term,     // pinName = data_addr_o[26]; 
    part_POs [140] = global_term,     // pinName = data_addr_o[27]; 
    part_POs [141] = global_term,     // pinName = data_addr_o[28]; 
    part_POs [142] = global_term,     // pinName = data_addr_o[29]; 
    part_POs [143] = global_term,     // pinName = data_addr_o[2]; 
    part_POs [144] = global_term,     // pinName = data_addr_o[30]; 
    part_POs [145] = global_term,     // pinName = data_addr_o[31]; 
    part_POs [146] = global_term,     // pinName = data_addr_o[3]; 
    part_POs [147] = global_term,     // pinName = data_addr_o[4]; 
    part_POs [148] = global_term,     // pinName = data_addr_o[5]; 
    part_POs [149] = global_term,     // pinName = data_addr_o[6]; 
    part_POs [150] = global_term,     // pinName = data_addr_o[7]; 
    part_POs [151] = global_term,     // pinName = data_addr_o[8]; 
    part_POs [152] = global_term,     // pinName = data_addr_o[9]; 
    part_POs [153] = global_term,     // pinName = data_be_o[0]; 
    part_POs [154] = global_term,     // pinName = data_be_o[1]; 
    part_POs [155] = global_term,     // pinName = data_be_o[2]; 
    part_POs [156] = global_term,     // pinName = data_be_o[3]; 
    part_POs [157] = global_term,     // pinName = data_req_o; 
    part_POs [158] = global_term,     // pinName = data_wdata_o[0]; 
    part_POs [159] = global_term,     // pinName = data_wdata_o[10]; 
    part_POs [160] = global_term,     // pinName = data_wdata_o[11]; 
    part_POs [161] = global_term,     // pinName = data_wdata_o[12]; 
    part_POs [162] = global_term,     // pinName = data_wdata_o[13]; 
    part_POs [163] = global_term,     // pinName = data_wdata_o[14]; 
    part_POs [164] = global_term,     // pinName = data_wdata_o[15]; 
    part_POs [165] = global_term,     // pinName = data_wdata_o[16]; 
    part_POs [166] = global_term,     // pinName = data_wdata_o[17]; 
    part_POs [167] = global_term,     // pinName = data_wdata_o[18]; 
    part_POs [168] = global_term,     // pinName = data_wdata_o[19]; 
    part_POs [169] = global_term,     // pinName = data_wdata_o[1]; 
    part_POs [170] = global_term,     // pinName = data_wdata_o[20]; 
    part_POs [171] = global_term,     // pinName = data_wdata_o[21]; 
    part_POs [172] = global_term,     // pinName = data_wdata_o[22]; 
    part_POs [173] = global_term,     // pinName = data_wdata_o[23]; 
    part_POs [174] = global_term,     // pinName = data_wdata_o[24]; 
    part_POs [175] = global_term,     // pinName = data_wdata_o[25]; 
    part_POs [176] = global_term,     // pinName = data_wdata_o[26]; 
    part_POs [177] = global_term,     // pinName = data_wdata_o[27]; 
    part_POs [178] = global_term,     // pinName = data_wdata_o[28]; 
    part_POs [179] = global_term,     // pinName = data_wdata_o[29]; 
    part_POs [180] = global_term,     // pinName = data_wdata_o[2]; 
    part_POs [181] = global_term,     // pinName = data_wdata_o[30]; 
    part_POs [182] = global_term,     // pinName = data_wdata_o[31]; 
    part_POs [183] = global_term,     // pinName = data_wdata_o[3]; 
    part_POs [184] = global_term,     // pinName = data_wdata_o[4]; 
    part_POs [185] = global_term,     // pinName = data_wdata_o[5]; 
    part_POs [186] = global_term,     // pinName = data_wdata_o[6]; 
    part_POs [187] = global_term,     // pinName = data_wdata_o[7]; 
    part_POs [188] = global_term,     // pinName = data_wdata_o[8]; 
    part_POs [189] = global_term,     // pinName = data_wdata_o[9]; 
    part_POs [190] = global_term,     // pinName = data_we_o; 
    part_POs [191] = global_term,     // pinName = debug_halted_o; 
    part_POs [192] = global_term,     // pinName = debug_havereset_o; 
    part_POs [193] = global_term,     // pinName = debug_running_o; 
    part_POs [194] = global_term,     // pinName = instr_addr_o[0]; 
    part_POs [195] = global_term,     // pinName = instr_addr_o[10]; 
    part_POs [196] = global_term,     // pinName = instr_addr_o[11]; 
    part_POs [197] = global_term,     // pinName = instr_addr_o[12]; 
    part_POs [198] = global_term,     // pinName = instr_addr_o[13]; 
    part_POs [199] = global_term,     // pinName = instr_addr_o[14]; 
    part_POs [200] = global_term,     // pinName = instr_addr_o[15]; 
    part_POs [201] = global_term,     // pinName = instr_addr_o[16]; 
    part_POs [202] = global_term,     // pinName = instr_addr_o[17]; 
    part_POs [203] = global_term,     // pinName = instr_addr_o[18]; 
    part_POs [204] = global_term,     // pinName = instr_addr_o[19]; 
    part_POs [205] = global_term,     // pinName = instr_addr_o[1]; 
    part_POs [206] = global_term,     // pinName = instr_addr_o[20]; 
    part_POs [207] = global_term,     // pinName = instr_addr_o[21]; 
    part_POs [208] = global_term,     // pinName = instr_addr_o[22]; 
    part_POs [209] = global_term,     // pinName = instr_addr_o[23]; 
    part_POs [210] = global_term,     // pinName = instr_addr_o[24]; 
    part_POs [211] = global_term,     // pinName = instr_addr_o[25]; 
    part_POs [212] = global_term,     // pinName = instr_addr_o[26]; 
    part_POs [213] = global_term,     // pinName = instr_addr_o[27]; 
    part_POs [214] = global_term,     // pinName = instr_addr_o[28]; 
    part_POs [215] = global_term,     // pinName = instr_addr_o[29]; 
    part_POs [216] = global_term,     // pinName = instr_addr_o[2]; 
    part_POs [217] = global_term,     // pinName = instr_addr_o[30]; 
    part_POs [218] = global_term,     // pinName = instr_addr_o[31]; 
    part_POs [219] = global_term,     // pinName = instr_addr_o[3]; 
    part_POs [220] = global_term,     // pinName = instr_addr_o[4]; 
    part_POs [221] = global_term,     // pinName = instr_addr_o[5]; 
    part_POs [222] = global_term,     // pinName = instr_addr_o[6]; 
    part_POs [223] = global_term,     // pinName = instr_addr_o[7]; 
    part_POs [224] = global_term,     // pinName = instr_addr_o[8]; 
    part_POs [225] = global_term,     // pinName = instr_addr_o[9]; 
    part_POs [226] = global_term,     // pinName = instr_req_o; 
    part_POs [227] = global_term,     // pinName = irq_ack_o; 
    part_POs [228] = global_term,     // pinName = irq_id_o[0]; 
    part_POs [229] = global_term,     // pinName = irq_id_o[1]; 
    part_POs [230] = global_term,     // pinName = irq_id_o[2]; 
    part_POs [231] = global_term,     // pinName = irq_id_o[3]; 
    part_POs [232] = global_term,     // pinName = irq_id_o[4]; 
    part_POs [233] = global_term,     // pinName = scan_out_0;  tf =  SO  ; 
    part_POs [234] = global_term;      // pinName = scan_out_1;  tf =  SO1 ; 

//***************************************************************************//
//                     OPEN THE FILE AND RUN SIMULATION                      //
//***************************************************************************//

  initial 
    begin 

      $timeformat ( -12, 2, " ps", 10 ); 

      `ifdef sdf_annotate 
        `ifdef SDF_Minimum 
          $sdf_annotate ("default.sdf",cv32e40p_core_inst,,"sdf_Min.log","MINIMUM");
        `endif 
        `ifdef SDF_Maximum 
          $sdf_annotate ("default.sdf",cv32e40p_core_inst,,"sdf_Max.log","MAXIMUM");
        `endif 
        `ifdef SDF_Typical
          $sdf_annotate ("default.sdf",cv32e40p_core_inst,,"sdf_Typ.log","TYPICAL");
        `endif 
      `endif 

      `ifndef NOT_NC 
        if ( $test$plusargs ( "simvision" ) )  begin 
          $shm_open("simvision.shm"); 
          $shm_probe("AC"); 
        end  
      `endif 

      if ( $test$plusargs ( "vcd" ) )  begin 
        $dumpfile("out.vcd"); 
        $dumpvars(0,stuck_at_COMPRESSION_cv32e40p_core_stuck_at ); 
      end  

      DATAFILE = 0; 
      sim_setup; 

      `ifdef MISCOMPAREDEBUG 
        diag_debug = 1'b0; 
        if ( $value$plusargs ( "MISCOMPAREDEBUGFILE=%s", DIAG_DEBUG_FILE )) begin 
          DIAG_DATAID = $fopen ( DIAG_DEBUG_FILE, "r" ); 
          if ( DIAG_DATAID ) begin 
            diag_debug = 1'b1; 
            $fclose ( DIAG_DATAID ); 
          end  
          else $display ( "\nERROR (TVE-951): Failed to open the file: Diagnostic 'MISCOMPAREDEBUGFILE' %0s. \n", DIAG_DEBUG_FILE ); 
        end  
      `endif  

      num_files = 0; 
      for ( TID = 1; TID <= 99; TID = TID + 1 ) begin 
        $sformat ( TESTFILE, "TESTFILE%0d=%s", TID, "%s" ); 
        if ( $value$plusargs ( TESTFILE, DATAFILE )) begin 
          DATAID = $fopen ( DATAFILE, "r" ); 
          if ( DATAID )  begin 
            sim_vector_file; 
            num_files = num_files + 1; 
          end  
          else $display ( "\nERROR (TVE-951): Failed to open the file: %0s. \n", DATAFILE ); 
        end  
      end  

      if ( FAILSETID )  $fclose ( FAILSETID ); 

      if ( DATAFILE )  begin
        $display ( "\nINFO (TVE-209): Cumulative Results: " ); 
        $display ( "                      Number of Files Simulated:        %0d ", num_files ); 
        $display ( "                      Total Number of Cycles:           %0d ", total_cycles ); 
        $display ( "                      Total Number of Tests:            %0d ", total_num_tests ); 
        $display ( "                        - Total Passed Tests:           %0d ", total_num_tests - total_num_failed_tests ); 
        $display ( "                        - Total Failed Tests:           %0d ", total_num_failed_tests ); 
        $display ( "                      Total Number of Compares:         %0.0f ", total_good_compares + total_miscompares ); 
        $display ( "                        - Total Good Compares:          %0.0f ", total_good_compares ); 
        $display ( "                        - Total Miscompares:            %0.0f \n", total_miscompares ); 
      end  
      else $display ( "\nWARNING (TVE-661): No input data files found. The data file must be specified using +TESTFILE1=<string>, +TESTFILE2=<string>, ... The +TESTFILEn=<string> keyword is an NC-Sim command. \n" ); 

      $finish; 

    end  

//***************************************************************************//
//                     DEFINE SIMULATION SETUP PROCEDURE                     //
//***************************************************************************//

  task sim_setup; 
    begin 

      total_good_compares = 0; 
      total_miscompares = 0; 
      miscompare_limit = 0; 
      total_num_tests = 0; 
      total_num_failed_tests = 0; 
      total_cycles = 0; 
      SOD = ""; 
      EOD = ""; 
      START = 0; 
      NUM_SHIFTS = 0; 
      MAX = 1; 

      sim_heart = 1'b0; 
      sim_range = 1'b1; 
      sim_range_measure = 1'b1; 
      sim_trace = 1'b0; 
      sim_debug = 1'b0; 
      sim_more_debug = 1'b0; 

      global_term = 1'bZ; 

      failset = 1'b0; 
      FAILSETID = 0; 

      CYCLE = 0; 
      SCANCYCLE = 0; 
      SERIALCYCLE = 0; 
      count_cycles = 1'b1; 
      SEQNUM = 0; 
      name_POs [1] = "\apu_operands_o[0][0]";      // pinName = \apu_operands_o[0][0]; 
      name_POs [2] = "\apu_operands_o[0][10]";      // pinName = \apu_operands_o[0][10]; 
      name_POs [3] = "\apu_operands_o[0][11]";      // pinName = \apu_operands_o[0][11]; 
      name_POs [4] = "\apu_operands_o[0][12]";      // pinName = \apu_operands_o[0][12]; 
      name_POs [5] = "\apu_operands_o[0][13]";      // pinName = \apu_operands_o[0][13]; 
      name_POs [6] = "\apu_operands_o[0][14]";      // pinName = \apu_operands_o[0][14]; 
      name_POs [7] = "\apu_operands_o[0][15]";      // pinName = \apu_operands_o[0][15]; 
      name_POs [8] = "\apu_operands_o[0][16]";      // pinName = \apu_operands_o[0][16]; 
      name_POs [9] = "\apu_operands_o[0][17]";      // pinName = \apu_operands_o[0][17]; 
      name_POs [10] = "\apu_operands_o[0][18]";      // pinName = \apu_operands_o[0][18]; 
      name_POs [11] = "\apu_operands_o[0][19]";      // pinName = \apu_operands_o[0][19]; 
      name_POs [12] = "\apu_operands_o[0][1]";      // pinName = \apu_operands_o[0][1]; 
      name_POs [13] = "\apu_operands_o[0][20]";      // pinName = \apu_operands_o[0][20]; 
      name_POs [14] = "\apu_operands_o[0][21]";      // pinName = \apu_operands_o[0][21]; 
      name_POs [15] = "\apu_operands_o[0][22]";      // pinName = \apu_operands_o[0][22]; 
      name_POs [16] = "\apu_operands_o[0][23]";      // pinName = \apu_operands_o[0][23]; 
      name_POs [17] = "\apu_operands_o[0][24]";      // pinName = \apu_operands_o[0][24]; 
      name_POs [18] = "\apu_operands_o[0][25]";      // pinName = \apu_operands_o[0][25]; 
      name_POs [19] = "\apu_operands_o[0][26]";      // pinName = \apu_operands_o[0][26]; 
      name_POs [20] = "\apu_operands_o[0][27]";      // pinName = \apu_operands_o[0][27]; 
      name_POs [21] = "\apu_operands_o[0][28]";      // pinName = \apu_operands_o[0][28]; 
      name_POs [22] = "\apu_operands_o[0][29]";      // pinName = \apu_operands_o[0][29]; 
      name_POs [23] = "\apu_operands_o[0][2]";      // pinName = \apu_operands_o[0][2]; 
      name_POs [24] = "\apu_operands_o[0][30]";      // pinName = \apu_operands_o[0][30]; 
      name_POs [25] = "\apu_operands_o[0][31]";      // pinName = \apu_operands_o[0][31]; 
      name_POs [26] = "\apu_operands_o[0][3]";      // pinName = \apu_operands_o[0][3]; 
      name_POs [27] = "\apu_operands_o[0][4]";      // pinName = \apu_operands_o[0][4]; 
      name_POs [28] = "\apu_operands_o[0][5]";      // pinName = \apu_operands_o[0][5]; 
      name_POs [29] = "\apu_operands_o[0][6]";      // pinName = \apu_operands_o[0][6]; 
      name_POs [30] = "\apu_operands_o[0][7]";      // pinName = \apu_operands_o[0][7]; 
      name_POs [31] = "\apu_operands_o[0][8]";      // pinName = \apu_operands_o[0][8]; 
      name_POs [32] = "\apu_operands_o[0][9]";      // pinName = \apu_operands_o[0][9]; 
      name_POs [33] = "\apu_operands_o[1][0]";      // pinName = \apu_operands_o[1][0]; 
      name_POs [34] = "\apu_operands_o[1][10]";      // pinName = \apu_operands_o[1][10]; 
      name_POs [35] = "\apu_operands_o[1][11]";      // pinName = \apu_operands_o[1][11]; 
      name_POs [36] = "\apu_operands_o[1][12]";      // pinName = \apu_operands_o[1][12]; 
      name_POs [37] = "\apu_operands_o[1][13]";      // pinName = \apu_operands_o[1][13]; 
      name_POs [38] = "\apu_operands_o[1][14]";      // pinName = \apu_operands_o[1][14]; 
      name_POs [39] = "\apu_operands_o[1][15]";      // pinName = \apu_operands_o[1][15]; 
      name_POs [40] = "\apu_operands_o[1][16]";      // pinName = \apu_operands_o[1][16]; 
      name_POs [41] = "\apu_operands_o[1][17]";      // pinName = \apu_operands_o[1][17]; 
      name_POs [42] = "\apu_operands_o[1][18]";      // pinName = \apu_operands_o[1][18]; 
      name_POs [43] = "\apu_operands_o[1][19]";      // pinName = \apu_operands_o[1][19]; 
      name_POs [44] = "\apu_operands_o[1][1]";      // pinName = \apu_operands_o[1][1]; 
      name_POs [45] = "\apu_operands_o[1][20]";      // pinName = \apu_operands_o[1][20]; 
      name_POs [46] = "\apu_operands_o[1][21]";      // pinName = \apu_operands_o[1][21]; 
      name_POs [47] = "\apu_operands_o[1][22]";      // pinName = \apu_operands_o[1][22]; 
      name_POs [48] = "\apu_operands_o[1][23]";      // pinName = \apu_operands_o[1][23]; 
      name_POs [49] = "\apu_operands_o[1][24]";      // pinName = \apu_operands_o[1][24]; 
      name_POs [50] = "\apu_operands_o[1][25]";      // pinName = \apu_operands_o[1][25]; 
      name_POs [51] = "\apu_operands_o[1][26]";      // pinName = \apu_operands_o[1][26]; 
      name_POs [52] = "\apu_operands_o[1][27]";      // pinName = \apu_operands_o[1][27]; 
      name_POs [53] = "\apu_operands_o[1][28]";      // pinName = \apu_operands_o[1][28]; 
      name_POs [54] = "\apu_operands_o[1][29]";      // pinName = \apu_operands_o[1][29]; 
      name_POs [55] = "\apu_operands_o[1][2]";      // pinName = \apu_operands_o[1][2]; 
      name_POs [56] = "\apu_operands_o[1][30]";      // pinName = \apu_operands_o[1][30]; 
      name_POs [57] = "\apu_operands_o[1][31]";      // pinName = \apu_operands_o[1][31]; 
      name_POs [58] = "\apu_operands_o[1][3]";      // pinName = \apu_operands_o[1][3]; 
      name_POs [59] = "\apu_operands_o[1][4]";      // pinName = \apu_operands_o[1][4]; 
      name_POs [60] = "\apu_operands_o[1][5]";      // pinName = \apu_operands_o[1][5]; 
      name_POs [61] = "\apu_operands_o[1][6]";      // pinName = \apu_operands_o[1][6]; 
      name_POs [62] = "\apu_operands_o[1][7]";      // pinName = \apu_operands_o[1][7]; 
      name_POs [63] = "\apu_operands_o[1][8]";      // pinName = \apu_operands_o[1][8]; 
      name_POs [64] = "\apu_operands_o[1][9]";      // pinName = \apu_operands_o[1][9]; 
      name_POs [65] = "\apu_operands_o[2][0]";      // pinName = \apu_operands_o[2][0]; 
      name_POs [66] = "\apu_operands_o[2][10]";      // pinName = \apu_operands_o[2][10]; 
      name_POs [67] = "\apu_operands_o[2][11]";      // pinName = \apu_operands_o[2][11]; 
      name_POs [68] = "\apu_operands_o[2][12]";      // pinName = \apu_operands_o[2][12]; 
      name_POs [69] = "\apu_operands_o[2][13]";      // pinName = \apu_operands_o[2][13]; 
      name_POs [70] = "\apu_operands_o[2][14]";      // pinName = \apu_operands_o[2][14]; 
      name_POs [71] = "\apu_operands_o[2][15]";      // pinName = \apu_operands_o[2][15]; 
      name_POs [72] = "\apu_operands_o[2][16]";      // pinName = \apu_operands_o[2][16]; 
      name_POs [73] = "\apu_operands_o[2][17]";      // pinName = \apu_operands_o[2][17]; 
      name_POs [74] = "\apu_operands_o[2][18]";      // pinName = \apu_operands_o[2][18]; 
      name_POs [75] = "\apu_operands_o[2][19]";      // pinName = \apu_operands_o[2][19]; 
      name_POs [76] = "\apu_operands_o[2][1]";      // pinName = \apu_operands_o[2][1]; 
      name_POs [77] = "\apu_operands_o[2][20]";      // pinName = \apu_operands_o[2][20]; 
      name_POs [78] = "\apu_operands_o[2][21]";      // pinName = \apu_operands_o[2][21]; 
      name_POs [79] = "\apu_operands_o[2][22]";      // pinName = \apu_operands_o[2][22]; 
      name_POs [80] = "\apu_operands_o[2][23]";      // pinName = \apu_operands_o[2][23]; 
      name_POs [81] = "\apu_operands_o[2][24]";      // pinName = \apu_operands_o[2][24]; 
      name_POs [82] = "\apu_operands_o[2][25]";      // pinName = \apu_operands_o[2][25]; 
      name_POs [83] = "\apu_operands_o[2][26]";      // pinName = \apu_operands_o[2][26]; 
      name_POs [84] = "\apu_operands_o[2][27]";      // pinName = \apu_operands_o[2][27]; 
      name_POs [85] = "\apu_operands_o[2][28]";      // pinName = \apu_operands_o[2][28]; 
      name_POs [86] = "\apu_operands_o[2][29]";      // pinName = \apu_operands_o[2][29]; 
      name_POs [87] = "\apu_operands_o[2][2]";      // pinName = \apu_operands_o[2][2]; 
      name_POs [88] = "\apu_operands_o[2][30]";      // pinName = \apu_operands_o[2][30]; 
      name_POs [89] = "\apu_operands_o[2][31]";      // pinName = \apu_operands_o[2][31]; 
      name_POs [90] = "\apu_operands_o[2][3]";      // pinName = \apu_operands_o[2][3]; 
      name_POs [91] = "\apu_operands_o[2][4]";      // pinName = \apu_operands_o[2][4]; 
      name_POs [92] = "\apu_operands_o[2][5]";      // pinName = \apu_operands_o[2][5]; 
      name_POs [93] = "\apu_operands_o[2][6]";      // pinName = \apu_operands_o[2][6]; 
      name_POs [94] = "\apu_operands_o[2][7]";      // pinName = \apu_operands_o[2][7]; 
      name_POs [95] = "\apu_operands_o[2][8]";      // pinName = \apu_operands_o[2][8]; 
      name_POs [96] = "\apu_operands_o[2][9]";      // pinName = \apu_operands_o[2][9]; 
      name_POs [97] = "apu_busy_o";      // pinName = apu_busy_o; 
      name_POs [98] = "apu_flags_o[0]";      // pinName = apu_flags_o[0]; 
      name_POs [99] = "apu_flags_o[10]";      // pinName = apu_flags_o[10]; 
      name_POs [100] = "apu_flags_o[11]";      // pinName = apu_flags_o[11]; 
      name_POs [101] = "apu_flags_o[12]";      // pinName = apu_flags_o[12]; 
      name_POs [102] = "apu_flags_o[13]";      // pinName = apu_flags_o[13]; 
      name_POs [103] = "apu_flags_o[14]";      // pinName = apu_flags_o[14]; 
      name_POs [104] = "apu_flags_o[1]";      // pinName = apu_flags_o[1]; 
      name_POs [105] = "apu_flags_o[2]";      // pinName = apu_flags_o[2]; 
      name_POs [106] = "apu_flags_o[3]";      // pinName = apu_flags_o[3]; 
      name_POs [107] = "apu_flags_o[4]";      // pinName = apu_flags_o[4]; 
      name_POs [108] = "apu_flags_o[5]";      // pinName = apu_flags_o[5]; 
      name_POs [109] = "apu_flags_o[6]";      // pinName = apu_flags_o[6]; 
      name_POs [110] = "apu_flags_o[7]";      // pinName = apu_flags_o[7]; 
      name_POs [111] = "apu_flags_o[8]";      // pinName = apu_flags_o[8]; 
      name_POs [112] = "apu_flags_o[9]";      // pinName = apu_flags_o[9]; 
      name_POs [113] = "apu_op_o[0]";      // pinName = apu_op_o[0]; 
      name_POs [114] = "apu_op_o[1]";      // pinName = apu_op_o[1]; 
      name_POs [115] = "apu_op_o[2]";      // pinName = apu_op_o[2]; 
      name_POs [116] = "apu_op_o[3]";      // pinName = apu_op_o[3]; 
      name_POs [117] = "apu_op_o[4]";      // pinName = apu_op_o[4]; 
      name_POs [118] = "apu_op_o[5]";      // pinName = apu_op_o[5]; 
      name_POs [119] = "apu_req_o";      // pinName = apu_req_o; 
      name_POs [120] = "core_sleep_o";      // pinName = core_sleep_o; 
      name_POs [121] = "data_addr_o[0]";      // pinName = data_addr_o[0]; 
      name_POs [122] = "data_addr_o[10]";      // pinName = data_addr_o[10]; 
      name_POs [123] = "data_addr_o[11]";      // pinName = data_addr_o[11]; 
      name_POs [124] = "data_addr_o[12]";      // pinName = data_addr_o[12]; 
      name_POs [125] = "data_addr_o[13]";      // pinName = data_addr_o[13]; 
      name_POs [126] = "data_addr_o[14]";      // pinName = data_addr_o[14]; 
      name_POs [127] = "data_addr_o[15]";      // pinName = data_addr_o[15]; 
      name_POs [128] = "data_addr_o[16]";      // pinName = data_addr_o[16]; 
      name_POs [129] = "data_addr_o[17]";      // pinName = data_addr_o[17]; 
      name_POs [130] = "data_addr_o[18]";      // pinName = data_addr_o[18]; 
      name_POs [131] = "data_addr_o[19]";      // pinName = data_addr_o[19]; 
      name_POs [132] = "data_addr_o[1]";      // pinName = data_addr_o[1]; 
      name_POs [133] = "data_addr_o[20]";      // pinName = data_addr_o[20]; 
      name_POs [134] = "data_addr_o[21]";      // pinName = data_addr_o[21]; 
      name_POs [135] = "data_addr_o[22]";      // pinName = data_addr_o[22]; 
      name_POs [136] = "data_addr_o[23]";      // pinName = data_addr_o[23]; 
      name_POs [137] = "data_addr_o[24]";      // pinName = data_addr_o[24]; 
      name_POs [138] = "data_addr_o[25]";      // pinName = data_addr_o[25]; 
      name_POs [139] = "data_addr_o[26]";      // pinName = data_addr_o[26]; 
      name_POs [140] = "data_addr_o[27]";      // pinName = data_addr_o[27]; 
      name_POs [141] = "data_addr_o[28]";      // pinName = data_addr_o[28]; 
      name_POs [142] = "data_addr_o[29]";      // pinName = data_addr_o[29]; 
      name_POs [143] = "data_addr_o[2]";      // pinName = data_addr_o[2]; 
      name_POs [144] = "data_addr_o[30]";      // pinName = data_addr_o[30]; 
      name_POs [145] = "data_addr_o[31]";      // pinName = data_addr_o[31]; 
      name_POs [146] = "data_addr_o[3]";      // pinName = data_addr_o[3]; 
      name_POs [147] = "data_addr_o[4]";      // pinName = data_addr_o[4]; 
      name_POs [148] = "data_addr_o[5]";      // pinName = data_addr_o[5]; 
      name_POs [149] = "data_addr_o[6]";      // pinName = data_addr_o[6]; 
      name_POs [150] = "data_addr_o[7]";      // pinName = data_addr_o[7]; 
      name_POs [151] = "data_addr_o[8]";      // pinName = data_addr_o[8]; 
      name_POs [152] = "data_addr_o[9]";      // pinName = data_addr_o[9]; 
      name_POs [153] = "data_be_o[0]";      // pinName = data_be_o[0]; 
      name_POs [154] = "data_be_o[1]";      // pinName = data_be_o[1]; 
      name_POs [155] = "data_be_o[2]";      // pinName = data_be_o[2]; 
      name_POs [156] = "data_be_o[3]";      // pinName = data_be_o[3]; 
      name_POs [157] = "data_req_o";      // pinName = data_req_o; 
      name_POs [158] = "data_wdata_o[0]";      // pinName = data_wdata_o[0]; 
      name_POs [159] = "data_wdata_o[10]";      // pinName = data_wdata_o[10]; 
      name_POs [160] = "data_wdata_o[11]";      // pinName = data_wdata_o[11]; 
      name_POs [161] = "data_wdata_o[12]";      // pinName = data_wdata_o[12]; 
      name_POs [162] = "data_wdata_o[13]";      // pinName = data_wdata_o[13]; 
      name_POs [163] = "data_wdata_o[14]";      // pinName = data_wdata_o[14]; 
      name_POs [164] = "data_wdata_o[15]";      // pinName = data_wdata_o[15]; 
      name_POs [165] = "data_wdata_o[16]";      // pinName = data_wdata_o[16]; 
      name_POs [166] = "data_wdata_o[17]";      // pinName = data_wdata_o[17]; 
      name_POs [167] = "data_wdata_o[18]";      // pinName = data_wdata_o[18]; 
      name_POs [168] = "data_wdata_o[19]";      // pinName = data_wdata_o[19]; 
      name_POs [169] = "data_wdata_o[1]";      // pinName = data_wdata_o[1]; 
      name_POs [170] = "data_wdata_o[20]";      // pinName = data_wdata_o[20]; 
      name_POs [171] = "data_wdata_o[21]";      // pinName = data_wdata_o[21]; 
      name_POs [172] = "data_wdata_o[22]";      // pinName = data_wdata_o[22]; 
      name_POs [173] = "data_wdata_o[23]";      // pinName = data_wdata_o[23]; 
      name_POs [174] = "data_wdata_o[24]";      // pinName = data_wdata_o[24]; 
      name_POs [175] = "data_wdata_o[25]";      // pinName = data_wdata_o[25]; 
      name_POs [176] = "data_wdata_o[26]";      // pinName = data_wdata_o[26]; 
      name_POs [177] = "data_wdata_o[27]";      // pinName = data_wdata_o[27]; 
      name_POs [178] = "data_wdata_o[28]";      // pinName = data_wdata_o[28]; 
      name_POs [179] = "data_wdata_o[29]";      // pinName = data_wdata_o[29]; 
      name_POs [180] = "data_wdata_o[2]";      // pinName = data_wdata_o[2]; 
      name_POs [181] = "data_wdata_o[30]";      // pinName = data_wdata_o[30]; 
      name_POs [182] = "data_wdata_o[31]";      // pinName = data_wdata_o[31]; 
      name_POs [183] = "data_wdata_o[3]";      // pinName = data_wdata_o[3]; 
      name_POs [184] = "data_wdata_o[4]";      // pinName = data_wdata_o[4]; 
      name_POs [185] = "data_wdata_o[5]";      // pinName = data_wdata_o[5]; 
      name_POs [186] = "data_wdata_o[6]";      // pinName = data_wdata_o[6]; 
      name_POs [187] = "data_wdata_o[7]";      // pinName = data_wdata_o[7]; 
      name_POs [188] = "data_wdata_o[8]";      // pinName = data_wdata_o[8]; 
      name_POs [189] = "data_wdata_o[9]";      // pinName = data_wdata_o[9]; 
      name_POs [190] = "data_we_o";      // pinName = data_we_o; 
      name_POs [191] = "debug_halted_o";      // pinName = debug_halted_o; 
      name_POs [192] = "debug_havereset_o";      // pinName = debug_havereset_o; 
      name_POs [193] = "debug_running_o";      // pinName = debug_running_o; 
      name_POs [194] = "instr_addr_o[0]";      // pinName = instr_addr_o[0]; 
      name_POs [195] = "instr_addr_o[10]";      // pinName = instr_addr_o[10]; 
      name_POs [196] = "instr_addr_o[11]";      // pinName = instr_addr_o[11]; 
      name_POs [197] = "instr_addr_o[12]";      // pinName = instr_addr_o[12]; 
      name_POs [198] = "instr_addr_o[13]";      // pinName = instr_addr_o[13]; 
      name_POs [199] = "instr_addr_o[14]";      // pinName = instr_addr_o[14]; 
      name_POs [200] = "instr_addr_o[15]";      // pinName = instr_addr_o[15]; 
      name_POs [201] = "instr_addr_o[16]";      // pinName = instr_addr_o[16]; 
      name_POs [202] = "instr_addr_o[17]";      // pinName = instr_addr_o[17]; 
      name_POs [203] = "instr_addr_o[18]";      // pinName = instr_addr_o[18]; 
      name_POs [204] = "instr_addr_o[19]";      // pinName = instr_addr_o[19]; 
      name_POs [205] = "instr_addr_o[1]";      // pinName = instr_addr_o[1]; 
      name_POs [206] = "instr_addr_o[20]";      // pinName = instr_addr_o[20]; 
      name_POs [207] = "instr_addr_o[21]";      // pinName = instr_addr_o[21]; 
      name_POs [208] = "instr_addr_o[22]";      // pinName = instr_addr_o[22]; 
      name_POs [209] = "instr_addr_o[23]";      // pinName = instr_addr_o[23]; 
      name_POs [210] = "instr_addr_o[24]";      // pinName = instr_addr_o[24]; 
      name_POs [211] = "instr_addr_o[25]";      // pinName = instr_addr_o[25]; 
      name_POs [212] = "instr_addr_o[26]";      // pinName = instr_addr_o[26]; 
      name_POs [213] = "instr_addr_o[27]";      // pinName = instr_addr_o[27]; 
      name_POs [214] = "instr_addr_o[28]";      // pinName = instr_addr_o[28]; 
      name_POs [215] = "instr_addr_o[29]";      // pinName = instr_addr_o[29]; 
      name_POs [216] = "instr_addr_o[2]";      // pinName = instr_addr_o[2]; 
      name_POs [217] = "instr_addr_o[30]";      // pinName = instr_addr_o[30]; 
      name_POs [218] = "instr_addr_o[31]";      // pinName = instr_addr_o[31]; 
      name_POs [219] = "instr_addr_o[3]";      // pinName = instr_addr_o[3]; 
      name_POs [220] = "instr_addr_o[4]";      // pinName = instr_addr_o[4]; 
      name_POs [221] = "instr_addr_o[5]";      // pinName = instr_addr_o[5]; 
      name_POs [222] = "instr_addr_o[6]";      // pinName = instr_addr_o[6]; 
      name_POs [223] = "instr_addr_o[7]";      // pinName = instr_addr_o[7]; 
      name_POs [224] = "instr_addr_o[8]";      // pinName = instr_addr_o[8]; 
      name_POs [225] = "instr_addr_o[9]";      // pinName = instr_addr_o[9]; 
      name_POs [226] = "instr_req_o";      // pinName = instr_req_o; 
      name_POs [227] = "irq_ack_o";      // pinName = irq_ack_o; 
      name_POs [228] = "irq_id_o[0]";      // pinName = irq_id_o[0]; 
      name_POs [229] = "irq_id_o[1]";      // pinName = irq_id_o[1]; 
      name_POs [230] = "irq_id_o[2]";      // pinName = irq_id_o[2]; 
      name_POs [231] = "irq_id_o[3]";      // pinName = irq_id_o[3]; 
      name_POs [232] = "irq_id_o[4]";      // pinName = irq_id_o[4]; 
      name_POs [233] = "scan_out_0";      // pinName = scan_out_0;  tf =  SO  ; 
      name_POs [234] = "scan_out_1";      // pinName = scan_out_1;  tf =  SO1 ; 



      if ( $test$plusargs ( "MODUS_DEBUG" ) )  sim_trace = 1'b1; 

      if ( $test$plusargs ( "HEARTBEAT" ) )  sim_heart = 1'b1; 

      if ( $value$plusargs ( "START_RANGE=%s", SOD ) )  sim_range = 1'b0; 
      if ( $value$plusargs ( "START_RANGE=%s", SOD ) ) sim_range_measure = 1'b0;

      if ( $value$plusargs ( "END_RANGE=%s", EOD ) ); 

      if ( $value$plusargs ( "miscompare_limit=%0f", miscompare_limit ) ); 

      if ( $test$plusargs ( "FAILSET" ) )  failset = 1'b1; 

      stim_PIs = {312{1'bX}};   
      stim_CIs = 312'bX0XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX0XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX; 
      meas_POs = {234{1'bX}};   
      stim_CR_1 = {14{1'b0}};   stim_CR_2 = {14{1'b0}};   
      meas_OR_1 = {14{1'bX}};   meas_OR_2 = {14{1'bX}};   
      stim_CME_0 = {14{1'b0}};   
      stim_CMSR_1 = {77{1'b0}};   stim_CMSR_2 = {77{1'b0}};   

    end  
  endtask  

//***************************************************************************//
//                          FAILSET SETUP PROCEDURE                          //
//***************************************************************************//

  task failset_setup; 
    begin 

      $sformat ( FAILSET, "%0s_FAILSET", DATAFILE ); 
      FAILSETID = $fopen ( FAILSET, "w" ); 
      if ( ! FAILSETID ) 
        $display ( "\nERROR (TVE-951): Failed to open the file: %0s. \n", FAILSET ); 

    end  
  endtask 

//***************************************************************************//
//                           SET UP FOR SIMULATION                           //
//***************************************************************************//

  task sim_vector_file; 
    begin 

      CYCLE = 0; 
      SCANCYCLE = 0; 
      SERIALCYCLE = 0; 
      good_compares = 0; 
      miscompares = 0; 
      measure_current = 0; 
      test_num = 0; 
      test_num_prev = 0; 
      failed_test_num = 0; 
      num_tests = 0; 
      num_failed_tests = 0; 
      scan_num = 0; 
      overlap = 0; 
      repeat_depth = 0; 
      repeat_heart = 1000; 


      $display ( "\nINFO (TVE-200): Simulating vector file: %0s ", DATAFILE ); 

      $display ( "\nINFO (TVE-189): Design:  cv32e40p_core   Test Mode:  COMPRESSION   InExperiment:  cv32e40p_core_stuck_at " ); 
      start_of_current_line = $ftell ( DATAID ); 
      line_number = 1; 
      rc_read = $fscanf ( DATAID, "%d", CMD ); 
      while ( rc_read > 0 ) begin 

        cmd_code; 

        if ( rc_read > 0 )  begin 
          if ( sim_range )  begin 
            if (( miscompare_limit > 0 ) & ( miscompares > miscompare_limit ))  begin 
              sim_range = 1'b0; 
              if ( overlap )  num_tests = num_tests - 1; 
              $display ( "\nINFO (TVE-207): The miscompare limit (+miscompare_limit) of %0.0f has been reached. ", miscompare_limit ); 
            end  
            if ( EOD == pattern )  begin 
              sim_range = 1'b0; 
            end  
          end  
          start_of_current_line = $ftell ( DATAID ); 
          rc_read = $fscanf ( DATAID, "%d", CMD ); 
          if ( rc_read <= 0 )  begin 
            rc_read = $fgets ( COMMENT, DATAID ); 
            if ( rc_read > 0 )  bad_cmd_code; 
            else  line_number = 0; 
          end  
        end  
      end  

      if ( line_number == 0 )  begin
        $display ( "\nINFO (TVE-201): Simulation complete on vector file: %0s ", DATAFILE ); 
        $display ( "\nINFO (TVE-210): Results for vector file: %0s ", DATAFILE ); 
        $display ( "                      Number of Cycles:               %0d ", CYCLE ); 
        $display ( "                      Number of Tests:                %0d ", num_tests ); 
        $display ( "                        - Passed Tests:               %0d ", num_tests - num_failed_tests ); 
        $display ( "                        - Failed Tests:               %0d ", num_failed_tests ); 
        $display ( "                      Number of Compares:             %0.0f ", good_compares + miscompares ); 
        $display ( "                        - Good Compares:              %0.0f ", good_compares ); 
        $display ( "                        - Miscompares:                %0.0f ", miscompares ); 
        $display ( "                      Time:                       %t \n", $time ); 
      end  

      $fclose ( DATAID ); 

      total_good_compares = total_good_compares + good_compares; 

      total_miscompares = total_miscompares + miscompares; 

      total_num_tests = total_num_tests + num_tests; 

      total_num_failed_tests = total_num_failed_tests + num_failed_tests; 

      total_cycles = total_cycles + CYCLE; 

    end  
  endtask  

//***************************************************************************//
//                           DEFINE TEST PROCEDURE                           //
//***************************************************************************//

  task test_cycle; 
    begin 

      CYCLE = CYCLE + 1; 
      SERIALCYCLE = SERIALCYCLE + 1; 
     #0.000000;        // 0.000000 ns;  From the start of the cycle.
      part_PIs [1] = stim_PIs [1];      // pinName = DFT_compression_enable;  tf = +SE  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [2] = stim_PIs [2];      // pinName = DFT_mask_clk;  tf = -CML  ; testOffset = 0.000000;  scanOffset = 16.000000;  
      part_PIs [3] = stim_PIs [3];      // pinName = DFT_mask_enable;  tf = -TC  -CME  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [4] = stim_PIs [4];      // pinName = SCAN_ENABLE;  tf = +SE  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [5] = stim_PIs [5];      // pinName = apu_flags_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [6] = stim_PIs [6];      // pinName = apu_flags_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [7] = stim_PIs [7];      // pinName = apu_flags_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [8] = stim_PIs [8];      // pinName = apu_flags_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [9] = stim_PIs [9];      // pinName = apu_flags_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [10] = stim_PIs [10];      // pinName = apu_gnt_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [11] = stim_PIs [11];      // pinName = apu_result_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [12] = stim_PIs [12];      // pinName = apu_result_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [13] = stim_PIs [13];      // pinName = apu_result_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [14] = stim_PIs [14];      // pinName = apu_result_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [15] = stim_PIs [15];      // pinName = apu_result_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [16] = stim_PIs [16];      // pinName = apu_result_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [17] = stim_PIs [17];      // pinName = apu_result_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [18] = stim_PIs [18];      // pinName = apu_result_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [19] = stim_PIs [19];      // pinName = apu_result_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [20] = stim_PIs [20];      // pinName = apu_result_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [21] = stim_PIs [21];      // pinName = apu_result_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [22] = stim_PIs [22];      // pinName = apu_result_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [23] = stim_PIs [23];      // pinName = apu_result_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [24] = stim_PIs [24];      // pinName = apu_result_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [25] = stim_PIs [25];      // pinName = apu_result_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [26] = stim_PIs [26];      // pinName = apu_result_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [27] = stim_PIs [27];      // pinName = apu_result_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [28] = stim_PIs [28];      // pinName = apu_result_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [29] = stim_PIs [29];      // pinName = apu_result_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [30] = stim_PIs [30];      // pinName = apu_result_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [31] = stim_PIs [31];      // pinName = apu_result_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [32] = stim_PIs [32];      // pinName = apu_result_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [33] = stim_PIs [33];      // pinName = apu_result_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [34] = stim_PIs [34];      // pinName = apu_result_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [35] = stim_PIs [35];      // pinName = apu_result_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [36] = stim_PIs [36];      // pinName = apu_result_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [37] = stim_PIs [37];      // pinName = apu_result_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [38] = stim_PIs [38];      // pinName = apu_result_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [39] = stim_PIs [39];      // pinName = apu_result_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [40] = stim_PIs [40];      // pinName = apu_result_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [41] = stim_PIs [41];      // pinName = apu_result_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [42] = stim_PIs [42];      // pinName = apu_result_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [43] = stim_PIs [43];      // pinName = apu_rvalid_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [44] = stim_PIs [44];      // pinName = boot_addr_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [45] = stim_PIs [45];      // pinName = boot_addr_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [46] = stim_PIs [46];      // pinName = boot_addr_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [47] = stim_PIs [47];      // pinName = boot_addr_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [48] = stim_PIs [48];      // pinName = boot_addr_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [49] = stim_PIs [49];      // pinName = boot_addr_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [50] = stim_PIs [50];      // pinName = boot_addr_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [51] = stim_PIs [51];      // pinName = boot_addr_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [52] = stim_PIs [52];      // pinName = boot_addr_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [53] = stim_PIs [53];      // pinName = boot_addr_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [54] = stim_PIs [54];      // pinName = boot_addr_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [55] = stim_PIs [55];      // pinName = boot_addr_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [56] = stim_PIs [56];      // pinName = boot_addr_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [57] = stim_PIs [57];      // pinName = boot_addr_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [58] = stim_PIs [58];      // pinName = boot_addr_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [59] = stim_PIs [59];      // pinName = boot_addr_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [60] = stim_PIs [60];      // pinName = boot_addr_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [61] = stim_PIs [61];      // pinName = boot_addr_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [62] = stim_PIs [62];      // pinName = boot_addr_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [63] = stim_PIs [63];      // pinName = boot_addr_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [64] = stim_PIs [64];      // pinName = boot_addr_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [65] = stim_PIs [65];      // pinName = boot_addr_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [66] = stim_PIs [66];      // pinName = boot_addr_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [67] = stim_PIs [67];      // pinName = boot_addr_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [68] = stim_PIs [68];      // pinName = boot_addr_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [69] = stim_PIs [69];      // pinName = boot_addr_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [70] = stim_PIs [70];      // pinName = boot_addr_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [71] = stim_PIs [71];      // pinName = boot_addr_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [72] = stim_PIs [72];      // pinName = boot_addr_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [73] = stim_PIs [73];      // pinName = boot_addr_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [74] = stim_PIs [74];      // pinName = boot_addr_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [75] = stim_PIs [75];      // pinName = boot_addr_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [77] = stim_PIs [77];      // pinName = data_gnt_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [78] = stim_PIs [78];      // pinName = data_rdata_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [79] = stim_PIs [79];      // pinName = data_rdata_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [80] = stim_PIs [80];      // pinName = data_rdata_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [81] = stim_PIs [81];      // pinName = data_rdata_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [82] = stim_PIs [82];      // pinName = data_rdata_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [83] = stim_PIs [83];      // pinName = data_rdata_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [84] = stim_PIs [84];      // pinName = data_rdata_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [85] = stim_PIs [85];      // pinName = data_rdata_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [86] = stim_PIs [86];      // pinName = data_rdata_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [87] = stim_PIs [87];      // pinName = data_rdata_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [88] = stim_PIs [88];      // pinName = data_rdata_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [89] = stim_PIs [89];      // pinName = data_rdata_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [90] = stim_PIs [90];      // pinName = data_rdata_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [91] = stim_PIs [91];      // pinName = data_rdata_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [92] = stim_PIs [92];      // pinName = data_rdata_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [93] = stim_PIs [93];      // pinName = data_rdata_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [94] = stim_PIs [94];      // pinName = data_rdata_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [95] = stim_PIs [95];      // pinName = data_rdata_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [96] = stim_PIs [96];      // pinName = data_rdata_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [97] = stim_PIs [97];      // pinName = data_rdata_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [98] = stim_PIs [98];      // pinName = data_rdata_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [99] = stim_PIs [99];      // pinName = data_rdata_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [100] = stim_PIs [100];      // pinName = data_rdata_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [101] = stim_PIs [101];      // pinName = data_rdata_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [102] = stim_PIs [102];      // pinName = data_rdata_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [103] = stim_PIs [103];      // pinName = data_rdata_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [104] = stim_PIs [104];      // pinName = data_rdata_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [105] = stim_PIs [105];      // pinName = data_rdata_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [106] = stim_PIs [106];      // pinName = data_rdata_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [107] = stim_PIs [107];      // pinName = data_rdata_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [108] = stim_PIs [108];      // pinName = data_rdata_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [109] = stim_PIs [109];      // pinName = data_rdata_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [110] = stim_PIs [110];      // pinName = data_rvalid_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [111] = stim_PIs [111];      // pinName = debug_req_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [112] = stim_PIs [112];      // pinName = dm_exception_addr_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [113] = stim_PIs [113];      // pinName = dm_exception_addr_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [114] = stim_PIs [114];      // pinName = dm_exception_addr_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [115] = stim_PIs [115];      // pinName = dm_exception_addr_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [116] = stim_PIs [116];      // pinName = dm_exception_addr_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [117] = stim_PIs [117];      // pinName = dm_exception_addr_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [118] = stim_PIs [118];      // pinName = dm_exception_addr_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [119] = stim_PIs [119];      // pinName = dm_exception_addr_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [120] = stim_PIs [120];      // pinName = dm_exception_addr_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [121] = stim_PIs [121];      // pinName = dm_exception_addr_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [122] = stim_PIs [122];      // pinName = dm_exception_addr_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [123] = stim_PIs [123];      // pinName = dm_exception_addr_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [124] = stim_PIs [124];      // pinName = dm_exception_addr_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [125] = stim_PIs [125];      // pinName = dm_exception_addr_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [126] = stim_PIs [126];      // pinName = dm_exception_addr_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [127] = stim_PIs [127];      // pinName = dm_exception_addr_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [128] = stim_PIs [128];      // pinName = dm_exception_addr_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [129] = stim_PIs [129];      // pinName = dm_exception_addr_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [130] = stim_PIs [130];      // pinName = dm_exception_addr_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [131] = stim_PIs [131];      // pinName = dm_exception_addr_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [132] = stim_PIs [132];      // pinName = dm_exception_addr_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [133] = stim_PIs [133];      // pinName = dm_exception_addr_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [134] = stim_PIs [134];      // pinName = dm_exception_addr_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [135] = stim_PIs [135];      // pinName = dm_exception_addr_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [136] = stim_PIs [136];      // pinName = dm_exception_addr_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [137] = stim_PIs [137];      // pinName = dm_exception_addr_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [138] = stim_PIs [138];      // pinName = dm_exception_addr_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [139] = stim_PIs [139];      // pinName = dm_exception_addr_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [140] = stim_PIs [140];      // pinName = dm_exception_addr_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [141] = stim_PIs [141];      // pinName = dm_exception_addr_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [142] = stim_PIs [142];      // pinName = dm_exception_addr_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [143] = stim_PIs [143];      // pinName = dm_exception_addr_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [144] = stim_PIs [144];      // pinName = dm_halt_addr_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [145] = stim_PIs [145];      // pinName = dm_halt_addr_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [146] = stim_PIs [146];      // pinName = dm_halt_addr_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [147] = stim_PIs [147];      // pinName = dm_halt_addr_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [148] = stim_PIs [148];      // pinName = dm_halt_addr_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [149] = stim_PIs [149];      // pinName = dm_halt_addr_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [150] = stim_PIs [150];      // pinName = dm_halt_addr_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [151] = stim_PIs [151];      // pinName = dm_halt_addr_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [152] = stim_PIs [152];      // pinName = dm_halt_addr_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [153] = stim_PIs [153];      // pinName = dm_halt_addr_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [154] = stim_PIs [154];      // pinName = dm_halt_addr_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [155] = stim_PIs [155];      // pinName = dm_halt_addr_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [156] = stim_PIs [156];      // pinName = dm_halt_addr_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [157] = stim_PIs [157];      // pinName = dm_halt_addr_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [158] = stim_PIs [158];      // pinName = dm_halt_addr_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [159] = stim_PIs [159];      // pinName = dm_halt_addr_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [160] = stim_PIs [160];      // pinName = dm_halt_addr_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [161] = stim_PIs [161];      // pinName = dm_halt_addr_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [162] = stim_PIs [162];      // pinName = dm_halt_addr_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [163] = stim_PIs [163];      // pinName = dm_halt_addr_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [164] = stim_PIs [164];      // pinName = dm_halt_addr_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [165] = stim_PIs [165];      // pinName = dm_halt_addr_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [166] = stim_PIs [166];      // pinName = dm_halt_addr_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [167] = stim_PIs [167];      // pinName = dm_halt_addr_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [168] = stim_PIs [168];      // pinName = dm_halt_addr_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [169] = stim_PIs [169];      // pinName = dm_halt_addr_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [170] = stim_PIs [170];      // pinName = dm_halt_addr_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [171] = stim_PIs [171];      // pinName = dm_halt_addr_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [172] = stim_PIs [172];      // pinName = dm_halt_addr_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [173] = stim_PIs [173];      // pinName = dm_halt_addr_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [174] = stim_PIs [174];      // pinName = dm_halt_addr_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [175] = stim_PIs [175];      // pinName = dm_halt_addr_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [176] = stim_PIs [176];      // pinName = fetch_enable_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [177] = stim_PIs [177];      // pinName = hart_id_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [178] = stim_PIs [178];      // pinName = hart_id_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [179] = stim_PIs [179];      // pinName = hart_id_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [180] = stim_PIs [180];      // pinName = hart_id_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [181] = stim_PIs [181];      // pinName = hart_id_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [182] = stim_PIs [182];      // pinName = hart_id_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [183] = stim_PIs [183];      // pinName = hart_id_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [184] = stim_PIs [184];      // pinName = hart_id_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [185] = stim_PIs [185];      // pinName = hart_id_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [186] = stim_PIs [186];      // pinName = hart_id_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [187] = stim_PIs [187];      // pinName = hart_id_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [188] = stim_PIs [188];      // pinName = hart_id_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [189] = stim_PIs [189];      // pinName = hart_id_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [190] = stim_PIs [190];      // pinName = hart_id_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [191] = stim_PIs [191];      // pinName = hart_id_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [192] = stim_PIs [192];      // pinName = hart_id_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [193] = stim_PIs [193];      // pinName = hart_id_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [194] = stim_PIs [194];      // pinName = hart_id_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [195] = stim_PIs [195];      // pinName = hart_id_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [196] = stim_PIs [196];      // pinName = hart_id_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [197] = stim_PIs [197];      // pinName = hart_id_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [198] = stim_PIs [198];      // pinName = hart_id_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [199] = stim_PIs [199];      // pinName = hart_id_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [200] = stim_PIs [200];      // pinName = hart_id_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [201] = stim_PIs [201];      // pinName = hart_id_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [202] = stim_PIs [202];      // pinName = hart_id_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [203] = stim_PIs [203];      // pinName = hart_id_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [204] = stim_PIs [204];      // pinName = hart_id_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [205] = stim_PIs [205];      // pinName = hart_id_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [206] = stim_PIs [206];      // pinName = hart_id_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [207] = stim_PIs [207];      // pinName = hart_id_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [208] = stim_PIs [208];      // pinName = hart_id_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [209] = stim_PIs [209];      // pinName = instr_gnt_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [210] = stim_PIs [210];      // pinName = instr_rdata_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [211] = stim_PIs [211];      // pinName = instr_rdata_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [212] = stim_PIs [212];      // pinName = instr_rdata_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [213] = stim_PIs [213];      // pinName = instr_rdata_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [214] = stim_PIs [214];      // pinName = instr_rdata_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [215] = stim_PIs [215];      // pinName = instr_rdata_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [216] = stim_PIs [216];      // pinName = instr_rdata_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [217] = stim_PIs [217];      // pinName = instr_rdata_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [218] = stim_PIs [218];      // pinName = instr_rdata_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [219] = stim_PIs [219];      // pinName = instr_rdata_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [220] = stim_PIs [220];      // pinName = instr_rdata_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [221] = stim_PIs [221];      // pinName = instr_rdata_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [222] = stim_PIs [222];      // pinName = instr_rdata_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [223] = stim_PIs [223];      // pinName = instr_rdata_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [224] = stim_PIs [224];      // pinName = instr_rdata_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [225] = stim_PIs [225];      // pinName = instr_rdata_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [226] = stim_PIs [226];      // pinName = instr_rdata_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [227] = stim_PIs [227];      // pinName = instr_rdata_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [228] = stim_PIs [228];      // pinName = instr_rdata_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [229] = stim_PIs [229];      // pinName = instr_rdata_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [230] = stim_PIs [230];      // pinName = instr_rdata_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [231] = stim_PIs [231];      // pinName = instr_rdata_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [232] = stim_PIs [232];      // pinName = instr_rdata_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [233] = stim_PIs [233];      // pinName = instr_rdata_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [234] = stim_PIs [234];      // pinName = instr_rdata_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [235] = stim_PIs [235];      // pinName = instr_rdata_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [236] = stim_PIs [236];      // pinName = instr_rdata_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [237] = stim_PIs [237];      // pinName = instr_rdata_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [238] = stim_PIs [238];      // pinName = instr_rdata_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [239] = stim_PIs [239];      // pinName = instr_rdata_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [240] = stim_PIs [240];      // pinName = instr_rdata_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [241] = stim_PIs [241];      // pinName = instr_rdata_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [242] = stim_PIs [242];      // pinName = instr_rvalid_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [243] = stim_PIs [243];      // pinName = irq_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [244] = stim_PIs [244];      // pinName = irq_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [245] = stim_PIs [245];      // pinName = irq_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [246] = stim_PIs [246];      // pinName = irq_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [247] = stim_PIs [247];      // pinName = irq_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [248] = stim_PIs [248];      // pinName = irq_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [249] = stim_PIs [249];      // pinName = irq_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [250] = stim_PIs [250];      // pinName = irq_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [251] = stim_PIs [251];      // pinName = irq_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [252] = stim_PIs [252];      // pinName = irq_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [253] = stim_PIs [253];      // pinName = irq_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [254] = stim_PIs [254];      // pinName = irq_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [255] = stim_PIs [255];      // pinName = irq_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [256] = stim_PIs [256];      // pinName = irq_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [257] = stim_PIs [257];      // pinName = irq_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [258] = stim_PIs [258];      // pinName = irq_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [259] = stim_PIs [259];      // pinName = irq_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [260] = stim_PIs [260];      // pinName = irq_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [261] = stim_PIs [261];      // pinName = irq_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [262] = stim_PIs [262];      // pinName = irq_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [263] = stim_PIs [263];      // pinName = irq_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [264] = stim_PIs [264];      // pinName = irq_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [265] = stim_PIs [265];      // pinName = irq_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [266] = stim_PIs [266];      // pinName = irq_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [267] = stim_PIs [267];      // pinName = irq_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [268] = stim_PIs [268];      // pinName = irq_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [269] = stim_PIs [269];      // pinName = irq_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [270] = stim_PIs [270];      // pinName = irq_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [271] = stim_PIs [271];      // pinName = irq_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [272] = stim_PIs [272];      // pinName = irq_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [273] = stim_PIs [273];      // pinName = irq_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [274] = stim_PIs [274];      // pinName = irq_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [275] = stim_PIs [275];      // pinName = mtvec_addr_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [276] = stim_PIs [276];      // pinName = mtvec_addr_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [277] = stim_PIs [277];      // pinName = mtvec_addr_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [278] = stim_PIs [278];      // pinName = mtvec_addr_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [279] = stim_PIs [279];      // pinName = mtvec_addr_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [280] = stim_PIs [280];      // pinName = mtvec_addr_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [281] = stim_PIs [281];      // pinName = mtvec_addr_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [282] = stim_PIs [282];      // pinName = mtvec_addr_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [283] = stim_PIs [283];      // pinName = mtvec_addr_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [284] = stim_PIs [284];      // pinName = mtvec_addr_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [285] = stim_PIs [285];      // pinName = mtvec_addr_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [286] = stim_PIs [286];      // pinName = mtvec_addr_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [287] = stim_PIs [287];      // pinName = mtvec_addr_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [288] = stim_PIs [288];      // pinName = mtvec_addr_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [289] = stim_PIs [289];      // pinName = mtvec_addr_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [290] = stim_PIs [290];      // pinName = mtvec_addr_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [291] = stim_PIs [291];      // pinName = mtvec_addr_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [292] = stim_PIs [292];      // pinName = mtvec_addr_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [293] = stim_PIs [293];      // pinName = mtvec_addr_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [294] = stim_PIs [294];      // pinName = mtvec_addr_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [295] = stim_PIs [295];      // pinName = mtvec_addr_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [296] = stim_PIs [296];      // pinName = mtvec_addr_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [297] = stim_PIs [297];      // pinName = mtvec_addr_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [298] = stim_PIs [298];      // pinName = mtvec_addr_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [299] = stim_PIs [299];      // pinName = mtvec_addr_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [300] = stim_PIs [300];      // pinName = mtvec_addr_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [301] = stim_PIs [301];      // pinName = mtvec_addr_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [302] = stim_PIs [302];      // pinName = mtvec_addr_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [303] = stim_PIs [303];      // pinName = mtvec_addr_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [304] = stim_PIs [304];      // pinName = mtvec_addr_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [305] = stim_PIs [305];      // pinName = mtvec_addr_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [306] = stim_PIs [306];      // pinName = mtvec_addr_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [307] = stim_PIs [307];      // pinName = pulp_clock_en_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [309] = stim_PIs [309];      // pinName = scan_cg_en_i;  tf = +TI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [310] = stim_PIs [310];      // pinName = scan_in_0;  tf =  SI   CMI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [311] = stim_PIs [311];      // pinName = scan_in_1;  tf =  SI1  CMI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [312] = stim_PIs [312];      // pinName = test_mode;  tf = +TI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
     #8.000000;        // 8.000000 ns;  From the start of the cycle.
      part_PIs [76] = stim_PIs [76];      // pinName = clk_i;  tf = -ES  ; testOffset = 8.000000;  scanOffset = 16.000000;  
      part_PIs [308] = stim_PIs [308];      // pinName = rst_ni;  tf = +SC  ; testOffset = 8.000000;  scanOffset = 0.000000;  
     #8.000000;        // 16.000000 ns;  From the start of the cycle.
      part_PIs [76] = stim_CIs [76];      // pinName = clk_i;  tf = -ES  ; testOffset = 8.000000;  scanOffset = 16.000000;  
      part_PIs [308] = stim_CIs [308];      // pinName = rst_ni;  tf = +SC  ; testOffset = 8.000000;  scanOffset = 0.000000;  
     #56.000000;        // 72.000000 ns;  From the start of the cycle.

      for ( POnum = 1; POnum <= 234; POnum = POnum + 1 ) begin 
        if (( part_POs [ POnum ] !== meas_POs [ POnum ] ) & ( meas_POs [ POnum ] !== 1'bX )) begin 
          if ( test_num != failed_test_num )  begin 
            num_failed_tests = num_failed_tests + 1; 
            failed_test_num = test_num; 
          end  
          miscompares = miscompares + 1; 
          $display ( "\nWARNING (TVE-650): PO miscompare at Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t ", test_num, PATTERN, CYCLE, $time ); 
          $display ( "           Expected: %0b   Simulated: %0b   On PO: %0s   ", meas_POs [ POnum ], part_POs [ POnum ], name_POs [ POnum ] ); 

          if (( failset ) & ( FAILSETID == 0 ))  failset_setup; 
          if ( FAILSETID ) begin 
            $fdisplay ( FAILSETID, " Chip %0s pad %0s pattern %0s position %0d value %0b ", "cv32e40p_core", name_POs [ POnum ], PATTERN, -1, part_POs [ POnum ] ); 
          end  
        end  
        else if ( meas_POs [ POnum ] !== 1'bX )  good_compares = good_compares + 1; 
      end  
     #8.000000;        // 80.000000 ns;  From the start of the cycle.
      meas_POs = {234{1'bX}}; 

    end  
  endtask  

//***************************************************************************//
//                       DEFINE SCAN PRECOND PROCEDURE                       //
//***************************************************************************//

  task Scan_Preconditioning_Sequence_TM_1_SEQ_1_SOP_1; 
    begin 

      PROCESSNAME = "SCAN PRECONDITIONING (Scan_Preconditioning_Sequence)";
      stim_PIs [1] = 1'b1;      // pinName = DFT_compression_enable;  tf = +SE  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      stim_PIs [3] = 1'b0;      // pinName = DFT_mask_enable;  tf = -TC  -CME  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      stim_PIs [4] = 1'b1;      // pinName = SCAN_ENABLE;  tf = +SE  ; testOffset = 0.000000;  scanOffset = 0.000000;  

      test_cycle; 
      PROCESSNAME = "";
      PROCESSNAME = "";

    end  
  endtask  

//***************************************************************************//
//                DEFINE CHANNEL MASK SCAN SEQUENCE PROCEDURE                //
//***************************************************************************//

  task ChannelMask_Cycle_Sequence_TM_1_SEQ_2_SOP_1; 
    begin 

      PROCESSNAME = "CHANNEL MASK SCAN SEQUENCE (ChannelMask_Cycle_Sequence)";
      START = MAX - NUM_SHIFTS; 
      for ( SCANCYCLE = 1; SCANCYCLE <= MAX; SCANCYCLE = SCANCYCLE + 1 ) begin 
        CYCLE = CYCLE + 1; 
        SERIALCYCLE = SERIALCYCLE + 1; 
     #0.000000;        // 0.000000 ns;  From the start of the cycle.
        part_PIs [310] = stim_CMSR_1 [ 0 + SCANCYCLE ];      // pinName = scan_in_0;  tf =  SI   CMI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
        part_PIs [311] = stim_CMSR_2 [ 0 + SCANCYCLE ];      // pinName = scan_in_1;  tf =  SI1  CMI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
     #16.000000;        // 16.000000 ns;  From the start of the cycle.
        part_PIs [2] = 1'b1;      // pinName = DFT_mask_clk;  tf = -CML  ; testOffset = 0.000000;  scanOffset = 16.000000;  
     #8.000000;        // 24.000000 ns;  From the start of the cycle.
        part_PIs [2] = 1'b0;      // pinName = DFT_mask_clk;  tf = -CML  ; testOffset = 0.000000;  scanOffset = 16.000000;  
     #56.000000;        // 80.000000 ns;  From the start of the cycle.
      end  
      stim_CMSR_1 = {77{1'b0}};   stim_CMSR_2 = {77{1'b0}};   
      stim_PIs = part_PIs; 
      SCANCYCLE = 0; 
      NUM_SHIFTS = 0; 
      PROCESSNAME = "";

    end  
  endtask  

//***************************************************************************//
//                      DEFINE SCAN SEQUENCE PROCEDURE                       //
//***************************************************************************//

  task Scan_Sequence_TM_1_SEQ_3_SOP_1; 
    begin 

      PROCESSNAME = "SCAN SEQUENCE (Scan_Sequence)";
      if (sim_range ) sim_range_measure = 1'b1 ;
      if ( overlap )  test_num = test_num - 1; 
      START = 0; 
      for ( SCANCYCLE = 1; SCANCYCLE <= MAX; SCANCYCLE = SCANCYCLE + 1 ) begin 
        CYCLE = CYCLE + 1; 
        SERIALCYCLE = SERIALCYCLE + 1; 
     #0.000000;        // 0.000000 ns;  From the start of the cycle.
        part_PIs [3] = stim_CME_0 [ 0 + SCANCYCLE ];      // pinName = DFT_mask_enable;  tf = -TC  -CME  ; testOffset = 0.000000;  scanOffset = 0.000000;  
        part_PIs [310] = stim_CR_1 [ 0 + SCANCYCLE ];      // pinName = scan_in_0;  tf =  SI   CMI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
        part_PIs [311] = stim_CR_2 [ 0 + SCANCYCLE ];      // pinName = scan_in_1;  tf =  SI1  CMI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
     #8.000000;        // 8.000000 ns;  From the start of the cycle.

        if (( part_POs [233] !== meas_OR_1 [ 0 + SCANCYCLE ] ) & ( meas_OR_1 [ 0 + SCANCYCLE ] !== 1'bX )) begin      // pinName = scan_out_0;  tf =  SO  ; 
          if ( test_num != failed_test_num )  begin 
            num_failed_tests = num_failed_tests + 1; 
            failed_test_num = test_num; 
          end  
          miscompares = miscompares + 1; 
          $display ( "\nWARNING (TVE-660): Serial scan miscompare at Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t ", test_num, PATTERN, CYCLE, $time ); 
          $display ( "           Expected: %0b   Simulated: %0b   Measured on Scan Cycle: %0d   Measured at SO: %0s   ", meas_OR_1 [ 0 + SCANCYCLE ], part_POs [233], SCANCYCLE, name_POs [233] ); 

          if (( failset ) & ( FAILSETID == 0 ))  failset_setup; 
          if ( FAILSETID ) begin 
            $fdisplay ( FAILSETID, " Chip %0s pad %0s pattern %0s position %0d value %0b ", "cv32e40p_core", name_POs [233], PATTERN, SCANCYCLE, part_POs [233] ); 
          end  
        end  
        else  begin 
          if ( meas_OR_1 [ 0 + SCANCYCLE ] !== 1'bX )  begin 
            good_compares = good_compares + 1;
          end 
        end 

        if (( part_POs [234] !== meas_OR_2 [ 0 + SCANCYCLE ] ) & ( meas_OR_2 [ 0 + SCANCYCLE ] !== 1'bX )) begin      // pinName = scan_out_1;  tf =  SO1 ; 
          if ( test_num != failed_test_num )  begin 
            num_failed_tests = num_failed_tests + 1; 
            failed_test_num = test_num; 
          end  
          miscompares = miscompares + 1; 
          $display ( "\nWARNING (TVE-660): Serial scan miscompare at Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t ", test_num, PATTERN, CYCLE, $time ); 
          $display ( "           Expected: %0b   Simulated: %0b   Measured on Scan Cycle: %0d   Measured at SO: %0s   ", meas_OR_2 [ 0 + SCANCYCLE ], part_POs [234], SCANCYCLE, name_POs [234] ); 

          if (( failset ) & ( FAILSETID == 0 ))  failset_setup; 
          if ( FAILSETID ) begin 
            $fdisplay ( FAILSETID, " Chip %0s pad %0s pattern %0s position %0d value %0b ", "cv32e40p_core", name_POs [234], PATTERN, SCANCYCLE, part_POs [234] ); 
          end  
        end  
        else  begin 
          if ( meas_OR_2 [ 0 + SCANCYCLE ] !== 1'bX )  begin 
            good_compares = good_compares + 1;
          end 
        end 
     #8.000000;        // 16.000000 ns;  From the start of the cycle.
        part_PIs [76] = 1'b1;      // pinName = clk_i;  tf = -ES  ; testOffset = 8.000000;  scanOffset = 16.000000;  
     #8.000000;        // 24.000000 ns;  From the start of the cycle.
        part_PIs [76] = 1'b0;      // pinName = clk_i;  tf = -ES  ; testOffset = 8.000000;  scanOffset = 16.000000;  
     #56.000000;        // 80.000000 ns;  From the start of the cycle.
      end  
      meas_OR_1 = {14{1'bX}};   meas_OR_2 = {14{1'bX}};   
      stim_CR_1 = {14{1'b0}};   stim_CR_2 = {14{1'b0}};   
      stim_CME_0 = {14{1'b0}};   
      stim_PIs = part_PIs; 
      SCANCYCLE = 0; 
      NUM_SHIFTS = 0; 
      if ( overlap )  test_num = test_num + 1; 
      PROCESSNAME = "";

    end  
  endtask  

//***************************************************************************//
//                        DEFINE SCAN EXIT PROCEDURE                         //
//***************************************************************************//

  task Scan_Exit_Sequence_TM_1_SEQ_4_SOP_1; 
    begin 

      PROCESSNAME = "SCAN EXIT (Scan_Exit_Sequence)";
      stim_PIs [3] = 1'b0;      // pinName = DFT_mask_enable;  tf = -TC  -CME  ; testOffset = 0.000000;  scanOffset = 0.000000;  

      scan_cycle; 
      PROCESSNAME = "";

    end  
  endtask  

//***************************************************************************//
//                           DEFINE SCAN PROCEDURE                           //
//***************************************************************************//

  task scan_cycle; 
    begin 

      if ( count_cycles )  begin 
        CYCLE = CYCLE + 1; 
        SERIALCYCLE = SERIALCYCLE + 1; 
      end 
     #0.000000;        // 0.000000 ns;  From the start of the cycle.
      part_PIs [1] = stim_PIs [1];      // pinName = DFT_compression_enable;  tf = +SE  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [3] = stim_PIs [3];      // pinName = DFT_mask_enable;  tf = -TC  -CME  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [4] = stim_PIs [4];      // pinName = SCAN_ENABLE;  tf = +SE  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [5] = stim_PIs [5];      // pinName = apu_flags_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [6] = stim_PIs [6];      // pinName = apu_flags_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [7] = stim_PIs [7];      // pinName = apu_flags_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [8] = stim_PIs [8];      // pinName = apu_flags_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [9] = stim_PIs [9];      // pinName = apu_flags_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [10] = stim_PIs [10];      // pinName = apu_gnt_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [11] = stim_PIs [11];      // pinName = apu_result_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [12] = stim_PIs [12];      // pinName = apu_result_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [13] = stim_PIs [13];      // pinName = apu_result_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [14] = stim_PIs [14];      // pinName = apu_result_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [15] = stim_PIs [15];      // pinName = apu_result_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [16] = stim_PIs [16];      // pinName = apu_result_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [17] = stim_PIs [17];      // pinName = apu_result_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [18] = stim_PIs [18];      // pinName = apu_result_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [19] = stim_PIs [19];      // pinName = apu_result_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [20] = stim_PIs [20];      // pinName = apu_result_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [21] = stim_PIs [21];      // pinName = apu_result_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [22] = stim_PIs [22];      // pinName = apu_result_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [23] = stim_PIs [23];      // pinName = apu_result_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [24] = stim_PIs [24];      // pinName = apu_result_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [25] = stim_PIs [25];      // pinName = apu_result_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [26] = stim_PIs [26];      // pinName = apu_result_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [27] = stim_PIs [27];      // pinName = apu_result_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [28] = stim_PIs [28];      // pinName = apu_result_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [29] = stim_PIs [29];      // pinName = apu_result_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [30] = stim_PIs [30];      // pinName = apu_result_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [31] = stim_PIs [31];      // pinName = apu_result_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [32] = stim_PIs [32];      // pinName = apu_result_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [33] = stim_PIs [33];      // pinName = apu_result_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [34] = stim_PIs [34];      // pinName = apu_result_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [35] = stim_PIs [35];      // pinName = apu_result_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [36] = stim_PIs [36];      // pinName = apu_result_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [37] = stim_PIs [37];      // pinName = apu_result_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [38] = stim_PIs [38];      // pinName = apu_result_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [39] = stim_PIs [39];      // pinName = apu_result_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [40] = stim_PIs [40];      // pinName = apu_result_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [41] = stim_PIs [41];      // pinName = apu_result_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [42] = stim_PIs [42];      // pinName = apu_result_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [43] = stim_PIs [43];      // pinName = apu_rvalid_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [44] = stim_PIs [44];      // pinName = boot_addr_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [45] = stim_PIs [45];      // pinName = boot_addr_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [46] = stim_PIs [46];      // pinName = boot_addr_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [47] = stim_PIs [47];      // pinName = boot_addr_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [48] = stim_PIs [48];      // pinName = boot_addr_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [49] = stim_PIs [49];      // pinName = boot_addr_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [50] = stim_PIs [50];      // pinName = boot_addr_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [51] = stim_PIs [51];      // pinName = boot_addr_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [52] = stim_PIs [52];      // pinName = boot_addr_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [53] = stim_PIs [53];      // pinName = boot_addr_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [54] = stim_PIs [54];      // pinName = boot_addr_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [55] = stim_PIs [55];      // pinName = boot_addr_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [56] = stim_PIs [56];      // pinName = boot_addr_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [57] = stim_PIs [57];      // pinName = boot_addr_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [58] = stim_PIs [58];      // pinName = boot_addr_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [59] = stim_PIs [59];      // pinName = boot_addr_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [60] = stim_PIs [60];      // pinName = boot_addr_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [61] = stim_PIs [61];      // pinName = boot_addr_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [62] = stim_PIs [62];      // pinName = boot_addr_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [63] = stim_PIs [63];      // pinName = boot_addr_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [64] = stim_PIs [64];      // pinName = boot_addr_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [65] = stim_PIs [65];      // pinName = boot_addr_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [66] = stim_PIs [66];      // pinName = boot_addr_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [67] = stim_PIs [67];      // pinName = boot_addr_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [68] = stim_PIs [68];      // pinName = boot_addr_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [69] = stim_PIs [69];      // pinName = boot_addr_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [70] = stim_PIs [70];      // pinName = boot_addr_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [71] = stim_PIs [71];      // pinName = boot_addr_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [72] = stim_PIs [72];      // pinName = boot_addr_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [73] = stim_PIs [73];      // pinName = boot_addr_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [74] = stim_PIs [74];      // pinName = boot_addr_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [75] = stim_PIs [75];      // pinName = boot_addr_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [77] = stim_PIs [77];      // pinName = data_gnt_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [78] = stim_PIs [78];      // pinName = data_rdata_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [79] = stim_PIs [79];      // pinName = data_rdata_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [80] = stim_PIs [80];      // pinName = data_rdata_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [81] = stim_PIs [81];      // pinName = data_rdata_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [82] = stim_PIs [82];      // pinName = data_rdata_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [83] = stim_PIs [83];      // pinName = data_rdata_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [84] = stim_PIs [84];      // pinName = data_rdata_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [85] = stim_PIs [85];      // pinName = data_rdata_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [86] = stim_PIs [86];      // pinName = data_rdata_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [87] = stim_PIs [87];      // pinName = data_rdata_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [88] = stim_PIs [88];      // pinName = data_rdata_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [89] = stim_PIs [89];      // pinName = data_rdata_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [90] = stim_PIs [90];      // pinName = data_rdata_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [91] = stim_PIs [91];      // pinName = data_rdata_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [92] = stim_PIs [92];      // pinName = data_rdata_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [93] = stim_PIs [93];      // pinName = data_rdata_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [94] = stim_PIs [94];      // pinName = data_rdata_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [95] = stim_PIs [95];      // pinName = data_rdata_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [96] = stim_PIs [96];      // pinName = data_rdata_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [97] = stim_PIs [97];      // pinName = data_rdata_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [98] = stim_PIs [98];      // pinName = data_rdata_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [99] = stim_PIs [99];      // pinName = data_rdata_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [100] = stim_PIs [100];      // pinName = data_rdata_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [101] = stim_PIs [101];      // pinName = data_rdata_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [102] = stim_PIs [102];      // pinName = data_rdata_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [103] = stim_PIs [103];      // pinName = data_rdata_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [104] = stim_PIs [104];      // pinName = data_rdata_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [105] = stim_PIs [105];      // pinName = data_rdata_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [106] = stim_PIs [106];      // pinName = data_rdata_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [107] = stim_PIs [107];      // pinName = data_rdata_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [108] = stim_PIs [108];      // pinName = data_rdata_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [109] = stim_PIs [109];      // pinName = data_rdata_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [110] = stim_PIs [110];      // pinName = data_rvalid_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [111] = stim_PIs [111];      // pinName = debug_req_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [112] = stim_PIs [112];      // pinName = dm_exception_addr_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [113] = stim_PIs [113];      // pinName = dm_exception_addr_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [114] = stim_PIs [114];      // pinName = dm_exception_addr_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [115] = stim_PIs [115];      // pinName = dm_exception_addr_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [116] = stim_PIs [116];      // pinName = dm_exception_addr_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [117] = stim_PIs [117];      // pinName = dm_exception_addr_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [118] = stim_PIs [118];      // pinName = dm_exception_addr_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [119] = stim_PIs [119];      // pinName = dm_exception_addr_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [120] = stim_PIs [120];      // pinName = dm_exception_addr_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [121] = stim_PIs [121];      // pinName = dm_exception_addr_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [122] = stim_PIs [122];      // pinName = dm_exception_addr_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [123] = stim_PIs [123];      // pinName = dm_exception_addr_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [124] = stim_PIs [124];      // pinName = dm_exception_addr_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [125] = stim_PIs [125];      // pinName = dm_exception_addr_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [126] = stim_PIs [126];      // pinName = dm_exception_addr_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [127] = stim_PIs [127];      // pinName = dm_exception_addr_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [128] = stim_PIs [128];      // pinName = dm_exception_addr_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [129] = stim_PIs [129];      // pinName = dm_exception_addr_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [130] = stim_PIs [130];      // pinName = dm_exception_addr_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [131] = stim_PIs [131];      // pinName = dm_exception_addr_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [132] = stim_PIs [132];      // pinName = dm_exception_addr_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [133] = stim_PIs [133];      // pinName = dm_exception_addr_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [134] = stim_PIs [134];      // pinName = dm_exception_addr_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [135] = stim_PIs [135];      // pinName = dm_exception_addr_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [136] = stim_PIs [136];      // pinName = dm_exception_addr_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [137] = stim_PIs [137];      // pinName = dm_exception_addr_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [138] = stim_PIs [138];      // pinName = dm_exception_addr_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [139] = stim_PIs [139];      // pinName = dm_exception_addr_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [140] = stim_PIs [140];      // pinName = dm_exception_addr_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [141] = stim_PIs [141];      // pinName = dm_exception_addr_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [142] = stim_PIs [142];      // pinName = dm_exception_addr_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [143] = stim_PIs [143];      // pinName = dm_exception_addr_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [144] = stim_PIs [144];      // pinName = dm_halt_addr_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [145] = stim_PIs [145];      // pinName = dm_halt_addr_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [146] = stim_PIs [146];      // pinName = dm_halt_addr_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [147] = stim_PIs [147];      // pinName = dm_halt_addr_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [148] = stim_PIs [148];      // pinName = dm_halt_addr_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [149] = stim_PIs [149];      // pinName = dm_halt_addr_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [150] = stim_PIs [150];      // pinName = dm_halt_addr_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [151] = stim_PIs [151];      // pinName = dm_halt_addr_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [152] = stim_PIs [152];      // pinName = dm_halt_addr_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [153] = stim_PIs [153];      // pinName = dm_halt_addr_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [154] = stim_PIs [154];      // pinName = dm_halt_addr_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [155] = stim_PIs [155];      // pinName = dm_halt_addr_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [156] = stim_PIs [156];      // pinName = dm_halt_addr_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [157] = stim_PIs [157];      // pinName = dm_halt_addr_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [158] = stim_PIs [158];      // pinName = dm_halt_addr_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [159] = stim_PIs [159];      // pinName = dm_halt_addr_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [160] = stim_PIs [160];      // pinName = dm_halt_addr_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [161] = stim_PIs [161];      // pinName = dm_halt_addr_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [162] = stim_PIs [162];      // pinName = dm_halt_addr_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [163] = stim_PIs [163];      // pinName = dm_halt_addr_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [164] = stim_PIs [164];      // pinName = dm_halt_addr_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [165] = stim_PIs [165];      // pinName = dm_halt_addr_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [166] = stim_PIs [166];      // pinName = dm_halt_addr_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [167] = stim_PIs [167];      // pinName = dm_halt_addr_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [168] = stim_PIs [168];      // pinName = dm_halt_addr_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [169] = stim_PIs [169];      // pinName = dm_halt_addr_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [170] = stim_PIs [170];      // pinName = dm_halt_addr_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [171] = stim_PIs [171];      // pinName = dm_halt_addr_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [172] = stim_PIs [172];      // pinName = dm_halt_addr_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [173] = stim_PIs [173];      // pinName = dm_halt_addr_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [174] = stim_PIs [174];      // pinName = dm_halt_addr_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [175] = stim_PIs [175];      // pinName = dm_halt_addr_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [176] = stim_PIs [176];      // pinName = fetch_enable_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [177] = stim_PIs [177];      // pinName = hart_id_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [178] = stim_PIs [178];      // pinName = hart_id_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [179] = stim_PIs [179];      // pinName = hart_id_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [180] = stim_PIs [180];      // pinName = hart_id_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [181] = stim_PIs [181];      // pinName = hart_id_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [182] = stim_PIs [182];      // pinName = hart_id_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [183] = stim_PIs [183];      // pinName = hart_id_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [184] = stim_PIs [184];      // pinName = hart_id_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [185] = stim_PIs [185];      // pinName = hart_id_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [186] = stim_PIs [186];      // pinName = hart_id_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [187] = stim_PIs [187];      // pinName = hart_id_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [188] = stim_PIs [188];      // pinName = hart_id_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [189] = stim_PIs [189];      // pinName = hart_id_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [190] = stim_PIs [190];      // pinName = hart_id_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [191] = stim_PIs [191];      // pinName = hart_id_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [192] = stim_PIs [192];      // pinName = hart_id_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [193] = stim_PIs [193];      // pinName = hart_id_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [194] = stim_PIs [194];      // pinName = hart_id_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [195] = stim_PIs [195];      // pinName = hart_id_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [196] = stim_PIs [196];      // pinName = hart_id_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [197] = stim_PIs [197];      // pinName = hart_id_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [198] = stim_PIs [198];      // pinName = hart_id_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [199] = stim_PIs [199];      // pinName = hart_id_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [200] = stim_PIs [200];      // pinName = hart_id_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [201] = stim_PIs [201];      // pinName = hart_id_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [202] = stim_PIs [202];      // pinName = hart_id_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [203] = stim_PIs [203];      // pinName = hart_id_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [204] = stim_PIs [204];      // pinName = hart_id_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [205] = stim_PIs [205];      // pinName = hart_id_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [206] = stim_PIs [206];      // pinName = hart_id_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [207] = stim_PIs [207];      // pinName = hart_id_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [208] = stim_PIs [208];      // pinName = hart_id_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [209] = stim_PIs [209];      // pinName = instr_gnt_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [210] = stim_PIs [210];      // pinName = instr_rdata_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [211] = stim_PIs [211];      // pinName = instr_rdata_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [212] = stim_PIs [212];      // pinName = instr_rdata_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [213] = stim_PIs [213];      // pinName = instr_rdata_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [214] = stim_PIs [214];      // pinName = instr_rdata_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [215] = stim_PIs [215];      // pinName = instr_rdata_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [216] = stim_PIs [216];      // pinName = instr_rdata_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [217] = stim_PIs [217];      // pinName = instr_rdata_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [218] = stim_PIs [218];      // pinName = instr_rdata_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [219] = stim_PIs [219];      // pinName = instr_rdata_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [220] = stim_PIs [220];      // pinName = instr_rdata_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [221] = stim_PIs [221];      // pinName = instr_rdata_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [222] = stim_PIs [222];      // pinName = instr_rdata_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [223] = stim_PIs [223];      // pinName = instr_rdata_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [224] = stim_PIs [224];      // pinName = instr_rdata_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [225] = stim_PIs [225];      // pinName = instr_rdata_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [226] = stim_PIs [226];      // pinName = instr_rdata_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [227] = stim_PIs [227];      // pinName = instr_rdata_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [228] = stim_PIs [228];      // pinName = instr_rdata_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [229] = stim_PIs [229];      // pinName = instr_rdata_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [230] = stim_PIs [230];      // pinName = instr_rdata_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [231] = stim_PIs [231];      // pinName = instr_rdata_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [232] = stim_PIs [232];      // pinName = instr_rdata_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [233] = stim_PIs [233];      // pinName = instr_rdata_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [234] = stim_PIs [234];      // pinName = instr_rdata_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [235] = stim_PIs [235];      // pinName = instr_rdata_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [236] = stim_PIs [236];      // pinName = instr_rdata_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [237] = stim_PIs [237];      // pinName = instr_rdata_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [238] = stim_PIs [238];      // pinName = instr_rdata_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [239] = stim_PIs [239];      // pinName = instr_rdata_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [240] = stim_PIs [240];      // pinName = instr_rdata_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [241] = stim_PIs [241];      // pinName = instr_rdata_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [242] = stim_PIs [242];      // pinName = instr_rvalid_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [243] = stim_PIs [243];      // pinName = irq_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [244] = stim_PIs [244];      // pinName = irq_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [245] = stim_PIs [245];      // pinName = irq_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [246] = stim_PIs [246];      // pinName = irq_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [247] = stim_PIs [247];      // pinName = irq_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [248] = stim_PIs [248];      // pinName = irq_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [249] = stim_PIs [249];      // pinName = irq_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [250] = stim_PIs [250];      // pinName = irq_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [251] = stim_PIs [251];      // pinName = irq_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [252] = stim_PIs [252];      // pinName = irq_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [253] = stim_PIs [253];      // pinName = irq_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [254] = stim_PIs [254];      // pinName = irq_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [255] = stim_PIs [255];      // pinName = irq_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [256] = stim_PIs [256];      // pinName = irq_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [257] = stim_PIs [257];      // pinName = irq_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [258] = stim_PIs [258];      // pinName = irq_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [259] = stim_PIs [259];      // pinName = irq_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [260] = stim_PIs [260];      // pinName = irq_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [261] = stim_PIs [261];      // pinName = irq_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [262] = stim_PIs [262];      // pinName = irq_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [263] = stim_PIs [263];      // pinName = irq_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [264] = stim_PIs [264];      // pinName = irq_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [265] = stim_PIs [265];      // pinName = irq_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [266] = stim_PIs [266];      // pinName = irq_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [267] = stim_PIs [267];      // pinName = irq_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [268] = stim_PIs [268];      // pinName = irq_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [269] = stim_PIs [269];      // pinName = irq_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [270] = stim_PIs [270];      // pinName = irq_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [271] = stim_PIs [271];      // pinName = irq_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [272] = stim_PIs [272];      // pinName = irq_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [273] = stim_PIs [273];      // pinName = irq_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [274] = stim_PIs [274];      // pinName = irq_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [275] = stim_PIs [275];      // pinName = mtvec_addr_i[0]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [276] = stim_PIs [276];      // pinName = mtvec_addr_i[10]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [277] = stim_PIs [277];      // pinName = mtvec_addr_i[11]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [278] = stim_PIs [278];      // pinName = mtvec_addr_i[12]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [279] = stim_PIs [279];      // pinName = mtvec_addr_i[13]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [280] = stim_PIs [280];      // pinName = mtvec_addr_i[14]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [281] = stim_PIs [281];      // pinName = mtvec_addr_i[15]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [282] = stim_PIs [282];      // pinName = mtvec_addr_i[16]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [283] = stim_PIs [283];      // pinName = mtvec_addr_i[17]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [284] = stim_PIs [284];      // pinName = mtvec_addr_i[18]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [285] = stim_PIs [285];      // pinName = mtvec_addr_i[19]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [286] = stim_PIs [286];      // pinName = mtvec_addr_i[1]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [287] = stim_PIs [287];      // pinName = mtvec_addr_i[20]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [288] = stim_PIs [288];      // pinName = mtvec_addr_i[21]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [289] = stim_PIs [289];      // pinName = mtvec_addr_i[22]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [290] = stim_PIs [290];      // pinName = mtvec_addr_i[23]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [291] = stim_PIs [291];      // pinName = mtvec_addr_i[24]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [292] = stim_PIs [292];      // pinName = mtvec_addr_i[25]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [293] = stim_PIs [293];      // pinName = mtvec_addr_i[26]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [294] = stim_PIs [294];      // pinName = mtvec_addr_i[27]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [295] = stim_PIs [295];      // pinName = mtvec_addr_i[28]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [296] = stim_PIs [296];      // pinName = mtvec_addr_i[29]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [297] = stim_PIs [297];      // pinName = mtvec_addr_i[2]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [298] = stim_PIs [298];      // pinName = mtvec_addr_i[30]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [299] = stim_PIs [299];      // pinName = mtvec_addr_i[31]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [300] = stim_PIs [300];      // pinName = mtvec_addr_i[3]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [301] = stim_PIs [301];      // pinName = mtvec_addr_i[4]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [302] = stim_PIs [302];      // pinName = mtvec_addr_i[5]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [303] = stim_PIs [303];      // pinName = mtvec_addr_i[6]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [304] = stim_PIs [304];      // pinName = mtvec_addr_i[7]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [305] = stim_PIs [305];      // pinName = mtvec_addr_i[8]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [306] = stim_PIs [306];      // pinName = mtvec_addr_i[9]; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [307] = stim_PIs [307];      // pinName = pulp_clock_en_i; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [308] = stim_PIs [308];      // pinName = rst_ni;  tf = +SC  ; testOffset = 8.000000;  scanOffset = 0.000000;  
      part_PIs [309] = stim_PIs [309];      // pinName = scan_cg_en_i;  tf = +TI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [310] = stim_PIs [310];      // pinName = scan_in_0;  tf =  SI   CMI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [311] = stim_PIs [311];      // pinName = scan_in_1;  tf =  SI1  CMI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
      part_PIs [312] = stim_PIs [312];      // pinName = test_mode;  tf = +TI  ; testOffset = 0.000000;  scanOffset = 0.000000;  
     #8.000000;        // 8.000000 ns;  From the start of the cycle.

      for ( POnum = 1; POnum <= 234; POnum = POnum + 1 ) begin 
        if (( part_POs [ POnum ] !== meas_POs [ POnum ] ) & ( meas_POs [ POnum ] !== 1'bX )) begin 
          if ( test_num != failed_test_num )  begin 
            num_failed_tests = num_failed_tests + 1; 
            failed_test_num = test_num; 
          end  
          miscompares = miscompares + 1; 
          $display ( "\nWARNING (TVE-650): PO miscompare at Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t ", test_num, PATTERN, CYCLE, $time ); 
          $display ( "           Expected: %0b   Simulated: %0b   On PO: %0s   ", meas_POs [ POnum ], part_POs [ POnum ], name_POs [ POnum ] ); 

          if (( failset ) & ( FAILSETID == 0 ))  failset_setup; 
          if ( FAILSETID ) begin 
            $fdisplay ( FAILSETID, " Chip %0s pad %0s pattern %0s position %0d value %0b ", "cv32e40p_core", name_POs [ POnum ], PATTERN, -1, part_POs [ POnum ] ); 
          end  
        end  
        else if ( meas_POs [ POnum ] !== 1'bX )  good_compares = good_compares + 1; 
      end  
     #8.000000;        // 16.000000 ns;  From the start of the cycle.
      part_PIs [2] = stim_PIs [2];      // pinName = DFT_mask_clk;  tf = -CML  ; testOffset = 0.000000;  scanOffset = 16.000000;  
      part_PIs [76] = stim_PIs [76];      // pinName = clk_i;  tf = -ES  ; testOffset = 8.000000;  scanOffset = 16.000000;  
     #8.000000;        // 24.000000 ns;  From the start of the cycle.
      part_PIs [2] = stim_CIs [2];      // pinName = DFT_mask_clk;  tf = -CML  ; testOffset = 0.000000;  scanOffset = 16.000000;  
      part_PIs [76] = stim_CIs [76];      // pinName = clk_i;  tf = -ES  ; testOffset = 8.000000;  scanOffset = 16.000000;  
     #56.000000;        // 80.000000 ns;  From the start of the cycle.
      meas_POs = {234{1'bX}}; 

    end  
  endtask  

//***************************************************************************//
//                 READ COMMANDS AND DATA AND RUN SIMULATION                 //
//***************************************************************************//

  task cmd_code; 
    begin 

      if ( sim_trace )  $display ( "\nCommand code:  %0d ", CMD ); 

      case ( CMD ) 

        000: begin 
          rc_read = 0;  // This will stop execution 
          line_number = line_number + 1; 
        end  

        100: begin 
          rc_read = $fgets ( COMMENT, DATAID ); 
          if ( rc_read > 0 )  begin 
          end  
          else  begin 
            $display ( "\nERROR (TVE-998): Unrecognizable data at line %0.0f in file: %0s \n", line_number, DATAFILE ); 
            $display ( "  Command code = %0d, Unrecognized data = %0s \n", CMD, COMMENT ); 
          end  
          line_number = line_number + 1; 
        end  

        104: begin 
          rc_read = $fgets ( PROCESSNAME, DATAID ); 
          if ( rc_read > 0 )  begin 
            if ( $value$plusargs ( "START_RANGE=%s", SOD ) ) begin
              if( sim_range == 1'b0 && PROCESSNAME == 4096'b100000010011010100111101000100010001010100100101001110010010010101010000001010) begin // PROCESSNAME == MODEINIT in ASCII
                sim_range = 1'b1 ;
              end
              if( sim_range==1'b1 && PROCESSNAME == 4096'b1000000010000000001010) begin // PROCESSNAME == '' in ASCII 
                sim_range = 1'b0 ;
              end
            end
          end  
          else  begin 
            $display ( "\nERROR (TVE-998): Unrecognizable data at line %0.0f in file: %0s \n", line_number, DATAFILE ); 
            $display ( "  Command code = %0d, Unrecognized data = %0s \n", CMD, PROCESSNAME ); 
          end  
          line_number = line_number + 1; 
        end  

        110: begin 
          rc_read = $fgets ( COMMENT, DATAID ); 
          if ( rc_read > 0 )  begin 
            $display ( "\n %0s ", COMMENT ); 
          end  
          else  begin 
            $display ( "\nERROR (TVE-998): Unrecognizable data at line %0.0f in file: %0s \n", line_number, DATAFILE ); 
            $display ( "  Command code = %0d, Unrecognized data = %0s \n", CMD, COMMENT ); 
          end  
          line_number = line_number + 1; 
        end  

        151: begin 
          test_num_prev = test_num; 
          rc_read = $fscanf ( DATAID, "%d", test_num ); 
          if ( rc_read > 0 )  begin 
            if (( test_num != test_num_prev ) && ( test_num != 0 ) && ( sim_range ))  num_tests = num_tests + 1; 
          end  
          else  bad_cmd_code; 

          rc_read = $fscanf ( DATAID, "%d", scan_num ); 
          if ( rc_read > 0 )  begin 
          end  
          else  bad_cmd_code; 

          rc_read = $fscanf ( DATAID, "%d", overlap ); 
          if ( rc_read > 0 )  begin 
          end  
          else  bad_cmd_code; 

          line_number = line_number + 1; 
        end  

        200: begin 
          if ( rc_read > 0 )  begin 
            rc_read = $fscanf ( DATAID, "%b", stim_PIs [1:312] ); 
            if ( rc_read <= 0 )  bad_cmd_code; 
            line_number = line_number + 1; 
          end  
        end  

        201: begin 
          if ( rc_read > 0 )  begin 
            rc_read = $fscanf ( DATAID, "%b", stim_CIs [1:312] ); 
            if ( rc_read <= 0 )  bad_cmd_code; 
            line_number = line_number + 1; 
          end  
        end  

        202: begin 
          if ( rc_read > 0 )  begin 
            rc_read = $fscanf ( DATAID, "%b", meas_POs [1:234] ); 
            if (sim_range_measure == 1'b0 ) meas_POs = 'bx;
            if ( rc_read <= 0 )  bad_cmd_code; 
            line_number = line_number + 1; 
          end  
        end  

        203: begin 
          rc_read = $fscanf ( DATAID, "%b", global_term ); 
          if ( rc_read > 0 )  begin 
          end  
          else  bad_cmd_code; 
          line_number = line_number + 1; 
        end  

        300: begin 
          rc_read = $fscanf ( DATAID, "%d", MODENUM ); 
          if ( rc_read <= 0 )  bad_cmd_code; 
          else  begin 

            case ( MODENUM ) 

              1: begin 
                rc_read = $fscanf ( DATAID, "%d", SCANNUM ); 
                if ( rc_read <= 0 )  bad_cmd_code; 
                else  begin 

                  case ( SCANNUM ) 

                    1: begin 

                      if ( rc_read > 0 )  begin 
                        rc_read = $fscanf ( DATAID, "%b", stim_CR_1 [1:14] ); 
                        if ( rc_read <= 0 )  bad_cmd_code; 
                        line_number = line_number + 1; 
                      end  
                    end  

                    2: begin 

                      if ( rc_read > 0 )  begin 
                        rc_read = $fscanf ( DATAID, "%b", stim_CR_2 [1:14] ); 
                        if ( rc_read <= 0 )  bad_cmd_code; 
                        line_number = line_number + 1; 
                      end  
                    end  

                  endcase  
                end  
              end  

            endcase  
          end  
        end  

        301: begin 
          rc_read = $fscanf ( DATAID, "%d", MODENUM ); 
          if ( rc_read <= 0 )  bad_cmd_code; 
          else  begin 

            case ( MODENUM ) 

              1: begin 
                rc_read = $fscanf ( DATAID, "%d", SCANNUM ); 
                if ( rc_read <= 0 )  bad_cmd_code; 
                else  begin 

                  case ( SCANNUM ) 

                    1: begin 

                      if ( rc_read > 0 )  begin 
                        rc_read = $fscanf ( DATAID, "%b", meas_OR_1 [1:14] ); 
                        if (sim_range_measure == 1'b0 ) meas_OR_1 = 'bx;
                        if ( rc_read <= 0 )  bad_cmd_code; 
                        line_number = line_number + 1; 
                      end  
                    end  

                    2: begin 

                      if ( rc_read > 0 )  begin 
                        rc_read = $fscanf ( DATAID, "%b", meas_OR_2 [1:14] ); 
                        if (sim_range_measure == 1'b0 ) meas_OR_2 = 'bx;
                        if ( rc_read <= 0 )  bad_cmd_code; 
                        line_number = line_number + 1; 
                      end  
                    end  

                  endcase  
                end  
              end  

            endcase  
          end  
        end  

        302: begin 
          rc_read = $fscanf ( DATAID, "%d", MODENUM ); 
          if ( rc_read <= 0 )  bad_cmd_code; 
          else  begin 

            case ( MODENUM ) 

              1: begin 
                rc_read = $fscanf ( DATAID, "%d", SCANNUM ); 
                if ( rc_read <= 0 )  bad_cmd_code; 
                else  begin 

                  case ( SCANNUM ) 

                    0: begin 

                      if ( rc_read > 0 )  begin 
                        rc_read = $fscanf ( DATAID, "%b", stim_CME_0 [1:14] ); 
                        if ( rc_read <= 0 )  bad_cmd_code; 
                        line_number = line_number + 1; 
                      end  
                    end  

                  endcase  
                end  
              end  

            endcase  
          end  
        end  

        303: begin 
          rc_read = $fscanf ( DATAID, "%d", SCANNUM ); 
          if ( rc_read <= 0 )  bad_cmd_code; 
          else  begin 

            case ( SCANNUM ) 

              1: begin 

                if ( rc_read > 0 )  begin 
                  rc_read = $fscanf ( DATAID, "%b", stim_CMSR_1 [1:77] ); 
                  if ( rc_read <= 0 )  bad_cmd_code; 
                  line_number = line_number + 1; 
                end  
              end  

              2: begin 

                if ( rc_read > 0 )  begin 
                  rc_read = $fscanf ( DATAID, "%b", stim_CMSR_2 [1:77] ); 
                  if ( rc_read <= 0 )  bad_cmd_code; 
                  line_number = line_number + 1; 
                end  
              end  

            endcase  
          end  
        end  

        400: begin 
          if ( sim_range )  test_cycle; 
          line_number = line_number + 1; 
        end  

        403: begin 
          if ( sim_range )  scan_cycle; 
          line_number = line_number + 1; 
        end  

        500: begin 
          repeat_depth = repeat_depth + 1; 
          rc_read = $fscanf ( DATAID, "%d", num_repeats [repeat_depth] ); 
          if ( rc_read > 0 )  begin 
            start_of_repeat[repeat_depth] = $ftell ( DATAID ); 
          end  
          else  bad_cmd_code; 
          if ((sim_range & sim_heart) && repeat_heart) 
            $display ( "\nINFO (TVE-202): Simulating Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t  Tests Passed %0d of %0d, Failed %0d.  Start of %0d cycles of a repeat loop.", test_num, pattern, CYCLE + 1, $time, num_tests - num_failed_tests, num_tests, num_failed_tests, num_repeats [repeat_depth] ); 
          line_number = line_number + 1; 
        end  

        501: begin 
          num_repeats [repeat_depth] = num_repeats [repeat_depth] - 1; 
          if ( num_repeats [repeat_depth] )  begin 
            if ((sim_range & sim_heart) && repeat_heart && (num_repeats [repeat_depth] % repeat_heart == 0 )) 
              $display ( "\nINFO (TVE-202): Simulating Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t  Tests Passed %0d of %0d, Failed %0d.  Number of cycles remaining in this repeat loop is %0d.", test_num, pattern, CYCLE + 1, $time, num_tests - num_failed_tests, num_tests, num_failed_tests, num_repeats [repeat_depth] ); 
            rc_read = $fseek ( DATAID, start_of_repeat [repeat_depth], 0 ); 
            rc_read = 1; 
            fseek_offset = $ftell ( DATAID ); 
            if ( fseek_offset != start_of_repeat [repeat_depth] )  begin 
              $display ( "\nERROR (TVE-956): A Verilog simulator limitation in the fseek routine has been reached.  The size of the Verilog Data file is so big that it can not support branching using fseek in the Verilog simulator.  Any branching after 9,223,372,036,854,775,807 (0x7fffffffffffffff) bytes of data will not run correctly under the Verilog simulator.  It is recommended that you break up the Verilog Data file using the keyword maxvectorsperfile.  The Verilog Data file:  %0s  \n", DATAFILE ); 
              rc_read = 0;  // This will stop execution 
            end  
          end  
          else  repeat_depth = repeat_depth - 1; 
          line_number = line_number + 1; 
        end  

        600: begin 
          rc_read = $fscanf ( DATAID, "%d", MODENUM ); 
          if ( rc_read <= 0 )  bad_cmd_code; 
          else  begin 

            case ( MODENUM ) 

              1: begin 
                rc_read = $fscanf ( DATAID, "%d", SEQNUM ); 
                if ( rc_read <= 0 )  bad_cmd_code; 
                else  begin 

                  case ( SEQNUM ) 

                    1: begin 
                      rc_read = $fscanf ( DATAID, "%d", MAX ); 
                      if ( rc_read > 0 )  begin 
                        if ( sim_range )  Scan_Preconditioning_Sequence_TM_1_SEQ_1_SOP_1; 
                      end  
                      else  bad_cmd_code; 
                      line_number = line_number + 1; 
                    end  

                    2: begin 
                      rc_read = $fscanf ( DATAID, "%d", MAX ); 
                      if ( rc_read > 0 )  begin 
                        if ( sim_range )  ChannelMask_Cycle_Sequence_TM_1_SEQ_2_SOP_1; 
                      end  
                      else  bad_cmd_code; 
                      line_number = line_number + 1; 
                    end  

                    3: begin 
                      rc_read = $fscanf ( DATAID, "%d", MAX ); 
                      if ( rc_read > 0 )  begin 
                        if ( sim_range )  Scan_Sequence_TM_1_SEQ_3_SOP_1; 
                      end  
                      else  bad_cmd_code; 
                      line_number = line_number + 1; 
                    end  

                    4: begin 
                      rc_read = $fscanf ( DATAID, "%d", MAX ); 
                      if ( rc_read > 0 )  begin 
                        if ( sim_range )  Scan_Exit_Sequence_TM_1_SEQ_4_SOP_1; 
                      end  
                      else  bad_cmd_code; 
                      line_number = line_number + 1; 
                    end  

                  endcase  
                end  
              end 

            endcase  
          end  
        end  

        900: begin 
          rc_read = $fscanf ( DATAID, "%s", pattern ); 
          if ( rc_read > 0 )  begin 
            if ( SOD == pattern )  begin 
              sim_range = 1'b1; 
            end  
            if (( sim_range ) & ( scan_num > 0 ))  begin 
              if ( sim_heart > 0 )  begin 
                if ( overlap )  $display ( "\nINFO (TVE-211): Simulating Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t  Relative Scan: %0d  Overlap Tests %0d and %0d.  Tests Passed %0d of %0d, Failed %0d. ", test_num - 1, pattern, CYCLE + 1, $time, scan_num, test_num - 1, test_num, num_tests - num_failed_tests - 1, num_tests - 1, num_failed_tests ); 
                else  $display ( "\nINFO (TVE-211): Simulating Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t  Relative Scan: %0d  Tests Passed %0d of %0d, Failed %0d. ", test_num, pattern, CYCLE + 1, $time, scan_num, num_tests - num_failed_tests, num_tests, num_failed_tests ); 
              end  
              scan_num = 0; 
            end  
            else if ( sim_range & sim_heart )  begin 
              $display ( "\nINFO (TVE-202): Simulating Test: %0d  Odometer: %0s  Relative Cycle: %0d  Time: %0t  Tests Passed %0d of %0d, Failed %0d. ", test_num, pattern, CYCLE + 1, $time, num_tests - num_failed_tests, num_tests, num_failed_tests ); 
            end  
          end  
          else  bad_cmd_code; 
          line_number = line_number + 1; 
        end  

        901: begin 
          rc_read = $fscanf ( DATAID, "%s", PATTERN ); 
          if ( rc_read > 0 )  begin 
          end  
          else  bad_cmd_code; 
          line_number = line_number + 1; 
        end  

        903: begin 
          measure_current = measure_current + 1; 
          line_number = line_number + 1; 
        end  

        904: begin 
          rc_read = $fscanf ( DATAID, "%s", eventID ); 
          if ( rc_read > 0 )  begin 
            `ifdef MISCOMPAREDEBUG 
              if ( diag_debug ) begin 
                $processSimulationDebugFile ( DIAG_DEBUG_FILE, "cv32e40p_core_inst", eventID ); 
              end 
            `endif 
          end  
          else  bad_cmd_code; 
          line_number = line_number + 1; 
        end  

        905: begin 
          rc_read = $fscanf ( DATAID, "%s", eventID ); 
          if ( rc_read > 0 )  begin 
            `ifdef MISCOMPAREDEBUG 
              if ( diag_debug ) begin 
                $processSimulationDebugFile ( DIAG_DEBUG_FILE, "cv32e40p_core_inst", eventID ); 
              end 
            `endif 
          end  
          else  bad_cmd_code; 
          line_number = line_number + 1; 
        end  


        default: begin 
          bad_cmd_code; 
          rc_read = 0;  // This will stop execution 
          line_number = line_number + 1; 
        end  

      endcase  

    end  
  endtask  

//***************************************************************************//
//                          PRINT BAD CMD CODE DATA                          //
//***************************************************************************//

  task bad_cmd_code; 
    begin 

      $display ( "\nERROR (TVE-998): Unrecognizable data at line %0.0f in file: %0s \n", line_number, DATAFILE ); 
      start_of_current_line = $ftell ( DATAID ); 
      rc_read = $fgets ( COMMENT, DATAID ); 
      $display ( "  Command code = %0d, Unrecognized data = %0s \n", CMD, COMMENT ); 
      rc_read = 0;  // This will stop execution 

    end  
  endtask  

  endmodule 
