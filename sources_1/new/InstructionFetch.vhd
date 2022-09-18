-------------------------------------------------
--  File:          InstructionFetch.vhd
--
--  Entity:        InstructionFetch
--  Architecture:  fetch
--  Author:        Trent Wesley
--  Created:       02/15/22
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of 
--                 instruction fetch
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity InstructionFetch is
    port (clk, rst : in std_logic;
    Instruction : out std_logic_vector(31 downto 0));
end InstructionFetch;

architecture fetch of InstructionFetch is
    signal pc : std_logic_vector(27 downto 0) := (others => '0');
begin
    InstrMem : entity work.InstructionMemory
        port map (addr => pc, d_out => Instruction);
    
    program_counter : process (rst, clk) begin
        if rst='1' then
            pc <= (others => '0');
        elsif rising_edge(clk) then
            pc <= std_logic_vector(to_unsigned((to_integer(unsigned(pc))+4), 28));
        end if;
    end process program_counter;
end;
