


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity full_adder_1bit is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           y : out STD_LOGIC;
           cout : out STD_LOGIC);
end full_adder_1bit;

architecture Behavioral of full_adder_1bit is

begin
    y <= a xor b xor cin;
    cout <= (a and b) or (a and cin) or (b and cin);

end Behavioral;
