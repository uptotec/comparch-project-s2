library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignExtend is
    Port ( a : in  STD_LOGIC_VECTOR (15 downto 0);
           b : out  STD_LOGIC_VECTOR (31 downto 0));
end SignExtend;

architecture rtl of SignExtend is
begin
    process(a)
    begin
        if a(15)='0' then
            b(31 downto 16) <="0000000000000000";
            b(15 downto 0) <=a;
        else
            b(31 downto 16) <="1111111111111111";
            b(15 downto 0) <=a;
        end if;
    end process;
end rtl;