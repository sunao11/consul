class SDG::RelatedListSelectorComponent < ApplicationComponent
  attr_reader :f, :record

  def initialize(form, record)
    @f = form
    @record = record
  end

  def checked?(code, record)
    record.sdg_goals.find_by(code: code).present?
  end

  def sdg_related_suggestions
    goals.map do |goal|
      [goal, *goal.targets.sort]
    end.flatten.map do |goal_or_target|
      display_text = goal_or_target.class.name == "SDG::Goal" ? "SDG#{goal_or_target.code}" : "#{goal_or_target.code}"
      {
        tag: "#{goal_or_target.code}. #{goal_or_target.title.gsub(",", "")}",
        title: "#{goal_or_target.title}",
        display_text: display_text,
        value: goal_or_target.code
      }
    end
  end

  def sdg_related_colors
    goals.map do |goal|
      [goal, *goal.targets.sort]
    end.flatten.map do |goal_or_target|
      goal_code = goal_or_target.code.to_s.split(".")[0]
      color_class = goal_or_target.class.name == "SDG::Goal" ? "goal-color-#{goal_code}" : "target-color-#{goal_code}"
      color_class
    end
  end

  private

    def goals
      SDG::Goal.order(:code)
    end
end
