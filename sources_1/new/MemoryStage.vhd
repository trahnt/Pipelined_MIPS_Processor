-------------------------------------------------
--  File:          MemoryStage.vhd
--
--  Entity:        MemoryStage
--  Architecture:  behave
--  Author:        Trent Wesley
--  Created:       03/17/22
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 complete memory stage
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MemoryStage is
    port (
        clk, RegWrite, MemtoReg, MemWrite : in std_logic;
        WriteReg : in std_logic_vector(4 downto 0);
        ALUResult, WriteData : in std_logic_vector(31 downto 0);
        RegWriteOut, MemtoRegOut : out std_logic;
        WriteRegOut : out std_logic_vector(4 downto 0);
        MemOut, ALUResultOut : out std_logic_vector(31 downto 0));
end MemoryStage;

architecture behave of MemoryStage is

begin
    RegWriteOut <= RegWrite;
    MemtoRegOut <= MemtoReg;
    WriteRegOut <= WriteReg;
    ALUResultOut <= ALUResult;
    
    dataMem : entity work.DataMemory 
        port map (clk => clk, w_en => MemWrite, addr => ALUResult(9 downto 0),
            d_in => WriteData, d_out => MemOut);
    
end behave;
