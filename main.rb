# The ancient mysterious Natarian riddle
# https://blog.kingdoms.com/2018/10/01/the-ancient-mysterious-natarian-riddle/
NUM_SYS = 10  # система счисления
NATAR_NUMBERS = [[:spider, :human, :spider], [:clock, :spider, :brush], [:pouch, :pouch, :human],
                 [:fish, :hands, :clock], [:human, :human, :human], [:cells, :pouch, :human],
                 [:pouch, :brush, :spider], [:cells, :brush, :spider], [:fish, :clock, :clock]]
FIGURES = NATAR_NUMBERS.flatten.uniq

# проверки вынес во внешний блок, с yield почему то не заработало
def check?(num)
  check = true

  check &&= (num[0] - num[1]) == num[2]
  check &&= (num[3] + num[4]) == num[5]
  check &&= (num[6] - num[7]) == num[8]

  check &&= (num[0] - num[3]) == num[6]
  check &&= (num[1] + num[4]) == num[7]
  check &&= (num[2] - num[5]) == num[8]
end

# figures_map - соотеветствия символов натар -> цифра
# figures[] - символы натар
# return - число
def map_to_number(figures_map, figures)
  figures.inject(0) { |number,figure| number*NUM_SYS + figures_map[figure] }
end

# рекурсивный поиск
def lookup(figures_map = {}, figure = FIGURES[0])
  bingo = [] if bingo.nil?
  NUM_SYS.times do |digit|
    has_digit = figures_map.select { |key,val| FIGURES.index(key) < FIGURES.index(figure) and val == digit }
    # p has_digit
    if has_digit.empty?
      figures_map[figure] = digit
      if figure == FIGURES.last
        num = NATAR_NUMBERS.map { |nat_num| map_to_number(figures_map, nat_num) }

        if check? num
          bingo << figures_map.clone
          # p bingo
        end
      else
        next_figure = FIGURES[FIGURES.index(figure)+1]
        bingo += lookup(figures_map, next_figure) 
      end
    end
  end
  bingo
end

# запуск
look = lookup()
puts 'bingo:' unless look.empty?
puts look
