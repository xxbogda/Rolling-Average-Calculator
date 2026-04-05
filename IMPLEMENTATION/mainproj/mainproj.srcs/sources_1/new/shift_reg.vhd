library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg is
    port( CLK: in std_logic;
        RESET: in std_logic;
           PL: in std_logic;
           SR: in std_logic;
          SIN: in std_logic;
          SUM: in std_logic_vector(11 downto 0);
          RES: out std_logic_vector(7 downto 0));
end entity;

architecture sr_arch of shift_reg is
--------- test 
--    component clk1hz is
--    Port ( clk100 : in STD_LOGIC;
--            clk1hz: out std_logic);
--    end component;
--    signal CLOCK:std_logic;
begin
--------- test
--    CLKDIV: clk1hz port map (clk100=>CLK, clk1hz=>CLOCK);
    process(CLK) --
    variable D:std_logic_vector(11 downto 0):=(others=>'0');
    variable Q:std_logic_vector(11 downto 0);
    begin
        D:=SUM;
        if rising_edge(CLK) then --
            if RESET='1' then Q:=(others=>'0');
            elsif PL='1' then Q:=SUM;
            elsif SR='1' then 
                for i in 0 to 10 loop
                Q(i):=Q(i+1);
                end loop;
                Q(11):=SIN;
            end if;
        end if;
        RES<=Q(7 downto 0);
    end process;
end architecture;
