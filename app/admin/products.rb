ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :price, :category_id, :image

  filter :name
  filter :description
  filter :price
  filter :category

  # Products page table, modified to show images
  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :category

    column :image do |product|
      if product.image.attached?
        image_tag url_for(product.image), size: "100x100", style: "object-fit: contain; width: 100px; height: 100px;"
      else
        "No Image"
      end
    end

    actions
  end

  # Modified form to accept image files
  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :category
      f.input :image, as: :file
    end
    f.actions
  end

  # Modified to show image
  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :category
      row :image do |product|
        image_tag url_for(product.image), size: "400x400", style: "object-fit: contain; width: 400px; height: 400px;" if product.image.attached?
      end
    end
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
