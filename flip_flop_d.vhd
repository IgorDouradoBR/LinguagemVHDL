 Library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.std_logic_arith.all;

entity ff_d is
port
(
	dado	:	in std_logic;
	clock	:	in std_logic;

	q0 		:	out std_logic;
	q0_n 	:	out std_logic;
);
end ff_d;

architecture ff_d_arch of ff_d is
begin

	ff_gen : process(clock)
	begin
		if (clock'event) and(clock = '1') then-- o '1' definirá que será um clock de subida, que vai alternar toda vez q a borda for subindo, trocando pra 0 vira uma de descida
			q0		<= dado;
			q0_n	<= not dado;
		end if;	
	end process ff_gen;


end ff_d_arch;