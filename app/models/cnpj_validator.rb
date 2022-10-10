class CnpjValidator
  # https://github.com/fnando/cpf_cnpj

  CNPJ_DENY_LIST = %w[
    00000000000000
    11111111111111
    22222222222222
    33333333333333
    44444444444444
    55555555555555
    66666666666666
    77777777777777
    88888888888888
    99999999999999
  ].freeze

  CNPJ_SIZE_VALIDATION = /^\d{11}$/.freeze

  def self.valid?(cnpj)
    cpf.gsub!(/[^\d]/, '')
    return unless CNPJ_SIZE_VALIDATION.match?(cnpj)

    cnpj_numbers = cnpj.chars.map(&:to_i)
    digits = cnpj_numbers[0...12]
    digits << generate_digit(digits)
    digits << generate_digit(digits)

    digits[-2, 2] == cnpj_numbers[-2, 2]
  end

  def self.generate_digit(numbers)
    index = 2

    sum = numbers.reverse.reduce(0) do |buffer, number|
      (buffer + (number * index)).tap do
        index = index == 9 ? 2 : index + 1
      end
    end

    mod = sum % 11
    mod < 2 ? 0 : 11 - mod
  end
end
