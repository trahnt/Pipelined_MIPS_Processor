-------------------------------------------------
--  File:          ExecuteStage.vhd
--
--  Entity:        ExecuteStage
--  Architecture:  behave
--  Author:        Trent Wesley
--  Created:       03/03/22
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of an
--                 ExecuteStage
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ExecuteStage is
    port (
        RegWrite, MemtoReg, MemWrite, ALUSrc, RegDst : in std_logic;
        ALUControl : in std_logic_vector(3 downto 0);
        RegSrcA, RegSrcB, SignImm : in std_logic_vector(31 downto 0);
        RtDest, RdDest : in std_logic_vector(4 downto 0);
        RegWriteOut, MemtoRegOut, MemWriteOut : out std_logic;
        ALUResult, WriteData : out std_logic_vector(31 downto 0);
        WriteReg : out std_logic_vector(4 downto 0));
end ExecuteStage;

architecture behave of ExecuteStage is
    signal AluInMux : std_logic_vector(31 downto 0);
begin
    RegWriteOut <= RegWrite;
    MemtoRegOut <= MemtoReg;
    MemWriteOut <= MemWrite;
    
    ALU : entity work.aluN
        port map (in1 => RegSrcA, in2 => AluInMux, control => ALUControl, out1 => ALUResult);
    
    with ALUSrc select
    AluInMux <= RegSrcB when '0',
                SignImm when others;

    with RegDst select
    WriteReg <= RtDest when '0',
                RdDest when others;
    
    WriteData <= RegSrcB;
end ;
