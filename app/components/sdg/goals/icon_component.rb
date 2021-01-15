class SDG::Goals::IconComponent < ApplicationComponent
  attr_reader :goal, :checked
  delegate :code, to: :goal

  def initialize(goal, checked = false)
    @goal = goal
    @checked = checked
  end

  def image_path
    "sdg/#{folder}/goal_#{code}.png"
  end

  private

    def image_text
      goal.code_and_title
    end

    def image_id
      "goal_#{goal.code}"
    end

    def checked_class
      "checked" if checked
    end

    def image_class
      "sdg-goal-icon #{checked_class}"
    end

    def folder
      [*I18n.fallbacks[I18n.locale], "default"].find do |locale|
        find_asset("sdg/#{locale}/goal_#{code}.png")
      end
    end

    def find_asset(path)
      if Rails.application.assets
        Rails.application.assets.find_asset(path)
      else
        Rails.application.assets_manifest.assets[path]
      end
    end
end
