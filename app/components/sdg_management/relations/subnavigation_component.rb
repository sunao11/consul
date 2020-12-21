class SDGManagement::Relations::SubnavigationComponent < SDGManagement::SubnavigationComponent
  private

    def sections
      SDGManagement::RelationsController::FILTERS
    end

    def text_for(section)
      t("sdg_management.relations.review_status.#{section}")
    end

    def path_for(section)
      {
        controller: "sdg_management/relations",
        action: :index,
        params: {
          filter: section
        }
      }
    end
end
