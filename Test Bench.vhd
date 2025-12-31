----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2025 17:33:10
-- Design Name: 
-- Module Name: i2c_testbench - Behavioral
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
use IEEE.numeric_std.ALL;
use std.env.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity i2c_testbench is
--  Port ( );
end i2c_testbench;

architecture Behavioral of i2c_testbench is
    signal clk        :   std_logic                        := '0';
    signal rst        :   std_logic                        := '0';
    signal enable     :   std_logic                        := '0';
    signal r_w        :   std_logic                        := '0';
    signal slv_addr   :   std_logic_vector(6 downto 0)     := (others => '0');
    signal addr       :   std_logic_vector(7 downto 0)     := (others => '0');
    signal data_in    :   std_logic_vector(7 downto 0)     := (others => '0');
    
    signal data_out   :   std_logic_vector(7 downto 0);
begin

    dut: entity work.i2c_top_module
        port map(clk        =>  clk,
                 rst        =>  rst,
                 enable     =>  enable,
                 r_w        =>  r_w,
                 slv_addr   =>  slv_addr,
                 addr       =>  addr,
                 data_in    =>  data_in,
                 
                 data_out   =>  data_out);
                 
    process
    begin
        wait for 10 ns;
        clk     <=  not clk;
    end process;

    process
    begin
        rst <=  '1';
        wait for 20 ns;
        rst <=  '0';
        enable  <=  '1';
                        
        r_w <=  '0';
            slv_addr<=  "1111111";
            addr    <=  x"ff";
            data_in <=  x"ff";
        wait for 5730 ns;
        
        r_w <=  '1';
            slv_addr<=  "1111111";
            addr    <=  x"ff";
        wait for 5600 ns;
        
        r_w <=  '0';
            slv_addr<=  "1111111";
            addr    <=  x"fe";
            data_in <=  x"fe";
        wait for 5600 ns;
        
        r_w <=  '1';
            slv_addr<=  "1111111";
            addr    <=  x"fe";
        wait for 5600 ns;
        
        r_w <=  '0';
            slv_addr<=  "1111111";
            addr    <=  x"fd";
            data_in <=  x"fd";
        wait for 5600 ns;
        
        r_w <=  '1';
            slv_addr<=  "1111111";
            addr    <=  x"fd";
        wait for 5600 ns;
        
        r_w <=  '0';
            slv_addr<=  "1111111";
            addr    <=  x"fc";
            data_in <=  x"fc";
        wait for 5600 ns;
        
        r_w <=  '1';
            slv_addr<=  "1111111";
            addr    <=  x"fc";
        wait for 5600 ns;
        
        r_w <=  '0';
            slv_addr<=  "1111111";
            addr    <=  x"fb";
            data_in <=  x"fb";
        wait for 5600 ns;
        
        r_w <=  '1';
            slv_addr<=  "1111111";
            addr    <=  x"fb";
        wait for 5600 ns;
        
        r_w <=  '0';
            slv_addr<=  "1111111";
            addr    <=  x"fa";
            data_in <=  x"fa";
        wait for 5600 ns;
        
        r_w <=  '1';
            slv_addr<=  "1111111";
            addr    <=  x"fa";
        wait for 5600 ns;
        
        enable  <=  '0';
--        r_w <=  '0';
        wait for 5600 ns;
        finish;
    end process;

end Behavioral;
