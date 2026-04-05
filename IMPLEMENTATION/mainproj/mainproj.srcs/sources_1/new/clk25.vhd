library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity clk25 is
    Port ( clk1hz : in STD_LOGIC;
            clk25: out std_logic);
end entity;

architecture arch_clk25 of clk25 is
    signal n: std_logic_vector(1 downto 0):=(others=>'0');
begin
    process(clk1hz)
    begin
        if rising_edge(clk1hz) then
            n<=n+1;
        end if;
        clk25<=n(1);
    end process;
end architecture;