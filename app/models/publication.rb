class Publication < ActiveRecord::Base
  attr_accessible *attribute_names
  attr_accessible :image

  has_attached_file :image,
                    styles: {large: "965x400#", thumb: "200x200#"},
                    convert_options: { large: "-quality 94 -interlace Plane",
                                       thumb: "-quality 94 -interlace Plane"},
                    url: "/assets/images/:class/:id/image_:style.:extension",
                    path:':rails_root/public:url',
                    default_url:"asset_path('default_image.png')"
  do_not_validate_attachment_file_type :image
  validates_presence_of :image, :message => "Виберіть зображення, відповідно до зазначених розмірів! Поле не може бути пустим."
  validates_presence_of :title, :message => "Поле назва повинне бути заповнене..."

  def next
    Publication.where("id > ?", id).first
  end

  def prev
    Publication.where("id < ?", id).last
  end

  def to_slug
    # I18n.with_locale :ru do
    title.parameterize
    # end
  end
  def to_param
    #{to_slug}"
  end
  def save_slug
    self.slug = to_slug
  end
  before_save :save_slug

  rails_admin do
    label 'Публікація'
    label_plural 'Публікації'

    edit do
      field :feature do
        label 'вибрана на головну:'
      end
      field :published do
        label 'чи публікувати ?'
      end
      field :title do
        label 'назва:'
      end
      field :image, :paperclip do
        label 'зображення:'
        help 'зображення для альбому повинне бути 965. / 400.'
      end
      field :short_description do
        label 'короткий опис:'
      end
      field :description, :ck_editor do
        label 'текст статті:'
      end
    end
  end
  scope :with_public, -> { where(:published => true).order('created_at desc')}
end
