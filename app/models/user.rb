class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis

  after_initialize :set_to_standard

  enum role: [:standard, :premium, :admin]

  def downgrade
    self.wikis.each {|wiki| wiki.publicize}
  end

  private

  def set_to_standard
    self.role ||= :standard
  end

  def publicize
    update_attribute(:private, false)
  end
end
