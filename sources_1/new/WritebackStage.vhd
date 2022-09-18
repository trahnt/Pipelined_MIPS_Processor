-------------------------------------------------
--  File:          WritebackStage.vhd
--
--  Entity:        WritebackStage
--  Architecture:  behave
--  Author:        Trent Wesley
--  Created:       03/17/22
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 complete writeback stage
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WritebackStage is
    port (
        RegWrite, MemtoReg : in std_logic;
        ALUResult, ReadData : in std_logic_vector(31 downto 0);
        WriteReg : in std_logic_vector(4 downto 0);
        RegWriteOut : out std_logic;
        WriteRegOut : out std_logic_vector(4 downto 0);
        Result : out std_logic_vector(31 downto 0));
end WritebackStage;

architecture behave of WritebackStage is

begin
    process (ReadData, MemtoReg, ALUResult) begin
        if (MemtoReg = '1') then
            Result <= ReadData;
        else
            Result <= ALUResult;
        end if;
    end process;
    
    WriteRegOut <= WriteReg;
    RegWriteOut <= RegWrite;
end behave;
