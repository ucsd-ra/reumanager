class AddGenDescrAndHighlightsAndEligibilityToGrants < ActiveRecord::Migration[5.1]
  def change
    add_column :grants, :gen_descr, :text
    add_column :grants, :highlights, :text
    add_column :grants, :eligibility, :text
  end
end
