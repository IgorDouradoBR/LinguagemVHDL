--Autor: Igor Pereira Dourado 19204004
--Email:igor.d@edu.pucrs.br

Library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.std_logic_arith.all;
	
entity calculadora_tb is
end calculadora_tb;

architecture calculadora_arch_tb of calculadora_tb is

	signal 	clock_tb	:	 std_logic := '0';
	signal	reset_tb	:	 std_logic;

	signal	opmode_tb	:	 std_logic_vector(3 downto 0):= "0000";
	signal	din_tb		:	 std_logic_vector(7 downto 0):= x"1A";

	signal	saida_tb	:	 std_logic_vector(7 downto 0);
	signal	cout_tb		:	 std_logic;
	signal	ov_tb		:	 std_logic;
	signal	zero_tb		:	 std_logic;

begin

	clock_tb <= not clock_tb after 10 ns;


	calc:	entity work.calculadora
	port map
	(
	clock	=> clock_tb,
	reset	=> reset_tb,

	opmode	=>	opmode_tb,
	din		=>	din_tb,

	saida	=>	saida_tb,
	cout	=>	cout_tb,
	ov		=>	ov_tb,
	zero	=>	zero_tb
	);

	process(clock_tb)
	begin
		if clock_tb'event and clock_tb = '1' then
			if din_tb < x"FF" then
				din_tb <= din_tb+1;
			else
				din_tb <= x"00";
			end if;	
			
		end if;
	end process;
	
	process
	begin
		
		
		opmode_tb <= "1001";--LOAD
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		
		opmode_tb <= "0010";--XNOR
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		opmode_tb <= "0011";--NOT
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		opmode_tb <= "0100";--ADD
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		opmode_tb <= "0111";--mult por 2
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		opmode_tb <= "0101";--SUBT
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		
		
		opmode_tb <= "1000";--comp2
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		opmode_tb <= "1011";--XY
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		opmode_tb <= "1100";--UP
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		opmode_tb <= "0110";--CLEAR
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		
		opmode_tb <= "1110";--uINC
		wait for 100 ns;
		
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		opmode_tb <= "0000";--AND
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		opmode_tb <= "1101";--uDEC
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		opmode_tb <= "0001";--OR
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		
		opmode_tb <= "1010";--uCPX
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		reset_tb<= '1';
		wait for 50 ns;
		
		reset_tb<= '0';
		wait for 50 ns;
		
		opmode_tb <= "1001";--LOAD
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		
		opmode_tb <= "0010";--XNOR
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		opmode_tb <= "0011";--NOT
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		opmode_tb <= "0100";--ADD
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		opmode_tb <= "0111";--mult por 2
		wait for 100 ns;
		
		opmode_tb <= "1111";
		wait for 100 ns;
		
		
	
	end process;
	

end calculadora_arch_tb;