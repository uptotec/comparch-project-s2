library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity InstructionMemory is
    Port ( PC : in  STD_LOGIC_VECTOR (31 downto 0);
           instruct : out  STD_LOGIC_VECTOR (31 downto 0));
end InstructionMemory;

architecture rtl of InstructionMemory is

type A is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
signal mem: A;

begin

mem(0) <= "00000000001000100001100000100000";
-- mem(1) <= "";
-- mem(2) <= "";
-- mem(3) <= "";

-- mem(4) <= "00000000";
-- mem(5) <= "00100010";
-- mem(6) <= "00011000";
-- mem(7) <= "00100000";

-- mem(8) <= "00000000";
-- mem(9) <= "00100010";
-- mem(10) <= "00011000";
-- mem(11) <= "00100000";

-- mem(12) <= "00000000";
-- mem(13) <= "00100010";
-- mem(14) <= "00011000";
-- mem(15) <= "00100000";

-- mem(16) <= "00000000";
-- mem(17) <= "00100010";
-- mem(18) <= "00011000";
-- mem(19) <= "00100000";

-- mem(20) <= "00000000";
-- mem(21) <= "00100010";
-- mem(22) <= "00011000";
-- mem(23) <= "00100000";

-- mem(24) <= "00000000";
-- mem(25) <= "00100010";
-- mem(26) <= "00011000";
-- mem(27) <= "00100000";

-- mem(28) <= "00000000";
-- mem(29) <= "00100010";
-- mem(30) <= "00011000";
-- mem(31) <= "00100000";

instruct(31 downto 0) <= mem(conv_integer(PC));

end rtl;