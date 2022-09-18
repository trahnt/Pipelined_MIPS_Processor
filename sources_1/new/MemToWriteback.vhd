-------------------------------------------------
--  File:          MemToWriteback.vhd
--
--  Entity:        MemToWriteback
--  Architecture:  behave
--  Author:        Trent Wesley
--  Created:       04/11/22
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 register going from the Memory 
--                 Stage to the Writeback Stage
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MemToWriteback is
    port (
        clk, RegWrite, MemtoReg : in std_logic;
        WriteReg : in std_logic_vector(4 downto 0);
        MemIn, ALUResult : in std_logic_vector(31 downto 0);
        
        RegWriteOut, MemtoRegOut : out std_logic;
        ALUResultOut, ReadData : out std_logic_vector(31 downto 0);
        WriteRegOut : out std_logic_vector(4 downto 0));
end MemToWriteback;

architecture behave of MemToWriteback is
begin
    process (clk) begin
        if rising_edge(clk) then
            RegWriteOut <= RegWrite;
            MemtoRegOut <= MemtoReg;
            ALUResultOut <= ALUResult;
            ReadData <= MemIn;
            WriteRegOut <= WriteReg;
        end if;
    end process;
end behave;
