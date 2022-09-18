-------------------------------------------------
--  File:          RegisterFile.vhd
--
--  Entity:        RegisterFile
--  Architecture:  idk
--  Author:        Trent Wesley
--  Created:       01/27/22
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 complete register file
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity RegisterFile is
	generic(
		BIT_DEPTH : integer := 32;
		LOG_PORT_DEPTH : integer := 5
	);
    port(
        we, clk_n : in std_logic;
        Addr1, Addr2, Addr3 : in std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
	    wd : in std_logic_vector(BIT_DEPTH-1 downto 0);
	    RD1, RD2 : out std_logic_vector(BIT_DEPTH-1 downto 0));
end RegisterFile;

architecture idk of RegisterFile is
    type reg_io is array (0 to 2**LOG_PORT_DEPTH-1) of std_logic_vector(BIT_DEPTH-1 downto 0);
    signal reg_array : reg_io := (others => (others => '0'));
begin
    write : process (clk_n)
    begin
        if (falling_edge(clk_n) and we='1' and to_integer(unsigned(Addr3))/=0) then
            reg_array(to_integer(unsigned(Addr3))) <= wd;
        end if;
    end process write;
    RD1 <= reg_array(to_integer(unsigned(Addr1)));
    RD2 <= reg_array(to_integer(unsigned(Addr2)));
end;
