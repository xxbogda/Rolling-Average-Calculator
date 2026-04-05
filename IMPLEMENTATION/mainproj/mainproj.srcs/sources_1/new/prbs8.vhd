library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity prbs8gen is
    Port ( CLK : in STD_LOGIC;
           PRBS8 : out STD_LOGIC_VECTOR (7 downto 0));
end entity;
    
architecture Behavioral of prbs8gen is
    component D_FF is
    port(CLK: in std_logic;
         D: in std_logic;
         Q: out std_logic;
         R: in std_logic;
         S: in std_logic);
    end component;
    
    signal d7:std_logic;
    signal q7:std_logic;
    signal q6:std_logic;
    signal q5:std_logic;
    signal q4:std_logic;
    signal q3:std_logic;
    signal q2:std_logic;
    signal q1:std_logic;
    signal q0:std_logic;
begin
    d7<= q0 xnor q2 xnor q3 xnor q4;
    DFF7: D_FF port map (CLK=>CLK, D=>d7, Q=>q7, R=>'1', S=>'1');
    DFF6: D_FF port map (CLK=>CLK, D=>q7, Q=>q6, R=>'1', S=>'1');
    DFF5: D_FF port map (CLK=>CLK, D=>q6, Q=>q5, R=>'1', S=>'1');
    DFF4: D_FF port map (CLK=>CLK, D=>q5, Q=>q4, R=>'1', S=>'1');
    DFF3: D_FF port map (CLK=>CLK, D=>q4, Q=>q3, R=>'1', S=>'1');
    DFF2: D_FF port map (CLK=>CLK, D=>q3, Q=>q2, R=>'1', S=>'1');
    DFF1: D_FF port map (CLK=>CLK, D=>q2, Q=>q1, R=>'1', S=>'1');
    DFF0: D_FF port map (CLK=>CLK, D=>q1, Q=>q0, R=>'1', S=>'1');
    PRBS8<=(q7,q6,q5,q4,q3,q2,q1,q0);
end architecture;