Joosy.Modules.Events =
  wait: (events, callback) ->
    events = events.split(/\s+/)

    @__oneShotEvents ||= []
    @__oneShotEvents.push [events, callback]

  bind: (events, callback) ->
    events = events.split(/\s+/)

    @__boundEvents ||= []
    @__boundEvents.push [events, callback]

  unbind: (target) ->
    for [events, callback], index in @__boundEvents
      if callback == target
        @__boundEvents.splice(index, 1)
        return

  trigger: (event) ->
    if @__oneShotEvents
      for [events, callback], index in @__oneShotEvents
        index = events.indexOf(event)
        events.splice(index, 1) if index >= 0

        if events.length == 0
          @__oneShotEvents.splice(index, 1)

          callback()

    if @__boundEvents
      for [ events, callback ] in @__boundEvents
        if events.has(event)
          callback()