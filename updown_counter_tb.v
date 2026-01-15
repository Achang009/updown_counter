library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_updown_counter_split is
end tb_updown_counter_split;

architecture Behavioral of tb_updown_counter_split is

    component updown_counter_split
    Port (
        i_clk        : in  STD_LOGIC;
        i_reset      : in  STD_LOGIC;
        o_countup   : out STD_LOGIC_VECTOR(3 downto 0);
        o_countdown : out STD_LOGIC_VECTOR(3 downto 0)
    );
    end component;

    signal i_clk        : std_logic := '0';
    signal i_reset      : std_logic := '0';
    signal o_countup   : std_logic_vector(3 downto 0);
    signal o_countdown : std_logic_vector(3 downto 0);
    constant CLK_PERIOD : time := 10 ns;

begin

    uut: updown_counter_split Port Map (
        i_clk        => i_clk,
        i_reset      => i_reset,
        o_count_up   => o_count_up,
        o_count_down => o_count_down
    );

    CLK_PROCESS : process
    begin
        i_clk <= '0';
        wait for CLK_PERIOD / 2;
        i_clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    STIM_PROC: process
    begin
  
        i_reset <= '1';
        wait for 20 ns;

        -- 放開 Reset，開始計數
        i_reset <= '0';
        
        -- 在這裡等待一段時間，讓計數器跑幾個循環
        -- 上數應該會看到：0, 1, 2... 8, 0...
        -- 下數應該會看到：8, 7, 6... 0, 8...
        wait for 200 ns;

        -- 測試結束 (可選)
        wait;
    end process;


end Behavioral;
