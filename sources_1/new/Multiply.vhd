-------------------------------------------------
--  File:          Multiply.vhd
--
--  Entity:        Multiply
--  Architecture:  behave
--  Author:        Trent Wesley
--  Created:       02/24/22
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of an
--                 N bit multiplier
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiply is
    generic (N : integer := 32);
    port (
        a : in std_logic_vector(N/2-1 downto 0);
        b : in std_logic_vector(N/2-1 downto 0);
        Product : out std_logic_vector(N-1 downto 0));
end Multiply;

architecture behave of Multiply is
    type and_array is array(N/2-1 downto 0) of std_logic_vector(N/2-1 downto 0);
    type sum_array is array(N/2-2 downto 0) of std_logic_vector(N/2 downto 0);
    type cout_array is array(N/2-2 downto 0) of std_logic_vector(N/2-2 downto 0);
    signal ands : and_array;
    signal sums : sum_array;
    signal couts : cout_array; 
begin
    rows : for row in 0 to N/2-1 generate 
        cols : for col in 0 to N/2-1 generate 
            ands(row)(col) <= a(row) and b(col);
        end generate cols;
    end generate rows;
    
    sum_gen_row0 : for col in 0 to N/2-1 generate
        ls_fa_r0 : if col=0 generate
            fa : entity work.FullAdder
                port map (a => ands(0)(col+1), b => ands(1)(col), cin => '0',
                    sum => sums(0)(col), cout => couts(0)(col));
        end generate ls_fa_r0;
        mid_fa_r0 : if col>0 and col<N/2-1 generate
            fa : entity work.FullAdder
                    port map (a => ands(0)(col+1), b => ands(1)(col), cin => couts(0)(col-1),
                        sum => sums(0)(col), cout => couts(0)(col));
        end generate mid_fa_r0;
        ms_fa_r0 : if col=N/2-1 generate
            fa : entity work.FullAdder
                    port map (a => '0', b => ands(1)(col), cin => couts(0)(col-1),
                        sum => sums(0)(col), cout => sums(0)(col+1));
        end generate ms_fa_r0;
    end generate sum_gen_row0;
    
    sum_gen_rows : for row in 1 to N/2-2 generate
        sum_gen_cols : for col in 0 to N/2-1 generate
            ls_fa : if col=0 generate
                fa : entity work.FullAdder
                    port map (a => sums(row-1)(col+1), b => ands(row+1)(col), cin => '0',
                        sum => sums(row)(col), cout => couts(row)(col));
            end generate ls_fa;
            mid_fa : if col>0 and col<N/2-1 generate
                fa : entity work.FullAdder 
                    port map (a => sums(row-1)(col+1), b => ands(row+1)(col), cin => couts(row)(col-1),
                        sum => sums(row)(col), cout => couts(row)(col));
            end generate mid_fa;
            ms_fa : if col=N/2-1 generate
                fa : entity work.FullAdder 
                    port map (a => sums(row-1)(col+1), b => ands(row+1)(col), cin => couts(row)(col-1),
                        sum => sums(row)(col), cout => sums(row)(col+1));
            end generate ms_fa;
        end generate sum_gen_cols;
    end generate sum_gen_rows;

    Product(N-1 downto N/2-1) <= sums(N/2-2);
    Product(0) <= ands(0)(0);
    Product_gen : for i in 1 to N/2-2 generate
        Product(i) <= sums(i-1)(0);
    end generate Product_gen;
end;
