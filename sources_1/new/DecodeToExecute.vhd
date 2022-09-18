-------------------------------------------------
--  File:          DecodeToExecute.vhd
--
--  Entity:        DecodeToExecute
--  Architecture:  behave
--  Author:        Trent Wesley
--  Created:       04/06/22
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 register going from the Decode 
--                 Stage to the Execute Stage 
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DecodeToExecute is
    port (
        clk : in std_logic;
        RegWriteIn, MemtoRegIn, MemWriteIn, ALUSrcIn, RegDstIn : in std_logic;
        ALUControlIn : in std_logic_vector(3 downto 0);
        RD1, RD2, SignImmIn : in std_logic_vector(31 downto 0);
        RtDestIn, RdDestIn : in std_logic_vector(4 downto 0);
        
        RegWriteOut, MemtoRegOut, MemWriteOut, ALUSrcOut, RegDstOut : out std_logic;
        ALUControlOut : out std_logic_vector(3 downto 0);
        RegSrcA, RegSrcB, SignImmOut : out std_logic_vector(31 downto 0);
        RtDestOut, RdDestOut : out std_logic_vector(4 downto 0));
end DecodeToExecute;

architecture behave of DecodeToExecute is
begin
    process (clk) begin
        if rising_edge(clk) then
            RegWriteOut <= RegWriteIn;
            MemtoRegOut <= MemtoRegIn;
            MemWriteOut <= MemWriteIn;
            ALUSrcOut <= ALUSrcIn;
            RegDstOut <= RegDstIn;
            ALUControlOut <= ALUControlIn;
            RegSrcA <= RD1;
            RegSrcB <= RD2;
            SignImmOut <= SignImmIn;
            RtDestOut <= RtDestIn;
            RdDestOut <= RdDestIn;
        end if;
    end process;
end behave;
