class ComplexBanner < ActiveRecord::Base
  attr_accessible *attribute_names
  extend Enumerize
  belongs_to :banner

  has_attached_file :image,
                    styles: {large: "1920x550>"},
                    convert_options: { large: "-quality 94 -interlace Plane" },
                    url: "/assets/images/:class/:id/image_:style.:extension",
                    path:':rails_root/public:url',
                    default_url:"asset_path('default_image.png')"

  do_not_validate_attachment_file_type :image
  # validates_presence_of :image, :message => "Виберіть фотографію, відповідно до зазначених розмірів! Поле не може бути пустим."

  enumerize :complex_class, in: [:delux, :club, :elite, :business, :comfort, :standard, :econom]

  rails_admin do
    label 'Квартири баннер'
    label_plural 'Банери'
    visible false

    edit do
      field :published do
        label 'чи публікувати ?'
      end
      field :position do
        label 'порядковий номер:'
      end
      field :title do
        label 'заголовок:'
      end
      field :complex_class do
        label 'комплекс клас:'
      end
      field :image, :paperclip do
        label 'зображення:'
        help 'Зображення для альбому повинне бути 1920. / 550.'
      end
      field :description do
        label 'опис:'
      end
      field :url do
        label 'посилання на сайт:'
      end
    end
  end
end
