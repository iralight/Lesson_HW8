class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
         
def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.uid + "@twitter.com").first
      if registered_user
        return registered_user
      else
        puts auth.inspect
        #user = User.create(name:auth.extra.raw_info.name,
        #                    provider:auth.provider,
        #                    uid:auth.uid,
        #                    email:auth.uid+"@twitter.com",
        #                    password:Devise.friendly_token[0,20],
        #                  )
        user = User.create(provider:auth.provider,
                           uid:auth.uid,
                           email:auth.uid+"@twitter.com",
                           encrypted_password:Devise.friendly_token[0,20])
      end

    end
  end     

  private

  def user_params
  	params.require(:provider).permit(:provider, :uid)
  end

end
