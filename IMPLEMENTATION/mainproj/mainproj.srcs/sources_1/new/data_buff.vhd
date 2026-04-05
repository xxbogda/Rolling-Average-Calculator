


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity data_buff is
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
end data_buff;

architecture Behavioral of data_buff is

component registers is
    Generic(N: integer := 4);
    Port ( clk : in STD_LOGIC;
           load : in STD_LOGIC_VECTOR (N - 1 downto 0);
           ld : in STD_LOGIC;
           reset: in STD_LOGIC;
           ce: in std_logic;
           q: out std_logic_vector(N-1 downto 0));
end component;

component mux41_2 is
    Port ( 
           a : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           y : out STD_LOGIC);
end component;

component generic_or is
    generic (N: INTEGER := 8);
    Port ( 
    a: in std_logic_vector (N-1 downto 0);
    y: out std_logic);
end component;

signal r: std_logic_vector (15 downto 0);
signal a: std_logic_vector(15 downto 0);
signal ld: std_logic_vector (15 downto 0);

type arr16x8 is array (15 downto 0) of std_logic_vector (7 downto 0);
signal q: arr16x8;

signal bf: std_logic_vector (3 downto 0);


begin

a(0) <= '0';
a(1) <= '0';
a(2) <= '1' when len(1 downto 0) = "00" else '0';
a(3) <= '1' when len(1 downto 0) = "00" else '0';
a(4) <= '1' when len(1 downto 0) = "00" or len (1 downto 0) = "01" else '0';
a(5) <= '1' when len(1 downto 0) = "00" or len (1 downto 0) = "01" else '0';
a(6) <= '1' when len(1 downto 0) = "00" or len (1 downto 0) = "01" else '0';
a(7) <= '1' when len(1 downto 0) = "00" or len (1 downto 0) = "01" else '0';
a(8) <= '0' when len(1 downto 0) = "11" else '1';
a(9) <= '0' when len(1 downto 0) = "11" else '1';
a(10) <= '0' when len(1 downto 0) = "11" else '1';
a(11) <= '0' when len(1 downto 0) = "11" else '1';
a(12) <= '0' when len(1 downto 0) = "11" else '1';
a(13) <= '0' when len(1 downto 0) = "11" else '1';
a(14) <= '0' when len(1 downto 0) = "11" else '1';
a(15) <= '0' when len(1 downto 0) = "11" else '1';

process(a, reset)
begin
    for i in 0 to 15 loop
        r(i) <= a(i) or reset;
    end loop;
end process;

process(r)
begin
    for i in 0 to 15 loop
        ld(i) <= not a(i);
    end loop;
end process;

registers16: for i in 0 to 15 generate
    r1: if i = 0 generate
        reg1: registers generic map (N => 8) port map (clk => data_clock, load => val, ld => ld(i), reset => r(i), ce => len(2), q => q(i));
    end generate;
    r2: if i > 0 generate
        reg2to15: registers generic map (N => 8) port map (clk => data_clock, load =>q(i - 1), ld => ld(i), reset => r(i), ce => len(2), q => q(i));
    end generate;
end generate;

bf(0) <= '0' when q(1) = x"00" else '1';
bf(1) <= '0' when q(3) = x"00" else '1';
bf(2) <= '0' when q(7) = x"00" else '1';
bf(3) <= '0' when q(15) = x"00" else '1';

mux: mux41_2 port map (a => bf, sel => len(1 downto 0), y => BFull);

v0 <= q(0);
v1 <= q(1);
v2 <= q(2);
v3 <= q(3);
v4 <= q(4);
v5 <= q(5);
v6 <= q(6);
v7 <= q(7);
v8 <= q(8);
v9 <= q(9);
v10 <= q(10);
v11 <= q(11);
v12 <= q(12);
v13 <= q(13);
v14 <= q(14);
v15 <= q(15);

Lerr <= (len(0) or len(1)) and (not len(2));

end Behavioral;