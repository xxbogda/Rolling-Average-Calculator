library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder3bit is
    port(   D: in std_logic_vector(2 downto 0);
            Q: out std_logic_vector(7 downto 0));
end entity;

architecture Behavioral of decoder3bit is
begin
    Q<= "00000001" when D="000" else
        "00000010" when D="001" else
        "00000100" when D="010" else
        "00001000" when D="011" else
        "00010000" when D="100" else
        "00100000" when D="101" else
        "01000000" when D="110" else
        "10000000";
end architecture;
