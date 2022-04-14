library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           ALUControl : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC);
end ALU;

architecture rtl of ALU is
begin
    process(A, B, ALUControl)
    begin
        if (ALUControl = "0000") then
        Output <= A AND B;
        elsif (ALUControl = "0001") then
        Output <= A OR B;
        elsif (ALUControl = "0010") then
        Output <= A + B;
        elsif (ALUControl = "0110") then
        Output <= A - B;
        elsif (ALUControl = "0111") then
        if (A < B) then
        Output <= X"00000001";
        else
        Output <= X"00000000";
        end if;
        elsif (ALUControl = "1100") then
        Output <= A NOR B;
        end if;

        if (A=B) then
        Zero <= '1';
        else
        Zero <= '0';
        end if;
    end process;

end rtl;

