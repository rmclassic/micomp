library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity test is
end test;

architecture behav of test is
  component RegisterFile
    port
        (
         clk         : in std_logic;
         read_reg_1   : in  std_logic_vector(4 downto 0);
         read_reg_2   : in  std_logic_vector(4 downto 0);
         write_reg    : in  std_logic_vector(4 downto 0);
         write_data   : in  std_logic_vector(31 downto 0);
         write_enable : in  std_logic;
         read_data_1  : out  std_logic_vector(31 downto 0);
         read_data_2  : out  std_logic_vector(31 downto 0)
        );
  end component;

  signal clk          : std_logic;
  signal read_reg_1   : std_logic_vector(4 downto 0);
  signal read_reg_2   : std_logic_vector(4 downto 0);
  signal write_reg    : std_logic_vector(4 downto 0);
  signal write_data   : std_logic_vector(31 downto 0);
  signal write_enable : std_logic;
  signal read_data_1  : std_logic_vector(31 downto 0);
  signal read_data_2  : std_logic_vector(31 downto 0);
begin
  rf_0: RegisterFile port map(clk, read_reg_1, read_reg_2, write_reg, write_data, write_enable, read_data_1, read_data_2);
  process
    type pattern_type is record
    clk         : std_logic;
    read_reg_1   :std_logic_vector(4 downto 0);
    read_reg_2   :std_logic_vector(4 downto 0);
    write_reg    :std_logic_vector(4 downto 0);
    write_data   :std_logic_vector(31 downto 0);
    write_enable :std_logic;
    read_data_1  : std_logic_vector(31 downto 0);
    read_data_2  : std_logic_vector(31 downto 0);
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
    (('0', "00000", "00000", "00001", "00000000000000000000000000001100", '0', "00000000000000000000000000000000", "00000000000000000000000000000000"),
    ('1', "00000", "00000", "00001", "00000000000000000000000000001100", '1', "00000000000000000000000000000000", "00000000000000000000000000000000"),
    ('0', "00000", "00000", "00010", "00000000000000000000000000001100", '0', "00000000000000000000000000000000", "00000000000000000000000000000000"),
    ('1', "00000", "00000", "00010", "00000000000000000000000000001100", '1', "00000000000000000000000000000000", "00000000000000000000000000000000"),
    ('0', "00000", "00000", "00001", "00000000000000000000000000001100", '0', "00000000000000000000000000000000", "00000000000000000000000000000000"),
    ('1', "00001", "00010", "00001", "00000000000000000000000000001100", '0', "00000000000000000000000000001100", "00000000000000000000000000001100"));

    begin
      for i in patterns'range loop

        clk <= patterns(i).clk;
        read_reg_1 <= patterns(i).read_reg_1;
        read_reg_2 <= patterns(i).read_reg_2;
        write_reg <= patterns(i).write_reg;
        write_data <= patterns(i).write_data;
        write_enable <= patterns(i).write_enable;
        read_data_1 <= patterns(i).read_data_1;
        read_data_2 <= patterns(i).read_data_2;

        wait for 1 ns;

        assert read_data_1 = patterns(i).read_data_1
          report "Result Doesn't match" severity error;

          assert read_data_2 = patterns(i).read_data_2
            report "Result Doesn't match" severity error;

        wait for 10 ns;
        end loop;

        assert false report "end of test" severity note;
        wait;
  end process;

end behav;
