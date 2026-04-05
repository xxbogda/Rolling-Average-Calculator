library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux41 is
    port(  I: in std_logic_vector(3 downto 0);
           S: in std_logic_vector(1 downto 0);
           Z: out std_logic);
end entity;

architecture Behavioral of mux41 is
begin
    Z<= I(0) when S="00" else
        I(1) when S="01" else
        I(2) when S="10" else
        I(3);
end architecture;
