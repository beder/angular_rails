class CreatePromoterNetworks < ActiveRecord::Migration
  def change
    create_table :promoter_networks do |t|
      t.string :name

      t.timestamps
    end
  end
end
