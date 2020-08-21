library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity test is
end test;

architecture behav of test is
  component InsMem
    port (
      clk     : in  std_logic;
      address : in  std_logic_vector(31 downto 0);
      dataout : out std_logic_vector(31 downto 0);
      datain  : in std_logic_vector(31 downto 0);
      writeins: in std_logic
    );
  end component;

  signal clk          : std_logic;
  signal address      : std_logic_vector(31 downto 0);
  signal datain       : std_logic_vector(31 downto 0);
  signal writeins : std_logic;
  signal dataout      : std_logic_vector(31 downto 0);
begin
  datamem_0: InsMem port map(clk, address, dataout, datain, writeins);
  process
    type pattern_type is record
      clk          : std_logic;
      address      : std_logic_vector(31 downto 0);
      datain       : std_logic_vector(31 downto 0);
      writeins : std_logic;
      dataout      : std_logic_vector(31 downto 0);
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
    (('0', "00000000000000000000000000000001", "00000000000000000000000000000000", '0', "00000000000000000000000000000000"),
    ('1', "00000000000000000000000000000001", "00000000000000000000000000000011", '1', "00000000000000000000000000000000"),
    ('0', "00000000000000000000000000000001", "00000000000000000000000000000000", '0', "00000000000000000000000000000000"),
    ('1', "00000000000000000000000000000001", "00000000000000000000000000000000", '0', "00000000000000000000000000000011"));

    begin
      for i in patterns'range loop

        clk <= patterns(i).clk;
        address <= patterns(i).address;
        datain <= patterns(i).datain;
        writeins <= patterns(i).writeins;
        dataout <= patterns(i).dataout;

        wait for 1 ns;

        assert dataout = patterns(i).dataout
          report "Result Doesn't match" severity error;

        wait for 10 ns;
        end loop;

        assert false report "end of test" severity note;
        wait;
  end process;

end behav;
