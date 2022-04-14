library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMemory is
    Port ( memread : in  STD_LOGIC;
           memwrite : in  STD_LOGIC;
           Wdata : in  STD_LOGIC_VECTOR (31 downto 0);
           address : in  STD_LOGIC_VECTOR (31 downto 0);
           Rdata : out  STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture rtl of DataMemory is

type A is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
signal mem: A;

begin

process(memread, memwrite, wdata, address)

begin

if(memread = '1' and memwrite = '0') then
	rdata(31 downto 0) <= mem(conv_integer(address));
elsif(memread = '0' and memwrite = '1') then
	mem(conv_integer(address)) <= wdata(31 downto 0);
end if;

end process;

end rtl;