class UserMailer < ApplicationMailer
    default from: "woofwhere@gmail.com"

    def welcome_email(user)
        @user = user
        mail(to: 'Cheraws@gmail.com', subject: 'Welcome to My Awesome Site')
        #mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
