library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    Port ( CLK : in  STD_LOGIC;
           PCin : in  STD_LOGIC_VECTOR (31 downto 0);
           PCout : out  STD_LOGIC_VECTOR (31 downto 0));
end PC;

architecture rtl of PC is

begin

process(CLK, PCin)
begin

if rising_edge(CLK) then
PCout <= PCin;
end if;
end process;
end rtl;

