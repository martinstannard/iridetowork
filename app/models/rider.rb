
class Rider < ActiveRecord::Base
  # Virtual attribute for the unencrypted password
  attr_accessor :password
  has_one       :route
  belongs_to    :image

  validates_length_of       :login,    :within => 3..40

end
