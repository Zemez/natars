# The ancient mysterious Natarian riddle
FIGURES = [ :spider, :human, :clock, :brush, :pouch, :fish, :hands, :cells ]
MAX_DIGIT = 9
# символы должны быть в обратном порядке: [<единицы>, <десятки>, <сотни>, ...]
NATAR_NUMBERS = [[:spider, :human, :spider], [:brush, :spider, :clock], [:human, :pouch, :pouch],
                 [:clock, :hands, :fish], [:human, :human, :human], [:human, :pouch, :cells],
                 [:spider, :brush, :pouch], [:spider, :brush, :cells], [:clock, :clock, :fish]]

def lookup(figures_map = {}, figure = FIGURES[0])
  bingo = []
  (MAX_DIGIT+1).times do |digit|
    has_digit = figures_map.select { |key,val| FIGURES.index(key) < FIGURES.index(figure) and val == digit }
    # p has_digit
    if has_digit.empty?
      figures_map[figure] = digit
      if figure == FIGURES.last
        check = true

        num = NATAR_NUMBERS.map { |nat_num| map_to_number(figures_map, nat_num) }

        check &&= (num[0] - num[1]) == num[2]
        check &&= (num[3] + num[4]) == num[5]
        check &&= (num[6] - num[7]) == num[8]

        check &&= (num[0] - num[3]) == num[6]
        check &&= (num[1] + num[4]) == num[7]
        check &&= (num[2] - num[5]) == num[8]

        if check
          # puts "bingo: #{figures_map}"
          bingo << figures_map
        end
      else
        next_figure = FIGURES[FIGURES.index(figure)+1]
        bingo += lookup(figures_map, next_figure)
      end
    end
  end
  bingo
end

# передаем символы в обратном порядке: [<единицы>, <сотни>, <тысячи>, ...]
def map_to_number(figures_map, figures)
  number = 0
  dec = 1
  figures.each do |figure|
    # p figure, figures_map
    number += figures_map[figure]*dec
    dec *= 10
  end
  number
end

look = lookup()
puts 'bingo:' unless look.nil?
puts look

