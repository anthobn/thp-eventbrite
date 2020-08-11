class AddAdminToEvent < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :user_admin, index: true
  end
end
