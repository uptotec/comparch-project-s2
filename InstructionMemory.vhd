library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity InstructionMemory is
    Port ( PC : in  STD_LOGIC_VECTOR (31 downto 0);
           instruct : out  STD_LOGIC_VECTOR (31 downto 0));
end InstructionMemory;

architecture rtl of InstructionMemory is

type A is array(0 to 63) of STD_LOGIC_VECTOR (7 downto 0);
signal mem: A;

begin

-- load first location in data memory to register 1
mem(0) <= "10001100";
mem(1) <= "00000001";
mem(2) <= "00000000";
mem(3) <= "00000000";

-- load second location in data memory to register 2
mem(4) <= "10001100";
mem(5) <= "00000010";
mem(6) <= "00000000";
mem(7) <= "00000100";

-- add register 1 and 2 in register 3
mem(8) <= "00000000";
mem(9) <= "00100010";
mem(10) <= "00011000";
mem(11) <= "00100000";

--store register 3 in location 3 in data memory
mem(12) <= "10101100";
mem(13) <= "00000011";
mem(14) <= "00000000";
mem(15) <= "00001001";

instruct(31 downto 24) <= mem(conv_integer(PC));
instruct(23 downto 16) <= mem(conv_integer(PC)+1);
instruct(15 downto 8) <= mem(conv_integer(PC)+2);
instruct(7 downto 0) <= mem(conv_integer(PC)+3);

end rtl;