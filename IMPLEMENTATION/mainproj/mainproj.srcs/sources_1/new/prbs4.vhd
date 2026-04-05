library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity prbs4gen is
    Port ( CLK : in STD_LOGIC;
           PRBS4 : out STD_LOGIC_VECTOR (3 downto 0));
end entity;
    
architecture Behavioral of prbs4gen is
    component D_FF is
    port(CLK: in std_logic;
         D: in std_logic;
         Q: out std_logic;
         R: in std_logic;
         S: in std_logic);
    end component;
    
    signal d3:std_logic;
    signal q3:std_logic:='0';
    signal q2:std_logic:='0';
    signal q1:std_logic:='0';
    signal q0:std_logic:='0';
begin
    d3<= '1' when q3='0' and q2='0' and q1='0'and q0='0' else 
         q1 xor q0;
    DFF3: D_FF port map (CLK=>CLK, D=>d3, Q=>q3, R=>'1', S=>'1');
    DFF2: D_FF port map (CLK=>CLK, D=>q3, Q=>q2, R=>'1', S=>'1');
    DFF1: D_FF port map (CLK=>CLK, D=>q2, Q=>q1, R=>'1', S=>'1');
    DFF0: D_FF port map (CLK=>CLK, D=>q1, Q=>q0, R=>'1', S=>'1');
    PRBS4<=(q3,q2,q1,q0);
end architecture;