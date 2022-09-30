class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :article_type
      t.string :bg_image_url
      t.string :label
      t.string :description
      t.text :content

      t.timestamps
    end
  end
end
