-------------------------------------------------
--  File:          WritebackToDecode.vhd
--
--  Entity:        WritebackToDecode
--  Architecture:  behave
--  Author:        Trent Wesley
--  Created:       04/11/22
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 register going from the Writeback 
--                 Stage to the Decode Stage
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WritebackToDecode is
    port (
        clk, RegWrite : in std_logic;
        WriteReg : in std_logic_vector(4 downto 0);
        Result : in std_logic_vector(31 downto 0);
        
        RegWriteEn : out std_logic;
        RegWriteData : out std_logic_vector(31 downto 0);
        RegWriteAddr : out std_logic_vector(4 downto 0));
end WritebackToDecode;

architecture behave of WritebackToDecode is
begin
    process (clk) begin
        if rising_edge(clk) then
            RegWriteEn <= RegWrite;
            RegWriteAddr <= WriteReg;
            RegWriteData <= Result;
        end if;
    end process;
end behave;
