$ ->
  $('#titles ul li').hover(
    -> $(@).find('.btn').addClass('in'),
    -> $(@).find('.btn').removeClass('in'))

`(function ($) {
  jQuery.expr[':'].Contains = function(a,i,m){
      return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase())>=0;
  };

  function filterList(header, list) {
    var form = $("#filter"),
        input = $("#filter input");

    $(input)
      .change( function () {
        var filter = $(this).val();
        if(filter) {

          $matches = $(list).find('a:Contains(' + filter + ')').parent();
          $('li', list).not($matches).slideUp();
          $matches.slideDown();

        } else {
          $(list).find("li").slideDown();
        }
        return false;
      })
    .keyup( function () {
        $(this).change();
    });
  }

  $(function () {
    filterList($("#filter"), $("#filter").data('list'));
  });
}(jQuery));
`
