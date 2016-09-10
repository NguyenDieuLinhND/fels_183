class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @word_learned = Word.learned current_user.id
    end
  end
end
