library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BS_Register is
    Port ( tdi : in STD_LOGIC;
           pin : in STD_LOGIC_VECTOR (3 downto 0);
           core_logic_in : out STD_LOGIC_VECTOR (3 downto 0);
           core_logic_out: in STD_LOGIC;
           pout : out STD_LOGIC;
           clk : in STD_LOGIC;
           mic : in STD_LOGIC;
           mcsc : in STD_LOGIC;
           moc : in STD_LOGIC;
           mlc : in STD_LOGIC;
           enable_ir : in STD_LOGIC;
           rst : in STD_LOGIC;
           tdo : out STD_LOGIC);
end BS_Register;

architecture Behavioral of BS_Register is

signal s0, s1, s2, s3 : STD_LOGIC;

begin

cell0: entity work.BS_Cell(Behavioral)
port map (pin => pin(0), clk => clk, rst => rst, sin => tdi, mic => mic, mcsc => mcsc, moc => moc, mlc => mlc, pout => core_logic_in(0), sout => s0, enable_ir => enable_ir);

cell1: entity work.BS_Cell(Behavioral)
port map (pin => pin(1), clk => clk, rst => rst, sin => s0, mic => mic, mcsc => mcsc, moc => moc, mlc => mlc, pout => core_logic_in(1), sout => s1, enable_ir => enable_ir);

cell2: entity work.BS_Cell(Behavioral)
port map (pin => pin(2), clk => clk, rst => rst, sin => s1, mic => mic, mcsc => mcsc, moc => moc, mlc => mlc, pout => core_logic_in(2), sout => s2, enable_ir => enable_ir);

cell3: entity work.BS_Cell(Behavioral)
port map (pin => pin(3), clk => clk, rst => rst, sin => s2, mic => mic, mcsc => mcsc, moc => moc, mlc => mlc, pout => core_logic_in(3), sout => s3, enable_ir => enable_ir);

cell4: entity work.BS_Cell(Behavioral)
port map (pin => core_logic_out, clk => clk, rst => rst, sin => s3, mic => mic, mcsc => mcsc, moc => moc, mlc => mlc, pout => pout, sout => tdo, enable_ir => enable_ir);

end Behavioral;
