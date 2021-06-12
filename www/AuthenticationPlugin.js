var exec = require('cordova/exec');

exports.coolMethod = function (arg0, success, error) {
  exec(success, error, 'AuthenticationPlugin', 'coolMethod', [arg0]);
};

exports.authenticateFaceIdOrTouchId = function (arg0, success, error) {
  exec(success, error, 'AuthenticationPlugin', 'authenticateFaceIdOrTouchId', [
    arg0,
  ]);
};
