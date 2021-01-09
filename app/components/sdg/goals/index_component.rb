class SDG::Goals::IndexComponent < ApplicationComponent
  attr_reader :goals
  delegate :link_list, to: :helpers

  def initialize(goals)
    @goals = goals
  end

  private

    def phases
      SDG::Phase.order(:kind)
    end

    def icon(goal)
      render SDG::Goals::IconComponent.new(goal)
    end

    def goal_link(goal)
      [icon(goal), sdg_goal_path(goal.code)]
    end

end
