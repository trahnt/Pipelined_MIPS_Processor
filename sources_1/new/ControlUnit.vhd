-------------------------------------------------
--  File:          ControlUnit.vhd
--
--  Entity:        ControlUnit
--  Architecture:  idk
--  Author:        Trent Wesley
--  Created:       02/10/22
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 control unit
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ControlUnit is
    port (
        opcode, funct : in std_logic_vector(5 downto 0);
        RegWrite, MemtoReg, MemWrite, ALUSrc, RegDst : out std_logic;
        ALUControl : out std_logic_vector(3 downto 0));
end entity ControlUnit;

architecture idk of ControlUnit is

begin
    ALUC : process (opcode, funct) begin
        if opcode = "000000" then
            if funct = "100000" then --ADD
                ALUControl <= "0100";
            elsif funct = "100100" then --AND
                ALUControl <= "1010";
            elsif funct = "011001" then --MULTU
                ALUControl <= "0110";
            elsif funct = "100101" then --OR
                ALUControl <= "1000";
            elsif funct = "000000" then --SLL
                ALUControl <= "1100";
            elsif funct = "000011" then --SRA
                ALUControl <= "1110";
            elsif funct = "000010" then --SRL
                ALUControl <= "1101";
            elsif funct = "100010" then --SUB
                ALUControl <= "0101";
            else                        --XOR funct:100110
                ALUControl <= "1011";
            end if;
        elsif opcode = "001000" then --ADDI
            ALUControl <= "0100";
        elsif opcode = "001100" then --ANDI
            ALUControl <= "1010";
        elsif opcode = "001101" then --ORI
            ALUControl <= "1000";
        elsif opcode = "001110" then --XORI
            ALUControl <= "1011";
        elsif opcode = "101011" then --SW
            ALUControl <= "0100";
        else                         --LW opcode:100011
            ALUControl <= "0100";
        end if;
    end process ALUC;
    
    ALUSrc <= '0' when opcode="000000" else '1';
    
    RegWrite <= '0' when opcode="101011" else '1';
    
    MemtoReg <= '1' when opcode="100011" else '0';
    
    MemWrite <= '1' when opcode="101011" else '0';
    
    RegDst <= '1' when opcode="000000" else '0';
end;