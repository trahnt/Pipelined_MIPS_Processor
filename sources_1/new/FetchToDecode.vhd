-------------------------------------------------
--  File:          FetchToDecode.vhd
--
--  Entity:        FetchToDecode
--  Architecture:  behave
--  Author:        Trent Wesley
--  Created:       03/31/22
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 register going from the Instruction 
--                 Fetch Stage to the Decode Stage
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FetchToDecode is
    port (
        clk : in std_logic;
        Instruction : in std_logic_vector(31 downto 0);
        InstructionOut : out std_logic_vector(31 downto 0));
end FetchToDecode;

architecture behave of FetchToDecode is

begin
    process (clk) begin
        if rising_edge(clk) then
            InstructionOut <= Instruction;
        end if;
    end process;
end behave;
