class ChangeUidColumnName < ActiveRecord::Migration
  def change
    rename_column :designers, :uid, :designer_uid
  end
end
