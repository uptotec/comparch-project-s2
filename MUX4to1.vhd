library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4to1 is
    Port ( X : in  STD_LOGIC_VECTOR (31 downto 0);
           Y : in  STD_LOGIC_VECTOR (31 downto 0);
           Z : in  STD_LOGIC_VECTOR (31 downto 0);
           W : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0);
			  sel : in STD_LOGIC_VECTOR (1 downto 0));
end MUX4to1;

architecture rtl of MUX4to1 is

COMPONENT MUX2to1
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);
		s : IN std_logic;          
		z : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	signal temp1:std_logic_vector(31 downto 0);
	signal temp2:std_logic_vector(31 downto 0);

begin

   MUX_1: MUX2to1 PORT MAP(
		a => x,
		b => y,
		s => sel(0),
		z => temp1
	);
	
	MUX_2: MUX2to1 PORT MAP(
		a => z,
		b => w,
		s => sel(0),
		z => temp2
	);
	
	MUX_3: MUX2to1 PORT MAP(
		a => temp1,
		b => temp2,
		s => sel(1),
		z => output
	);

end rtl;

