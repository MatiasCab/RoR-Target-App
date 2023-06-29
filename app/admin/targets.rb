ActiveAdmin.register Target do  
  actions :index, :show

  controller do
    def scoped_collection
      super.includes(:user, :topic)
    end
  end

  index do
    id_column
    column :title
    column "Radius (m)"do |target|
        target.radius
    end
    column :lat
    column :lng
    column :matched
    column :user_name do |target| 
      target.user.first_name
    end
    column :topic_title do |target|
      target.topic.name
    end
    column :created_at

    actions
  end
  
  show do
    attributes_table do
    row :title
    row "Radius (m)"do |target|
        target.radius
    end
    row :lat
    row :lng
    row :matched
    row :user_name do |target| 
      target.user.first_name
    end
    row :topic_title do |target|
      target.topic.name
    end
    row :created_at
    row :updated_at
  end
  end
end
