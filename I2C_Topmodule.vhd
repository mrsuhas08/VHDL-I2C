----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2025 17:21:59
-- Design Name: 
-- Module Name: i2c_top_module - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity i2c_top_module is
    Port(clk        :   in std_logic;
         rst        :   in std_logic;
         --master
         sdio_m     :   inout std_logic;--34
         sclk_m     :   out std_logic;--35
         --slave
         sclk_s     :   in std_logic;--33
         sdio_s     :   inout std_logic);--32
end i2c_top_module;

architecture Behavioral of i2c_top_module is
    
    component i2c_master is
        Port(clk        :   in std_logic;
             rst        :   in std_logic;
             enable     :   in std_logic;
             r_w        :   in std_logic;
             slv_addr   :   in std_logic_vector(6 downto 0);
             addr       :   in std_logic_vector(7 downto 0);
             data_in    :   in std_logic_vector(7 downto 0);
             
             sdio_m     :   inout std_logic;
             
             sclk_m     :   out std_logic;
             data_out   :   out std_logic_vector(7 downto 0));
    end component;
    
    component i2c_slave is
        Port(clk    :   in std_logic;
             rst    :   in std_logic;
             sclk_s :   in std_logic;
             
             sdio_s :   inout std_logic);    
    end component;
    
    COMPONENT ila_0
        PORT(clk    :   IN STD_LOGIC;
             probe0 :   IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
             probe1 :   IN STD_LOGIC_VECTOR(7 DOWNTO 0));
    END COMPONENT  ;
    
    COMPONENT vio_0
        PORT(clk        : IN STD_LOGIC;
             probe_out0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
             probe_out1 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
             probe_out2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
             probe_out3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
             probe_out4 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
             probe_out5 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0));
    END COMPONENT;
        
    -- inputs
    signal rst_vio  :   std_logic       := '1';
    signal enable   :   std_logic       := '0';
    signal r_w      :   std_logic       := '0';
    signal slv_addr :   std_logic_vector(6 downto 0)    := (others => '0');
    signal addr     :   std_logic_vector(7 downto 0)    := (others => '0');
    signal data_in  :   std_logic_vector(7 downto 0)    := (others => '0');
    -- outputs
    signal data_out :   std_logic_vector(7 downto 0)    := (others => '0');
    
begin

    master: i2c_master
            port map(clk        =>  clk,
                     rst        =>  rst_vio,
                     enable     =>  enable,
                     r_w        =>  r_w,
                     slv_addr   =>  slv_addr,
                     addr       =>  addr,
                     data_in    =>  data_in,
                     
                     sclk_m     =>  sclk_m,
                     sdio_m     =>  sdio_m,
                     
                     data_out   =>  data_out);
    
    slave:  i2c_slave
            port map(clk        =>  clk,
                     rst        =>  rst_vio,
                     
                     sclk_s     =>  sclk_s,
                     sdio_s     =>  sdio_s);
    
    wires_output: ila_0
            PORT MAP(clk        =>  clk,
                     probe0(0)  =>  sclk_s,
                     probe1     =>  data_out);
    
    inputs: vio_0
            PORT MAP(clk            =>  clk,
                     probe_out0(0)  =>  enable,
                     probe_out1(0)  =>  r_w,
                     probe_out2     =>  slv_addr,
                     probe_out3     =>  addr,
                     probe_out4     =>  data_in,
                     probe_out5(0)  =>  rst_vio);
    
end Behavioral;
