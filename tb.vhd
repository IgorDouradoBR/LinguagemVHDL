Library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.std_logic_arith.all;
	
entity tb is

end tb;

architecture testbench_arch of tb is

	signal tb_op1 		: 	std_logic_vector(11 downto 0):= "101010111100";
	signal tb_op2		: 	std_logic_vector(11 downto 0):= "111110001111";
	signal tb_op_alu	:	std_logic_vector(3 downto 0):= "0000";


	signal tb_out_alu :  	std_logic_vector(11 downto 0):= (others => '0');--como é saída, não precisaria inicializar obrigatoriamente
	signal tb_cout		:	std_logic:= '0';
	signal tb_ov		:	std_logic:= '0';	

	signal clock	:	 std_logic := '0';

begin

	clock <= not clock	after 20 ns;

	duv: entity work.ula_fsd
	port map
	(
		op1 	=> tb_op1,	
		op2		=> tb_op2,	
		op_alu	=>	tb_op_alu,
		
		out_alu => tb_out_alu,
		cout	=> tb_cout,
		ov		=> tb_ov
	);
	
	process
	begin
		--wait for 50 ns;
		
		--if tb_op_alu < 15 then --decimal para 1111
		--	tb_op_alu <= tb_op_alu + 1;
		--else 
		--	tb_op_alu <= "0000";
		--end if;
		
		-- agora outro exemplo que leva menos processamento por ter limites
		
		wait for 10 ns;
		
		if tb_op1 < 10 then 
			tb_op1 <= tb_op1 + 1;
		else
			tb_op1 <= (others => '0');
			
			if tb_op2 < 10 then 
				tb_op2 <= tb_op2 + 1;
			else
				tb_op2 <= (others => '0');
				
				if tb_op_alu < 15 then --decimal para 1111
					tb_op_alu <= tb_op_alu + 1;
				else 
					tb_op_alu <= "0000";
				end if;
			end if;
		end if;
				

		
	end process;

end testbench_arch;