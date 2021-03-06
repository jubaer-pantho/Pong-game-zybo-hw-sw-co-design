----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2016 01:32:41 PM
-- Design Name: 
-- Module Name: top_module - structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity top_module is
  port (
  DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
  DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
  DDR_cas_n : inout STD_LOGIC;
  DDR_ck_n : inout STD_LOGIC;
  DDR_ck_p : inout STD_LOGIC;
  DDR_cke : inout STD_LOGIC;
  DDR_cs_n : inout STD_LOGIC;
  DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
  DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
  DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
  DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
  DDR_odt : inout STD_LOGIC;
  DDR_ras_n : inout STD_LOGIC;
  DDR_reset_n : inout STD_LOGIC;
  DDR_we_n : inout STD_LOGIC;
  FIXED_IO_ddr_vrn : inout STD_LOGIC;
  FIXED_IO_ddr_vrp : inout STD_LOGIC;
  FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
  FIXED_IO_ps_clk : inout STD_LOGIC;
  FIXED_IO_ps_porb : inout STD_LOGIC;
  FIXED_IO_ps_srstb : inout STD_LOGIC;
  led : in STD_LOGIC_VECTOR ( 3 downto 0 );
  vga_vs  : out std_logic;
  vga_hs  : out std_logic;
  vga_b   : out std_logic_vector(4 downto 0);
  vga_g   : out std_logic_vector(5 downto 0);
  vga_r   : out std_logic_vector(4 downto 0);
  clk       : in std_logic
);
end top_module;

architecture structural of top_module is
component design_1_wrapper is
  port (
    BRAM_PORTB_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTB_clk : in STD_LOGIC;
    BRAM_PORTB_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTB_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTB_en : in STD_LOGIC;
    BRAM_PORTB_rst : in STD_LOGIC;
    BRAM_PORTB_we : in STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    led : in STD_LOGIC_VECTOR ( 3 downto 0 );    
    vga : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
end component design_1_wrapper;

component vga_controller IS
  GENERIC(
    h_pulse  :  INTEGER   := 208;   --horiztonal sync pulse width in pixels
    h_bp     :  INTEGER   := 336;   --horiztonal back porch width in pixels
    h_pixels :  INTEGER   := 1920;  --horiztonal display width in pixels
    h_fp     :  INTEGER   := 128;   --horiztonal front porch width in pixels
    h_pol    :  STD_LOGIC := '0';   --horizontal sync pulse polarity (1 = positive, 0 = negative)
    v_pulse  :  INTEGER   := 3;     --vertical sync pulse width in rows
    v_bp     :  INTEGER   := 38;    --vertical back porch width in rows
    v_pixels :  INTEGER   := 1200;  --vertical display width in rows
    v_fp     :  INTEGER   := 1;     --vertical front porch width in rows
    v_pol    :  STD_LOGIC := '1');  --vertical sync pulse polarity (1 = positive, 0 = negative)
  PORT(
    pixel_clk :  IN   STD_LOGIC;  --pixel clock at frequency of VGA mode being used
    reset_n   :  IN   STD_LOGIC;  --active low asycnchronous reset
    h_sync    :  OUT  STD_LOGIC;  --horiztonal sync pulse
    v_sync    :  OUT  STD_LOGIC;  --vertical sync pulse
    disp_ena  :  OUT  STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    column    :  OUT  INTEGER;    --horizontal pixel coordinate
    row       :  OUT  INTEGER;    --vertical pixel coordinate
    n_blank   :  OUT  STD_LOGIC;  --direct blacking output to DAC
    n_sync    :  OUT  STD_LOGIC); --sync-on-green output to DAC
END component vga_controller;

component clk_wiz_0 is
 port (
  clk_in1 : in std_logic;
  clk_out1 : out std_logic;
  locked : out std_logic
 );
 end component clk_wiz_0;

signal vga_pixclk : std_logic;
signal vga_reset : std_logic;
signal hs : std_logic;
signal vs : std_logic;
signal r : std_logic_vector(4 downto 0);
signal g : std_logic_vector(5 downto 0);
signal b : std_logic_vector(4 downto 0);
signal col : integer;
signal row : integer;
signal answer : integer;
signal den : std_logic;
signal addr : std_logic_vector(31 downto 0):= x"00000000";
signal data : std_logic_vector(31 downto 0);
signal addlogic : STD_LOGIC_VECTOR(31 downto 0):= x"00000000";
--signal columnlogic : STD_LOGIC_VECTOR(31 downto 0);
--attribute mark_debug : string;
--attribute mark_debug of hs : signal is "true";
--attribute mark_debug of vs : signal is "true";
--attribute mark_debug of col : signal is "true";
--attribute mark_debug of row : signal is "true";
--attribute mark_debug of den : signal is "true";


begin

--addr <= conv_std_logic_vector(col,addr'length);

--pADDR : process(clk,vga_reset)
--begin
--    if (vga_reset='0') then
--        addr <= (others=>'0');
--    elsif (clk'event and clk='1') then
--        if (col=0) then
--            addr <= (others=>'0');
--        elsif (den='1')  then
--            addr <= addr+'1';
--        end if;
--    end if;
--end process;




uPS : design_1_wrapper 
  port map (
    BRAM_PORTB_addr => addr,
    BRAM_PORTB_clk  => vga_pixclk,
    BRAM_PORTB_din  => x"00000000",
    BRAM_PORTB_dout => data,
    BRAM_PORTB_en   => '1',
    BRAM_PORTB_rst  => '0',
    BRAM_PORTB_we   => "0000",
    DDR_addr    => DDR_addr,    
    DDR_ba      => DDR_ba,      
    DDR_cas_n   => DDR_cas_n,   
    DDR_ck_n    => DDR_ck_n ,   
    DDR_ck_p    => DDR_ck_p ,   
    DDR_cke     => DDR_cke ,    
    DDR_cs_n    => DDR_cs_n  ,  
    DDR_dm      => DDR_dm   ,   
    DDR_dq      => DDR_dq   ,   
    DDR_dqs_n   => DDR_dqs_n  , 
    DDR_dqs_p   => DDR_dqs_p  , 
    DDR_odt     => DDR_odt    , 
    DDR_ras_n   => DDR_ras_n  , 
    DDR_reset_n => DDR_reset_n ,
    DDR_we_n    => DDR_we_n    ,
    FIXED_IO_ddr_vrn    => FIXED_IO_ddr_vrn, 
    FIXED_IO_ddr_vrp    => FIXED_IO_ddr_vrp,
    FIXED_IO_mio        => FIXED_IO_mio    , 
    FIXED_IO_ps_clk     => FIXED_IO_ps_clk , 
    FIXED_IO_ps_porb    => FIXED_IO_ps_porb ,
    FIXED_IO_ps_srstb   => FIXED_IO_ps_srstb,
    led                 => led,
    vga(15 downto 11)   => r,
    vga(10 downto 5)    => g,
    vga(4 downto 0)     => b
  );
  
     
     
  
  changeAddr: PROCESS(vga_pixclk)
  begin
    if rising_edge(vga_pixclk) then
        
        if(row<300 and col< 300) then
            answer <= row*300 +col;
            addlogic <= conv_std_logic_vector(answer, 32);
            addr <= x"00000000" + addlogic;
        

         
         else 
            addr <= x"00000000";
         end if;
            
    end if;
    end PROCESS;
  
  vga_r <= data(15 downto 11) when (den = '1') else (others=>'0');
  vga_g <= data(10 downto 5) when (den = '1') else (others=>'0');
  vga_b <= data(4 downto 0) when (den = '1') else (others=>'0');
  
--    vga_r <= (others=>'1') when (den='1' and col<426) else (others=>'0');
--    vga_g <= (others=>'1') when (den='1' and col>=426 and col<2*426) else (others=>'0');
--    vga_b <= (others=>'1') when (den='1' and col>=2*426) else (others=>'0');
  
  vga_hs <= hs;
  vga_vs <= vs;
  
uVGA : vga_controller 
    GENERIC map (
      h_pulse  =>  96,   --horiztonal sync pulse width in pixels
      h_bp     =>  48,   --horiztonal back porch width in pixels
      h_pixels =>  640,  --horiztonal display width in pixels
      h_fp     =>  16,   --horiztonal front porch width in pixels
      h_pol    =>  '0',   --horizontal sync pulse polarity (1 = positive, 0 = negative)
      v_pulse  =>  2,     --vertical sync pulse width in rows
      v_bp     =>  33,    --vertical back porch width in rows
      v_pixels =>  480,  --vertical display width in rows
      v_fp     =>  10,     --vertical front porch width in rows
      v_pol    =>  '0')  --vertical sync pulse polarity (1 = positive, 0 = negative)
    PORT map (
      pixel_clk =>  vga_pixclk,  --pixel clock at frequency of VGA mode being used
      reset_n   =>  vga_reset,  --active low asycnchronous reset
      h_sync    =>  hs,  --horiztonal sync pulse
      v_sync    =>  vs,  --vertical sync pulse
      disp_ena  =>  den,  --display enable ('1' = display time, '0' = blanking time)
      column    =>  col,    --horizontal pixel coordinate
      row       =>  row,    --vertical pixel coordinate
      n_blank   =>  open,  --direct blacking output to DAC
      n_sync    =>  open   --sync-on-green output to DAC
    );      

uVGA_CLK : clk_wiz_0
port map (
  clk_in1 => clk,
  clk_out1 => vga_pixclk,
  locked => vga_reset
);

end structural;
