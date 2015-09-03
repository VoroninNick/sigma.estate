class CreateSigmaAgreements < ActiveRecord::Migration
  def change
    create_table :sigma_agreements do |t|
      t.string :code_number
      t.datetime :laid_at

      t.belongs_to :apartment
      t.belongs_to :client
      t.belongs_to :manager
      t.belongs_to :agreement_template

      t.timestamps null: false
    end
  end
end
