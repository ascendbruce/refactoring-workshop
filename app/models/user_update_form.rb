class UserUpdateForm
  include ActiveModel::Model

  attr_reader :user
  attr_reader :profile

  attr_accessor :email    # from user
  attr_accessor :nickname # from profile
  attr_accessor :bio      # from profile


  validates_presence_of :email
  validates_format_of   :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_presence_of :nickname, :bio
  validates_length_of   :nickname, in: 3..20

  def initialize(user_id)
    @user    = User.find_by_id(user_id)
    @profile = @user.profile || @user.build_profile
  end

  def persisted?
    @user.persisted? && @profile.persisted?
  end

  def update(params)
    self.email    = params[:email]
    self.nickname = params[:nickname]
    self.bio      = params[:bio]
    # binding.pry
    if valid?
      @user.update_attributes(email: email)
      @profile.update_attributes(nickname: nickname, bio: bio)
      true
    else
      false
    end
  end
end



# class SignupForm
#   include ActiveModel::Model

#   attr_reader :company
#   attr_reader :user

#   attr_accessor :company_name
#   attr_accessor :name
#   attr_accessor :email

#   validates :company_name, presence: true
#   validates :name,         presence: true
#   validates :email,        presence: true
#   validate :email_uniqueness

#   # Forms are never themselves persisted
#   def persisted?
#     false
#   end

#   def save
#     if valid?
#       @company = Company.create!(name: company_name)
#       @user    = @company.users.create!(name: name, email: email)
#       true
#     else
#       false
#     end
#   end

#   private

#   def email_uniqueness
#     if User.where(email: email).exists?
#       errors.add :email, "has already been taken"
#     end
#   end
# end
