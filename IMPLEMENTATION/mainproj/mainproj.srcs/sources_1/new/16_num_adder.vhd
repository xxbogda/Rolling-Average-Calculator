


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity adder is


Port (  v0: in std_logic_vector(7 downto 0);
        v1: in std_logic_vector(7 downto 0);
        v2: in std_logic_vector(7 downto 0);
        v3: in std_logic_vector(7 downto 0);
        v4: in std_logic_vector(7 downto 0);
        v5: in std_logic_vector(7 downto 0);
        v6: in std_logic_vector(7 downto 0);
        v7: in std_logic_vector(7 downto 0);
        v8: in std_logic_vector(7 downto 0);
        v9: in std_logic_vector(7 downto 0);
        v10: in std_logic_vector(7 downto 0);
        v11: in std_logic_vector(7 downto 0);
        v12: in std_logic_vector(7 downto 0);
        v13: in std_logic_vector(7 downto 0);
        v14: in std_logic_vector(7 downto 0);
        v15: in std_logic_vector(7 downto 0);
        sum: out std_logic_vector(11 downto 0)

);
end adder;

architecture Behavioral of adder is

type array16x12 is array (0 to 15) of std_logic_vector (11 downto 0);
type array14x12 is array (0 to 13) of std_logic_vector (11 downto 0);


component adder12bit is
    generic(N : integer);
    Port ( a : in STD_LOGIC_VECTOR (N - 1 downto 0);
           b : in STD_LOGIC_VECTOR (N - 1 downto 0);
           cin : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (N - 1 downto 0);
           cout : out STD_LOGIC);
end component;

signal val: array16x12 := (others => "000000000000"); 
signal inter: array14x12 := (others => "000000000000");
begin

    val(0)(7 downto 0) <= v0;
    val(1)(7 downto 0) <= v1;
    val(2)(7 downto 0) <= v2;
    val(3)(7 downto 0) <= v3;
    val(4)(7 downto 0) <= v4;
    val(5)(7 downto 0) <= v5;
    val(6)(7 downto 0) <= v6;
    val(7)(7 downto 0) <= v7;
    val(8)(7 downto 0) <= v8;
    val(9)(7 downto 0) <= v9;
    val(10)(7 downto 0) <= v10;
    val(11)(7 downto 0) <= v11;
    val(12)(7 downto 0) <= v12;
    val(13)(7 downto 0) <= v13;
    val(14)(7 downto 0) <= v14;
    val(15)(7 downto 0) <= v15;

    adders: for i in 0  to 14 generate
        add1: if i <= 7 generate
            a1: adder12bit generic map (N => 12) port map (a => val(2 * i), b => val (2 * i + 1), cin => '0', y => inter(i), cout => open);
        end generate;
        add2: if i >= 8 and i <= 11 generate
            a2: adder12bit generic map (N => 12) port map (a => inter(2 * (i - 8)), b => inter (2 * (i - 8) + 1), cin => '0', y => inter(i), cout => open);
        end generate;
        add3: if i >=12 and i <= 13 generate
            a3: adder12bit generic map (N => 12) port map (a => inter(2 * (i- 8)), b => inter(2 * (i - 8) + 1), cin => '0', y => inter(i), cout => open);
        end generate;
        add4: if i = 14 generate
            a4:adder12bit generic map (N => 12) port map (a => inter(12), b =>inter(13), cin => '0', y => sum, cout => open);
        end generate;
    end generate;

end Behavioral;
