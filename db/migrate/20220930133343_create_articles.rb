class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :bg_image_url
      t.string :label
      t.string :description
      t.text :content
      t.boolean :published, default: false
      t.boolean :worth_reading, default: false

      t.timestamps
    end
  end
end
