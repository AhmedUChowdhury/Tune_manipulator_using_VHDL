----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.11.2025 15:48:54
-- Design Name: 
-- Module Name: Lab4_tbench - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Lab4_tbench is
--  Port ( );
end Lab4_tbench;

architecture Behavioral of Lab4_tbench is
    component Lab4 is
        port (
        clk, start  : in std_logic;
        bclk, pbdat, pblrc, mclk, mute  : out std_logic
        );
    end component; 

signal clk, start, bclk, pbdat, pblrc, mclk, mute: std_logic := '0';

begin
uut : Lab4 port map(
    clk => clk,
    mclk => mclk,
    bclk => bclk,
    start => start,
    mute => mute,
    pbdat => pbdat,
    pblrc => pblrc
    );

clk_proc: process
begin
    wait for 4 ns;
    clk <= not clk;
end process clk_proc;

stim_proc : process
begin
     
     wait for 4 ns;
     start <= '0';
     
     wait for 12 ns;    
     start <= '1';

     wait;
    end process stim_proc;

end Behavioral;
