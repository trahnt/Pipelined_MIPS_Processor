-------------------------------------------------
--  File:          InstructionDecode.vhd
--
--  Entity:        InstructionDecode
--  Architecture:  decode
--  Author:        Trent Wesley
--  Created:       02/22/22
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of the
--                 complete Instruction Decode stage
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity InstructionDecode is
    port(
        clk, RegWriteEn : in std_logic;
        Instruction, RegWriteData : in std_logic_vector(31 downto 0);
        RegWriteAddr : in std_logic_vector(4 downto 0);
        RegWrite, MemtoReg, MemWrite, ALUSrc, RegDst : out std_logic;
        ALUControl : out std_logic_vector(3 downto 0);
        RD1, RD2, ImmOut : out std_logic_vector(31 downto 0);
        RtDest, RdDest : out std_logic_vector(4 downto 0));
end InstructionDecode;

architecture decode of InstructionDecode is

begin
    CUnit : entity work.ControlUnit
        port map (opcode => Instruction(31 downto 26), funct => Instruction(5 downto 0),
                RegWrite => RegWrite, MemtoReg => MemtoReg, MemWrite => MemWrite,
                ALUControl => ALUControl, ALUSrc => ALUSrc, RegDst => RegDst);
    
    RegFile : entity work.RegisterFile
        port map (clk_n => clk, we => RegWriteEn, Addr1 => Instruction(25 downto 21),
            Addr2 => Instruction(20 downto 16), Addr3 => RegWriteAddr, 
            wd => RegWriteData, RD1 => RD1, RD2 => RD2);
    
    RtDest <= Instruction(20 downto 16);
    RdDest <= Instruction(15 downto 11);
    
    
    ImmOutProc : process (Instruction) begin
        ImmOut(15 downto 0) <= Instruction(15 downto 0);
        if (Instruction(15) = '0') then
            ImmOut(31 downto 16) <= (others => '0');
        else
            ImmOut(31 downto 16) <= (others => '1');
        end if;
    end process ImmOutProc;
end;
