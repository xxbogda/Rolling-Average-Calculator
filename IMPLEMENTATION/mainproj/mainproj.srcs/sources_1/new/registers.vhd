


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity registers is
Generic(N: integer := 4);
    Port ( clk : in STD_LOGIC;
           load : in STD_LOGIC_VECTOR (N - 1 downto 0);
           ld : in STD_LOGIC;
           reset: in STD_LOGIC;
           ce: in std_logic;
           q: out std_logic_vector(N-1 downto 0));
end registers;

architecture Behavioral of registers is

begin

process(clk)
begin
if clk'event and clk = '1' and ce = '1' then
    if reset = '1' then 
        q <= (others => '0');
    elsif ld = '1' then
        q <= load;
    end if;
end if;
end process;

end Behavioral;
