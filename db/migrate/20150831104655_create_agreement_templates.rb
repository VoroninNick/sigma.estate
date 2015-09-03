class CreateAgreementTemplates < ActiveRecord::Migration
  def change
    create_table :agreement_templates do |t|
      t.string :name
      t.text :html_source

      t.timestamps null: false
    end
  end
end
