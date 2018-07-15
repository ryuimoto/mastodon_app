class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

         def self.find_for_oauth(auth)
          user = User.where(email: auth.uid, provider: auth.provider).first
          
          if user != nil then
            user.update!(:uid => auth.extra.raw_info.display_name)
          end
          
          _, domain = auth.uid.split('@')
          client = Mastodon::REST::Client.new(base_url: "https://#{domain}", bearer_token: auth.credentials.token)
      
          unless user
            user = User.create(
              uid:      auth.extra.raw_info.display_name,
              provider: auth.provider,
              email:    User.dummy_email(auth),
              password: Devise.friendly_token[0, 20],
              avatar:   client.verify_credentials.avatar
            )
            user.save!
          end
          current_user = user
        end
      
        private
      
        def self.dummy_email(auth)
          "#{auth.uid}"
        end
        end
