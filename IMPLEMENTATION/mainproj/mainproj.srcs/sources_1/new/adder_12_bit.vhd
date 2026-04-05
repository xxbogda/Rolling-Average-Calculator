----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2025 01:25:25 PM
-- Design Name: 
-- Module Name: adder_4bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder12bit is
    generic(N : integer := 8);
    Port ( a : in STD_LOGIC_VECTOR (N - 1 downto 0);
           b : in STD_LOGIC_VECTOR (N - 1 downto 0);
           cin : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (N - 1 downto 0);
           cout : out STD_LOGIC);
end adder12bit;

architecture Behavioral of adder12bit is

component full_adder_1bit is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           y : out STD_LOGIC;
           cout : out STD_LOGIC);
end component;
signal carry: std_logic_vector(0 to N-1);
begin
  adder1: if N > 0 generate 
    c1: full_adder_1bit port map(a => a(0), b => b(0), cin => cin, y =>y(0), cout => carry(0));
    end generate adder1;
 adders: for I in 1 to N - 2 generate
    c2: full_adder_1bit port map(a => a(I), b => b(I), cin =>carry(I - 1) , y =>y(I), cout => carry(I));
 end generate adders;
 last: if N > 1 generate
    c3: full_adder_1bit port map(a => a(N - 1), b => b(N - 1), cin =>carry(N - 2), y =>y(N - 1), cout => cout);
 end generate last; 
   

end Behavioral;
