library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    port(   CLK: in std_logic;
            RST: in std_logic;
            LEN: in std_logic_vector(2 downto 0);
           CTRL: in std_logic_vector(2 downto 0);
            CAT: out std_logic_vector(6 downto 0);
             AN: out std_logic_vector(3 downto 0);
             ST: out std_logic_vector(1 downto 0)); -- for state display
end entity;

architecture main_arch of main is
    component CU is
    port(   CLK: in std_logic;
          RESET: in std_logic;
             BF: in std_logic;
             NS: in std_logic;
           LOAD: out std_logic;
             PL: out std_logic;
             SR: out std_logic;
             ST: out std_logic_vector(1 downto 0)); -- for state display
    end component;
    
    component EU is
    port(   CLK: in std_logic;
          RESET: in std_logic;
            LEN: in std_logic_vector(2 downto 0);
           CTRL: in std_logic_vector(2 downto 0);
           LOAD: in std_logic;
             PL: in std_logic;
             SR: in std_logic;
             BF: out std_logic;
             NS: out std_logic;
            CAT: out std_logic_vector(6 downto 0);
             AN: out std_logic_vector(3 downto 0));
    end component;
    
    component debouncer is
    port( button,CLK: in std_logic;
             BTN_DB: out std_logic);
    end component;
    
    signal RESET: std_logic;
    signal LOAD: std_logic;
    signal PL: std_logic;
    signal SR: std_logic;
    signal BF: std_logic;
    signal NS: std_logic;
begin
    
    RSTDEB: debouncer port map(button=>RST, CLK=>CLK, BTN_DB=>RESET);
    COMMAND_UNIT: CU port map (CLK=>CLK, RESET=>RESET, BF=>BF, NS=>NS, LOAD=>LOAD, PL=>PL, SR=>SR);
    
    EXECUTION_UNIT: EU port map (CLK=>CLK, RESET=>RESET, LEN=>LEN, CTRL=>CTRL, LOAD=>LOAD, PL=>PL, SR=>SR, BF=>BF, NS=>NS, CAT=>CAT, AN=>AN);
end main_arch;
