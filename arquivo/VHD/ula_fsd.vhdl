--Autor: Igor Pereira Dourado
--Email:igor.d@edu.pucrs.br

Library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.std_logic_arith.all;
entity ula_fsd is
port
(
	op1 	: 	in	std_logic_vector(11 downto 0);
	op2		: 	in	std_logic_vector(11 downto 0);
	op_alu	: 	in	std_logic_vector(3 downto 0);
	
	out_alu :   out	std_logic_vector(11 downto 0);
	cout	:	out std_logic;
	ov		:	out std_logic	
);
end ula_fsd;

architecture igor_pereira_dourado of ula_fsd is

	signal soma_interna	: std_logic_vector(12 downto 0);
	signal subtracao_interna	: std_logic_vector(12 downto 0);
	signal dobrar	: std_logic_vector(0 to 12);


begin
	
	soma_interna <= ('0' & op1) + ('0' & op2);
	subtracao_interna <= ('0' & op2) - ('0' & op1);
	dobrar <= (op1 & '0');
	
	decoder_proc: process(op1, op2, op_alu, soma_interna, subtracao_interna, dobrar)
	begin
		if op_alu="0000" then
			out_alu <= op1 AND op2;-- operação and 1
			cout	<= '0';--para ter um valor atribuito a todas as chaves, conforme orientação
			ov		<= '0';
		elsif op_alu="0001" then
			out_alu <= op1 OR op2;-- operação or 2
			cout	<= '0';
			ov		<= '0';
		elsif op_alu="0010" then
			out_alu <= op1 XNOR op2;-- operação xnor 3
			cout	<= '0';
			ov		<= '0';
		elsif op_alu="0011" then
			out_alu <= NOT op1;-- inverso da operação 1, 4
			cout	<= '0';
			ov		<= '0';			
		elsif op_alu="0100" then
			out_alu <= soma_interna(11 downto 0);-- soma do op1 com op2
			cout <= soma_interna(12);
			ov		<= '0';
		elsif op_alu="0101" then
			out_alu <= subtracao_interna(11 downto 0);-- subtracao de op2 com op1
			cout <= subtracao_interna(12);
			ov		<= '0';
		elsif op_alu="0110" then
			out_alu <= op1; -- atribui direto a sequencia de op1 à saida
			cout	<= '0';
			ov		<= '0';
		elsif op_alu="0111" then
			out_alu <= dobrar(1 to 12);--dobra o valor do op1
			ov <= dobrar(0);
			cout	<= '0';
		elsif op_alu="1000" then
			out_alu <= 0 - op1;--complemento de dois do op1
			cout	<= '0';
			ov		<= '0';
			
		else
			out_alu <= "111111111111";
			cout	<= '0';
			ov		<= '0';
					
		end if;
	end process decoder_proc;
end igor_pereira_dourado;
