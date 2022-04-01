library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.std_logic_arith.all;
	
entity contador is
port
(
	clock	: 	in std_logic;
	reset	: 	in std_logic;
	start	:	in std_logic;
	q		:	out std_logic_vector(1 downto 0)
);
end contador;

architecture contador_arch of contador is

	signal cont	: std_logic_vector(1 downto 0)	:= "00";

begin

	cont_gen: process(clock, reset)
	begin
		if reset = '0' then -- ativo em 0
			cont <= "00";
		else	
			if clock'event and clock = '1' then
				if start = '1' then
					if cont < 3 then-- se fosse regressivo, faria cont > 0
						cont <= cont + 1;-- cont - 1
					else
						cont <= "00"; --cont <= "11"
					end if;
				end if;
			end if;
		end if;
	end process cont_gen;
	
	q <= cont;

end contador_arch;