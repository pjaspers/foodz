class Parser

  def food_items
    @food_items ||= Food.all.inject([]) do |result, food|
      parts = food.name.downcase.split(" ").uniq.reject do |p|
        %w(+ - met en cl broodje).include?(p) || p.length < 2
      end
      result << parts.inject({}) do |result, part|
        result[/\b#{part}\b/] = food
        result
      end
      result
    end
  end

  def parse(text)
    lines = tokenize(text)
    result = {}
    lines.each do |line|
      line.gsub!(/[^0-9a-zA-Z ]/, "")
      line.downcase!
      line.strip!
      result[line] = []
      words = line.split(" ")
      words.reject!{|w| ["de", "het", "een"].include?(w)}
      words.reject!{|w| ["met", "zonder"].include?(w)}
      words.reject!{|w| ["andalouse", "samurai", "cocktailsaus", "mayo", "ketchup"].include?(w)}
      words.reject!{|w| ["brood", "broodje", "smos"].include?(w)}
      words.reject!{|w| ["klein", "midden", "grote", "kleine", "grote"].include?(w)}
      words.reject!{|w| ["fitness", "fitnes", "grote", "kleine", "grote"].include?(w)}
      r = []
      words.each do |word|
        r << find_food(word)
      end
      result[line] = r.compact.reject(&:empty?).inject(:&)
    end
    result
  end

  def find_food(word)
    # Food.select("*, levenshtein(name, '#{s}') as LVH").where(f[:name].matches("%#{s}%")).order("LVH ASC").collect(&:name)
    like = Food.arel_table[:name].matches("%#{word}%")
    food = Food.where(like)
    if food.count == 0
      # food = Food.select("*, levenshtein(name, '#{word}') as LVH").order("LVH ASC").limit(1)
      food = food.where("levenshtein(name, '#{word}') < 10")
    # elsif food.count > 1
    #   food = food.where("levenshtein(name, '#{word}') < 10")
    end
    food.to_a
  end

  def tokenize(text)
    text = normalize(text)
    text.split(/en een|[0-9]/)
  end

  def scan_for_food_items(word)
    foods = []
    food_items.each do |hash|
      hash.each do |regex, value|
        if regex =~ word
          foods << value
        end
      end
    end
    if foods.length > 0
      foods
    else
      nil
    end
  end

  def normalize(text)
    text = text.downcase.strip
    text.gsub!(/\bsamo?urai\b/, 'samurai')
    text.gsub!(/\ben ne\b/, 'en een')
    text.gsub!(/(en|\+) (een|ne)/, 'en een')
    text.gsub!(/\+ ([0-9]+)/, 'en \1')
    text.gsub!("+ curryrol", 'en een curryrol')
    text.gsub!(/\bslaatje\b/, "salade")
    text.gsub!(/\hawaii?\b/, "hawai")
    text.gsub!(/\bpoll?o\b/, "pollo")
    text.gsub!("heps", "hesp")
    text.gsub!(/\bkip curry\b/, "kipcurry")
    text.gsub!(/sa(m|n)dwh?ich/, "sandwich")
    text.gsub!(/kippen?wit/, "kippenwit")
    text
  end
end
