var ready;
ready = function() {
  var Chartkick = {"language": "pl"};
  $('.nav-pills a[href="#days"]').tab('show')
};

$(document).ready(ready);
$(document).on('page:load', ready);
