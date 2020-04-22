class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.string :digits
      t.integer :cvc
      t.integer :month
      t.integer :year
      t.string :stripe_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
