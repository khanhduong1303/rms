class CreateAdsBanners < ActiveRecord::Migration
  def change
    create_table :ads_banners do |t|
      t.string :title
      t.string :name
      t.attachment :image

      t.timestamps
    end
  end
end
