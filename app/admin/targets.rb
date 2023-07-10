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
    column I18n.t('active_admin.target_headers.radius'), &:radius
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
      row I18n.t('active_admin.target_headers.radius'), &:radius
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
