library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU is
    port(   CLK: in std_logic;
          RESET: in std_logic;
             BF: in std_logic;
             NS: in std_logic;
             ST: out std_logic_vector(1 downto 0); -- for testing
           LOAD: out std_logic;
             PL: out std_logic;
             SR: out std_logic);
end entity;

architecture arch_CU of CU is
    signal inST:std_logic_vector(1 downto 0):="00"; -- if not testing change inST to ST
    
--------- test 
--    component clk1hz is
--    Port ( clk100 : in STD_LOGIC;
--            clk1hz: out std_logic);
--    end component;
--    signal CLOCK:std_logic;
begin
--------- test
--    CLKDIV: clk1hz port map (clk100=>CLK, clk1hz=>CLOCK);
    STATE_MACHINE: process(CLK)
    begin
        if rising_edge(CLK) then
            if RESET='1' then inST<="00"; PL<='0'; SR<='0'; LOAD<='0';
            elsif inST="00" then inST<="01"; PL<='0'; SR<='0'; LOAD<='0';
            elsif inST="01" then
                if BF='1' then PL<='1'; inST<="10"; SR<='0'; LOAD<='0';
                else inST<="01"; PL<='0'; SR<='0'; LOAD<='0';
                end if;
            elsif inST="10" then 
                if NS='1' then LOAD<='1'; inST<="01"; PL<='0'; SR<='0';
                else SR<='1'; inST<="10"; PL<='0'; LOAD<='0';
                end if;
            end if;
        end if;
    end process;
    ST<=inST;
end architecture;
