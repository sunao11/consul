class SDG::RelatedListSelectorComponent < ApplicationComponent
  attr_reader :f

  def initialize(form)
    @f = form
  end

  def sdg_related_suggestions
    goals.map do |goal|
      [goal, *goal.targets.sort]
    end.flatten.map do |goal_or_target|
      {
        tag: "#{goal_or_target.code}. #{goal_or_target.title.gsub(",", "")}",
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
