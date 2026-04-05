library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity stud1 is
    Port ( CLK : in STD_LOGIC;
           SEQ1 : out STD_LOGIC_VECTOR (3 downto 0));
end stud1;

architecture Behavioral of stud1 is
    signal REG1: std_logic_vector(3 downto 0):="0111"; -- 1 3 5 6 8 7
    signal REG2: std_logic_vector(3 downto 0):="1000";
    signal REG3: std_logic_vector(3 downto 0):="0110";
    signal REG4: std_logic_vector(3 downto 0):="0011";
    signal REG5: std_logic_vector(3 downto 0):="0101";
    signal REG6: std_logic_vector(3 downto 0):="0001";
begin
    process(CLK)
        variable t:std_logic_vector(3 downto 0);
    begin
        if rising_edge(CLK) then 
            SEQ1<=REG1;
            t:=REG1;
            REG1<=REG2;
            REG2<=REG3;
            REG3<=REG4;
            REG4<=REG5;
            REG5<=REG6;
            REG6<=t;
        end if;
    end process;
end Behavioral;
