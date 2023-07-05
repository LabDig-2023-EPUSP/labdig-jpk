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

------------------------------
--DECODER
------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY shift_register IS 
	port   (  
      sys_rst : in std_logic;
      enable: in std_logic;
      dado_entrada : in std_logic;  
      dado_saida : out std_logic_vector(15 downto 0)
      
 );  
 end shift_register; 
 
architecture shift_arc of shift_register is  
signal dado_registrado, dado_registrado_out : std_logic_vector (15 downto 0);  
signal word: std_logic;
begin  

clk: process(enable,sys_rst)  
begin  
	if (sys_rst = '0') then  
      dado_registrado <= "0000000000000000";  
	elsif(enable'EVENT) AND (enable ='1')  THEN 
      dado_registrado(14 downto 0) <= dado_registrado(15 downto 1);  
      dado_registrado(15) <= dado_entrada;  
	end if;  
end process;

contador: process(enable)
    VARIABLE contador  : NATURAL RANGE 0 to 17 := 0;
	begin
	if (enable'EVENT) AND (enable ='1')  THEN    
    	word <= '0';							-- word recebe 1 quando há um dado completo de 16 bits a ser apresentado na saída do registrador
    	contador := contador + 1;
    	if contador = 16 THEN
       		contador := 0;
       		word <= '1';
    	end if;
    end if;
end process contador;

update: process(word)
	begin
		if(word'EVENT and word = '1') then
			dado_registrado_out <= dado_registrado;
		end if;
end process update;
dado_saida <= dado_registrado_out;  

end architecture;  

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder IS
	PORT ( 
    Data: IN STD_LOGIC;
    clock  : IN std_logic; 
    reset   : IN std_logic;
	 ShiftEnable: OUT std_logic;
    DataOut: OUT std_logic
    );
END Decoder;

architecture Decoder_arc of Decoder is
	begin

end architecture;
