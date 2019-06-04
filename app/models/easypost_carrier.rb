# frozen_string_literal: true

class EasypostCarrier
  class <<self
    def all
      @all ||= yaml_contents.map(&method(:new))
    end

    private

    def yaml_contents
      YAML.safe_load(yaml_file.read)
    end

    def yaml_file
      Rails.root.join('config', 'easypost_carriers.yml')
    end
  end

  attr_reader :name, :code, :fab_icon

  def initialize(attributes)
    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end

  def icon?
    fab_icon.present?
  end

  private

  attr_writer :name, :code, :fab_icon
end
