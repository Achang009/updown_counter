library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity updown_counter_split is
    Port (
        i_clk        : in  STD_LOGIC;
        i_reset      : in  STD_LOGIC;
        o_count_up   : out STD_LOGIC_VECTOR(3 downto 0); 
        o_count_down : out STD_LOGIC_VECTOR(3 downto 0) 
    );
end updown_counter_split;

architecture Behavioral of updown_counter_split is

    constant MAX_COUNT : unsigned(3 downto 0) := "1001";
    signal r_cnt_up   : unsigned(3 downto 0) := (others => '0');
    signal r_cnt_down : unsigned(3 downto 0) := MAX_COUNT;

begin

    UP_COUNT_PROC: process(i_clk, i_reset)
    begin
        if i_reset = '1' then
            r_cnt_up <= (others => '0');
        elsif rising_edge(i_clk) then
            if r_cnt_up >= MAX_COUNT then
                r_cnt_up <= (others => '0'); 
            else
                r_cnt_up <= r_cnt_up + 1;  
            end if;
        end if;
    end process UP_COUNT_PROC;

    DOWN_COUNT_PROC: process(i_clk, i_reset)
    begin
        if i_reset = '1' then
            r_cnt_down <= MAX_COUNT;
        elsif rising_edge(i_clk) then
            if r_cnt_down = 0 then
                r_cnt_down <= MAX_COUNT;
            else
                r_cnt_down <= r_cnt_down - 1;
            end if;
        end if;
    end process DOWN_COUNT_PROC;

    OUTPUT_PROC: process(r_cnt_up, r_cnt_down)
    begin
        o_count_up   <= std_logic_vector(r_cnt_up);
        o_count_down <= std_logic_vector(r_cnt_down);
    end process OUTPUT_PROC;

end Behavioral;