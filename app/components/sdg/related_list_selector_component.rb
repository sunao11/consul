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

  private

    def goals
      SDG::Goal.order(:code)
    end
end
