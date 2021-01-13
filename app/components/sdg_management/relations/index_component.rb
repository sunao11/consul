class SDGManagement::Relations::IndexComponent < ApplicationComponent
  include Header
  include SDG::Goals::OptionsForSelect

  attr_reader :records, :current_filter

  def initialize(records, current_filter: "pending")
    @records = records
    @current_filter = current_filter
  end

  private

    def title
      t("sdg_management.menu.#{model_class.table_name}")
    end

    def model_class
      records.model
    end

    def edit_path_for(record)
      {
        controller: "sdg_management/relations",
        action: :edit,
        relatable_type: record.class.name.tableize,
        id: record
      }
    end

    def search_label
      t("admin.shared.search.label.#{model_class.table_name}")
    end

    def goal_label
      t("admin.shared.search.advanced_filters.sdg_goals.label")
    end

    def goal_blank_option
      t("admin.shared.search.advanced_filters.sdg_goals.all")
    end

    def target_label
      t("admin.shared.search.advanced_filters.sdg_targets.label")
    end

    def target_blank_option
      t("admin.shared.search.advanced_filters.sdg_targets.all")
    end

    def goal_options
      super(params[:goal_code])
    end

    def target_options
      options_from_collection_for_select(SDG::Target.all.sort, :code, :code, params[:target_code])
    end
end
