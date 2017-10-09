def cesar(string, key)

  result = []

  string.each_char do |lettre|
    bon_code = lettre.ord
    crytp_code = bon_code + key

    if bon_code === 32
      crypt_letter = ' '
    else
      if crytp_code > 122
        crytp_code = crytp_code - 122 + 96
      end

      crypt_letter = crytp_code.chr
    end

    result << crypt_letter
  end

  return result.join

end


puts cesar("what a string", 5)