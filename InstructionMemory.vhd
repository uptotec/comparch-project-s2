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

--recently added
mem(0) <= "00000000";
mem(1) <= "00100010";
mem(2) <= "00011000";
mem(3) <= "00100000";

mem(4) <= "00000000";
mem(5) <= "00100010";
mem(6) <= "00011000";
mem(7) <= "00100000";

mem(8) <= "00000000";
mem(9) <= "00100010";
mem(10) <= "00011000";
mem(11) <= "00100000";

mem(12) <= "00000000";
mem(13) <= "00100010";
mem(14) <= "00011000";
mem(15) <= "00100000";

mem(16) <= "00000000";
mem(17) <= "00100010";
mem(18) <= "00011000";
mem(19) <= "00100000";

mem(20) <= "00000000";
mem(21) <= "00100010";
mem(22) <= "00011000";
mem(23) <= "00100000";

mem(24) <= "00000000";
mem(25) <= "00100010";
mem(26) <= "00011000";
mem(27) <= "00100000";

mem(28) <= "00000000";
mem(29) <= "00100010";
mem(30) <= "00011000";
mem(31) <= "00100000";

mem(32) <= "00000000";
mem(33) <= "00100010";
mem(34) <= "00011000";
mem(35) <= "00100000";

mem(36) <= "00000000";
mem(37) <= "00100010";
mem(38) <= "00011000";
mem(39) <= "00100000";

mem(40) <= "00000000";
mem(41) <= "00100010";
mem(42) <= "00011000";
mem(43) <= "00100000";

mem(44) <= "00000000";
mem(45) <= "00100010";
mem(46) <= "00011000";
mem(47) <= "00100000";

mem(48) <= "00000000";
mem(49) <= "00100010";
mem(50) <= "00011000";
mem(51) <= "00100000";

mem(52) <= "00000000";
mem(53) <= "00100010";
mem(54) <= "00011000";
mem(55) <= "00100000";

mem(56) <= "00000000";
mem(57) <= "00100010";
mem(58) <= "00011000";
mem(59) <= "00100000";

mem(60) <= "00000000";
mem(61) <= "00100010";
mem(62) <= "00011000";
mem(63) <= "00100000";
--end

instruct(31 downto 24) <= mem(conv_integer(PC));
instruct(23 downto 16) <= mem(conv_integer(PC)+1);
instruct(15 downto 8) <= mem(conv_integer(PC)+2);
instruct(7 downto 0) <= mem(conv_integer(PC)+3);

end rtl;