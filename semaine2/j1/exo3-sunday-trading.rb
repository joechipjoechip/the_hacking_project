def sunday_trading(arr)

  metaArr = []
  best = {:difference => 0}

  arr.each_with_index do |value, index|

    arr.each_with_index do |compare_value, compare_index|
      if compare_index > index && compare_value - value > 0
        metaArr << { :difference => (compare_value - value), :index_de_base => index, :index_de_comparaison => compare_index }
      end
      
    end

  end

  metaArr.each do |elem|
    if elem[:difference] > best[:difference]
      best = elem
    end
  end

  return [best[:index_de_base], best[:index_de_comparaison]]

end

p sunday_trading([17,3,6,9,15,8,6,1,10])
