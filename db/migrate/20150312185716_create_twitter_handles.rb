class CreateTwitterHandles < ActiveRecord::Migration
	def change
		create_table :twitter_handles do |t|
			t.belongs_to :athlete, index: true
			t.string :handle, index: :unique
			
			t.timestamps null: false
		end
	end
end
