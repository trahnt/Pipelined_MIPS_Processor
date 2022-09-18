------------------------------------------------------
-- Company: Rochester Institute of Technology (RIT)
-- Engineer: Trent Wesley taw8452@rit.edu
--
-- Create Date: 1/13/2022
-- Design Name: sraN
-- Module Name: sraN - behavioral
-- Project Name: Lab 1
-- Target Devices: Basys3
--
-- Description: Shift Right Arithmetic with N bit width and M shift bits
------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sraN is
    GENERIC (N : INTEGER := 32; --bit width
            M : INTEGER := 5); --shift bits
            
        PORT (
            A : IN std_logic_vector(N-1 downto 0);
            SHIFT_AMT : IN std_logic_vector(M-1 downto 0);
            Y : OUT std_logic_vector(N-1 downto 0)
        );
end sraN;

architecture behavioral of sraN is
  -- create array of vectors to hold each of n shifters
    type shifty_array is array(N-1 downto 0) of std_logic_vector(N-1 downto 0);
    signal aSRA : shifty_array;
begin
    generateSRL: for i in 0 to N-1 generate
        aSRA(i)(N-1-i downto 0) <= A(N-1 downto i);
        left_fill: if i > 0 generate
            aSRA(i)(N-1 downto N-i) <= (others => '0') when (A(N-1) = '0') else
                                       (others => '1');            
        end generate left_fill;
    end generate generateSRL;

-- The value of shift_amt (in binary) determines number of bits A is shifted.
-- Since shift_amt (in decimal) must not exceed n-1 so only M bits are 
-- used. The default or N=4,
-- will require 2 shift bits (M=2), because 2^2 = 4, the maximum shift.
-- In all cases , 2^M = N.
Y <= aSRA(to_integer(unsigned(SHIFT_AMT)));

end behavioral;
