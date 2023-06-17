class Article < ApplicationRecord
  belongs_to :user

  def to_json(current_user = user)
    {
      **as_json({ except: %i[id user_id created_at updated_at] }),
      createdAt: created_at,
      updatedAt: updated_at,
    }
  end

  private

  # タイトルからスラッグを生成するメソッド
  def create_slug
    self.slug = title.parameterize
  end
end
