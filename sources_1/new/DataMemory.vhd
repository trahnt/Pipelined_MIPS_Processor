-------------------------------------------------
--  File:          DataMemory.vhd
--
--  Entity:        DataMemory
--  Architecture:  behave
--  Author:        Trent Wesley
--  Created:       03/17/22
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 complete data memory
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity DataMemory is
    generic (WIDTH : integer := 32; ADDR_SPACE : integer := 10);
    port (
        clk, w_en : in std_logic;
        addr : in std_logic_vector(ADDR_SPACE-1 downto 0);
        d_in : in std_logic_vector(WIDTH-1 downto 0);
        d_out : out std_logic_vector(WIDTH-1 downto 0));
end DataMemory;

architecture behave of DataMemory is
    type mem is array ((2**ADDR_SPACE)-1 downto 0) of std_logic_vector(WIDTH-1 downto 0);
    signal mips_mem : mem := (x"00000000", x"11111111", x"22222222", others => x"00000000");
begin
    process (clk) begin
        if (rising_edge(clk) and w_en='1') then
            mips_mem(to_integer(unsigned(addr))) <= d_in;
        end if;
    end process;
    
    d_out <= mips_mem(to_integer(unsigned(addr)));
    
end behave;
