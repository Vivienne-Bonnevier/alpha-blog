class ChangeArticleCategoriesConstraint < ActiveRecord::Migration[7.0]
  def change
    change_table :article_categories do |t|
      t.index %i[article_id category_id], unique: true
    end
  end
end
