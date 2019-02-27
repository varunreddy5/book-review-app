class RemoveAttachmentBookImgToBooks < ActiveRecord::Migration[5.2]
  def change
    remove_attachment :books, :book_img
  end
end
