-- VHDL Entity work.top_extphy.symbol
--
-- Created:
--          by - phdgc.users (voltar.phy.bris.ac.uk)
--          at - 11:30:28 09/03/15
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2013.1b (Build 2)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY top_extphy IS
   GENERIC( 
      g_NUM_DUTS            : positive := 3;
      g_NUM_TRIG_INPUTS     : positive := 4;
      g_NUM_EXT_SLAVES      : positive := 8;      --! Number of slaves outside IPBus interface
      g_EVENT_DATA_WIDTH    : positive := 64;
      g_IPBUS_WIDTH         : positive := 32;
      g_NUM_EDGE_INPUTS     : positive := 4;
      g_SPILL_COUNTER_WIDTH : positive := 12;
      g_BUILD_SIMULATED_MAC : integer  := 0
   );
   PORT( 
      busy_n_i            : IN     std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);
      busy_p_i            : IN     std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);         --! Busy lines from DUTs ( active high )
      cfd_discr_n_i       : IN     std_logic_vector (g_NUM_TRIG_INPUTS-1 DOWNTO 0);
      cfd_discr_p_i       : IN     std_logic_vector (g_NUM_TRIG_INPUTS-1 DOWNTO 0);
      dip_switch_i        : IN     std_logic_vector (3 DOWNTO 0);
      gmii_rx_clk_i       : IN     std_logic;
      gmii_rx_dv_i        : IN     std_logic;
      gmii_rx_er_i        : IN     std_logic;
      gmii_rxd_i          : IN     std_logic_vector (7 DOWNTO 0);
      sysclk_n_i          : IN     std_logic;                                        --! 200 MHz xtal clock
      sysclk_p_i          : IN     std_logic;
      threshold_discr_n_i : IN     std_logic_vector (g_NUM_TRIG_INPUTS-1 DOWNTO 0);
      threshold_discr_p_i : IN     std_logic_vector (g_NUM_TRIG_INPUTS-1 DOWNTO 0);
      gmii_gtx_clk_o      : OUT    std_logic;
      gmii_tx_en_o        : OUT    std_logic;
      gmii_tx_er_o        : OUT    std_logic;
      gmii_txd_o          : OUT    std_logic_vector (7 DOWNTO 0);
      gpio_hdr            : OUT    std_logic_vector (3 DOWNTO 0);
      leds_o              : OUT    std_logic_vector (3 DOWNTO 0);
      phy_rstb_o          : OUT    std_logic;
      reset_or_clk_n_o    : OUT    std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);
      reset_or_clk_p_o    : OUT    std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);         --! T0 synchronization signal
      shutter_to_dut_n_o  : OUT    std_logic_vector (g_NUM_DUTS-1 DOWNTO 1);         --! Shutter output
      shutter_to_dut_p_o  : OUT    std_logic_vector (g_NUM_DUTS-1 DOWNTO 1);         --! Shutter output
      triggers_n_o        : OUT    std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);
      triggers_p_o        : OUT    std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);         --! Trigger lines to DUT
      dut_clk_n_o         : INOUT  std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);
      dut_clk_p_o         : INOUT  std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);         --! Clock to DUT (P)
      extclk_n_b          : INOUT  std_logic;
      extclk_p_b          : INOUT  std_logic;                                        --! either external clock in, or a clock being driven out
      i2c_scl_b           : INOUT  std_logic;
      i2c_sda_b           : INOUT  std_logic
   );

-- Declarations

END ENTITY top_extphy ;

--
-- VHDL Architecture work.top_extphy.struct
--
-- Created:
--          by - phdgc.users (voltar.phy.bris.ac.uk)
--          at - 11:30:28 09/03/15
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2013.1b (Build 2)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

LIBRARY work;
USE work.ipbus.all;
-- USE work.emac_hostbus_decl.all;

USE work.fmcTLU.all;
LIBRARY unisim;
USE unisim.vcomponents.all;
USE work.ipbus_reg_types.all;


ARCHITECTURE struct OF top_extphy IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL T0_o                  : std_logic;
   SIGNAL buffer_full_o         : std_logic;                                             --! Goes high when event buffer almost full
   SIGNAL clk_16x_logic         : std_logic;                                             -- 640MHz clock
   SIGNAL clk_4x_logic          : std_logic;                                             --! normally 160MHz
   SIGNAL clk_logic_xtal        : std_logic;                                             -- ! 40MHz clock from onboard xtal
   SIGNAL data_strobe           : std_logic;                                             -- goes high when data ready to load into event buffer
   SIGNAL dout                  : std_logic;
   SIGNAL dout1                 : std_logic;
   SIGNAL event_data            : std_logic_vector(g_EVENT_DATA_WIDTH-1 DOWNTO 0);
   SIGNAL ipbr                  : ipb_rbus_array(g_NUM_EXT_SLAVES-1 DOWNTO 0);           --! IPBus read signals
   SIGNAL ipbus_clk             : std_logic;
   SIGNAL ipbus_reset           : std_logic;                                             -- ! IPBus reset to slaves
   SIGNAL ipbw                  : ipb_wbus_array(g_NUM_EXT_SLAVES-1 DOWNTO 0);           --! IBus write signals
   SIGNAL logic_clocks_reset    : std_logic;                                             -- Goes high to reset counters etc. Sync with clk_4x_logic
   SIGNAL logic_reset           : std_logic;
   SIGNAL overall_trigger       : std_logic;                                             --! goes high to load trigger data
   SIGNAL overall_veto          : std_logic;                                             --! Halts triggers when high
   SIGNAL postVetoTrigger_times : t_triggerTimeArray(g_NUM_TRIG_INPUTS-1 DOWNTO 0);      -- ! trigger arrival time ( w.r.t. logic_strobe)
   SIGNAL postVetotrigger       : std_logic_vector(g_NUM_TRIG_INPUTS-1 DOWNTO 0);        -- ! High when trigger from input connector active and enabled
   --trigger_count_i   : IN     std_logic_vector (g_IPBUS_WIDTH-1 DOWNTO 0); --! Not used yet.
   SIGNAL rst_fifo_o            : std_logic;                                             --! rst signal to first level fifos
   SIGNAL s_edge_fall_times     : t_triggerTimeArray(g_NUM_EDGE_INPUTS-1 DOWNTO 0);      -- Array of edge times ( w.r.t. logic_strobe)
   SIGNAL s_edge_falling        : std_logic_vector(g_NUM_EDGE_INPUTS-1 DOWNTO 0);        -- ! High when falling edge
   SIGNAL s_edge_rise_times     : t_triggerTimeArray(g_NUM_EDGE_INPUTS-1 DOWNTO 0);      -- Array of edge times ( w.r.t. logic_strobe)
   SIGNAL s_edge_rising         : std_logic_vector(g_NUM_EDGE_INPUTS-1 DOWNTO 0);        -- ! High when rising edge
   SIGNAL s_i2c_scl_enb         : std_logic;
   SIGNAL s_i2c_sda_enb         : std_logic;
   SIGNAL s_shutter             : std_logic;                                             --! shutter signal from TimePix, retimed onto local clock
   SIGNAL s_triggerLogic_reset  : std_logic;
   SIGNAL shutter_cnt_i         : std_logic_vector(g_SPILL_COUNTER_WIDTH-1 DOWNTO 0);
   SIGNAL shutter_i             : std_logic;
   SIGNAL spill_cnt_i           : std_logic_vector(g_SPILL_COUNTER_WIDTH-1 DOWNTO 0);
   SIGNAL spill_i               : std_logic;
   SIGNAL strobe_16x_logic      : std_logic;                                             --! Pulses one cycle every 4 of 16x clock.
   SIGNAL strobe_4x_logic       : std_logic;                                             -- one pulse every 4 cycles of clk_4x
   SIGNAL trigger_count         : std_logic_vector(g_IPBUS_WIDTH-1 DOWNTO 0);
   SIGNAL trigger_times         : t_triggerTimeArray(g_NUM_TRIG_INPUTS-1 DOWNTO 0);      -- ! trigger arrival time ( w.r.t. logic_strobe)
   SIGNAL triggers              : std_logic_vector(g_NUM_TRIG_INPUTS-1 DOWNTO 0);
   SIGNAL veto_o                : std_logic;                                             --! goes high when one or more DUT are busy


   -- Component Declarations
   COMPONENT DUTInterfaces
   GENERIC (
      g_NUM_DUTS    : positive := 3;
      g_IPBUS_WIDTH : positive := 32
   );
   PORT (
      clk_4x_logic_i          : IN     std_logic ;
      strobe_4x_logic_i       : IN     std_logic ;                                  --! goes high every 4th clock cycle
      trigger_counter_i       : IN     std_logic_vector (g_IPBUS_WIDTH-1 DOWNTO 0); --! Number of trigger events since last reset
      trigger_i               : IN     std_logic ;                                  --! goes high when trigger logic issues a trigger
      reset_or_clk_to_dut_i   : IN     std_logic ;                                  --! Synchronization signal. Passed TO DUT pins
      shutter_to_dut_i        : IN     std_logic ;                                  --! Goes high TO indicate data-taking active. DUTs report busy unless ignoreShutterVeto IPBus flag is set high
      -- IPBus signals.
      ipbus_clk_i             : IN     std_logic ;
      ipbus_i                 : IN     ipb_wbus ;                                   --! Signals from IPBus core TO slave
      ipbus_reset_i           : IN     std_logic ;
      ipbus_o                 : OUT    ipb_rbus ;                                   --! signals from slave TO IPBus core
      -- Signals to/from DUT
      busy_from_dut_n_i       : IN     std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);    --! BUSY input from DUTs
      busy_from_dut_p_i       : IN     std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);    --! BUSY input from DUTs
      clk_to_dut_n_io         : INOUT  std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);    --! clocks trigger data when in EUDET mode
      clk_to_dut_p_io         : INOUT  std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);    --! clocks trigger data when in EUDET mode
      reset_or_clk_to_dut_n_o : OUT    std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);    --! Either reset line or trigger
      reset_or_clk_to_dut_p_o : OUT    std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);    --! Either reset line or trigger
      trigger_to_dut_n_o      : OUT    std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);    --! Trigger output
      trigger_to_dut_p_o      : OUT    std_logic_vector (g_NUM_DUTS-1 DOWNTO 0);    --! Trigger output
      shutter_to_dut_n_o      : OUT    std_logic_vector (g_NUM_DUTS-1 DOWNTO 1);    --! Shutter output. Output 0 (RJ45) has no shutter signal
      shutter_to_dut_p_o      : OUT    std_logic_vector (g_NUM_DUTS-1 DOWNTO 1);    --! Shutter output
      veto_o                  : OUT    std_logic                                    --! goes high when one or more DUT are busy or vetoed by shutter
   );
   END COMPONENT DUTInterfaces;
   COMPONENT IPBusInterface
   GENERIC (
      NUM_EXT_SLAVES           : positive := 5;
      BUILD_SIMULATED_ETHERNET : integer  := 0      --! Set to 1 to build simulated Ethernet interface using Modelsim FLI
   );
   PORT (
      gmii_rx_clk_i    : IN     std_logic ;
      gmii_rx_dv_i     : IN     std_logic ;
      gmii_rx_er_i     : IN     std_logic ;
      gmii_rxd_i       : IN     std_logic_vector (7 DOWNTO 0);
      ipbr_i           : IN     ipb_rbus_array (NUM_EXT_SLAVES-1 DOWNTO 0); -- ! IPBus read signals
      sysclk_n_i       : IN     std_logic ;
      sysclk_p_i       : IN     std_logic ;                                 -- ! 200 MHz xtal clock
      clocks_locked_o  : OUT    std_logic ;
      gmii_gtx_clk_o   : OUT    std_logic ;
      gmii_tx_en_o     : OUT    std_logic ;
      gmii_tx_er_o     : OUT    std_logic ;
      gmii_txd_o       : OUT    std_logic_vector (7 DOWNTO 0);
      ipb_clk_o        : OUT    std_logic ;                                 -- ! IPBus clock TO slaves
      ipb_rst_o        : OUT    std_logic ;                                 -- ! IPBus reset TO slaves
      ipbw_o           : OUT    ipb_wbus_array (NUM_EXT_SLAVES-1 DOWNTO 0); -- ! IBus write signals
      onehz_o          : OUT    std_logic ;
      phy_rstb_o       : OUT    std_logic ;
      dip_switch_i     : IN     std_logic_vector (3 DOWNTO 0);
      clk_logic_xtal_o : OUT    std_logic 
   );
   END COMPONENT IPBusInterface;
   COMPONENT T0_Shutter_Iface
   PORT (
      clk_4x_i      : IN     std_logic;
      clk_4x_strobe : IN     std_logic;
      ipbus_clk_i   : IN     std_logic;
      ipbus_i       : IN     ipb_wbus;
      T0_o          : OUT    std_logic;
      ipbus_o       : OUT    ipb_rbus;
      shutter_o     : OUT    std_logic
   );
   END COMPONENT T0_Shutter_Iface;
   COMPONENT eventBuffer
   GENERIC (
      g_EVENT_DATA_WIDTH   : positive := 64;
      g_IPBUS_WIDTH        : positive := 32;
      g_READ_COUNTER_WIDTH : positive := 16
   );
   PORT (
      clk_4x_logic_i    : IN     std_logic ;
      data_strobe_i     : IN     std_logic ;                                     -- Indicates data TO transfer
      event_data_i      : IN     std_logic_vector (g_EVENT_DATA_WIDTH-1 DOWNTO 0);
      ipbus_clk_i       : IN     std_logic ;
      ipbus_i           : IN     ipb_wbus ;
      ipbus_reset_i     : IN     std_logic ;
      strobe_4x_logic_i : IN     std_logic ;
      --trigger_count_i   : IN     std_logic_vector (g_IPBUS_WIDTH-1 DOWNTO 0); --! Not used yet.
      rst_fifo_o        : OUT    std_logic ;                                     --! rst signal TO first level fifos
      buffer_full_o     : OUT    std_logic ;                                     --! Goes high when event buffer almost full
      ipbus_o           : OUT    ipb_rbus ;
      logic_reset_i     : IN     std_logic                                       -- reset buffers when high. Synch withclk_4x_logic
   );
   END COMPONENT eventBuffer;
   COMPONENT eventFormatter
   GENERIC (
      g_EVENT_DATA_WIDTH   : positive := 64;
      g_IPBUS_WIDTH        : positive := 32;
      g_COUNTER_TRIG_WIDTH : positive := 32;
      g_COUNTER_WIDTH      : positive := 12;
      g_EVTTYPE_WIDTH      : positive := 4;      --! Width of the event type word
      --g_NUM_INPUT_TYPES     : positive := 4;               -- Number of different input types (trigger, shutter, edge...)
      g_NUM_EDGE_INPUTS    : positive := 4;      --! Number of edge inputs
      g_NUM_TRIG_INPUTS    : positive := 5       --! Number of trigger inputs
   );
   PORT (
      clk_4x_logic_i         : IN     std_logic ;                                         --! Rising edge active
      ipbus_clk_i            : IN     std_logic ;
      logic_strobe_i         : IN     std_logic ;                                         --! Pulses high once every 4 cycles of clk_4x_logic
      logic_reset_i          : IN     std_logic ;                                         --! goes high TO reset counters. Synchronous with clk_4x_logic
      rst_fifo_i             : IN     std_logic ;                                         --! Goes high TO reset FIFOs
      buffer_full_i          : IN     std_logic ;                                         --! Goes high when output fifo full
      trigger_i              : IN     std_logic ;                                         --! goes high TO load trigger data. One cycle of clk_4x_logic
      trigger_times_i        : IN     t_triggerTimeArray (g_NUM_TRIG_INPUTS-1 DOWNTO 0);  --! Array of trigger times ( w.r.t. logic_strobe)
      trigger_inputs_fired_i : IN     std_logic_vector (g_NUM_TRIG_INPUTS-1 DOWNTO 0);    --! high for each input that "fired"
      trigger_cnt_i          : IN     std_logic_vector (g_COUNTER_TRIG_WIDTH-1 DOWNTO 0); --! Trigger count
      shutter_i              : IN     std_logic ;
      shutter_cnt_i          : IN     std_logic_vector (g_COUNTER_WIDTH-1 DOWNTO 0);
      spill_i                : IN     std_logic ;
      spill_cnt_i            : IN     std_logic_vector (g_COUNTER_WIDTH-1 DOWNTO 0);
      edge_rise_i            : IN     std_logic_vector (g_NUM_EDGE_INPUTS-1 DOWNTO 0);    --! High when rising edge
      edge_fall_i            : IN     std_logic_vector (g_NUM_EDGE_INPUTS-1 DOWNTO 0);    --! High when falling edge
      edge_rise_time_i       : IN     t_triggerTimeArray (g_NUM_EDGE_INPUTS-1 DOWNTO 0);  --! Array of edge times ( w.r.t. logic_strobe)
      edge_fall_time_i       : IN     t_triggerTimeArray (g_NUM_EDGE_INPUTS-1 DOWNTO 0);  --! Array of edge times ( w.r.t. logic_strobe)
      ipbus_i                : IN     ipb_wbus ;
      ipbus_o                : OUT    ipb_rbus ;
      data_strobe_o          : OUT    std_logic ;                                         --! goes high when data ready TO load into event buffer
      event_data_o           : OUT    std_logic_vector (g_EVENT_DATA_WIDTH-1 DOWNTO 0);
      reset_timestamp_i      : IN     std_logic ;                                         --! Taking high causes timestamp TO be reset. Combined with internal timestmap reset and written to reset_timestamp_o
      reset_timestamp_o      : OUT    std_logic                                           --! Goes high for one clock cycle of clk_4x_logic when timestamp reset
   );
   END COMPONENT eventFormatter;
   COMPONENT i2c_master
   PORT (
      i2c_scl_i     : IN     std_logic;
      i2c_sda_i     : IN     std_logic;
      ipbus_clk_i   : IN     std_logic;
      ipbus_i       : IN     ipb_wbus;
      ipbus_reset_i : IN     std_logic;
      i2c_scl_enb_o : OUT    std_logic;
      i2c_sda_enb_o : OUT    std_logic;
      ipbus_o       : OUT    ipb_rbus
   );
   END COMPONENT i2c_master;
   COMPONENT logic_clocks
   GENERIC (
      g_USE_EXTERNAL_CLK : integer := 1
   );
   PORT (
      ipbus_clk_i           : IN     std_logic ;
      ipbus_i               : IN     ipb_wbus ;
      ipbus_reset_i         : IN     std_logic ;
      Reset_i               : IN     std_logic ;
      clk_logic_xtal_i      : IN     std_logic ; -- ! 40MHz clock from onboard xtal
      clk_16x_logic_o       : OUT    std_logic ; -- 640MHz clock
      clk_4x_logic_o        : OUT    std_logic ; -- 160MHz clock
      ipbus_o               : OUT    ipb_rbus ;
      strobe_16x_logic_o    : OUT    std_logic ; -- strobes once every 4 cycles of clk_16x
      strobe_4x_logic_o     : OUT    std_logic ; -- one pulse every 4 cycles of clk_4x
      extclk_p_b            : INOUT  std_logic ; -- either external clock in, or a clock being driven out
      extclk_n_b            : INOUT  std_logic ;
      DUT_clk_o             : OUT    std_logic ;
      logic_clocks_locked_o : OUT    std_logic ;
      logic_reset_o         : OUT    std_logic   -- Goes high TO reset counters etc. Sync with clk_4x_logic
   );
   END COMPONENT logic_clocks;
   COMPONENT triggerInputs
   GENERIC (
      g_NUM_INPUTS  : natural  := 1;
      g_IPBUS_WIDTH : positive := 32
   );
   PORT (
      cfd_discr_p_i        : IN     std_logic_vector (g_NUM_INPUTS-1 DOWNTO 0);        --! Inputs from constant-fraction discriminators
      cfd_discr_n_i        : IN     std_logic_vector (g_NUM_INPUTS-1 DOWNTO 0);        --! Input from CFD
      clk_4x_logic         : IN     std_logic ;                                        --! Rising edge active. By default = 4*40MHz = 160MHz
      strobe_4x_logic_i    : IN     std_logic ;                                        --! Pulses high once every 4 cycles of clk_4x_logic
      threshold_discr_p_i  : IN     std_logic_vector (g_NUM_INPUTS-1 DOWNTO 0);        --! inputs from threshold comparators
      threshold_discr_n_i  : IN     std_logic_vector (g_NUM_INPUTS-1 DOWNTO 0);        --! inputs from threshold comparators
      reset_i              : IN     std_logic ;
      trigger_times_o      : OUT    t_triggerTimeArray (g_NUM_INPUTS-1 DOWNTO 0);      --! trigger arrival time ( w.r.t. logic_strobe)
      trigger_o            : OUT    std_logic_vector (g_NUM_INPUTS-1 DOWNTO 0);        --!  Goes high on leading edge of trigger, in sync with clk_4x_logic_i
      trigger_debug_o      : OUT    std_logic_vector ( ((2*g_NUM_INPUTS)-1) DOWNTO 0); --! Copy of input trigger level. High bits CFD, Low threshold
      edge_rising_times_o  : OUT    t_triggerTimeArray (g_NUM_INPUTS-1 DOWNTO 0);      --! edge arrival time ( w.r.t. logic_strobe)
      edge_falling_times_o : OUT    t_triggerTimeArray (g_NUM_INPUTS-1 DOWNTO 0);      --! edge arrival time ( w.r.t. logic_strobe)
      edge_rising_o        : OUT    std_logic_vector (g_NUM_INPUTS-1 DOWNTO 0);        --! High when rising edge. Syncronous with clk_4x_logic_i
      edge_falling_o       : OUT    std_logic_vector (g_NUM_INPUTS-1 DOWNTO 0);        --! High when falling edge
      ipbus_clk_i          : IN     std_logic ;
      ipbus_reset_i        : IN     std_logic ;
      ipbus_i              : IN     ipb_wbus ;                                         --! Signals from IPBus core TO slave
      ipbus_o              : OUT    ipb_rbus ;                                         --! signals from slave TO IPBus core
      clk_16x_logic_i      : IN     std_logic ;                                        --! 640MHz clock ( 16x 40MHz )
      strobe_16x_logic_i   : IN     std_logic                                          --! Pulses one cycle every 4 of 16x clock.
   );
   END COMPONENT triggerInputs;
   COMPONENT triggerLogic
   GENERIC (
      g_NUM_INPUTS  : positive := 4;
      g_IPBUS_WIDTH : positive := 32
   );
   PORT (
      clk_4x_logic_i      : IN     std_logic ;                                   -- ! Rising edge active
      ipbus_clk_i         : IN     std_logic ;
      ipbus_i             : IN     ipb_wbus ;                                    -- Signals from IPBus core TO slave
      ipbus_reset_i       : IN     std_logic ;
      logic_reset_i       : IN     std_logic ;                                   -- active high. Synchronous with clk_4x_logic
      logic_strobe_i      : IN     std_logic ;                                   -- ! Pulses high once every 4 cycles of clk_4x_logic
      trigger_i           : IN     std_logic_vector (g_NUM_INPUTS-1 DOWNTO 0);   -- ! High when trigger from input connector active
      trigger_times_i     : IN     t_triggerTimeArray (g_NUM_INPUTS-1 DOWNTO 0); --! trigger arrival time
      veto_i              : IN     std_logic ;                                   -- ! Halts triggers when high
      trigger_o           : OUT    std_logic_vector (g_NUM_INPUTS-1 DOWNTO 0);   -- ! High when trigger from input connector active and enabled
      trigger_times_o     : OUT    t_triggerTimeArray (g_NUM_INPUTS-1 DOWNTO 0); --! trigger arrival time
      event_number_o      : OUT    std_logic_vector (g_IPBUS_WIDTH-1 DOWNTO 0);  -- starts at one. Increments for each post_veto_trigger
      ipbus_o             : OUT    ipb_rbus ;                                    -- signals from slave TO IPBus core
      post_veto_trigger_o : OUT    std_logic ;                                   -- ! goes high when trigger passes
      pre_veto_trigger_o  : OUT    std_logic ;
      trigger_active_o    : OUT    std_logic                                     --! Goes high when triggers are active ( ie. not veoted)
   );
   END COMPONENT triggerLogic;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : DUTInterfaces USE ENTITY work.DUTInterfaces;
   FOR ALL : IPBusInterface USE ENTITY work.IPBusInterface;
   FOR ALL : T0_Shutter_Iface USE ENTITY work.T0_Shutter_Iface;
   FOR ALL : eventBuffer USE ENTITY work.eventBuffer;
   FOR ALL : eventFormatter USE ENTITY work.eventFormatter;
   FOR ALL : i2c_master USE ENTITY work.i2c_master;
   FOR ALL : logic_clocks USE ENTITY work.logic_clocks;
   FOR ALL : triggerInputs USE ENTITY work.triggerInputs;
   FOR ALL : triggerLogic USE ENTITY work.triggerLogic;
   -- pragma synthesis_on


BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 1 i2c_tristate
   -- eb1 1
   i2c_scl_b <= '0' when (s_i2c_scl_enb = '0') else 'Z';
   i2c_sda_b <= '0' when (s_i2c_sda_enb = '0') else 'Z';
   
                               


   -- ModuleWare code(v1.12) for instance 'I9' of 'gnd'
   logic_clocks_reset <= '0';

   -- ModuleWare code(v1.12) for instance 'I11' of 'gnd'
   spill_i <= '0';

   -- ModuleWare code(v1.12) for instance 'I12' of 'gnd'
   spill_cnt_i <= (OTHERS => '0');

   -- ModuleWare code(v1.12) for instance 'I13' of 'gnd'
   shutter_i <= '0';

   -- ModuleWare code(v1.12) for instance 'I14' of 'gnd'
   shutter_cnt_i <= (OTHERS => '0');

   -- ModuleWare code(v1.12) for instance 'I17' of 'gnd'
   dout1 <= '0';

   -- ModuleWare code(v1.12) for instance 'I18' of 'gnd'
   dout <= '0';

   -- ModuleWare code(v1.12) for instance 'I19' of 'merge'
   gpio_hdr <= dout1 & dout & s_shutter & T0_o;

   -- ModuleWare code(v1.12) for instance 'I8' of 'sor'
   overall_veto <= buffer_full_o OR veto_o;

   -- ModuleWare code(v1.12) for instance 'I16' of 'sor'
   s_triggerLogic_reset <= logic_reset OR T0_o;

   -- Instance port mappings.
   --! @brief Interfaces to Device Under Test (DUT) connectors.
   --!
   --! @author David Cussans , David.Cussans@bristol.ac.uk
   --!
   --! @date 15:09:50 11/09/12
   --!
   --! @version v0.1
   --!
   --! @details
   --! \n\n IPBUS Address map:
   --! \n (Decodes 4 bits)
   --! \li 0x00000000 - DUT mask(write). 1 = active , 0 = inactive. Inactive DUT don't contribute to BUSY. One bit per DUT XXXXXXXXXXXXXXXXXXXXXXBA9876543210
   --! \li 0x00000001 - Ignore DUT busy. 1 = ignore BUSY from this connector
   --! \li 0x00000002 - Ignore shutter veto. 0 = raising shutter vetos triggers.
   --! \li 0x00000003 - DUT interface mode, two bits per DUT. Up to 12 inputs  XXXXXXXXBBAA99887766554433221100 mode: 0 = EUDET mode , 1 = synchronous ( LHC / Timepix ) , 2,3=reserved
   --! \li 0x00000004 - DUT mode modifier: XXXXXXXXBBAA99887766554433221100 in EUDET mode: 0 = standard trigger/busy mode, 1 = raising BUSY outside handshake vetoes triggers
   --! \li 0x00000008 - DUT mask ( read )
   --!
   --! DUT(0) = RJ45 ( J3 )\n
   --! DUT(1) = HDMI ( J1 ) , furthest from RJ45\n
   --! DUT(2) = HDMI ( J2) , closest to RJ45\n
   --!
   --! <b>Modified by:</b>\n
   --! -----------------------------------------------------------------------------
   --! \n\n<b>Last changes:</b>\n
   -------------------------------------------------------------------------------
   -- todo  Indicate if the DUT works under AIDA/EUDET style
   --
   I0 : DUTInterfaces
      GENERIC MAP (
         g_NUM_DUTS    => g_NUM_DUTS,
         g_IPBUS_WIDTH => g_IPBUS_WIDTH
      )
      PORT MAP (
         clk_4x_logic_i          => clk_4x_logic,
         strobe_4x_logic_i       => strobe_4x_logic,
         trigger_counter_i       => trigger_count,
         trigger_i               => overall_trigger,
         reset_or_clk_to_dut_i   => T0_o,
         shutter_to_dut_i        => s_shutter,
         ipbus_clk_i             => ipbus_clk,
         ipbus_i                 => ipbw(0),
         ipbus_reset_i           => ipbus_reset,
         ipbus_o                 => ipbr(0),
         busy_from_dut_n_i       => busy_n_i,
         busy_from_dut_p_i       => busy_p_i,
         clk_to_dut_n_io         => dut_clk_n_o,
         clk_to_dut_p_io         => dut_clk_p_o,
         reset_or_clk_to_dut_n_o => reset_or_clk_n_o,
         reset_or_clk_to_dut_p_o => reset_or_clk_p_o,
         trigger_to_dut_n_o      => triggers_n_o,
         trigger_to_dut_p_o      => triggers_p_o,
         shutter_to_dut_n_o      => shutter_to_dut_n_o,
         shutter_to_dut_p_o      => shutter_to_dut_p_o,
         veto_o                  => veto_o
      );
   I4 : IPBusInterface
      GENERIC MAP (
         NUM_EXT_SLAVES           => g_NUM_EXT_SLAVES,
         BUILD_SIMULATED_ETHERNET => g_BUILD_SIMULATED_MAC         --! Set to 1 to build simulated Ethernet interface using Modelsim FLI
      )
      PORT MAP (
         gmii_rx_clk_i    => gmii_rx_clk_i,
         gmii_rx_dv_i     => gmii_rx_dv_i,
         gmii_rx_er_i     => gmii_rx_er_i,
         gmii_rxd_i       => gmii_rxd_i,
         ipbr_i           => ipbr,
         sysclk_n_i       => sysclk_n_i,
         sysclk_p_i       => sysclk_p_i,
         clocks_locked_o  => leds_o(2),
         gmii_gtx_clk_o   => gmii_gtx_clk_o,
         gmii_tx_en_o     => gmii_tx_en_o,
         gmii_tx_er_o     => gmii_tx_er_o,
         gmii_txd_o       => gmii_txd_o,
         ipb_clk_o        => ipbus_clk,
         ipb_rst_o        => ipbus_reset,
         ipbw_o           => ipbw,
         onehz_o          => leds_o(3),
         phy_rstb_o       => phy_rstb_o,
         dip_switch_i     => dip_switch_i,
         clk_logic_xtal_o => clk_logic_xtal
      );
   I10 : T0_Shutter_Iface
      PORT MAP (
         clk_4x_i      => clk_4x_logic,
         clk_4x_strobe => strobe_4x_logic,
         T0_o          => T0_o,
         shutter_o     => s_shutter,
         ipbus_clk_i   => ipbus_clk,
         ipbus_i       => ipbw(7),
         ipbus_o       => ipbr(7)
      );
   I5 : eventBuffer
      GENERIC MAP (
         g_EVENT_DATA_WIDTH   => g_EVENT_DATA_WIDTH,
         g_IPBUS_WIDTH        => g_IPBUS_WIDTH,
         g_READ_COUNTER_WIDTH => 14
      )
      PORT MAP (
         clk_4x_logic_i    => clk_4x_logic,
         data_strobe_i     => data_strobe,
         event_data_i      => event_data,
         ipbus_clk_i       => ipbus_clk,
         ipbus_i           => ipbw(3),
         ipbus_reset_i     => ipbus_reset,
         strobe_4x_logic_i => strobe_4x_logic,
         rst_fifo_o        => rst_fifo_o,
         buffer_full_o     => buffer_full_o,
         ipbus_o           => ipbr(3),
         logic_reset_i     => logic_reset
      );
   --! @brief Takes the data delivered on each trigger and turns it into 64-bit
   --!        words to push into event buffer
   --!
   --!
   --! @author David Cussans , David.Cussans@bristol.ac.uk
   --!
   --! @date 15:10:35 11/09/12
   --!
   --! @version v0.1
   --!
   --! @details
   --! \n\n IPBus address:
   --! \n (Decodes 3 bits)
   --! \li 000 - read/write enable data recording.
   --! \li 001 - write = reset timestamp,
   --! \li 010 - read = current timestamp (low  32-bits)
   --! \li 011 - read = current timestamp (high 16-bits)
   --!
   --! -----------------------------------------------------------------------------
   --! \n\n<b>Last changes:</b>\n
   --! Modified by: Alvaro Dosil , alvaro.dosil@usc.es \n
   --! 27/Feb/14 DGC Change "If" when setting s_word2 to a case ... generate. Questasim
   --!               doesn't like having an if that can take an array out of bounds.
   --!-----------------------------------------------------------------------------
   --! @todo Add more input data: \n
   --! a) shutter signals. One per DUT. ?? \n
   --! b) input levels ( for recording edge data ). Record rising and falling edges\n
   --! c) veto levels. One per DUT. Record rising and falling edges.\n
   --! \n
   --! Add backpressure output if short FIFOs fill up? But many inputs won't
   --! respond - e.g. scintillator inputs. This data will be lost....
   --! some ports are redundant - e.g. trigger counter, others confusingly
   --! labelled. Sort this out..
   --------------------------------------------------------------------------------
   I2 : eventFormatter
      GENERIC MAP (
         g_EVENT_DATA_WIDTH   => g_EVENT_DATA_WIDTH,
         g_IPBUS_WIDTH        => g_IPBUS_WIDTH,
         g_COUNTER_TRIG_WIDTH => g_IPBUS_WIDTH,
         g_COUNTER_WIDTH      => 12,
         g_EVTTYPE_WIDTH      => 4,                         --! Width of the event type word
         --g_NUM_INPUT_TYPES     : positive := 4;               -- Number of different input types (trigger, shutter, edge...)
         g_NUM_EDGE_INPUTS    => g_NUM_EDGE_INPUTS,         --! Number of edge inputs
         g_NUM_TRIG_INPUTS    => g_NUM_TRIG_INPUTS          --! Number of trigger inputs
      )
      PORT MAP (
         clk_4x_logic_i         => clk_4x_logic,
         ipbus_clk_i            => ipbus_clk,
         logic_strobe_i         => strobe_4x_logic,
         logic_reset_i          => logic_reset,
         rst_fifo_i             => rst_fifo_o,
         buffer_full_i          => buffer_full_o,
         trigger_i              => overall_trigger,
         trigger_times_i        => postVetoTrigger_times,
         trigger_inputs_fired_i => postVetotrigger,
         trigger_cnt_i          => trigger_count,
         shutter_i              => shutter_i,
         shutter_cnt_i          => shutter_cnt_i,
         spill_i                => spill_i,
         spill_cnt_i            => spill_cnt_i,
         edge_rise_i            => s_edge_rising,
         edge_fall_i            => s_edge_falling,
         edge_rise_time_i       => s_edge_rise_times,
         edge_fall_time_i       => s_edge_fall_times,
         ipbus_i                => ipbw(6),
         ipbus_o                => ipbr(6),
         data_strobe_o          => data_strobe,
         event_data_o           => event_data,
         reset_timestamp_i      => T0_o,
         reset_timestamp_o      => OPEN
      );
   I7 : i2c_master
      PORT MAP (
         i2c_scl_i     => i2c_scl_b,
         i2c_sda_i     => i2c_sda_b,
         ipbus_clk_i   => ipbus_clk,
         ipbus_i       => ipbw(5),
         ipbus_reset_i => ipbus_reset,
         i2c_scl_enb_o => s_i2c_scl_enb,
         i2c_sda_enb_o => s_i2c_sda_enb,
         ipbus_o       => ipbr(5)
      );
   I6 : logic_clocks
      GENERIC MAP (
         g_USE_EXTERNAL_CLK => 0
      )
      PORT MAP (
         ipbus_clk_i           => ipbus_clk,
         ipbus_i               => ipbw(4),
         ipbus_reset_i         => ipbus_reset,
         Reset_i               => logic_clocks_reset,
         clk_logic_xtal_i      => clk_logic_xtal,
         clk_16x_logic_o       => clk_16x_logic,
         clk_4x_logic_o        => clk_4x_logic,
         ipbus_o               => ipbr(4),
         strobe_16x_logic_o    => strobe_16x_logic,
         strobe_4x_logic_o     => strobe_4x_logic,
         extclk_p_b            => extclk_p_b,
         extclk_n_b            => extclk_n_b,
         DUT_clk_o             => OPEN,
         logic_clocks_locked_o => leds_o(1),
         logic_reset_o         => logic_reset
      );
   I1 : triggerInputs
      GENERIC MAP (
         g_NUM_INPUTS  => g_NUM_TRIG_INPUTS,
         g_IPBUS_WIDTH => 32
      )
      PORT MAP (
         cfd_discr_p_i        => cfd_discr_p_i,
         cfd_discr_n_i        => cfd_discr_n_i,
         clk_4x_logic         => clk_4x_logic,
         strobe_4x_logic_i    => strobe_4x_logic,
         threshold_discr_p_i  => threshold_discr_p_i,
         threshold_discr_n_i  => threshold_discr_n_i,
         reset_i              => logic_reset,
         trigger_times_o      => trigger_times,
         trigger_o            => triggers,
         trigger_debug_o      => OPEN,
         edge_rising_times_o  => s_edge_rise_times,
         edge_falling_times_o => s_edge_fall_times,
         edge_rising_o        => s_edge_rising,
         edge_falling_o       => s_edge_falling,
         ipbus_clk_i          => ipbus_clk,
         ipbus_reset_i        => ipbus_reset,
         ipbus_i              => ipbw(1),
         ipbus_o              => ipbr(1),
         clk_16x_logic_i      => clk_16x_logic,
         strobe_16x_logic_i   => strobe_16x_logic
      );
   I3 : triggerLogic
      GENERIC MAP (
         g_NUM_INPUTS  => g_NUM_TRIG_INPUTS,
         g_IPBUS_WIDTH => g_IPBUS_WIDTH
      )
      PORT MAP (
         clk_4x_logic_i      => clk_4x_logic,
         ipbus_clk_i         => ipbus_clk,
         ipbus_i             => ipbw(2),
         ipbus_reset_i       => ipbus_reset,
         logic_reset_i       => s_triggerLogic_reset,
         logic_strobe_i      => strobe_4x_logic,
         trigger_i           => triggers,
         trigger_times_i     => trigger_times,
         veto_i              => overall_veto,
         trigger_o           => postVetotrigger,
         trigger_times_o     => postVetoTrigger_times,
         event_number_o      => trigger_count,
         ipbus_o             => ipbr(2),
         post_veto_trigger_o => overall_trigger,
         pre_veto_trigger_o  => OPEN,
         trigger_active_o    => leds_o(0)
      );

END ARCHITECTURE struct;
