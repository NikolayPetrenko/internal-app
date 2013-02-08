class @PeopleControlPanel extends View
  path: "pages/people/control-panel"

  events:
    "keyup .bb-keyup-search" : "search"
    # "focus .bb-keyup-search" : "focus"
    "submit form"            : "search"

  propagate:
    "focus .bb-keyup-search" : "change.collection"


  search: (event) ->
    event?.preventDefault()
    clearTimeout @_timer
    
    @_timer = setTimeout => 
      input = @find('.bb-keyup-search')
      @trigger "search", input.val()
    , 350