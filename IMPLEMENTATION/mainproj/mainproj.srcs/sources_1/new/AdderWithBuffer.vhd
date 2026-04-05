

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity AdderWithBuffer is
  Port (val: in std_logic_vector(7 downto 0);
        data_clock: in std_logic;
        len: in std_logic_vector(2 downto 0);
        reset: in std_logic;
        BFull: out std_logic;
        Lerr: out std_logic;
        sum: out std_logic_vector(11 downto 0));
end AdderWithBuffer;

architecture Behavioral of AdderWithBuffer is

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

signal v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15: std_logic_vector (7 downto 0);
signal N: std_logic_vector(25 downto 0) := (others => '0');

begin

process(DATA_CLOCK)
begin
    if data_clock'event and data_clock = '1' then
    N <= N + 1;
    end if;
end process;

buf: data_buff port map (len => len, val => val, data_clock => n(25), reset => reset, BFull => BFull, Lerr => Lerr, v0 => v0, v1 => v1, v2 => v2, v3 => v3, v4 => v4, v5 => v5, v6 => v6, v7 => v7, v8 => v8, v9 => v9, v10 => v10, v11 => v11, v12 => v12, v13 => v13, v14 => v14, v15 => v15);
add: adder port map (v0 => v0, v1 => v1, v2 => v2, v3 => v3, v4 => v4, v5 => v5, v6 => v6, v7 => v7, v8 => v8, v9 => v9, v10 => v10, v11 => v11, v12 => v12, v13 => v13, v14 => v14, v15 => v15, sum => sum);

end Behavioral;
