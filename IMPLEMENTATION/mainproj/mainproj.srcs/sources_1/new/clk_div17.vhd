

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity clk_div_16 is
    Port ( clk : in STD_LOGIC;
            clk16: out std_logic);
end clk_div_16;

architecture Behavioral of clk_div_16 is
signal N: std_logic_vector(15 downto 0);
begin
process(clk)
begin
    if clk'event and clk = '1' then
        N <= N + 1;
    end if;
    clk16 <= N(15);    
end process;
end Behavioral;
