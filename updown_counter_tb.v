library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_updown_counter_split is
-- Testbench 的 entity 通常是空的
end tb_updown_counter_split;

architecture Behavioral of tb_updown_counter_split is

    -- 1. 宣告要測試的元件 (Component)
    -- 名稱與 Port 必須與原本的設計完全一致
    component updown_counter_split
    Port (
        i_clk        : in  STD_LOGIC;
        i_reset      : in  STD_LOGIC;
        o_count_up   : out STD_LOGIC_VECTOR(3 downto 0);
        o_count_down : out STD_LOGIC_VECTOR(3 downto 0)
    );
    end component;

    -- 2. 宣告內部訊號用來連接元件
    signal tb_clk        : std_logic := '0';
    signal tb_reset      : std_logic := '0';
    signal tb_count_up   : std_logic_vector(3 downto 0);
    signal tb_count_down : std_logic_vector(3 downto 0);

    -- 定義時脈週期 (例如 10奈秒)
    constant CLK_PERIOD : time := 10 ns;

begin

    -- 3. 實例化 (Instantiate) 元件：將訊號線接上去
    uut: updown_counter_split Port Map (
        i_clk        => tb_clk,
        i_reset      => tb_reset,
        o_count_up   => tb_count_up,
        o_count_down => tb_count_down
    );

    -- 4. 產生時脈訊號 Process
    CLK_PROCESS : process
    begin
        tb_clk <= '0';
        wait for CLK_PERIOD / 2;
        tb_clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- 5. 測試激勵 Process (Stimulus)
    STIM_PROC: process
    begin
        -- 初始狀態：按下 Reset
        tb_reset <= '1';
        wait for 20 ns; -- 保持 Reset 一段時間

        -- 放開 Reset，開始計數
        tb_reset <= '0';
        
        -- 在這裡等待一段時間，讓計數器跑幾個循環
        -- 上數應該會看到：0, 1, 2... 8, 0...
        -- 下數應該會看到：8, 7, 6... 0, 8...
        wait for 200 ns;

        -- 測試結束 (可選)
        wait;
    end process;

end Behavioral;