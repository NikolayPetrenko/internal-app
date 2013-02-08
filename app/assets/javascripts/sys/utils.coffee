# unless console
#   console = null

# _sync = Backbone.sync
# Backbone.sync = (method, model, a) ->
#   _sync method, model, a
#   log method, model, a

@log = ->
  if console
    args = Array.prototype.slice.call(arguments)
    unless @_log
      @_log = Function.prototype.bind.call(console.log, console)

    @_log.apply console, args

log.enabledLogs = ["info", "debug", "warn", "flash"]

for name in ["info", "debug", "warn", "flash"]
  do (name) ->
    log[name] = ->
      return if name not in log.enabledLogs
      args = Array.prototype.slice.call(arguments)
      args.unshift "#{name.toUpperCase()}:::"
      log.apply console, args


unless String::trim
  String::trim = ->
    @replace /^\s+|\s+$/g, ""


String::capitalize = ->
  @charAt(0).toUpperCase() + @slice(1)

unless Array::indexOf
  Array::indexOf = (obj) ->
    _.indexOf @, obj

String::repeat = (times) ->
  result  = ""
  pattern = this
  for i in [0...times]
    result += pattern

  result