class RenamePricePriceCents < ActiveRecord::Migration[6.0]
  def up 
    rename_column :properties, :price, :price_cents
  end

  def down
    rename_column :properties, :price_cents, :price
  end
end
