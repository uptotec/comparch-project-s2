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

type A is array(0 to 63) of STD_LOGIC_VECTOR (7 downto 0);
signal mem: A;

begin

process(memread, memwrite, wdata, address)

begin

if(memread = '1' and memwrite = '0') then
	rdata(31 downto 24) <= mem(conv_integer(address));
	rdata(23 downto 16) <= mem(conv_integer(address)+1);
	rdata(15 downto 8) <= mem(conv_integer(address)+2);
	rdata(7 downto 0) <= mem(conv_integer(address)+3);
elsif(memread = '0' and memwrite = '1') then
	mem(conv_integer(address)) <= wdata(31 downto 24);
	mem(conv_integer(address)+1) <= wdata(23 downto 16);
	mem(conv_integer(address)+2) <= wdata(15 downto 8);
	mem(conv_integer(address)+3) <= wdata(7 downto 0);
end if;

end process;

end rtl;