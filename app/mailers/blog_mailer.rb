class BlogMailer < ApplicationMailer
    def blog_mail(blog)
      @blog = blog
      mail to: "yoshiprograming@gmail.com", subject: "インスタの投稿確認メール"
    end
end