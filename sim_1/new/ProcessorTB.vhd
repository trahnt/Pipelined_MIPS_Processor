-------------------------------------------------
--  File:          ProcessorTB.vhd
--
--  Entity:        ProcessorTB
--  Architecture:  tb
--  Author:        Trent Wesley
--  Created:       04/12/22
--  VHDL'93
--  Description:   The following is a testbench for 
--                 the full MIPS Processor
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.finish;

entity ProcessorTB is
end ProcessorTB;

architecture tb of ProcessorTB is
    signal clk, rst : std_logic := '1';
    signal ALUResult : std_logic_vector(31 downto 0);
begin
    processor : entity work.Processor
        port map (clk_in => clk, rst => rst, ALUResult => ALUResult);
    
    clk <= not clk after 4 ns;
    
    test : process begin 
        wait for 80 ns;
        rst <= '0';
        wait for 2000 ns;
        report "Testbench Concluded";
        finish;
    end process;
    
    process (clk) begin 
        if falling_edge(clk) then
            report "ALUResult = " & to_hstring(ALUResult) & " at time " & time'image(now);
        end if;
    end process;
end tb;
