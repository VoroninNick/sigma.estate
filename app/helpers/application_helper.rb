module ApplicationHelper
  def embedded_svg filename, options={}
   embedded_svg_from_abs(Rails.root.join('app', 'assets', 'images', 'svg', filename), options)
  end

  def embedded_svg_from_abs filename, options = {}
   file = File.read(filename)
   doc = Nokogiri::HTML::DocumentFragment.parse file
   svg = doc.at_css 'svg'
   if options[:class].present?
     svg['class'] = options[:class]
   end
   doc.to_html.html_safe
  end

  def embedded_svg_from_root_directory filename, options = {}
   embedded_svg_from_abs(Rails.root.join( filename), options)
  end

  def embedded_svg_from_public filename, options ={}
    embedded_svg_from_root_directory("public#{filename}", options)
  end

  def self.embedded_svg_js filename, options={}
   file = File.read(Rails.root.join('app', 'assets', 'images', 'svg', filename))
   doc = Nokogiri::HTML::DocumentFragment.parse file
   svg = doc.at_css 'svg'
   if options[:class].present?
     svg['class'] = options[:class]
   end
   doc.to_html.html_safe
  end
  def cp(path)
    "current" if current_page?(path)
  end


  def flash_class_name(name)
      case name
      when 'notice' then 'success'
      when 'alert'  then 'danger'
      else name
      end
  end

  def embed(youtube_url)
    youtube_id = youtube_url.split("=").last
    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}", frameborder: "0", allowfullscreen: "")
  end

  def nav_link(text, link)
    recognized = Rails.application.routes.recognize_path(link)
    if recognized[:controller] == params[:controller] && recognized[:action] == params[:action]
      content_tag(:li, :class => "material-component ripple current") do
        content_tag :a, href: link do
          embedded_svg("ic_photo_size_select_small_24px.svg") +
          content_tag(:div, class: "link-text") do
            text
          end
        end
      end
    else
      content_tag(:li, :class => "material-component ripple") do
        content_tag :a, href: link do
          embedded_svg("ic_photo_size_select_small_24px.svg") +
              content_tag(:div, class: "link-text") do
                text
              end
        end
      end
    end
  end

  def get_stars(val, color)
    current_class = case val.to_sym
      when :delux
        "se-ri-deluxe"
      when :club
        "se-ri-club"
      when :elite
        "se-ri-elite"
      when :business
        "se-ri-business"
      when :comfort
        "se-ri-comfort"
      when :standard
        "se-ri-standard"
      when :econom
        "se-ri-economy"
    end

    # count = BuildingComplex.complex_class.values.map(&:to_s).index(val.to_s) + 1

    total_count = 7
    content_tag(:div, :class => "rating-ico-wrap #{color} #{current_class}") do
      raw(total_count.times.map do |index|
        embedded_svg("ic_star_24px.svg")
      end.join)
    end
  end

end
