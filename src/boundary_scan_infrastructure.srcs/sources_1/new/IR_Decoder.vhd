library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IR_Decoder is
    Port ( instruction : in STD_LOGIC_VECTOR (3 downto 0);
           data_mux : out STD_LOGIC;
           bp_en : out STD_LOGIC;
           bs_en : out STD_LOGIC;
           bs_moc : out STD_LOGIC);
end IR_Decoder;

architecture Behavioral of IR_Decoder is

begin

data_mux <= '0' when instruction = "0000" or instruction = "1001" or instruction = "0110" else
    '1';
    
bs_moc <= '1' when instruction = "0000" else
    '0';
    
bp_en <= '0' when instruction = "0000" or instruction = "1001" or instruction = "0110" else
    '1';

bs_en <= '1' when instruction = "0000" or instruction = "1001" or instruction = "0110" else
    '0';

end Behavioral;
