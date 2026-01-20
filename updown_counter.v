library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity updown_counter is
    Port (
        i_clk       : in  STD_LOGIC;
        i_reset     : in  STD_LOGIC;
        o_cntup     : out STD_LOGIC_VECTOR(3 downto 0);
        o_cntdown   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end updown_counter;

architecture Behavioral of updown_counter is

    signal bin_cnt : STD_LOGIC_VECTOR(24 downto 0) := (others => '0');
    signal f_clk   : std_logic := '0';
    constant min      : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    constant max      : STD_LOGIC_VECTOR(3 downto 0) := "1001";
    signal cnt_up     : STD_LOGIC_VECTOR(3 downto 0) := min;
    signal cnt_down   : STD_LOGIC_VECTOR(3 downto 0) := max;

begin

    frequency_divider: process(i_clk, i_reset)
    begin
        if i_reset = '1' then
            bin_cnt <= (others => '0');
        elsif rising_edge(i_clk) then
            bin_cnt <= bin_cnt + 1;
        end if;
    end process frequency_divider;

    f_clk <= bin_cnt(24);

    up_counter: process(f_clk, i_reset)
    begin
        if i_reset = '1' then
            cnt_up <= min;
        elsif rising_edge(f_clk) then
            if cnt_up >= max then
                cnt_up <= min;
            else
                cnt_up <= cnt_up + 1;
            end if;
        end if;
    end process up_counter;

    down_counter: process(f_clk, i_reset)
    begin
        if i_reset = '1' then
            cnt_down <= max;
        elsif rising_edge(f_clk) then
            if cnt_down = min then
                cnt_down <= max;
            else
                cnt_down <= cnt_down - 1;
            end if;
        end if;
    end process down_counter;

    o_cntup   <= cnt_up;
    o_cntdown <= cnt_down;

end Behavioral;

