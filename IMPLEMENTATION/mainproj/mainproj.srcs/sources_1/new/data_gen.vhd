library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity data_gen is
    port(   CLK: in std_logic;
           CTRL: in std_logic_vector(2 downto 0);
            VAL: out std_logic_vector(7 downto 0);
           CERR: out std_logic;
        DATACLK: out std_logic);
end entity;

architecture dg_arch of data_gen is
    component clk1hz is
    Port (  clk100: in STD_LOGIC;
            clk1hz: out std_logic);
    end component;
    
    component clk25 is
    Port ( clk1hz : in STD_LOGIC;
            clk25: out std_logic);
    end component;
    
    component stud1 is
    Port ( CLK : in STD_LOGIC;
           SEQ1 : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component stud2 is
    Port ( CLK : in STD_LOGIC;
           SEQ2 : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component prbs4gen is
    Port ( CLK : in STD_LOGIC;
           PRBS4 : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component prbs8gen is
    Port ( CLK : in STD_LOGIC;
           PRBS8 : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal tDCLK:std_logic;
    signal CLOCK25:std_logic;
    signal inDATACLK: std_logic;
    
    signal seq1:std_logic_vector(7 downto 0):="00000000";
    signal seq2:std_logic_vector(7 downto 0):="00000000";
    signal prbs4:std_logic_vector(7 downto 0):="00000000";
    signal prbs8:std_logic_vector(7 downto 0):="00000000";
    
begin

    CLKDIV: clk1hz port map (clk100=>CLK, clk1hz=>tDCLK);
    CLKDIV25: clk25 port map (clk1hz=>tDCLK, clk25=>CLOCK25);
            
    inDATACLK<= CLOCK25 when CTRL="001" else
              tDCLK;
              
    DATACLK<=inDATACLK;
              
    STUD1GEN: stud1 port map (CLK=>inDATACLK, SEQ1=>SEQ1(3 downto 0));
    
    STUD2GEN: stud2 port map (CLK=>inDATACLK, SEQ2=>SEQ2(3 downto 0));
    
    PRBS4generator: prbs4gen port map (CLK=>inDATACLK, PRBS4=>PRBS4(3 downto 0));
    
    PRBS8generator: prbs8gen port map (CLK=>inDATACLK, PRBS8=>PRBS8);

    VAL<= "00000000" when CTRL="000" else
          SEQ1 when CTRL="001" else
          SEQ1 when CTRL="010" else
          SEQ2 when CTRL="011" else
          "00000000" when CTRL="100" else
          "00000000" when CTRL="101" else
          PRBS4 when CTRL="110" else
          PRBS8;
          
    CERR<= '1' when CTRL="100" else
           '1' when CTRL="101" else
           '0';
    
end architecture;