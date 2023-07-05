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

------------------------------
--HUMAN-MACHINE INTERFACE
------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BinaryToDecimal is
    port (
        binary_input : in std_logic_vector(15 downto 0);
        decimal_output : out integer
    );
end entity BinaryToDecimal;

architecture Behavioral of BinaryToDecimal is
begin
    process(binary_input)
    	begin
            decimal_output <= to_integer(signed(binary_input(12 downto 4)));	
        end process;
end architecture Behavioral;

library ieee;
use ieee.std_logic_1164.all;

entity HMI is
	port (
		wordReady: in bit;
    	binary_input : in std_logic_vector(15 downto 0);
		control: in std_logic_vector(2 downto 0);
		tempMin: in integer;
		tempMax: in integer;
		scale: in integer;
      display_output : out std_logic_vector(41 downto 0)
    );
end entity HMI;

architecture HMI_arch of HMI is

    component BinaryToDecimal
        port (
            binary_input : in std_logic_vector(15 downto 0);
            decimal_output : out integer
        );
    end component;
	 
	 component mux8x1 is
		port(
			sel: in std_logic_vector(2 downto 0);
			I0, I1, I2, I3, I4, I5, I6, I7: in std_logic_vector(41 downto 0);
			Y: out std_logic_vector(41 downto 0)
		);
	end component mux8x1;
	 
    signal decimal, centena, dezena, unidade, decimal_s: integer;
	 signal min_dezena, min_unidade, max_dezena, max_unidade, min, max: integer;
	 signal display_0, display_1, display_2, display_3, display_4, display_5, display_6, display_7: std_logic_vector(41 downto 0);

begin
    
	BTD: BinaryToDecimal port map(binary_input, decimal);
		
	MX: Mux8x1 port map(control, display_0, display_1, display_2, display_3, display_4, display_5, display_6, display_7, display_output);
			
	min <= tempMin;
	max <= tempMax;
	
	min_unidade <= min mod 10;
	min_dezena <= min/10;
	max_unidade <= max mod 10;
	max_dezena <= max/10;
	
	display: process(binary_input, scale)
    	begin
			if (scale = 2) then
				decimal_s <= decimal + 273;
			elsif (scale = 1) then
				decimal_s <= decimal + decimal + 32;
			else
				decimal_s <= decimal;
			end if;
        end process;
		  
	 unidade <= decimal_s mod 10;
    dezena <= (decimal_s mod 100)/10;
    centena <= (decimal_s mod 1000)/100;
	
	--Display 0
	display_0(41 downto 35) <= "0000111";
	display_0(34 downto 28) <= "0110111";
	
	with centena select display_0(27 downto 21) <=
    	  "1000000" when 0,
        "1111001" when 1,
        "0100100" when 2,
        "0110000" when 3,
        "0011001" when 4,
        "0010010" when 5,
        "0000010" when 6,
        "1111000" when 7,
        "0000000" when 8,
        "0010000" when others;
	
	with dezena select display_0(20 downto 14) <=
    	  "1000000" when 0,
        "1111001" when 1,
        "0100100" when 2,
        "0110000" when 3,
        "0011001" when 4,
        "0010010" when 5,
        "0000010" when 6,
        "1111000" when 7,
        "0000000" when 8,
        "0010000" when others;
	
	with unidade select display_0(13 downto 7) <=
    	  "1000000" when 0,
        "1111001" when 1,
        "0100100" when 2,
        "0110000" when 3,
        "0011001" when 4,
        "0010010" when 5,
        "0000010" when 6,
        "1111000" when 7,
        "0000000" when 8,
        "0010000" when others; 

	 with scale select display_0(6 downto 0) <= "1000110" when 0, 
																"0001110" when 1,
																"0001010" when 2,
																"1000110" when others;
	--Displays 1,2 e 3
	display_1 <= "111111111111111111111111111110111111000110";
	display_2 <= "111111111111111111111111111110111110001110";
	display_3 <= "111111111111111111111111111110111110001010";
	
	 --Display 4
    
	 display_4(41 downto 35) <= "1101010";
	 display_4(34 downto 28) <= "1001000";
	 display_4(27 downto 21) <= "0110111";
	 
    with min_dezena select display_4(20 downto 14) <=
    	  "1000000" when 0,
        "1111001" when 1,
        "0100100" when 2,
        "0110000" when 3,
        "0011001" when 4,
        "0010010" when 5,
        "0000010" when 6,
        "1111000" when 7,
        "0000000" when 8,
        "0010000" when others;
    
	 with min_unidade select display_4(13 downto 7) <=
    	  "1000000" when 0,
        "1111001" when 1,
        "0100100" when 2,
        "0110000" when 3,
        "0011001" when 4,
        "0010010" when 5,
        "0000010" when 6,
        "1111000" when 7,
        "0000000" when 8,
        "0010000" when others;
   
	 display_4(6 downto 0) <= "1000110";
	
	 --Display 5
	 display_5(41 downto 35) <= "1101010";
	 display_5(34 downto 28) <= "0001001";
	 display_5(27 downto 21) <= "0110111";
	 
    with max_dezena select display_5(20 downto 14) <=
    	  "1000000" when 0,
        "1111001" when 1,
        "0100100" when 2,
        "0110000" when 3,
        "0011001" when 4,
        "0010010" when 5,
        "0000010" when 6,
        "1111000" when 7,
        "0000000" when 8,
        "0010000" when others;
        
    with max_unidade select display_5(13 downto 7) <=
    	  "1000000" when 0,
        "1111001" when 1,
        "0100100" when 2,
        "0110000" when 3,
        "0011001" when 4,
        "0010010" when 5,
        "0000010" when 6,
        "1111000" when 7,
        "0000000" when 8,
        "0010000" when others;
	 
	 display_5(6 downto 0) <= "1000110";
	 
	 --Displays 6 e 7
	 display_6 <= "100011100001100100001111111111111111111111";
	 display_7 <= "000001110000010100100010010000001101001100";
	
end architecture HMI_arch;
