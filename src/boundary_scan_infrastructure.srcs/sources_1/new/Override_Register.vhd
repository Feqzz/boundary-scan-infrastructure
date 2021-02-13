----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/13/2021 11:15:53 AM
-- Design Name: 
-- Module Name: Override_Register - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Override_Register is
    Port ( pout : out STD_LOGIC_VECTOR (4 downto 0);
               tdi : in STD_LOGIC;
               tdo : out STD_LOGIC;
               mic : in STD_LOGIC;
               mcsc : in STD_LOGIC;
               rst : in STD_LOGIC;
               enable_ir : in STD_LOGIC;
               clk : in STD_LOGIC;
               mlc : in STD_LOGIC);
end Override_Register;

architecture Behavioral of Override_Register is

signal sout_vec : STD_LOGIC_VECTOR (3 downto 0);

begin

cell0: entity work.OR_Cell(Behavioral)
port map (pin => '0', clk => clk, rst => rst, sin => tdi, mic => mic, mcsc => mcsc, mlc => mlc, pout => pout(0), sout => sout_vec(0), enable_ir => enable_ir);

cell1: entity work.OR_Cell(Behavioral)
port map (pin => '0', clk => clk, rst => rst, sin => sout_vec(0), mic => mic, mcsc => mcsc, mlc => mlc, pout => pout(1), sout => sout_vec(1), enable_ir => enable_ir);

cell2: entity work.OR_Cell(Behavioral)
port map (pin => '0', clk => clk, rst => rst, sin => sout_vec(1), mic => mic, mcsc => mcsc, mlc => mlc, pout => pout(2), sout => sout_vec(2), enable_ir => enable_ir);

cell3: entity work.OR_Cell(Behavioral)
port map (pin => '0', clk => clk, rst => rst, sin => sout_vec(2), mic => mic, mcsc => mcsc, mlc => mlc, pout => pout(3), sout => sout_vec(3), enable_ir => enable_ir);

cell4: entity work.OR_Cell(Behavioral)
port map (pin => '0', clk => clk, rst => rst, sin => sout_vec(3), mic => mic, mcsc => mcsc, mlc => mlc, pout => pout(4), sout => tdo, enable_ir => enable_ir);


end Behavioral;
