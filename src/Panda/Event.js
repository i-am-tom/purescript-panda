'use strict';

// FRP.Event creation function pulled from an old version of -behaviors.

exports.create = function () {
  var subs = [];
  return {
    event: function(sub) {
      subs.push(sub);
    },
    push: function(a) {
      return function() {
        for (var i = 0; i < subs.length; i++) {
          subs[i](a);
        }
      };
    }
  };
};
