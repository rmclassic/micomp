library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity test is
end test;

architecture behav of test is
  component DataMem
    port (
      clk          : in  std_logic;
      address      : in  std_logic_vector(31 downto 0);
      datain       : in  std_logic_vector(31 downto 0);
      write_enable : in  std_logic;
      dataout      : out std_logic_vector(31 downto 0)
    );
  end component;

  signal clk          : std_logic;
  signal address      : std_logic_vector(31 downto 0);
  signal datain       : std_logic_vector(31 downto 0);
  signal write_enable : std_logic;
  signal dataout      : std_logic_vector(31 downto 0);
begin
  datamem_0: DataMem port map(clk, address, datain , write_enable, dataout);
  process
    type pattern_type is record
      clk          : std_logic;
      address      : std_logic_vector(31 downto 0);
      datain       : std_logic_vector(31 downto 0);
      write_enable : std_logic;
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
        write_enable <= patterns(i).write_enable;
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
