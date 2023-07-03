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
      column :image
      actions
    end
    
    show do
      attributes_table do
        row :id
        row :name
        row :image
      end
    end
  end
