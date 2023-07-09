ActiveAdmin.register Target do
  actions :index, :show

  controller do
    def scoped_collection
      super.includes(:user, :topic)
    end
  end

  filter :topic

  index do
    id_column
    column :title
    column 'Radius (m)', &:radius
    column :lat
    column :lng
    column :matched
    column :user_name do |target|
      TargetPresenter.new(target).user_name
    end
    column :topic_title do |target|
      TargetPresenter.new(target).topic_title
    end
    column :created_at

    actions
  end

  show do
    attributes_table do
      row :title
      row 'Radius (m)', &:radius
      row :lat
      row :lng
      row :matched
      row :user_name do |target|
        TargetPresenter.new(target).user_name
      end
      row :topic_title do |target|
        TargetPresenter.new(target).topic_title
      end
      row :created_at
      row :updated_at
    end
  end
end
