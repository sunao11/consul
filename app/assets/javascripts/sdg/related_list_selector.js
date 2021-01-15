(function() {
  "use strict";
  App.SDGRelatedListSelector = {
    initialize: function() {
      var amsifySuggestags = new AmsifySuggestags($(".sdg-related-list-selector .input"));
      amsifySuggestags.classes.focus = ".sdg-related-list-focus";
      amsifySuggestags.classes.sTagsInput = ".sdg-related-list-selector-input";
      amsifySuggestags._init();
    }
  };
}).call(this);
