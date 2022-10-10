class CpfValidator
  # https://github.com/fnando/cpf_cnpj

  CPF_DENY_LIST = %w[
    00000000000
    11111111111
    22222222222
    33333333333
    44444444444
    55555555555
    66666666666
    77777777777
    88888888888
    99999999999
    12345678909
    01234567890
  ].freeze

  CPF_SIZE_VALIDATION = /^\d{11}$/.freeze

  def self.valid?(cpf)
    cpf.gsub!(/[^\d]/, '')
    return unless CPF_SIZE_VALIDATION.match?(cpf)

    cpf_numbers = cpf.chars.map(&:to_i)
    digits = cpf_numbers[0...12]
    digits << generate_digit(digits)
    digits << generate_digit(digits)

    digits[-2, 2] == cpf_numbers[-2, 2]
  end

  def self.generate_digit(numbers)
    modulus = numbers.size + 1

    multiplied = numbers.map.each_with_index do |number, index|
      number * (modulus - index)
    end

    mod = multiplied.sum % 11
    mod < 2 ? 0 : 11 - mod
  end
end
