library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
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

end RegisterFile;

architecture behav of RegisterFile is
    subtype register_t is std_logic_vector(31 downto 0);
    type regfile_t is array (integer range <>) of register_t;


    -- Register file
    signal regfile : regfile_t(31 downto 0);

begin

--------------------------------------------------
------------   READ PORT 1 -----------------------
--------------------------------------------------
    process (clk, regfile, read_reg_1)
    begin
        if read_reg_1 = "00000"  then
            read_data_1 <= (others => '0');
        else
            read_data_1 <= regfile(to_integer(unsigned(read_reg_1)));
        end if;
    end process;

--------------------------------------------------
------------ READ PORT 2 -------------------------
--------------------------------------------------
    process (clk, regfile, read_reg_2)
    begin
        if read_reg_2 = "00000" then
            read_data_2 <= (others => '0');
        else
            read_data_2 <= regfile(to_integer(unsigned(read_reg_2)));
        end if;
    end process;

--------------------------------------------------
------------   WRITE -----------------------------
--------------------------------------------------
    process (clk)
    begin
        if rising_edge(clk) then
          if write_enable = '1' then
            regfile(to_integer(unsigned(write_reg))) <= write_data;
          end if;
        end if;
    end process;

end behav;
