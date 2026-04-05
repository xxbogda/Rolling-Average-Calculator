


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ssd is
    Port ( clk : in STD_LOGIC;
           Zerr : in STD_LOGIC;
           avg: in std_logic_vector(7 downto 0);
           val: in std_logic_vector(7 downto 0);
           BFull: in std_logic;
           an: out std_logic_vector(3 downto 0);
           cat: out std_logic_vector (6 downto 0));
           
end ssd;

architecture Behavioral of ssd is

signal clock: std_logic;
component clk_div_16 is
    Port ( clk : in STD_LOGIC;
            clk16: out std_logic);
end component;

signal nr: std_logic_vector(1 downto 0) := "00";
signal N: std_logic_vector (3 downto 0);
begin

c1: clk_div_16 port map (clk => clk, clk16 => clock);

process(clock)
begin
    if clock'event and clock = '1' then
        nr <= nr + 1;
    end if;
end process;

an <= "1110" when nr = "00" 
    else "1101" when nr = "01"
    else "1011" when nr = "10"
    else "0111";

N <= avg(3 downto 0) when nr = "00"
    else avg(7 downto 4) when nr = "01"
    else val(3 downto 0) when nr = "10"
    else val(7 downto 4);
    
cat<= "0111111" when Zerr = '1'
    else "1110110" when Bfull = '0' and (nr = "00" or nr = "01")
    else "1000000" when N="0000"
    else "1111001" when N="0001"
    else "0100100" when N="0010"
    else "0110000" when N="0011"
    else "0011001" when N="0100"
    else "0010010" when N="0101"
    else "0000010" when N="0110"
    else "1111000" when N="0111"
    else "0000000" when N="1000"
    else "0010000" when N="1001"
    else "0001000" when N="1010"
    else "0000011" when N="1011"
    else "1000110" when N="1100"
    else "0100001" when N="1101"
    else "0000110" when N="1110"
    else "0001110";
end Behavioral;
