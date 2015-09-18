class OurPartners < ActiveRecord::Base
  attr_accessible *attribute_names
  attr_accessible :image

  belongs_to :page_about_company, :foreign_key => :page_about_companies_id

  has_attached_file :image,
                    styles: {large: "386x156>"},
                    convert_options: { large: "-quality 94 -interlace Plane" },
                    url: "/assets/images/:class/:id/image_:style.:extension",
                    path:':rails_root/public:url',
                    default_url:"asset_path('default_image.png')"
  do_not_validate_attachment_file_type :image
  validates_presence_of :image, :message => "Виберіть зображення, відповідно до зазначених розмірів! Поле не може бути пустим."

  rails_admin do
    label 'Наш партнер'
    label_plural 'Наші партнери'
    visible false

    edit do
      field :publication do
        label 'чи публікувати ?'
      end
      field :position do
        label 'порядковий номер:'
      end
      field :name do
        label 'назва:'
      end
      field :image, :paperclip do
        label 'зображення:'
        help 'зображення для альбому повинне бути 386. / 156.'
      end
      field :url do
        label 'посилання на сайт:'
      end
      field :status do
        label 'статус:'
      end
    end
  end
  scope :with_public_position, -> { where(:publication => true).order('position asc')}
end
