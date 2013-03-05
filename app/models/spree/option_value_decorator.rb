Spree::OptionValue.class_eval do

  attr_accessible :image

  has_attached_file :image,
    :styles        => { :small => '40x30#', :large => '140x110#' },
    :default_style => :small,
    :url           => "/spree/option_values/:id/:style/:basename.:extension",
    :path          => ":rails_root/public/spree/option_values/:id/:style/:basename.:extension"

  def has_image?
    image_file_name && !image_file_name.empty?
  end

  scope :for_product, lambda { |product|
    uniq.where("spree_option_values_variants.variant_id IN (?)", product.variant_ids)
    .joins(:variants).order_by_positions
  }

  scope :order_by_positions, joins(:option_type).order("#{Spree::OptionType.quoted_table_name}.position asc, #{quoted_table_name}.position asc")
end
