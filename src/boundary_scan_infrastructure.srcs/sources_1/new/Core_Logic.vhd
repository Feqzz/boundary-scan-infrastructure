library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity core_logic is
    Port ( core_logic_in : in STD_LOGIC_VECTOR (3 downto 0);
           core_logic_out : out STD_LOGIC);
end core_logic;

architecture Behavioral of core_logic is

begin

core_logic_out <= core_logic_in(0) and core_logic_in(1) and core_logic_in(2) and core_logic_in(3);

end Behavioral;
