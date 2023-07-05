library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8x1 is
	port(
    	sel: in std_logic_vector(2 downto 0);
        I0, I1, I2, I3, I4, I5, I6, I7: in std_logic_vector(41 downto 0);
        Y: out std_logic_vector(41 downto 0)
    );
end mux8x1;

architecture mux8x1_arc of mux8x1 is
begin
	Y <= I0 when (sel = "000") else
    	  I1 when (sel = "001") else
        I2 when (sel = "010") else
        I3 when (sel = "011") else
	     I4 when (sel = "100") else
	     I5 when (sel = "101") else
		  I6 when (sel = "110") else
	     I7 when (sel = "111") else
        "000000000000000000000000000000000000000000";
end mux8x1_arc;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ClockDivider is
	port(
		 clock_in: in std_logic;
       clock_out: out std_logic
    );

end ClockDivider;

architecture ClkDiv_arc of ClockDivider is
signal clock_intermed: std_logic := '0';
begin

clkdiv: process(clock_in)
    VARIABLE contador  : NATURAL RANGE 0 to 2500001 := 0;
    begin
      
	if (clock_in'EVENT) AND (clock_in ='1')  THEN
        contador := contador + 1;
        if contador = 2500000 THEN
            contador := 0;
            clock_intermed <= '1' xor clock_intermed;
        end if;
	end if;
end process clkdiv;   

clock_out <= clock_intermed;

end ClkDiv_arc;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ClockDivider2 is
	port(
		 clock_in: in std_logic;
       clock_out: out std_logic
    );

end ClockDivider2;

architecture ClkDiv_arc2 of ClockDivider2 is
signal clock_intermed: std_logic := '0';
begin

clkdiv: process(clock_in)
    VARIABLE contador  : NATURAL RANGE 0 to 12500001 := 0;
    begin
      
	if (clock_in'EVENT) AND (clock_in ='1')  THEN
        contador := contador + 1;
        if contador = 12500000 THEN
            contador := 0;
            clock_intermed <= '1' xor clock_intermed;
        end if;
	end if;
end process clkdiv;   

clock_out <= clock_intermed;

end ClkDiv_arc2;
