class AddMusicToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :music, :string
  end
end
