library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hold_reg is
    port( CLK: in std_logic;
          RES: in std_logic_vector(7 downto 0);
           PL: in std_logic;
          AVG: out std_logic_vector(7 downto 0));
end entity;

architecture Behavioral of hold_reg is
begin
    process(CLK)
    variable Q:std_logic_vector(7 downto 0):=(others=>'0');
    begin
        if rising_edge(CLK) then
            if PL='1' then Q:=RES;
            end if;
        end if;
        AVG<=Q;
    end process;
end architecture;
