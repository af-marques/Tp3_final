class Product < ActiveRecord::Base
  default_scope :order => 'price'
  attr_accessible :category_id, :description, :image_url, :name, :price
  validates :category_id, :presence  => true
  validates :name, :presence => true, :uniqueness =>true
  validates :price,:numericality => {:greater_than_or_equal_to => 0.01}
  validates :image_url, :format => {
      :with => %r{\.(gif|jpg|png)$}i,
      :message => 'must be a URL for GIF,JPG or PNG image.'
  }
  belongs_to :category, :foreign_key => :category_id
  has_many :relations, :dependent => :destroy
  has_many :line_items


  before_destroy :ensure_not_referenced_by_any_line_item
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

  def self.search(search,var)
    if search
      find(:all, :conditions => [var+' LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def snippet(thought, wordcount)

    thought.split[0..(wordcount-1)].join(" ")
    + (thought.split.size > wordcount ? "..." : "")

  end

end
