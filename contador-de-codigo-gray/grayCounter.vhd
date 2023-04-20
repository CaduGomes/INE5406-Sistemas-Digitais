-- Complete abaixo com o nome dos alunos que fazem esta avaliacao (sem caracteres especiais nos nomes, como acentos)
-- ALUNO 1: Carlos Eduardo Vitorino Gomes

-- Um codificador gray recebe um valor binario B de N bits e devolve um valor gray G de N bits, em que cada bit i do codigo gray eh dado por G[i] = b[i+1] xor b[i]. Considere B[N]=0
-- Um decodificador gray recebe um valor gray G de N bits e devolve um valor binario B de N bits, em que cada bit i do valor binario eh dado por B[i] = B[i+1] xor G[i]. Considere B[N]=0

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity grayCounter is
	generic(	width: positive := 16;
				generateLoad: boolean := true;
				generateEnb: boolean := true;
				generateInc: boolean := true;
				resetValue: integer := 0 );
	port(	-- control
			clock, reset, load: in std_logic;
			enb, inc: in std_logic;
			-- data
			input: in std_logic_vector(width-1 downto 0);
			output: out std_logic_vector(width-1 downto 0)	);
end entity;


architecture behav0 of grayCounter is
    -- Nao altere as duas linhas abaixo
    subtype state is signed(width-1 downto 0);
    signal nextState, currentState: state;
    -- COMPLETE AQUI, SE NECESSARIO
    signal grayOutput, converterInput: std_logic_vector(width-1 downto 0);
begin
	-- next-state logic (DO NOT CHANGE OR REMOVE THIS LINE)
	-- COMPLETE
	
	-- TTT
	generateTTT: if generateLoad and generateEnb and generateInc generate
 
	    converterToBinary: for i in width-2 downto 0 generate
	        grayOutput(i) <= grayOutput(i + 1) xor input(i);
	    end generate;
	
	    grayOutput(grayOutput'high) <= '0';
	    
	    nextState <= signed(grayOutput) when load='1' else
	                   currentState when enb='0' else
	               currentState + 1 when inc='1' else
	               currentState - 1;
	end generate;
	
	-- FFF
	generateFFF: if not generateLoad and not generateEnb and not generateInc generate
	    nextState <= to_signed(to_integer(currentState) + 1, currentState'length);
	end generate;
	
	-- FFT
	generateFFT: if not generateLoad and not generateEnb and generateInc generate
	    nextState <= currentState + 1 when inc='1' else currentState - 1;
	end generate;
	
    -- FTT
	generateFTT: if not generateLoad and generateEnb and generateInc generate
	    nextState <= currentState when enb='0' else
	                 currentState + 1 when inc='1' else
	                 currentState - 1;
		 
    end generate;
	-- end-next-state logic (DO NOT CHANGE OR REMOVE THIS LINE)
	
	-- memory register (DO NOT CHANGE OR REMOVE THIS LINE)
	process(clock, reset) is
	begin
		if reset='1' then
			currentState <= (to_signed(resetValue, currentState'length));
		elsif rising_edge(clock) then
			currentState <= nextState;
		end if;
	end process;
	-- memory register (DO NOT CHANGE OR REMOVE THIS LINE)
	
	
	-- output-logic (DO NOT CHANGE OR REMOVE THIS LINE)
    -- COMPLETE
    
    converterInput <= std_logic_vector(currentState);
	
	converterToGray: for i in width-2 downto 0 generate
			output(i) <= converterInput(i) xor converterInput(i + 1);
	end generate;
	
	output(output'high) <= converterInput(converterInput'high);
	
    -- end-output-logic (DO NOT CHANGE OR REMOVE THIS LINE)
end architecture;