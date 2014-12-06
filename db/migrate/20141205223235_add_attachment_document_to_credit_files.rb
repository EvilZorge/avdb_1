class AddAttachmentDocumentToCreditFiles < ActiveRecord::Migration
  def self.up
    change_table :credit_files do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :credit_files, :document
  end
end
