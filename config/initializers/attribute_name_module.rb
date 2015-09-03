class ActionViewHelper
  extend ActionView::Helpers::OutputSafetyHelper
end

module CommonAttributeName
  def human_attribute_name(attr_name, **options)

    classes = [self]
    res = nil
    classes.each do |klass|
      class_selector = klass.name.underscore
      begin
        res = I18n.t("activerecord.attributes.#{class_selector}.#{attr_name}", raise: true)
        res = nil if res.blank?
        break
      rescue
        next
      end
    end

    unless res
      res = I18n.t("activerecord.attributes.#{attr_name}", raise: true) rescue nil

      # skip if node is hash
      res = nil if res.blank? || res.is_a?(Hash)
    end



    unless res
      if r = self.reflections[attr_name.to_s]
        res = ( const = Object.const_get(r.class_name) rescue nil ).try do |m|
          break nil unless const.respond_to?(:human_class_name)
          multiple = r.class == ActiveRecord::Reflection::HasManyReflection;
          const.human_class_name(multiple: multiple)

        end
      end
    end

    unless res
      res = attr_name.to_s.humanize
    end

    res = ActionViewHelper.raw res
    res
  end

  def human_class_name(**options)
    multiple = !!options[:multiple]
    res = nil
    underscored_class_name = self.name.underscore
    classes = [underscored_class_name, underscored_class_name.split("/").last]

    classes.each do |underscored_class_name|
      if multiple
        res = I18n.t("activerecord.models.#{underscored_class_name}.other", raise: true) rescue nil
        return res if res.present?
      end

      begin
        res = I18n.t("activerecord.models.#{underscored_class_name}.one", raise: true)
        break
      rescue
        begin
          res = I18n.t("activerecord.models.#{underscored_class_name}", raise: true)
        rescue
          next
        end
      end
    end

    res ||= underscored_class_name.humanize
  end
end