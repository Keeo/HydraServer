`import Ember from 'ember'`

Pollster = Ember.Object.extend
  refreshRate: 1000
  server: null
  payload: null
  response: 0
  timer: null
  requestStatus: 'ground'

  start: ->
    timer = setInterval @onPoll.bind(@), @get('refreshRate')
    @set 'timer', timer
  stop: ->
    clearInterval @get('timer')
  onPoll: ->
    start = Date.now()
    @set 'requestStatus', 'air'
    Ember.$.ajax(
      url: @get('server.url'),
      type: "GET",
    ).then(
      (data) =>
        @set('payload',
          Ember.Object.create
            received: new Date().getTime()
            data: data
        )
        @set('response', Date.now() - start)
        @set 'requestStatus', 'groud'
    )

`export default Pollster`
