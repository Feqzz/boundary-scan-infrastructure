library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top_Level is
    Port ( pin : in STD_LOGIC_VECTOR (3 downto 0);
           pout : out STD_LOGIC;
           tdo : out STD_LOGIC;
           tdi : in STD_LOGIC;
           tms : in STD_LOGIC;
           tck : in STD_LOGIC);
end Top_Level;

architecture Behavioral of Top_Level is

signal internal_rst, tap_mux_signal,
data_mux_tdo, ir_tdo, bp_tdo, bs_reg_tdo, bs_moc, internal_core_logic_out,
ir_mic, ir_mcsc, ir_mlc, bs_mic, bs_mcsc, bs_mlc, bp_mic, bp_mcsc,
or_mic, or_mcsc, or_mlc, or_tdo, bp_en, bs_en, or_en : STD_LOGIC;

signal instruction_register_pout, internal_core_logic_in: STD_LOGIC_VECTOR (3 downto 0);
signal override_register_pout : STD_LOGIC_VECTOR (4 downto 0);
signal ir_decoder_mux_signal_bus : STD_LOGIC_VECTOR (1 downto 0);

begin

tdo <= ir_tdo when tap_mux_signal = '1' else
    data_mux_tdo;

data_mux_tdo <= bs_reg_tdo when ir_decoder_mux_signal_bus = "00" else
    or_tdo when ir_decoder_mux_signal_bus = "01" else
    bp_tdo;

tap_controller: entity work.TAP_Controller(Behavioral)
port map (tms => tms, clk => tck, rst_to_others => internal_rst, ir_mic => ir_mic, ir_mcsc => ir_mcsc, ir_mlc => ir_mlc,
bs_mic => bs_mic, bs_mcsc => bs_mcsc, bs_mlc => bs_mlc, data_instruction_mux_controller_signal => tap_mux_signal,
bp_reg_mic => bp_mic, bp_reg_mcsc => bp_mcsc, or_mic => or_mic, or_mcsc => or_mcsc, or_mlc => or_mlc);

instruction_register: entity work.IR_Register(Behavioral)
port map (pout => instruction_register_pout, tdi => tdi, tdo => ir_tdo, mic => ir_mic, mcsc => ir_mcsc, rst => internal_rst, clk => tck, mlc => ir_mlc);

instruction_decoder: entity work.IR_Decoder(Behavioral)
port map (instruction => instruction_register_pout, data_mux => ir_decoder_mux_signal_bus, bs_moc => bs_moc, bs_en => bs_en, bp_en => bp_en, or_en => or_en);

bp_cell: entity work.BP_Cell(Behavioral)
port map (clk => tck, rst => internal_rst, sin => tdi, sout => bp_tdo, mcsc => bp_mcsc, enable_ir => bp_en, mic => bp_mic);

core_logic: entity work.Core_Logic(Behavioral)
port map (core_logic_in => internal_core_logic_in, core_logic_out => internal_core_logic_out);

bs_reg: entity work.BS_Register(Behavioral)
port map (tdi => tdi, pin => pin, core_logic_in => internal_core_logic_in, core_logic_out => internal_core_logic_out,
pout => pout, clk => tck, mic => bs_mic, moc => bs_moc, mcsc => bs_mcsc, mlc => bs_mlc, rst => internal_rst, tdo => bs_reg_tdo, enable_ir => bs_en, override_enable_bus => override_register_pout);

or_reg: entity work.Override_Register(Behavioral)
port map (pout => override_register_pout, tdi => tdi, tdo => or_tdo, mic => or_mic, mcsc => or_mcsc, rst => internal_rst, clk => tck, mlc => or_mlc, enable_ir => or_en);

end Behavioral;
