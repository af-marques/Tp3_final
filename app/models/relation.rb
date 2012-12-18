class Relation < ActiveRecord::Base
  attr_accessible :assoc_id, :product_id
  validate :check_ids
  validate :assoc_id , :product_id , :presence => true
  def check_ids
    errors.add(:assoc_id, "Can't be the same as product") if assoc_id == product_id
  end
end
