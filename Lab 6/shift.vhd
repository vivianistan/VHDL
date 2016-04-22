--shift
--Vivian Tan
--04/18/2016
--Shift register that has 6 bits
    --serial-in, serial-out
    --inputs: RSI, LSI, R, L, CLK
        --asynchronous active low: ClrN
    --outputs: RSO, LSO (serial outputs)
    --falling edge
  --Behavior: 
    --if R = 1 and L = 0, register shifts right
    --if R = 0 and L = 1, register shifts left
    --else (R = L = 0 or R = L = 1) register holds state

library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

Entity shift is
    Port(CLK, LSI, RSI, R, L, ClrN: in std_logic; 
        RSO, LSO: out std_logic); 
End shift; 

Architecture shiftarch of shift is 
    signal temp: std_logic_vector(5 downto 0) := (Others => '0'); 
--    if(ClrN = '0') then
--        temp <= 0; 
--    end if;
    begin
        process(CLK, ClrN)
            begin
                if(ClrN = '0') then
                    temp <= (others => '0');
                elsif(CLK'event and CLK = '1') then
                    if(R = '1' and L = '0') then
                        temp <= RSI & temp(5 downto 1); 
                    elsif(R = '0' and L = '1') then
                            temp <= temp(4 downto 0) & LSI;                       
                    end if;                     
                end if; 
        end process;       
     RSO <= temp(5); 
     LSO <= temp(0); 
 end shiftarch;    