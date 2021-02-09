library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top_Level_tb is
--  Port ( );
end Top_Level_tb;

architecture Behavioral of Top_Level_tb is

component Top_Level
    Port ( pin : in STD_LOGIC_VECTOR (3 downto 0);
           pout : out STD_LOGIC;
           tdo : out STD_LOGIC;
           tdi : in STD_LOGIC;
           tms : in STD_LOGIC;
           tck : in STD_LOGIC);
end component;

signal pin_tb : STD_LOGIC_VECTOR (3 downto 0);
signal pout_tb, tdo_tb, tdi_tb, tms_tb, tck_tb : STD_LOGIC;
constant clk_period : time := 4 ns;

begin

UUT: Top_Level
port map (pin => pin_tb, pout => pout_tb, tdo => tdo_tb, tdi => tdi_tb, tms => tms_tb, tck => tck_tb);

process
begin
	tck_tb <= '1';
	wait for (clk_period / 2);
	tck_tb <= '0';
	wait for (clk_period / 2);
end process;

process
begin
--    pin_tb <= (others => '0');
--    tdi_tb <= '0';
--    tms_tb <= '1';
--    wait for clk_period / 2;
--    wait for (clk_period * 2);
--    tms_tb <= '0';
--    wait for clk_period;
--    tms_tb <= '1';
--    wait for clk_period;
--    tms_tb <= '1';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
    
--    --inside Shift IR
--    tdi_tb <= '0';
--    tms_tb <= '0';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
    
--    tms_tb <= '1';
--    wait for clk_period;
--    tms_tb <= '1';
--    wait for clk_period;
--    tms_tb <= '1';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
    
--    --inside Shift DR
--    tdi_tb <= '1';
--    tms_tb <= '0';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
    
--    tms_tb <= '1';
--    wait for clk_period;
--    tms_tb <= '1';
--    wait for clk_period;
--    tms_tb <= '1';
--    wait for clk_period;
--    tms_tb <= '1';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
    
--    --inside Shift IR
--    tdi_tb <= '1';
--    tms_tb <= '0';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;
    
--    tms_tb <= '1';
--    wait for clk_period;
--    tms_tb <= '1';
--    wait for clk_period;
--    tms_tb <= '0';
--    wait for clk_period;

    pin_tb <= (others => '0');
    tdi_tb <= '0';
    tms_tb <= '0';
    wait for clk_period/2;
    tms_tb <= '1';
    wait for clk_period * 7;
    tms_tb <= '0';
    wait for clk_period;
    wait;
end process;


end Behavioral;
