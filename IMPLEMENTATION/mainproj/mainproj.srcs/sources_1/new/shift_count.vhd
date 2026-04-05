library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity shift_count is
    port(   CLK: in std_logic;
          RESET: in std_logic;
            LEN: in std_logic_vector(2 downto 0);
             CE: in std_logic; -- SR in port map
             NS: out std_logic);
end entity;

architecture Behavioral of shift_count is
    signal Q: std_logic_vector(2 downto 0):=(others=>'0');
    signal link:std_logic_vector(7 downto 0);
    signal RST:std_logic;
    
    component mux41 is
    port(  I: in std_logic_vector(3 downto 0);
           S: in std_logic_vector(1 downto 0);
           Z: out std_logic);
    end component;
    
    component decoder3bit 
    port(   D: in std_logic_vector(2 downto 0);
            Q: out std_logic_vector(7 downto 0));
    end component;
    
    signal inNS:std_logic;
    
--------- test 
--    component clk1hz is
--    Port ( clk100 : in STD_LOGIC;
--            clk1hz: out std_logic);
--    end component;
--    signal CLOCK:std_logic;
begin
--------- test
--    CLKDIV: clk1hz port map (clk100=>CLK, clk1hz=>CLOCK);
    NS<=inNS;
    RST<=RESET or inNS;
    COUNTER: process(CLK)
    variable Qi: std_logic_vector(2 downto 0):=(others=>'0');
    begin
        if rising_edge(CLK) then
            if RST='1' then Qi:=(others=>'0');
            elsif CE='1' then Qi:=Q+1;
            end if;
        end if;
        Q<=Qi;
    end process;
    
    DECODER: decoder3bit port map (D=>Q,Q=>link);
    
    MUX: mux41 port map (I=>link(4 downto 1), S=>LEN(1 downto 0), Z=>inNS);
end architecture;
