ActiveAdmin.register Topic do
  permit_params :name, :image

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :image
    end
    actions
  end

  index do
    id_column
    column :name
    column :image do |topic|
      image_tag topic.image, height: '25px'
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :image do |topic|
        image_tag topic.image, height: '25px'
      end
    end
  end
end
