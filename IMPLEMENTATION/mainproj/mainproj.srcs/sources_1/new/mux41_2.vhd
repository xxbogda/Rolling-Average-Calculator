library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux41_2 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           y : out STD_LOGIC);
end mux41_2;

architecture Behavioral of mux41_2 is

begin
process(a, sel)
begin
    if sel = "00" then
        y <= a(0);
    elsif sel = "01" then
        y <= a(1);
    elsif sel = "10" then
        y <= a(2);
    elsif sel = "11" then
        y <= a(3);
    else y <= 'Z';
    end if;
end process;

end Behavioral;