library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FF is
    port(CLK: in std_logic;
         D: in std_logic;
         Q: out std_logic;
         R: in std_logic;
         S: in std_logic);
end D_FF;

architecture Behavioral of D_FF is
begin
    process(CLK)
    begin
        if CLK'EVENT and CLK='1' then 
            if R='0' then Q<='0';
                elsif S='0' then Q<='1';
                else Q<=D;
            end if;
        end if;
    end process;
    
    
end Behavioral;
