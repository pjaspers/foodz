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
      result[line] = []
      line.split(" ").each do |word|
        if foods = scan_for_food_items(word)
          result[line] = foods
        end
      end
    end
    result
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
