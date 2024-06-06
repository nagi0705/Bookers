class InitializeViewsCountInBooks < ActiveRecord::Migration[6.1]
  def up
    Book.find_each do |book|
      book.update(views_count: 0) if book.views_count.nil?
    end
  end

  def down
    # このマイグレーションのdownメソッドには何も書かなくてもよい
    # または、必要に応じてロールバック時の処理を追加します
  end
end
