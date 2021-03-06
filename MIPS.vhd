library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity MIPS is
    Port ( CLKmain : in  STD_LOGIC);
end MIPS;

architecture rtl of MIPS is

COMPONENT ALUControl
	PORT(
		Func : IN std_logic_vector(5 downto 0);
		ALUop : IN std_logic_vector(1 downto 0);
		ALUcon : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
COMPONENT ALU
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		ALUControl : IN std_logic_vector(3 downto 0);
		Output : OUT std_logic_vector(31 downto 0);
		Zero : OUT std_logic
		);
	END COMPONENT;
	
COMPONENT Adder
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);
		c : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT ControlUnit
	PORT(
		OP : IN std_logic_vector(5 downto 0);
		RegDst : OUT std_logic;
		ALUSrc : OUT std_logic;
		MemToReg : OUT std_logic;
		RegWrite : OUT std_logic;
		MemRead : OUT std_logic;
		MemWrite : OUT std_logic;
		Branch : OUT std_logic;
		Jump : OUT std_logic;
		ALUop : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
COMPONENT DataMemory
	PORT(
		memread : IN std_logic;
		memwrite : IN std_logic;
		Wdata : IN std_logic_vector(31 downto 0);
		address : IN std_logic_vector(31 downto 0);
		Rdata : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT InstructionMemory
	PORT(
		PC : IN std_logic_vector(31 downto 0);
		instruct : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT MUX2_1_32bit
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT MUX2_1_5bit
	PORT(
		a : IN std_logic_vector(4 downto 0);
		b : IN std_logic_vector(4 downto 0);
		sel : IN std_logic;
		output : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;
	
COMPONENT PC
	PORT(
		CLK : IN std_logic;
		PCin : IN std_logic_vector(31 downto 0);
		PCout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT RegisterFile
	PORT(
		rs : IN std_logic_vector(4 downto 0);
		rt : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		WriteData : IN std_logic_vector(31 downto 0);
		RegWrite : IN std_logic;
		ReadData1 : OUT std_logic_vector(31 downto 0);
		ReadData2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT ShiftLeft2
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT SignExtend
	PORT(
		a : IN std_logic_vector(15 downto 0);
		b : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	signal ALUinput1: std_logic_vector(31 downto 0);
	signal ALUinput2: std_logic_vector(31 downto 0);
	signal ALUoutput: std_logic_vector(31 downto 0);
	signal ALUzeroFlag: std_logic;
	signal ALUselect: std_logic_vector(3 downto 0);
	
	signal PCoutput: std_logic_vector(31 downto 0);
	signal PCinput: std_logic_vector (31 downto 0);
	signal AdderOut: std_logic_vector (31 downto 0);
	
	signal inputInstruction: std_logic_vector (31 downto 0);
	signal readData2: std_logic_vector (31 downto 0);
	signal dataMemoryOut: std_logic_vector (31 downto 0);
	signal writeDataIn: std_logic_vector (31 downto 0);
	signal MUXregDstOut:std_logic_vector (4 downto 0);
	
	signal regDstControlSig: std_logic;
	signal branchControlSig: std_logic;
	signal jumpControlSig: std_logic;
	signal memReadControlSig: std_logic;
	signal memToRegControlSig: std_logic;
	signal ALUopControl: std_logic_vector (1 downto 0);
	signal memWriteControlSig: std_logic;
	signal ALUSrcControlSig: std_logic;
	signal RegWriteControlSig: std_logic;
	
	signal sign_extend: std_logic_vector (31 downto 0);
	signal shift_left2: std_logic_vector (31 downto 0);
	
	signal ALUoutputToPCMUX: std_logic_vector (31 downto 0);
	signal PCMUXcontrol: std_logic;
	
begin

	Inst_PC: PC PORT MAP(
		CLK => CLKmain,
		PCin => PCinput,
		PCout => PCoutput 
	);
	
	Inst_Adder1: Adder PORT MAP(
		a => PCoutput,
		b => "00000000000000000000000000000100",
		c => AdderOut
	);
	
	Inst_InstructionMemory: InstructionMemory PORT MAP(
		PC => PCoutput,
		instruct => inputInstruction
	);
	
	Inst_ControlUnit: ControlUnit PORT MAP(
		OP => inputInstruction (31 downto 26),
		RegDst => regDstControlSig,
		ALUSrc => ALUSrcControlSig,
		MemToReg => memToRegControlSig,
		RegWrite => RegWriteControlSig,
		MemRead => memReadControlSig,
		MemWrite => memWriteControlSig,
		Branch => branchControlSig,
		Jump => jumpControlSig,
		ALUop => ALUopControl
	);
	
	Inst_MUXRegDst: MUX2_1_5bit PORT MAP(
		a => inputInstruction (20 downto 16),
		b => inputInstruction (15 downto 11),
		sel => regDstControlSig,
		output => MUXregDstOut 
	);
	
	Inst_RegisterFile: RegisterFile PORT MAP(
		ReadData1 => ALUinput1,
		ReadData2 => readData2,
		rs => inputInstruction (25 downto 21),
		rt => inputInstruction (20 downto 16),
		rd => MUXregDstOut,
		WriteData => writeDataIn,
		RegWrite => RegWriteControlSig
	);
	
	Inst_SignExtend: SignExtend PORT MAP(
		a => inputInstruction (15 downto 0),
		b => sign_extend
	);
	
	Inst_ShiftLeft2: ShiftLeft2 PORT MAP(
		a => sign_extend,
		b => shift_left2
	);
	
	Inst_Adder2: Adder PORT MAP(
		a => AdderOut,
		b => shift_left2,
		c => ALUoutputToPCMUX
	);

	Inst_ALUControl: ALUControl PORT MAP(
		Func => inputInstruction (5 downto 0),
		ALUop => ALUopControl,
		ALUcon => ALUselect
	);
	
	ALUMUX: MUX2_1_32bit PORT MAP(
		a => readData2,
		b => sign_extend,
		sel => ALUSrcControlSig,
		output => ALUinput2 
	);
	
	Inst_ALU: ALU PORT MAP(
		A => ALUinput1,
		B => ALUinput2,
		ALUControl => ALUselect,
		Output => ALUoutput,
		Zero => ALUzeroFlag
	);
	
	PCMUXcontrol <= ((branchControlSig AND ALUzeroFlag) OR jumpControlSig);
	
	PCMUX: MUX2_1_32bit PORT MAP(
		a => AdderOut,
		b => ALUoutputToPCMUX,
		sel => PCMUXcontrol,
		output => PCinput
	);
	
	Inst_DataMemory: DataMemory PORT MAP(
		memread => memReadControlSig,
		memwrite => memWriteControlSig,
		Wdata => readData2,
		address => ALUoutput,
		Rdata => dataMemoryOut
	);
	
	MemoryMUX: MUX2_1_32bit PORT MAP(
		a => ALUoutput,
		b => dataMemoryOut,
		sel => memToRegControlSig,
		output => writeDataIn
	);

end rtl;

