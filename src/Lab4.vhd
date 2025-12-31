----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.10.2025 08:56:46
-- Design Name: 
-- Module Name: Lab4 - Behavioral
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

entity Lab4 is
    Port ( clk : in STD_LOGIC;
           start : in STD_LOGIC;
           mclk : out STD_LOGIC;
           bclk : out STD_LOGIC;
           mute : out STD_LOGIC;
           pblrc : out STD_LOGIC;
           pbdat : out STD_LOGIC);
end Lab4;

architecture Behavioral of Lab4 is

component ssm2603_i2s is
    Port ( clk : in STD_LOGIC;
           r_data : in STD_LOGIC_VECTOR (23 downto 0);
           l_data : in STD_LOGIC_VECTOR (23 downto 0);
           bclk :   out STD_LOGIC;
           pbdat :  out STD_LOGIC;
           pblrc :  out STD_LOGIC;
           mclk :   out STD_LOGIC;
           mute :   out STD_LOGIC;
           ready :  out STD_LOGIC);
end component;
signal r_data, l_data:  std_logic_vector(23 downto 0) := (others => '0');
signal mclk_sig:        std_logic;
signal ready:           std_logic;
signal slow_clk : std_logic := '0';
signal counter  : integer range 0 to 12287999 := 0;

signal tone_counter:         unsigned(6 downto 0) := (others => '0');
signal tone_terminal_count : unsigned(6 downto 0) := (others => '0');

constant COUNT_C5: unsigned(6 downto 0) := TO_UNSIGNED(92, 7)
;
constant COUNT_D5: unsigned(6 downto 0) := TO_UNSIGNED(82, 7);
constant COUNT_E5: unsigned(6 downto 0) := TO_UNSIGNED(73, 7);
constant COUNT_F5: unsigned(6 downto 0) := TO_UNSIGNED(69, 7);
constant COUNT_G5: unsigned(6 downto 0) := TO_UNSIGNED(61, 7);
constant COUNT_A5: unsigned(6 downto 0) := TO_UNSIGNED(55, 7);
constant COUNT_B5: unsigned(6 downto 0) := TO_UNSIGNED(49, 7);
constant COUNT_C6: unsigned(6 downto 0) := TO_UNSIGNED(46, 7);
constant COUNT_D6: unsigned(6 downto 0) := TO_UNSIGNED(41, 7);
constant COUNT_E6: unsigned(6 downto 0) := TO_UNSIGNED(36, 7);
constant COUNT_F6: unsigned(6 downto 0) := TO_UNSIGNED(34, 7);
constant COUNT_G6: unsigned(6 downto 0) := TO_UNSIGNED(31, 7);
constant COUNT_A6: unsigned(6 downto 0) := TO_UNSIGNED(27, 7);
constant COUNT_B6: unsigned(6 downto 0) := TO_UNSIGNED(24, 7);

type state_type is (IDLE, NOTE1, NOTE2, NOTE3, NOTE4, NOTE5, NOTE6, NOTE7, NOTE8, NOTE9, NOTE10, NOTE11, NOTE12, NOTE13, NOTE14);
signal current_state: state_type := IDLE;

begin

mclk <= mclk_sig;

codec: ssm2603_i2s port map(
  clk  => clk,
  mclk => mclk_sig,
  bclk => bclk,
  mute => mute,
  ready => ready,
  r_data => r_data,
  l_data => l_data,
  pblrc => pblrc,
  pbdat => pbdat
);


slow_clk_gen: process(mclk_sig)
    begin
        if rising_edge(mclk_sig) then
            if counter = 12287999 then
                slow_clk <= '1';
                counter <= 0;
            else
                slow_clk <= '0';
                counter <= counter + 1;
            end if;
        end if;     
    end process;

square_wave_gen: process(mclk_sig)
    begin
        if rising_edge(mclk_sig) then
            if ready = '1' then
                if tone_counter = tone_terminal_count then
                    tone_counter <= (others => '0');
                else
                    tone_counter <= tone_counter + 1;
                end if;
            end if;
        end if;
    end process;        

state_machine: process(mclk_sig)
    begin
        if rising_edge(mclk_sig) then
            case current_state is
                when IDLE =>
                    if start = '1' then
                        current_state <= NOTE1;
                    else
                        current_state <= IDLE;
                    end if;
                when NOTE1 =>
                    if slow_clk = '1' then
                        current_state <= NOTE2;
                    end if;
                when NOTE2 =>
                    if slow_clk = '1' then
                        current_state <= NOTE3;
                    end if;
                when NOTE3 =>
                    if slow_clk = '1' then
                        current_state <= NOTE4;
                    end if;
                when NOTE4 =>
                    if slow_clk = '1' then
                        current_state <= NOTE5;
                    end if;
                when NOTE5 =>
                    if slow_clk = '1' then
                        current_state <= NOTE6;
                    end if;
                when NOTE6 =>
                    if slow_clk = '1' then
                        current_state <= NOTE7;
                    end if;
                when NOTE7 =>
                    if slow_clk = '1' then
                        current_state <= NOTE8;
                    end if;
                when NOTE8 =>
                    if slow_clk = '1' then
                        current_state <= NOTE9;
                    end if;
                when NOTE9 =>
                    if slow_clk = '1' then
                        current_state <= NOTE10;
                    end if;
                when NOTE10 =>
                    if slow_clk = '1' then
                        current_state <= NOTE11;
                    end if;
                when NOTE11 =>
                    if slow_clk = '1' then
                        current_state <= NOTE12;
                    end if;
                when NOTE12 =>
                    if slow_clk = '1' then
                        current_state <= NOTE13;
                    end if;
                when NOTE13 =>
                    if slow_clk = '1' then
                        current_state <= NOTE14;
                    end if;
                when NOTE14 =>
                    if slow_clk = '1' then
                        current_state <= IDLE;
                    end if;
                when OTHERS =>
                    current_state <= IDLE;
            end case;
        end if;
    end process;
    
with current_state select
    tone_terminal_count <=
        COUNT_C5 when NOTE1,
        COUNT_D5 when NOTE2,
        COUNT_E5 when NOTE3,
        COUNT_F6 when NOTE4,
        COUNT_G5 when NOTE5,
        COUNT_A5 when NOTE6,
        COUNT_B5 when NOTE7,
        COUNT_C6 when NOTE8,
        COUNT_D6 when NOTE9,
        COUNT_E6 when NOTE10,
        COUNT_F6 when NOTE11,
        COUNT_G6 when NOTE12,
        COUNT_A6 when NOTE13,
        COUNT_B6 when NOTE14,
        TO_UNSIGNED(1,7) when others;
            
l_data <= (others => '0') when tone_counter < (tone_terminal_count/2) else
            x"0FFFFF";
r_data <= (others => '0') when tone_counter < (tone_terminal_count/2) else
            x"0FFFFF";
    
end Behavioral;
