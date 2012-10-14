jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  $(".sub-unsub button.btn").tooltip
    placement: 'right'
