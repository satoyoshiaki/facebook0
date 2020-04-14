class ContactMailer < ApplicationMailer
    def contact_mail(blog)
        @blog = blog
        mail to: "yoshiprograming@gmail.com", subject: "偽インスタ投稿確認メール"
      end
end
