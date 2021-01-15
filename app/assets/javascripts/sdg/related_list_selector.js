(function() {
  "use strict";
  App.SDGRelatedListSelector = {
    initialize: function() {
      var amsifySuggestags = new AmsifySuggestags($(".sdg-related-list-selector .input"));
      amsifySuggestags._settings({
        suggestions: $(".sdg-related-list-selector .input").data("suggestions-list"),
        classes: $(".sdg-related-list-selector .input").data("class-list"),
        whiteList: true,
      });
      amsifySuggestags.classes.focus = ".sdg-related-list-focus";
      amsifySuggestags.classes.sTagsInput = ".sdg-related-list-selector-input";
      amsifySuggestags._init();

      $(".sdg-goal-icon").on({
        click: function() {
          var goal_id = $(this)[0].id.split("_")[1];
          if ($(this).hasClass("checked")) {
            amsifySuggestags.removeTag(goal_id);
            $(this).removeClass("checked");
          } else {
            amsifySuggestags.addTag(goal_id);
            $(this).addClass("checked");
          }
        }
      });
    }
  };
}).call(this);
