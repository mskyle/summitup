class Permission

  def initialize(user)
    allow :welcome, [:index]
    allow "devise/sessions", [:new, :create, :destroy]
    allow "devise/registrations", [:new, :create, :edit, :update]
    allow :mountains, [:index, :show]
    if user
      allow :users, [:edit, :update, :show]
      allow :trips, [:new, :create, :index] 
      allow :trips, [:edit, :update, :show, :destroy] { |trip| binding.pry user.trips.include?(trip) }
      allow_all if user.admin?
    end
  end

  def allow_all
    @allow_all = true
  end
    
  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end

  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
  end
end
