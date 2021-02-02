library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IR_Decoder is
    Port ( instruction : in STD_LOGIC_VECTOR (3 downto 0);
           data_mux : out STD_LOGIC;
           bs_moc : out STD_LOGIC);
end IR_Decoder;

architecture Behavioral of IR_Decoder is

begin

data_mux <= '0' when instruction = "0000" or instruction = "1001" or instruction = "0110" else
    '1';
    
bs_moc <= '1' when instruction = "0000" else
    '0';

end Behavioral;
