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
    column :user
    column :topic
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
      row :user
      row :topic
      row :created_at
      row :updated_at
    end
  end
end
