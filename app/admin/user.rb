ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :username, :password, :password_confirmation, :plan_id

  controller do
    def scoped_collection
      super.includes(:plan)
    end
  end

  form do |f|
    f.inputs 'Details' do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :username
      f.input :plan, as: :select, collection: Plan.all

      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end

    actions
  end

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :username
    column :plan
    column :sign_in_count
    column :created_at
    column :updated_at

    actions
  end

  filter :id
  filter :email
  filter :username
  filter :first_name
  filter :last_name
  filter :plan
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :id
      row :email
      row :first_name
      row :last_name
      row :username
      row :plan
      row :sign_in_count
      row :created_at
      row :updated_at
    end
  end
end
