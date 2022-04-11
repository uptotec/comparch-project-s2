library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUControl is
    Port ( Func : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUop : in  STD_LOGIC_VECTOR (1 downto 0);
           ALUcon : out  STD_LOGIC_VECTOR (3 downto 0));
end ALUControl;

architecture rtl of ALUControl is

begin
process(Func,ALUop)
begin

if ALUop = "00" then ALUcon <= "0010";
elsif ALUop = "01" then ALUcon <= "0110";
elsif ALUop = "10" then
if Func = "100000" then ALUcon <= "0010";
elsif Func = "100010" then ALUcon <= "0110";
elsif Func = "100100" then ALUcon <= "0000";
elsif Func = "100101" then ALUcon <= "0001";
elsif Func = "101010" then ALUcon <= "0111";
end if;
 
end if;
end process;
end rtl;