-------------------------------------------------
--  File:          AddSub.vhd
--
--  Entity:        AddSub
--  Architecture:  behave
--  Author:        Trent Wesley
--  Created:       02/24/22
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of an
--                 N bit Adder/Subtracter
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AddSub is
    generic(N : integer := 32);
    port(
        a : in std_logic_vector(N-1 downto 0);
        b : in std_logic_vector(N-1 downto 0);
        control : in std_logic;
        y : out std_logic_vector(N-1 downto 0));
end AddSub;

architecture behave of AddSub is
    signal cout : std_logic_vector(N-1 downto 0);
begin
    fa_gen : for i in 0 to N-1 generate 
        ls_fa : if i=0 generate
            fa : entity work.FullAdder port map (
                a => a(i), b => b(i) xor control, cin => control, 
                sum => y(i), cout => cout(i));
        end generate ls_fa;
        
        middle_fa : if i>0 and i<N-1 generate
            fa : entity work.FullAdder port map (
                a => a(i), b => b(i) xor control, cin => cout(i-1), 
                sum => y(i), cout => cout(i));
        end generate middle_fa;
        
        ms_fa : if i=N-1 generate
            fa : entity work.FullAdder port map (
                a => a(i), b => b(i) xor control, cin => cout(i-1), 
                sum => y(i), cout => cout(i));
        end generate ms_fa;
    end generate fa_gen;
end;
