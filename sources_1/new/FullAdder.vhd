-------------------------------------------------
--  File:          FullAdder.vhd
--
--  Entity:        FullAdder
--  Architecture:  dataflow
--  Author:        Trent Wesley
--  Created:       02/24/22
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 Full Adder
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    port(
        a : in std_logic;
        b : in std_logic;
        cin : in std_logic;
        sum : out std_logic;
        cout : out std_logic);
end FullAdder;

architecture dataflow of FullAdder is

begin
    sum <= a xor b xor cin;
    cout <= ((a xor b) and cin) or (a and b);
end ;
