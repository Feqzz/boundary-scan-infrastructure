library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TAP_Controller_tb is
--  Port ( );
end TAP_Controller_tb;

architecture Behavioral of TAP_Controller_tb is

component TAP_Controller
    Port ( tms : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end component;

signal tms_tb, clk_tb, rst_tb : STD_LOGIC;
constant clk_period : time := 4 ns;

begin

UUT: TAP_Controller
port map (tms => tms_tb, clk => clk_tb, rst => rst_tb);

process
begin
	clk_tb <= '1';
	wait for (clk_period / 2);
	clk_tb <= '0';
	wait for (clk_period / 2);
end process;

process
begin
    rst_tb <= '0';
    tms_tb <= '0';
    wait for 4ns;
    tms_tb <= '1';
    wait for 4ns;
    tms_tb <= '1';
    wait for 4ns;
    tms_tb <= '0';
    wait for 4ns;
    tms_tb <= '0';
    wait for 4ns;
    tms_tb <= '0';
    wait for 4ns;
    tms_tb <= '0';
    wait for 4ns;
    tms_tb <= '0';
    wait for 4ns;
    tms_tb <= '0';
    wait for 4ns;
    tms_tb <= '0';
    wait for 4ns;
    tms_tb <= '0';
    wait for 4ns;
    tms_tb <= '0';
    wait for 4ns;
    tms_tb <= '1';
    wait for 4ns;
    tms_tb <= '1';
    wait for 4ns;
    tms_tb <= '0';
    wait;
end process;

end Behavioral;