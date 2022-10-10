class Person < ApplicationRecord
  require 'cpf_validator'
  require 'cnpj_validator'

  has_many :addresses
  validates_associated :addresses

  validates :name, presence: true
  validates :document, presence: true, format: {
    with: %r{([0-9]{2}\.?[0-9]{3}\.?[0-9]{3}/?[0-9]{4}-?[0-9]{2})|([0-9]{3}\.?[0-9]{3}\.?[0-9]{3}-?[0-9]{2})},
    message: I18n.t('person.must_be_cpf_cnpj')
  }
  validate :document, :valid_cpf_or_cnpj

  protected

  def valid_cpf_or_cnpj
    return if CpfValidator.valid?(document) && CnpjValidator.valid?(document)

    errors.add(:document, I18n.t('person.invalid_cpf_cnpj'))
  end
end
