`import Ember from 'ember'`
`import config from '../config/environment'`
`import Pollster from '../utils/pollster'`

ServerRoute = Ember.Route.extend
  model: (params)->
    server = config.APP.servers.find (item)->
      item.name is params.server
    pollster = Pollster.create
      server: server
    return pollster

  afterModel: (pollster) ->
    pollster.start()

  actions:
    willTransition: ->
      clearInterval @get('currentModel').stop()
      return true;

`export default ServerRoute`
