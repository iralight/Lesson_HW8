class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :omniauthable, omniauth_providers: [:twitter]
         
def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
  puts 'inside find_for_twitter_oath'
  puts auth.slice(:provider, :uid)

    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider,
      user.uid = auth.uid,
      user.email = auth.uid+"@twitter.com",
      user.encrypted_password = Devise.friendly_token[0,20]
  end
end     

end
