library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EU is
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
end entity;

architecture arch_EU of EU is
    component data_gen is
    port(   CLK: in std_logic;
           CTRL: in std_logic_vector(2 downto 0);
            VAL: out std_logic_vector(7 downto 0);
           CERR: out std_logic;
        DATACLK: out std_logic);
    end component;
    
    component data_buff is
    Port ( 
      len: in std_logic_vector(2 downto 0);
      val: in std_logic_vector(7 downto 0);
      data_clock: in std_logic;
      reset: in std_logic;
      BFull: out std_logic;
      Lerr: out std_logic;
      v0: out std_logic_vector(7 downto 0);
      v1: out std_logic_vector(7 downto 0);
      v2: out std_logic_vector(7 downto 0);
      v3: out std_logic_vector(7 downto 0);
      v4: out std_logic_vector(7 downto 0);
      v5: out std_logic_vector(7 downto 0);
      v6: out std_logic_vector(7 downto 0);
      v7: out std_logic_vector(7 downto 0);
      v8: out std_logic_vector(7 downto 0);
      v9: out std_logic_vector(7 downto 0);
      v10: out std_logic_vector(7 downto 0);
      v11: out std_logic_vector(7 downto 0);
      v12: out std_logic_vector(7 downto 0);
      v13: out std_logic_vector(7 downto 0);
      v14: out std_logic_vector(7 downto 0);
      v15: out std_logic_vector(7 downto 0));
    end component;
    
    component adder is

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
    end component; 
    
    component shift_reg is
    port( CLK: in std_logic;
        RESET: in std_logic;
           PL: in std_logic;
           SR: in std_logic;
          SIN: in std_logic;
          SUM: in std_logic_vector(11 downto 0);
          RES: out std_logic_vector(7 downto 0));
    end component;
    
    component shift_count is
    port(   CLK: in std_logic;
          RESET: in std_logic;
            LEN: in std_logic_vector(2 downto 0);
             CE: in std_logic; -- SR in port map
             NS: out std_logic);
    end component;
    
    component hold_reg is
    port( CLK: in std_logic;
          RES: in std_logic_vector(7 downto 0);
           PL: in std_logic;
          AVG: out std_logic_vector(7 downto 0));
    end component;
    
    component ssd is
    Port ( clk : in STD_LOGIC;
           Zerr : in STD_LOGIC;
           avg: in std_logic_vector(7 downto 0);
           val: in std_logic_vector(7 downto 0);
           BFull: in std_logic;
           an: out std_logic_vector(3 downto 0);
           cat: out std_logic_vector (6 downto 0));
           
    end component; 
    
    signal CERR: std_logic; -- error signals
    signal LERR: std_logic;
    signal ZERR: std_logic;
    
    signal VAL: std_logic_vector(7 downto 0); -- value transmission signals
    signal V0:std_logic_vector(7 downto 0);
    signal V1:std_logic_vector(7 downto 0);
    signal V2:std_logic_vector(7 downto 0);
    signal V3:std_logic_vector(7 downto 0);
    signal V4:std_logic_vector(7 downto 0);
    signal V5:std_logic_vector(7 downto 0);
    signal V6:std_logic_vector(7 downto 0);
    signal V7:std_logic_vector(7 downto 0);
    signal V8:std_logic_vector(7 downto 0);
    signal V9:std_logic_vector(7 downto 0);
    signal V10:std_logic_vector(7 downto 0);
    signal V11:std_logic_vector(7 downto 0);
    signal V12:std_logic_vector(7 downto 0);
    signal V13:std_logic_vector(7 downto 0);
    signal V14:std_logic_vector(7 downto 0);
    signal V15:std_logic_vector(7 downto 0); 
    
    signal SUM: std_logic_vector(11 downto 0); -- result intermediary signals
    signal RES: std_logic_vector(7 downto 0);
    signal AVG: std_logic_vector(7 downto 0);
    
    signal DATACLK: std_logic;
    
    signal inBF:std_logic;
begin
    DATAGEN: data_gen port map (CLK=>CLK, CTRL=>CTRL, VAL=>VAL, CERR=>CERR, DATACLK=>DATACLK);
    
    DATABUFFR: data_buff port map (len=>LEN, val=>VAL, data_clock=>DATACLK, reset=>RESET, BFull=>inBF, Lerr=>LERR, v0=>V0, v1=>V1, v2=>V2, v3=>V3, v4=>V4, v5=>V5, v6=>V6, v7=>V7, v8=>V8, v9=>V9, v10=>V10, v11=>V11, v12=>V12, v13=>V13, v14=>V14, v15=>V15);
    BF<=inBF;
    
    ADDR: adder port map (v0=>V0, v1=>V1, v2=>V2, v3=>V3, v4=>V4, v5=>V5, v6=>V6, v7=>V7, v8=>V8, v9=>V9, v10=>V10, v11=>V11, v12=>V12, v13=>V13, v14=>V14, v15=>V15, sum=>SUM);
    
    SHIFTREG: shift_reg port map (CLK=>CLK, RESET=>RESET, PL=>PL, SR=>SR, SIN=>'1', SUM=>SUM, RES=>RES);
    
    SHIFTCOUNT: shift_count port map (CLK=>CLK, RESET=>RESET, LEN=>LEN, CE=>SR, NS=>NS);
    
    HOLDREG: hold_reg port map (CLK=>CLK, RES=>RES, PL=>LOAD, AVG=>AVG);
    
    ERR: ZERR<= LERR or CERR;
    SSDDEC: ssd port map (clk=>CLK, Zerr=>ZERR, avg=>AVG, val=>VAL, Bfull=>inBF, an=>AN, cat=>CAT);

end architecture;
