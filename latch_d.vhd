Library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.std_logic_arith.all;

entity latch_d is
port
(
	dado	:	in std_logic;
	enable	:	in std_logic;

	q0 		:	out std_logic;
	q0_n 	:	out std_logic;
);
end latch_d;

architecture latch_d_arch of latch_d is
begin

	latch_gen : process(enable,dado)
	begin
		if enable = '1' then
			q0		<= dado;
			q0_n	<= not dado;
		end if;	
	end process latch_gen;


end latch_d_arch;