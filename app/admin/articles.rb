ActiveAdmin.register Article do
  
  # Filterable attributes
  filter :title
  filter :tags
  filter :contact_id
  filter :is_published

  # View 
  index do
    column :id
    column "Article Title", :title do |article|
      link_to article.title, [:admin, article]
    end
    column :category
    column "Created", :created_at
    # column :tags
    column :slug
    column "Published", :is_published
    default_actions # Add show, edit, delete column
  end
  
  form do |f|   # create/edit user form
    f.inputs "Article Details" do
      f.input :title
      f.input :content
      f.input :category
      f.input :content_type
      f.input :preview
      f.input :tags, :as => :string
      f.input :is_published, :label => "Publish"
    end
    f.buttons
  end
end
# == Schema Information
#
# Table name: articles
#
#  id           :integer         not null, primary key
#  updated      :datetime
#  title        :string(255)
#  content      :text
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  category     :string(255)
#  content_type :integer
#  preview      :text
#  contact_id   :integer
#  tags         :text
#  service_url  :string(255)
#