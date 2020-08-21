library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity test is
end test;

architecture behav of test is
  component reg_ex_mem
  port
      (
       clk            : in std_logic;
       newpc          : in std_logic_vector(31 downto 0);
       newpc_out      : out std_logic_vector(31 downto 0);
       alures         : in std_logic_vector(31 downto 0);
       alures_out     : out std_logic_vector(31 downto 0);
       aluzero        : in std_logic;
       aluzero_out    : out std_logic;
       read_data_2    : in std_logic_vector(31 downto 0);
       read_data_2_out: out std_logic_vector(31 downto 0);
       dst_reg        : in std_logic_vector(4 downto 0);
       dst_reg_out    : out std_logic_vector(4 downto 0);
       memwrite    : in std_logic;
       memwrite_out: out std_logic;
       memread     : in std_logic;
       memread_out : out std_logic;
       memtoreg    : in std_logic;
       memtoreg_out: out std_logic;
       regwrite    : in std_logic;
       regwrite_out: out std_logic;
       write_reg     : in std_logic
      );
  end component;

  signal clk            : std_logic;
  signal newpc          : std_logic_vector(31 downto 0);
  signal newpc_out      :  std_logic_vector(31 downto 0);
  signal alures         : std_logic_vector(31 downto 0);
  signal alures_out     :  std_logic_vector(31 downto 0);
  signal aluzero        : std_logic;
  signal aluzero_out    :  std_logic;
  signal read_data_2    : std_logic_vector(31 downto 0);
  signal read_data_2_out:  std_logic_vector(31 downto 0);
  signal dst_reg        : std_logic_vector(4 downto 0);
  signal dst_reg_out    :  std_logic_vector(4 downto 0);
  signal memwrite    : std_logic;
  signal memwrite_out:  std_logic;
  signal memread     : std_logic;
  signal memread_out :  std_logic;
  signal memtoreg    : std_logic;
  signal memtoreg_out:  std_logic;
  signal regwrite    : std_logic;
  signal regwrite_out:  std_logic;
  signal write_reg     : std_logic;
begin
  r_0: reg_ex_mem port map(clk, newpc, newpc_out, alures, alures_out, aluzero, aluzero_out, read_data_2, read_data_2_out, dst_reg, dst_reg_out, memwrite, memwrite_out, memread, memread_out, memtoreg, memtoreg_out, regwrite, regwrite_out, write_reg);
  process
    type pattern_type is record
      clk            : std_logic;
      newpc          : std_logic_vector(31 downto 0);
      newpc_out      :  std_logic_vector(31 downto 0);
      alures         : std_logic_vector(31 downto 0);
      alures_out     :  std_logic_vector(31 downto 0);
      aluzero        : std_logic;
      aluzero_out    :  std_logic;
      read_data_2    : std_logic_vector(31 downto 0);
      read_data_2_out:  std_logic_vector(31 downto 0);
      dst_reg        : std_logic_vector(4 downto 0);
      dst_reg_out    :  std_logic_vector(4 downto 0);
      memwrite    : std_logic;
      memwrite_out:  std_logic;
      memread     : std_logic;
      memread_out :  std_logic;
      memtoreg    : std_logic;
      memtoreg_out:  std_logic;
      regwrite    : std_logic;
      regwrite_out:  std_logic;
      write_reg     : std_logic;
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
    (('0', "00000000000000000000000000001100", "00000000000000000000000000001100", "00000000000000000000000000001100", "00000000000000000000000000001100", '1', '1', "00000000000000000000000000000000", "00000000000000000000000000000000", "00010", "00010", '1', '1', '1', '1', '1', '1', '1', '1', '1'),
    ('1', "00000000000000000000000000001100", "00000000000000000000000000001100", "00000000000000000000000000001100", "00000000000000000000000000001100", '1', '1', "00000000000000000000000000000000", "00000000000000000000000000000000", "00010", "00010", '1', '1', '1', '1', '1', '1', '1', '1', '1'),
    ('0', "00000000000000000000000000001100", "00000000000000000000000000001100", "00000000000000000000000000001100", "00000000000000000000000000001100", '1', '1', "00000000000000000000000000000000", "00000000000000000000000000000000", "00010", "00010", '1', '1', '1', '1', '1', '1', '1', '1', '1'),
    ('1', "00000000000000000000000000001100", "00000000000000000000000000001100", "00000000000000000000000000001100", "00000000000000000000000000001100", '1', '1', "00000000000000000000000000000000", "00000000000000000000000000000000", "00010", "00010", '1', '1', '1', '1', '1', '1', '1', '1', '0'));

    begin
      for i in patterns'range loop

        clk <= patterns(i).clk;

        newpc         <= patterns(i).newpc;
        newpc_out      <= patterns(i).newpc_out;
        alures        <= patterns(i).alures;
        alures_out     <= patterns(i).alures_out;
        aluzero        <= patterns(i).aluzero;
        aluzero_out    <= patterns(i).aluzero_out;
        read_data_2   <= patterns(i).read_data_2;
        read_data_2_out<= patterns(i).read_data_2_out;
        dst_reg      <= patterns(i).dst_reg;
        dst_reg_out   <= patterns(i).dst_reg_out;
        memwrite    <= patterns(i).memwrite;
        memwrite_out<= patterns(i).memwrite_out;
        memread     <= patterns(i).memread;
        memread_out <= patterns(i).memread_out;
        memtoreg    <= patterns(i).memtoreg;
        memtoreg_out<= patterns(i).memtoreg_out;
        regwrite    <= patterns(i).regwrite;
        regwrite_out<= patterns(i).regwrite_out;
        write_reg   <= patterns(i).write_reg;

        wait for 1 ns;
        
          assert read_data_2 = patterns(i).read_data_2
            report "Result Doesn't match" severity error;

        wait for 10 ns;
        end loop;

        assert false report "end of test" severity note;
        wait;
  end process;

end behav;
