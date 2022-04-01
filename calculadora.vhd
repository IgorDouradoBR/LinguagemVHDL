--Autor: Igor Pereira Dourado 19204004
--Email:igor.d@edu.pucrs.br

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

architecture igor_dourado of calculadora is

	signal reg_x :  std_logic_vector(7 downto 0);
	signal reg_y :  std_logic_vector(7 downto 0);
	signal reg_z :  std_logic_vector(7 downto 0);
	signal reg_t :  std_logic_vector(7 downto 0);
	
	signal soma_interna			: std_logic_vector(8 downto 0);
	signal subtracao_interna	: std_logic_vector(8 downto 0);
	signal dobrar				: std_logic_vector(8 downto 0);
	signal complem2				: std_logic_vector(8 downto 0); 
	signal incrementa			: std_logic_vector(8 downto 0);
	signal decrementa			: std_logic_vector(8 downto 0);

begin

	

	shift_register: process(clock, reset, soma_interna, subtracao_interna, dobrar,complem2, decrementa, incrementa)
	begin
		if reset= '1' then-- ativo em 1
			reg_x<= "00000000";
			reg_y<= "00000000";
			reg_z<= "00000000";
			reg_t<= "00000000";
			cout<= '0';
			ov<= '0';
			zero<='0';
			saida<="00000000";
			
			
			
		else			
			if clock'event and clock = '1' then
				soma_interna <= ('0' & reg_x) + ('0' & reg_y);
				subtracao_interna <= ('0' & reg_y) - ('0' & reg_x);
				dobrar <= (reg_x & '0');
				complem2<= ("000000000" - ('0' & reg_x));
				incrementa<= ('0' & reg_x) + 1;
				decrementa<= ('0' & reg_x) - 1;
				zero<='0';
				if opmode = "0000" then -- operacao uAnd
					reg_x <= reg_x AND reg_y;
					reg_y <= reg_z;
					reg_z <= reg_t;
					reg_t <= reg_t;
					cout<= '0';
					ov<= '0';
					
				elsif opmode = "0001" then --operacao uOr
					reg_x <= reg_x OR reg_y;
					reg_y <= reg_z;
					reg_z <= reg_t;
					reg_t <= reg_t;
					cout<= '0';
					ov<= '0';
					
				elsif opmode = "0010" then  --operacao uXnor
					reg_x <= reg_x XNOR reg_y;
					reg_y <= reg_z;
					reg_z <= reg_t;
					reg_t <= reg_t;
					cout<= '0';
					ov<= '0';
				
				elsif opmode = "0011" then  --operacao uNot
					reg_x <= NOT reg_x;
					reg_y <= reg_y;
					reg_z <= reg_z;
					reg_t <= reg_t;
					cout<= '0';
					ov<= '0';
					
				elsif opmode = "0100" then --operacao uAdd
					reg_x <= soma_interna(7 downto 0);
					cout <=  soma_interna(8);
					reg_y <= reg_z;
					reg_z <= reg_t;
					reg_t <= reg_t;
					ov<= '0';
					
				elsif opmode = "0101" then --operacao uSub
					reg_x <= subtracao_interna(7 downto 0);
					cout <=  subtracao_interna(8);
					reg_y <= reg_z;
					reg_z <= reg_t;
					reg_t <= reg_t;
					ov<= '0';
					
				elsif opmode = "0110" then  --operacao uClear
					reg_x <= "00000000";
					reg_y <= reg_y;
					reg_z <= reg_z;
					reg_t <= reg_t;	
					cout<= '0';
					ov<= '0';
					
				elsif opmode = "0111" then  --operacao uMu2
					reg_x <= dobrar(7 downto 0);
					ov  <= dobrar(8);
					reg_y <= reg_y;
					reg_z <= reg_z;
					reg_t <= reg_t;
					cout<= '0';
					
					
				elsif opmode = "1000" then  --operacao uNeg
					reg_x <= complem2(7 downto 0);
					cout  <= complem2(8);
					reg_y <= reg_y;
					reg_z <= reg_z;
					reg_t <= reg_t;	
					ov<= '0';
				
				elsif opmode = "1001" then -- operacao uLoad
					reg_x <= din;
					reg_y <= reg_x;
					reg_z <= reg_y;
					reg_t <= reg_z;
					cout<= '0';
					ov<= '0';
					
				elsif opmode = "1010" then --operacao uCpx
					reg_y <= reg_x;
					reg_z <= reg_y;
					reg_t <= reg_z;
					cout<= '0';
					ov<= '0';
					
				elsif opmode = "1011" then --operacao uXy
					reg_x <= reg_y;
					reg_y <= reg_x;
					reg_z <= reg_z;
					reg_t <= reg_t;
					cout<= '0';
					ov<= '0';
					
				elsif opmode = "1100" then --operacao uUp
					reg_x <= reg_y;
					reg_y <= reg_z;
					reg_z <= reg_t;
					reg_t <= reg_t;
					cout<= '0';
					ov<= '0';
					
				elsif opmode = "1101" then  --operacao uDec
					reg_x <= decrementa(7 downto 0);
					cout  <= decrementa(8);
					reg_y <= reg_y;
					reg_z <= reg_z;
					reg_t <= reg_t;
					ov<= '0';

				elsif opmode = "1110" then  --operacao uInc
					reg_x <= incrementa(7 downto 0);
					cout  <= incrementa(8);
					reg_y <= reg_y;
					reg_z <= reg_z;
					reg_t <= reg_t;
					ov<= '0';
					
				end if;
				saida <= reg_x;
				if reg_x <= "00000000" then 
					zero<= '1';
				end if;
			end if;
		end if;
	end process shift_register;
end igor_dourado;