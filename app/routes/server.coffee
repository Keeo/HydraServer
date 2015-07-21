`import Ember from 'ember'`
`import config from '../config/environment'`

ServerRoute = Ember.Route.extend
  intervalId: null
  model: (params)->
    server = config.APP.servers.find (item)->
      item.name is params.server

    line1 = new TimeSeries()
    @set 'intervalId', setInterval(
      => (
        Ember.$.ajax(
          url: server.url,
          type: "GET",
        ).then(
          (data) =>
            line1.append(
              new Date().getTime()
              @getPercentage(data.CPU[0].usage_percentage)
            )
        )

      )
      1000
    )
    return line1

  last: null,
  getPercentage: (currentLine) ->
    current = currentLine.split(' ')
    @set 'last', current if not @get('last')?

    sumCurrent = current.reduce((a, b) -> return parseInt(a)+parseInt(b))
    sumPast = @get('last').reduce((a, b) -> return parseInt(a)+parseInt(b))
    sumDiff = sumCurrent - sumPast

    emptyDiff = parseInt(current[3]) - parseInt(@get('last')[3])
    percentage = 1 - parseFloat(emptyDiff) / parseFloat(sumDiff)

    @set 'last', current
    return percentage * 100

  actions:
    willTransition: ->
      clearInterval @get('intervalId')
      return true;

`export default ServerRoute`
