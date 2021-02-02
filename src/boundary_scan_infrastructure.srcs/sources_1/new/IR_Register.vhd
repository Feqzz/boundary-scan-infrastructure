library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IR_Register is
    Port ( pout : out STD_LOGIC_VECTOR (3 downto 0);
           tdi : in STD_LOGIC;
           tdo : out STD_LOGIC;
           mic : in STD_LOGIC;
           mcsc : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           mlc : in STD_LOGIC);
end IR_Register;

architecture Behavioral of IR_Register is

signal sout_vec : STD_LOGIC_VECTOR (2 downto 0);

begin

cell0: entity work.IR_Cell(Behavioral)
port map (pin => '1', clk => clk, rst => rst, sin => tdi, mic => mic, mcsc => mcsc, mlc => mlc, pout => pout(0), sout => sout_vec(0));

cell1: entity work.IR_Cell(Behavioral)
port map (pin => '0', clk => clk, rst => rst, sin => sout_vec(0), mic => mic, mcsc => mcsc, mlc => mlc, pout => pout(1), sout => sout_vec(1));

cell2: entity work.IR_Cell(Behavioral)
port map (pin => '0', clk => clk, rst => rst, sin => sout_vec(1), mic => mic, mcsc => mcsc, mlc => mlc, pout => pout(2), sout => sout_vec(2));

cell3: entity work.IR_Cell(Behavioral)
port map (pin => '1', clk => clk, rst => rst, sin => sout_vec(2), mic => mic, mcsc => mcsc, mlc => mlc, pout => pout(3), sout => tdo);

end Behavioral;
