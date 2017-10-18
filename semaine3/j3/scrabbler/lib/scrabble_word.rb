$table_points = {
  a: 1, b: 3, c: 3, d: 2, e: 1,
  f: 4, g: 2, h: 4, i: 1, j: 8,
  k: 5, l: 1, m: 3, n: 1, o: 1,
  p: 3, q: 10, r: 1, s: 1, t: 1,
  u: 1, v: 4, w: 4, x: 8, y: 4,
  z: 10
}

class ScrabbleWord

  attr_writer :word
  attr_reader :word

  def initialize(word)
    @word = word.downcase
    @score = 0
  end

  def word
    return @word
  end

  def score
    @word = @word.split('')
    @word.each do |lettre|
      $table_points.keys.each do |key|
        if lettre.to_s == key.to_s
          @score += $table_points[key]
        end
      end
    end
    @word = @word.join

    return @score
  end

  def multiplier_score(coef)
    score
    return @score * coef
  end

end


mot1 = ScrabbleWord.new('poncho')
puts mot1.score

# binding.pry