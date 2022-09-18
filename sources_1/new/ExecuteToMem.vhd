-------------------------------------------------
--  File:          ExecuteToMem.vhd
--
--  Entity:        ExecuteToMem
--  Architecture:  behave
--  Author:        Trent Wesley
--  Created:       04/06/22
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 register going from the Execute  
--                 Stage to the Memory Stage
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ExecuteToMem is
    port (
        clk, RegWrite, MemtoReg, MemWrite : in std_logic;
        ALUResult, WriteData : in std_logic_vector(31 downto 0);
        WriteReg : in std_logic_vector(4 downto 0);
        
        RegWriteOut, MemtoRegOut, MemWriteOut : out std_logic;
        WriteRegOut : out std_logic_vector(4 downto 0);
        ALUResultOut, WriteDataOut : out std_logic_vector(31 downto 0));
end ExecuteToMem;

architecture behave of ExecuteToMem is
begin
    process (clk) begin
        if rising_edge(clk) then
            RegWriteOut <= RegWrite;
            MemtoRegOut <= MemtoReg;
            MemWriteOut <= MemWrite;
            WriteRegOut <= WriteReg;
            ALUResultOut <= ALUResult;
            WriteDataOut <= WriteData;
        end if;
    end process;
end behave;
