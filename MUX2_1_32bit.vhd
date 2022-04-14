library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX2_1_32bit is
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX2_1_32bit;

architecture rtl of MUX2_1_32bit is

begin

process(a,b,sel)
begin

if sel = '0' then
output <= a;
elsif sel = '1' then
output <= b;
end if;
end process;

end rtl;