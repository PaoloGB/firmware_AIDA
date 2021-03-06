--=============================================================================
--! @file logic_clocks_rtl.vhd
--=============================================================================
--
-------------------------------------------------------------------------------
-- --
-- University of Bristol, High Energy Physics Group.
-- --
------------------------------------------------------------------------------- --
-- VHDL Architecture fmc_mTLU_lib.logic_clocks.rtl
--
--------------------------------------------------------------------------------
-- 
-- Created using using Mentor Graphics HDL Designer(TM) 2010.3 (Build 21)
--
-- Based on output of Xilinx Coregen and Alvro Dosil TLU code.
------------------------------------------------------------------------------
-- "Output    Output      Phase     Duty      Pk-to-Pk        Phase"
-- "Clock    Freq (MHz) (degrees) Cycle (%) Jitter (ps)  Error (ps)"
------------------------------------------------------------------------------
-- CLK_OUT1___640.000______0.000______50.0______175.916____213.982
-- CLK_OUT2___160.000______0.000______50.0______223.480____213.982
-- CLK_OUT3____40.000______0.000______50.0______306.416____213.982
--
------------------------------------------------------------------------------
-- "Input Clock   Freq (MHz)    Input Jitter (UI)"
------------------------------------------------------------------------------
-- __primary__________40.000____________0.010

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

USE work.ipbus.all;

library unisim;
use unisim.vcomponents.all;

--! @brief Generates 160MHz , 640MHz clocks from an incoming 40MHz clock.
--! Can switch between clock generated from on-board Xtal ( clk_logic_xtal ) and external clock.
--! Can also output clock to external clock pins.
--!
--! @author David Cussans , David.Cussans@bristol.ac.uk
--
--! @date 14:20:26 11/14/12
--
--! @version v0.1
--
--! @details
--! \br <b> IPBus Address map:</b>
--! \br (decode 2 bits)
--! \li 0x00000000 - control/status register:
--! \li             bit-0 - PLL locked ( 1 = locked )
--! \li              bit-1 - buff-PLL locked ( 1 = locked )
--! \li             bit-2 - use xtal for logic ( 1 = xtal , 0= external)
--! \li             bit-3 - clock connector is an input ( 1=input , 0 = output)
--! \li 0x00000001 - reset logic. Write to bit-zero to send reset.
--!
--!
ENTITY logic_clocks IS
    GENERIC( 
        g_USE_EXTERNAL_CLK : integer := 1
    );
    PORT( 
        ipbus_clk_i           : IN     std_logic;
        ipbus_i               : IN     ipb_wbus;
        ipbus_reset_i         : IN     std_logic;
        Reset_i               : IN     std_logic;
        clk_logic_xtal_i      : IN     std_logic;   --! 40MHz clock derived from onboard xtal
        clk_8x_logic_o       : OUT    std_logic;   --! 640MHz clock
        clk_4x_logic_o        : OUT    std_logic;   --! 160MHz clock
        ipbus_o               : OUT    ipb_rbus;
        strobe_8x_logic_o    : OUT    std_logic;   --! strobes once every 4 cycles of clk_16x
        strobe_4x_logic_o     : OUT    std_logic;   --! one pulse every 4 cycles of clk_4x
        DUT_clk_o             : OUT    std_logic;   --! 40MHz to DUTs
        logic_clocks_locked_o : OUT    std_logic;   --! Goes high if clocks locked.
        logic_reset_o         : OUT    std_logic    --! Goes high to reset counters etc. Sync with clk_4x_logic
    );

-- Declarations
END ENTITY logic_clocks ;

--
ARCHITECTURE rtl OF logic_clocks IS
    signal s_clk40 , s_clk40_internal : std_logic;
    signal s_clk160 ,s_clk160_internal : std_logic;
    signal ryanclock : std_logic;
    signal s_clk320 , s_clk320_internal : std_logic;
    signal s_clk40_out : std_logic;       -- Clock generated by DDR register to feed out of chip.
    signal s_clk_is_xtal, s_clk_is_ext_buf : std_logic := '0'; -- default to
                                                             -- input from ext
    --  signal s_logic_clk_rst : std_logic := '0';
    signal s_locked_pll, s_locked_bufpll : std_logic;
    
    signal s_clk : std_logic;
    signal s_DUT_Clk, s_DUT_Clk_o, s_DUT_ClkG : std_logic;
    signal s_extclk, s_extclkG : std_logic;
    -- signal s_clk_d1 , s_strobe_4x_p1 , s_strobe_4x_logic  : std_logic;
    signal s_clkfbout_buf , s_clkfbout : std_logic;
    
    signal s_strobe_generator  : std_logic_vector(3 downto 0) := "1000";  -- ! Store state of ring buffer to generate strobe
    signal s_logic_clk_generator : std_logic_vector(3 downto 0) := "1100";  --! Stores state of 40MHz "clock"
    --signal s_strobe_generator  : std_logic_vector(15 downto 0) := "1111000000000000";  -- ! Store state of ring buffer to generate strobe
    --signal s_logic_clk_generator : std_logic_vector(15 downto 0) := "1111111100000000";  --! Stores state of 40MHz "clock"
    signal s_strobe160 :std_logic_vector(15 downto 0) := "1000000000000000"; -- 160 strobe ring
    signal s_strobe_fb : std_logic := '0';
    
    signal s_logic_reset_ipb, s_logic_reset_ipb_d1 : std_logic := '0';  
                                        -- ! Reset signal in IPBus clock domain
    signal s_logic_reset , s_logic_reset_d1 , s_logic_reset_d2 , s_logic_reset_d3 , s_logic_reset_d4 : std_logic := '0';  
                                        -- ! reset signal clocked onto logic-clock domain.
    attribute SHREG_EXTRACT: string;
    attribute SHREG_EXTRACT of s_logic_reset_d1: signal is "no"; -- Synchroniser not to be optimised into shre
    attribute SHREG_EXTRACT of s_logic_reset_d2: signal is "no"; -- Synchroniser not to be optimised into shreg
    attribute SHREG_EXTRACT of s_logic_reset_d3: signal is "no"; -- Synchroniser not to be optimised into shreg
    attribute SHREG_EXTRACT of s_logic_reset_d4: signal is "no"; -- Synchroniser not to be optimised into shreg
    signal s_ipbus_ack : std_logic := '0';
    signal s_reset_pll : std_logic := '0';
    
    
    -- ! Global Reset signal
    signal  s_extclk_internal  : std_logic := '0';
    signal s_clock_status_ipb : std_logic_vector( ipbus_o.ipb_rdata'range );   --! Hold status of clocks
  
BEGIN
    -----------------------------------------------------------------------------
    -- IPBus write
    -----------------------------------------------------------------------------
    ipbus_write: process (ipbus_clk_i)
    begin  -- process ipb_clk_i
    if rising_edge(ipbus_clk_i) then
        s_logic_reset_ipb <= '0';
        if (ipbus_i.ipb_strobe = '1' and ipbus_i.ipb_write = '1') then
            case ipbus_i.ipb_addr(1 downto 0) is
            when "00" =>
             s_clk_is_xtal <= ipbus_i.ipb_wdata(2) ; -- select clock source
             
            when "01" =>
             s_logic_reset_ipb <= ipbus_i.ipb_wdata(0) ; -- write to reset
            when others => null;
            end case;
       end if;

        -- register reset signal to aid timing.
        s_logic_reset_ipb_d1 <= s_logic_reset_ipb;
        s_ipbus_ack <= ipbus_i.ipb_strobe and not s_ipbus_ack;
        -- register the clock status signals onto IPBus domain.
        --s_clock_status_ipb <=  x"0000000" & '0' & s_clk_is_xtal & s_locked_bufpll & s_locked_pll;
        s_clock_status_ipb <=  x"0000000" & '0' & '0' & '0' & s_locked_pll; -- The only useful bit is not the PLL lock status. 
    end if;
    end process ipbus_write;

    ipbus_o.ipb_ack <= s_ipbus_ack;
    ipbus_o.ipb_err <= '0';

    -----------------------------------------------------------------------------
    -- IPBUS read
    -----------------------------------------------------------------------------
    with ipbus_i.ipb_addr(1 downto 0) select
    ipbus_o.ipb_rdata <=
        s_clock_status_ipb  when "00",
        (others => '1')      when others;


    -----------------------------------------------------------------------------
    -- Generate reset signal on logic-clock domain
    -- This relies on the IPBus clock being much slower than the 4x logic clock.
    -----------------------------------------------------------------------------
    p_reset: process (s_clk160_internal)
    begin  -- process p_reset
    if rising_edge(s_clk160_internal) then
        s_logic_reset_d1 <= s_logic_reset_ipb_d1;
        s_logic_reset_d2 <= s_logic_reset_d1;
        s_logic_reset_d3 <= s_logic_reset_d2;
        s_logic_reset_d4 <= s_logic_reset_d2 and ( not s_logic_reset_d3); 
        s_logic_reset <= s_logic_reset_d4;
    end if;
    end process p_reset;
    
    logic_reset_o <= s_logic_reset;
    logic_clocks_locked_o <= s_locked_bufpll and s_locked_pll;


    -- Use Generate, since can't figure out how BUFGMUX works    
    --  gen_extclk_input: if ( g_USE_EXTERNAL_CLK = 1) generate
    --    s_DUT_Clk <= s_extclkG; -- Hard wire for now.    
    --  end generate gen_extclk_input;
    --  gen_intclk_input: if ( g_USE_EXTERNAL_CLK = 0) generate
    s_DUT_Clk <= clk_logic_xtal_i; 
    --  end generate gen_intclk_input;  
  

  
    --! Clocking primitive
    -------------------------------------
    --! Instantiation of the PLL primitive
    pll_base_inst : PLL_BASE
    generic map
       (BANDWIDTH            => "OPTIMIZED",
        --CLK_FEEDBACK         => "CLKOUT0", --"CLKFBOUT",
        CLK_FEEDBACK         => "CLKFBOUT",
        COMPENSATION         => "SYSTEM_SYNCHRONOUS",
        DIVCLK_DIVIDE        => 1,
        CLKFBOUT_MULT        => 16,
        CLKFBOUT_PHASE       => 0.000,
        CLKOUT0_DIVIDE       => 2, -- 1-->2 move from 640 to 320
        CLKOUT0_PHASE        => 0.000,
        CLKOUT0_DUTY_CYCLE   => 0.500,
        CLKOUT1_DIVIDE       => 4, -- 4-->8 move from 160 to 80
        CLKOUT1_PHASE        => 0.000,
        CLKOUT1_DUTY_CYCLE   => 0.500,
        CLKOUT2_DIVIDE       => 16, -- 16--> 32 move from 40 to 20
        CLKOUT2_PHASE        => 0.000,
        CLKOUT2_DUTY_CYCLE   => 0.500,
        CLKIN_PERIOD         => 25.000,
        REF_JITTER           => 0.010)
    port map(
        -- Output clocks
        CLKFBOUT            => s_clkfbout,
        CLKOUT0             => s_clk320,
        CLKOUT1             => s_clk160,
        CLKOUT2             => s_clk40,
        CLKOUT3             => open,
        CLKOUT4             => open,
        CLKOUT5             => open,
        -- Status and control signals
        LOCKED              => s_locked_pll,
        --    RST                 => s_logic_clk_rst,
        RST                 => s_reset_pll,
        -- Input clock control
        --    CLKFBIN             => s_clkfbout_buf,
        CLKFBIN             => s_clkfbout,
        CLKIN               => s_DUT_clk);
        --      CLKIN               => clk_logic_xtal_i);

    s_reset_pll <= Reset_i or s_logic_reset; 

-----------------------------------------------
--BUFPLL not supported by 7 Series. We need to replace it with BUFIO+BUFR 
  -- Buffer the 16x clock and generate the ISERDES strobe signal
--   BUFPLL_inst : BUFPLL
--   generic map (
--      DIVIDE => 4)
--   port map (
--      IOCLK  => s_clk640_internal,          -- 1-bit output: Output I/O clock
--      LOCK   => s_locked_bufpll,            -- 1-bit output: Synchronized LOCK output
--      SERDESSTROBE => strobe_16x_logic_O,   -- 1-bit output: Output SERDES strobe (connect to ISERDES2/OSERDES2)
--      GCLK   => s_clk160_internal,          -- 1-bit input: BUFG clock input
--      LOCKED => s_locked_pll,               -- 1-bit input: LOCKED input from PLL
--      PLLIN  => s_clk640                    -- 1-bit input: Clock input from PLL
--   );

    BUFG_inst: BUFG
    port map (
        I => s_clk320,
        O => s_clk320_internal    
    );
    
--    BUFR_inst: BUFR
--    generic map (
--        BUFR_DIVIDE => "4"
--    )
--    port map (
--        I   => s_clk160_internal,
--        CE  => '1',
--        CLR => '0',
--        O   => ryanclock
--    );
    
--    BUFG_inst2: BUFG
--    port map (
--        I => ryanclock,
--        O => strobe_16x_logic_O    -- Not sure this is actually a strobe... Check
--    );
-----------------------------------------------

	clk_8x_logic_o <= s_clk320_internal;
	DUT_clk_o <= s_DUT_clk;


  
  -- Generate a strobe signal every 4 clocks. 
  -- Can't use a clock signal as a combinatorial signal. Hence the baroque
  -- method of generating a strobe. Add a mechanism to restart if the '1' gets
  -- lost ....
    
    ------------------
    generate_4x_strobe: process (s_clk160_internal)-- , s_clk40_out)
    begin  -- process generate_4x_strobe
    if rising_edge(s_clk160_internal) then
        if s_logic_reset = '1' then
            s_strobe_generator <= "1000";
            s_logic_clk_generator <= "1100";
            --s_strobe160 <= "1000000000000000";
        elsif (s_locked_pll ='1') then
            s_strobe_generator <= s_strobe_generator(2 downto 0) & s_strobe_generator(3); -- <- bit shift left      
            s_logic_clk_generator <= s_logic_clk_generator(2 downto 0) & s_logic_clk_generator(3); -- <- bit shift left 
            --s_strobe160 <= s_strobe160(14 downto 0) & s_strobe160(15);
        end if;
    end if;
    end process generate_4x_strobe;
    strobe_4x_logic_o <=  s_strobe_generator(3); -- Every 4 clocks this gets to 1 for one pulse
    s_clk40_out <= s_logic_clk_generator(3); -- Every 4 clocks this gets to 1 for two pulses (so half F of the original clock? But then it is a clk80 not clk40.) Not used it seems.
    ---------------
    
    generate_8x_strobe: process (s_clk320_internal)
    begin
    if rising_edge(s_clk320_internal) then
        if s_logic_reset = '1' then
            s_strobe160 <= "1000000000000000"; 
            --s_strobe_generator <= "1111000000000000";--
            --s_logic_clk_generator <= "1111111100000000";--
        elsif (s_locked_pll ='1') then
            s_strobe160 <= s_strobe160(14 downto 0) & s_strobe160(15);
            --s_strobe_generator <= s_strobe_generator(14 downto 0) & s_strobe_generator(15); --       
            --s_logic_clk_generator <= s_logic_clk_generator(14 downto 0) & s_logic_clk_generator(15); -- <- bit shift left
        end if;
    end if;
    end process generate_8x_strobe;
    strobe_8x_logic_O <= s_strobe160(15);
    --strobe_4x_logic_o <=  s_strobe_generator(15); -- 
    --s_clk40_out <= s_logic_clk_generator(15); -- 
        

  -- buffer 160MHz (4x) clock
  --------------------------------------
    clk160_o_buf : BUFG
    port map(
        O   => s_clk160_internal,
        I   => s_clk160);
    
    clk_4x_logic_o <= s_clk160_internal;
 
--   -- buffer 40MHz (1x) clock
--  --------------------------------------
--  clk40_o_buf : BUFG
--  port map(
--    O   => s_clk40_internal,
--    I   => s_clk40);

--  clk_logic_o <= s_clk40_out;

END ARCHITECTURE rtl;

