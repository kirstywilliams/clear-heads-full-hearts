class CreateAthletes < ActiveRecord::Migration
	def change
		create_table :athletes do |t|
			t.string :first_name
			t.string :last_name
			t.string :sport
			t.string :position
			t.string :nationality
			t.string :team
			t.string :src,			null: false

			t.timestamps null: false
		end

		add_index :athletes, :sport
		add_index :athletes, :team
		add_index :athletes, :nationality
	end
end
