class Form::Chat < Form::Base
  attr_accessor :users

  def attributes=(attrs)
    super(attrs)
    @users = attrs["users"]
  end

  def submit
    super do
      @users.each do |user|
        self.object.users << User.find(user)
      end
    end
  end
end
