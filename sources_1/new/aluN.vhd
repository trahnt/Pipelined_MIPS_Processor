-------------------------------------------------
--  File:          aluN.vhd
--
--  Entity:        aluN
--  Architecture:  structural
--  Author:        Trent Wesley
--  Created:       02/24/22
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of an
--                 N bit ALU
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity aluN is
    generic (N : integer := 32;
             M : integer := 5);
    port (
        in1 : IN std_logic_vector(N-1 downto 0);
        in2 : IN std_logic_vector(N-1 downto 0);
        control : IN std_logic_vector(3 downto 0);
        out1 : OUT std_logic_vector(N-1 downto 0));
end aluN;

architecture structural of aluN is
    signal addsub_result : std_logic_vector(N-1 downto 0);
    signal sll_result : std_logic_vector(N-1 downto 0);
    signal srl_result : std_logic_vector(N-1 downto 0);
    signal sra_result : std_logic_vector(N-1 downto 0);
    signal mul_result : std_logic_vector(N-1 downto 0);
begin
    addSub : entity work.AddSub
        port map (a => in1, b => in2, control => control(0), y => addsub_result);
    
    sllN : entity work.sllN
        port map (A => in1, SHIFT_AMT => in2(M-1 downto 0), Y => sll_result);
        
    srlN : entity work.srlN
        port map (A => in1, SHIFT_AMT => in2(M-1 downto 0), Y => srl_result);
    
    sraN : entity work.sraN
        port map (A => in1, SHIFT_AMT => in2(M-1 downto 0), Y => sra_result);
        
      multuN : entity work.Multiply
          port map (a => in1(N/2-1 downto 0), b => in2(N/2-1 downto 0), Product => mul_result);

    with control select
    out1 <= addsub_result when "0100",  -- ADD
         addsub_result when "0101",     -- SUB
         mul_result when "0110",        -- MULTU
         in1 and in2 when "1010",       -- AND
         in1 or in2 when "1000",        -- OR
         in1 xor in2 when "1011",       -- XOR 
         sll_result when "1100",        -- SLL
         srl_result when "1101",        -- SRL 
         sra_result when "1110",        -- SRA
         (others => '0') when others;
end;
