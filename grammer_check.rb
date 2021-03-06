class GrammerCheck
  
  def validate_sentence(sentence)
    error_display = []
    sentence.strip!
    error_display << check_first_character(sentence)
    error_display << check_double_space(sentence)
    error_display << check_double_upcase(sentence)
    error_display << check_full_stop(sentence)

    error_got = error_display.select { |error| error unless error.nil? }.join("\n")
    puts "\n"
    if error_got.size > 0
      puts 'Given sentence is wrong because' + "\n" + error_got
    else
      puts 'Given sentence is correct, sentence does not have grammer mistake'
    end
    puts "\n"
  end

  def check_first_character(sentence)
    unless sentence =~ /^[A-Z]/
      'First character should start with upper case'
    end
  end

  def check_double_space(sentence)
    unless sentence.gsub(/\s+/, ' ') == sentence
      'Two spaces are not allowed'
    end
  end

  def check_last_character(sentence)
    sentence[-2].match(/[A-Z]/).nil?
  end

  def check_double_upcase(sentence)
    loop_value    = 0
    increment_one = 1
    while loop_value < sentence.length do
      caps_found         = print_index(sentence, loop_value)
      if caps_found
        increment_by_one = caps_found + increment_one
        again_found      = print_index(sentence, increment_by_one)
        if again_found && increment_by_one == again_found
          return 'Two Uppercase characters are not allowed continuously'
        elsif again_found
          loop_value = again_found
        else
          loop_value = caps_found + increment_one
        end
      else
        loop_value   = loop_value + increment_one
      end
    end
  end

  def check_full_stop(sentence)
    if sentence[-1] != '.'
      'Sentence should end with full stop'
    elsif sentence[-1] == '.' && !sentence[-2].match(/[a-z,A-Z]/)
      'Sentence should not end with space'
    end
  end

  private
  def print_index(sentence, index)
    sentence.index(/[A-Z]/, index)
  end

end
puts 'Please enter a sentence to check grammer mistake'
user_sentence   = gets.chomp
instance_object = GrammerCheck.new
instance_object.validate_sentence(user_sentence)
