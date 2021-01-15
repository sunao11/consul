(function() {
  "use strict";
  App.SDGRelatedListSelector = {
    initialize: function() {
      var amsifySuggestags = new AmsifySuggestags($(".sdg-related-list-selector .input"));
      amsifySuggestags._settings({
        suggestions: $(".sdg-related-list-selector .input").data("suggestions-list"),
        classes: $(".sdg-related-list-selector .input").data("class-list"),
        whiteList: true,
        afterRemove: function(value) {
          var values = $(amsifySuggestags.selector).val().split(",");
          var parent_values = jQuery.map(values, function(v) {
            return (v.split(".")[0]);
          });
          if (parent_values.indexOf(value.toString().split(".")[0]) === -1) {
            $("#goal_" + value.split(".")[0]).removeClass("checked");
          }
          $('[data-id="' + value + '"]').remove();
          if ($(amsifySuggestags.selector).val() === "") {
            $(".sdg-related-list-selector .help-section").addClass("hide");
          }
        },
        afterAdd: function(value) {
          $("#goal_" + value.toString().split(".")[0]).addClass("checked");

          var item_key = amsifySuggestags.getItemKey(value);
          var item = amsifySuggestags.settings.suggestions[item_key]
          var display_text = item.display_text
          $('[data-val="' + value + '"]').get(0).childNodes[0].nodeValue = display_text + " ";

          var title = item.title
          var html = '<li data-id="' + value + '">' + "<b>" + value + "</b> " + title + "</li>";
          $(".sdg-related-list-selector .help-section").removeClass("hide");
          $(".sdg-related-list-selector .selected-info").append(html);
        },
        keepLastOnHoverTag: false,
        checkSimilar: false
      });
      amsifySuggestags.classes.focus = ".sdg-related-list-focus";
      amsifySuggestags.classes.sTagsInput = ".sdg-related-list-selector-input";
      amsifySuggestags.defaultLabel = $(".sdg-related-list-selector .input").data("placeholder-text");
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
