
Library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.std_logic_arith.all;
	
entity calculadora is
port
(
	clock	:	in std_logic;
	reset	:	in std_logic;

	opmode	:	in std_logic_vector(3 downto 0);
	din		:	in std_logic_vector(7 downto 0);

	saida	:	out std_logic_vector(7 downto 0);
	cout	:	out std_logic;
	ov		:	out std_logic;
	zero	:	out std_logic
);
end calculadora;

architecture teu_nome of calculadora is
	
	signal MU2				: std_logic_vector(8 downto 0);	
	signal soma			: std_logic_vector(8 downto 0);
	signal sub	: std_logic_vector(8 downto 0);
	signal complemementoDe2				: std_logic_vector(8 downto 0);
	

	signal reg_x :  std_logic_vector(7 downto 0);
	signal reg_y :  std_logic_vector(7 downto 0);
	signal reg_z :  std_logic_vector(7 downto 0);
	signal reg_t :  std_logic_vector(7 downto 0);
	
	
	

begin

	MU2 <= (reg_x & '0');
	soma <= ('0' & reg_x) + ('0' & reg_y);
	sub <= ('0' & reg_y) - ('0' & reg_x);
	complemementoDe2<= ("000000000" - ('0' & reg_x));
	
	
	

	shift_register: process(clock, reset, soma, sub, MU2, complemementoDe2)
	begin
		if clock'event and clock = '1' then
			if opmode = "1001" then -- uLOAD
				reg_x <= din;
				reg_y <= reg_x;
				reg_z <= reg_y;
				reg_t <= reg_z;
			elsif opmode = "1010" then --uCPX
				reg_y<= reg_x;
				reg_z<= reg_y;
				reg_t<= reg_z;
			elsif opmode = "0000" then -- uAND
				reg_x<= reg_x AND reg_y;
				reg_y<= reg_z;
				reg_z<= reg_t;
			elsif opmode = "0001" then --uOR
				reg_x<= reg_x OR reg_y;
				reg_y<= reg_z;
				reg_z<= reg_t;
			elsif opmode = "0010" then  --uXNOR
				reg_x<= reg_x XNOR reg_y;
				reg_y<= reg_z;
				reg_z<= reg_t;			
			elsif opmode = "0011" then  --uNOT
				reg_x<= NOT reg_x;			
			elsif opmode = "0100" then --uADD
				reg_x<= soma(7 downto 0);
				cout<=  soma(8);
				reg_y<= reg_z;
				reg_z<= reg_t;	
			elsif opmode = "0101" then --uSUB
				reg_x<= sub(7 downto 0);
				cout<=  sub(8);
				reg_y<= reg_z;
				reg_z<= reg_t;				
			elsif opmode = "0110" then  --uCLEAR
				reg_x<= "00000000";
			elsif opmode = "0111" then  --uMU2
				reg_x<= MU2(7 downto 0);
				ov <= MU2(8);				
			elsif opmode = "1000" then  --uNEG
				reg_x<= complemementoDe2(7 downto 0);
				cout <= complemementoDe2(8);						
			elsif opmode = "1011" then --uXY
				reg_x<= reg_y;
				reg_y<= reg_x;
			elsif opmode = "1100" then --uUP
				reg_x<= reg_y;
				reg_y<= reg_z;
				reg_z<= reg_t;
			elsif opmode = "1101" then  --uDEC
				reg_x<= reg_x-1;
			elsif opmode = "1110" then  --uINC
				reg_x<= reg_x+1;
			end if;
			saida <= reg_x;
		end if;
	end process shift_register;
end teu_nome;