Spree::Variant.class_eval do

  include ActionView::Helpers::NumberHelper

  attr_accessible :option_values

  def to_hash(current_currency)
    actual_price  = self.price_in(current_currency).display_price
    #actual_price += Calculator::Vat.calculate_tax_on(self) if Spree::Config[:show_price_inc_vat]
    {
      :id    => self.id,
      :count => self.count_on_hand,
      :on_demand => self.on_demand,
      :price => actual_price
    }
  end

end
