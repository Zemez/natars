# bla-bla-bla
FIGURES = [ :spider, :human, :clock, :brush, :pouch, :fish, :hands, :cells ]
MAX_NUM = 9

def lookup(numbers = nil, fig = FIGURES[0])
  n = numbers.nil? ? { spider: nil, human: nil, clock: nil, brush: nil, pouch: nil, fish: nil, hands: nil, cells: nil } : numbers
  i = FIGURES.index(fig)
  (MAX_NUM+1).times do |num|
    has_num = n.select { |key,val| FIGURES.index(key) < FIGURES.index(fig) and val == num }
    # puts has_num
    if has_num.empty?
      n[fig] = num
      if i == FIGURES.size - 1
        # puts "test: #{n}"
        n1 = n[:spider]*100 + n[:human]*10 + n[:spider]
        n2 = n[:clock]*100 + n[:spider]*10 + n[:brush]
        n3 = n[:pouch]*100 + n[:pouch]*10 + n[:human]
        # puts "#{'%03d'%n1} #{'%03d'%n2} #{'%03d'%n3}"

        n4 = n[:fish]*100 + n[:hands]*10 + n[:clock]
        n5 = n[:human]*100 + n[:human]*10 + n[:human]
        n6 = n[:cells]*100 + n[:pouch]*10 + n[:human]
        # puts "#{'%03d'%n4} #{'%03d'%n5} #{'%03d'%n6}"

        n7 = n[:pouch]*100 + n[:brush]*10 + n[:spider]
        n8 = n[:cells]*100 + n[:brush]*10 + n[:spider]
        n9 = n[:fish]*100 + n[:clock]*10 + n[:clock]
        # puts "#{'%03d'%n7} #{'%03d'%n8} #{'%03d'%n9}"

        c1 = ((n1 - n2) == n3)
        c2 = ((n4 + n5) == n6)
        c3 = ((n7 - n8) == n9)

        c4 = ((n1 - n4) == n7)
        c5 = ((n2 + n5) == n8)
        c6 = ((n3 - n6) == n9)

        if c1 and c2 and c3 and c4 and c5 and c6
          puts "bingo: #{n}"
        end
      else
        next_fig = FIGURES[FIGURES.index(fig)+1]
        lookup(n, next_fig)
      end
    end
  end
end

lookup()
