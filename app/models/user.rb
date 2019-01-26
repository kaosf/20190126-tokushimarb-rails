class User < ApplicationRecord
  devise :two_factor_authenticatable,
         :otp_secret_encryption_key => ENV['DEVISE_MFA_ENCRYPTION_KEY']

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable

  devise :two_factor_backupable, otp_number_of_backup_codes: 10
  serialize :otp_backup_codes, JSON

  has_many :entries, dependent: :destroy
end
