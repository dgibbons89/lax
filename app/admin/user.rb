ActiveAdmin.register User do
	permit_params :extra_access

  before_filter do
    User.class_eval do
    def to_param
      id.to_s
    end
    end
  end
end

