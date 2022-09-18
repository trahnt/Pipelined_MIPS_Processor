-------------------------------------------------
--  File:          Processor.vhd
--
--  Entity:        Processor
--  Architecture:  Structural
--  Author:        Trent Wesley
--  Created:       03/31/22
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 complete micro-processor
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Processor is
    port (
        clk_in, rst : in std_logic;
        ALUResult : out std_logic_vector(31 downto 0));
end Processor;

architecture Structural of Processor is
    signal InstrFetchOut, FtDInstrOut : std_logic_vector(31 downto 0);
    
    signal WtDRegWriteEn : std_logic;
    signal WtDRegWriteData : std_logic_vector(31 downto 0);
    signal WtDRegWriteAddr : std_logic_vector(4 downto 0);
    
    signal IDRegWrite, IDMemtoReg, IDMemWrite : std_logic;
    signal IDALUSrc, IDRegDst : std_logic;
    signal IDALUControl : std_logic_vector(3 downto 0);
    signal IDRD1, IDRD2, IDImmOut : std_logic_vector(31 downto 0);
    signal IDRtDest, IDRdDest : std_logic_vector(4 downto 0);
    
    signal DtERegWrite, DtEMemtoReg, DtEMemWrite : std_logic;
    signal DtEALUSrc, DtERegDst : std_logic;
    signal DtEALUControl : std_logic_vector(3 downto 0);
    signal DtERegSrcA, DtERegSrcB, DtESignImm : std_logic_vector(31 downto 0);
    signal DtERtDest, DtERdDest : std_logic_vector(4 downto 0);
    
    signal ESRegWrite, ESMemtoReg, ESMemWrite : std_logic;
    signal ESALUResult, ESWriteData : std_logic_vector(31 downto 0);
    signal ESWriteReg : std_logic_vector(4 downto 0);
    
    signal EtMRegWrite, EtMMemtoReg, EtMMemWrite : std_logic;
    signal EtMWriteReg : std_logic_vector(4 downto 0);
    signal EtMALUResult, EtMWriteData : std_logic_vector(31 downto 0);
    
    signal MSRegWrite, MSMemtoReg : std_logic;
    signal MSWriteReg : std_logic_vector(4 downto 0);
    signal MSMem, MSALUResult : std_logic_vector(31 downto 0);
    
    signal MtWRegWrite, MtWMemtoReg : std_logic;
    signal MtWALUResult, MtWReadData : std_logic_vector(31 downto 0);
    signal MtWWriteReg : std_logic_vector(4 downto 0);
    
    signal WRegWrite : std_logic;
    signal WWriteReg : std_logic_vector(4 downto 0);
    signal WResult : std_logic_vector(31 downto 0);
    
    signal clk : std_logic;
    
    component clk_wiz_9
        port
         (-- Clock in ports
          -- Clock out ports
          clk_out1          : out    std_logic;
          -- Status and control signals
          reset             : in     std_logic;
          clk_in1           : in     std_logic
         );
    end component;
begin
    clk_wizard : clk_wiz_9
       port map ( 
      -- Clock out ports  
       clk_out1 => clk,
      -- Status and control signals                
       reset => rst,
       -- Clock in ports
       clk_in1 => clk_in
     );
 
    InstrFetch : entity work.InstructionFetch 
        port map (clk => clk, rst => rst, Instruction => InstrFetchOut);
    
    FetchToDecode : entity work.FetchToDecode
        port map (clk => clk, Instruction => InstrFetchOut, 
            InstructionOut => FtDInstrOut);
    
    InstrDecode : entity work.InstructionDecode
        port map (clk => clk, RegWriteEn => WtDRegWriteEn, Instruction => FtDInstrOut,
            RegWriteData => WtDRegWriteData, RegWriteAddr => WtDRegWriteAddr,
            RegWrite => IDRegWrite, MemtoReg => IDMemtoReg, MemWrite => IDMemWrite,
            ALUSrc => IDALUSrc, RegDst => IDRegDst, ALUControl => IDALUControl,
            RD1 => IDRD1, RD2 => IDRD2, ImmOut => IDImmOut, RtDest => IDRtDest,
            RdDest => IDRdDest);
    
    DecodeToExecute : entity work.DecodeToExecute
        port map (clk => clk, RegWriteIn => IDRegWrite, MemtoRegIn => IDMemtoReg,
            MemWriteIn => IDMemWrite, ALUSrcIn => IDALUSrc, RegDstIn => IDRegDst,
            ALUControlIn => IDALUControl, RD1 => IDRD1, RD2 => IDRD2, SignImmIn => IDImmOut,
            RtDestIn => IDRtDest, RdDestIn => IDRdDest, RegWriteOut => DtERegWrite,
            MemtoRegOut => DtEMemtoReg, MemWriteOut => DtEMemWrite, ALUSrcOut => DtEALUSrc,
            RegDstOut => DtERegDst, ALUControlOut => DtEALUControl, RegSrcA => DtERegSrcA,
            RegSrcB => DtERegSrcB, SignImmOut => DtESignImm, RtDestOut => DtERtDest,
            RdDestOut => DtERdDest);
    
    Execute : entity work.ExecuteStage
        port map (RegWrite => DtERegWrite, MemtoReg => DtEMemtoReg, MemWrite => DtEMemWrite, ALUSrc => DtEALUSrc, 
            RegDst => DtERegDst, ALUControl => DtEALUControl, RegSrcA => DtERegSrcA, RegSrcB => DtERegSrcB,
            SignImm => DtESignImm, RtDest => DtERtDest, RdDest => DtERdDest, RegWriteOut => ESRegWrite,
            MemtoRegOut => ESMemtoReg, MemWriteOut => ESMemWrite, ALUResult => ESALUResult,
            WriteData => ESWriteData, WriteReg => ESWriteReg);
    
    ExecToMem : entity work.ExecuteToMem
        port map (clk => clk, RegWrite => ESRegWrite, MemtoReg => ESMemtoReg, MemWrite => ESMemWrite,
            ALUResult => ESALUResult, WriteData => ESWriteData, WriteReg => ESWriteReg,
            RegWriteOut => EtMRegWrite, MemtoRegOut => EtMMemtoReg, MemWriteOut => EtMMemWrite,
            WriteRegOut => EtMWriteReg, ALUResultOut => EtMALUResult, WriteDataOut => EtMWriteData);
    
    MemStage : entity work.MemoryStage
        port map (clk => clk, RegWrite => EtMRegWrite, MemtoReg => EtMMemtoReg, MemWrite => EtMMemWrite,
            WriteReg => EtMWriteReg, ALUResult => EtMALUResult, WriteData => EtMWriteData,
            RegWriteOut => MSRegWrite, MemtoRegOut => MSMemtoReg, WriteRegOut => MSWriteReg,
            MemOut => MSMem, ALUResultOut => MSALUResult);
    
    MemToWriteback : entity work.MemToWriteback
        port map (clk => clk, RegWrite => MSRegWrite, MemtoReg => MSMemtoReg, WriteReg => MSWriteReg,
            MemIn => MSMem, ALUResult => MSALUResult,
            RegWriteOut => MtWRegWrite, MemtoRegOut => MtWMemtoReg, ALUResultOut => MtWALUResult,
            ReadData => MtWReadData, WriteRegOut => MtWWriteReg);
            
    Writeback : entity work.WritebackStage
        port map (RegWrite => MtWRegWrite, MemtoReg => MtWMemtoReg, ALUResult => MtWALUResult,
            ReadData => MtWReadData, WriteReg => MtWWriteReg, RegWriteOut => WRegWrite,
            WriteRegOut => WWriteReg, Result => WResult);
            
    WritebackToDecode : entity work.WritebackToDecode
        port map (clk => clk, RegWrite => WRegWrite, WriteReg => WWriteReg, Result => WResult, 
            RegWriteEn => WtDRegWriteEn, RegWriteData => WtDRegWriteData, RegWriteAddr => WtDRegWriteAddr);
    
    ALUResult <= WResult;
end Structural;
