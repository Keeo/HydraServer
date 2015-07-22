`import Ember from 'ember'`
`import ChartLine from '../../utils/chart-line'`

ChartsCpuChartComponent = Ember.Component.extend
  pollster: null,
  lines: Ember.A([])

  setupLines: ( ->
    @get('lines')[0] = (ChartLine.create(
      options:
        lineWidth: 1
        strokeStyle: '#00ff00'
    ))
    @get('lines')[1] = (ChartLine.create(
      options:
        lineWidth: 1
        strokeStyle: '#ff0000'
    ))
  ).on('init')

  limiter: 0
  onModelUpdate: Ember.observer('pollster.payload', ->
    data = @get 'pollster.payload.data'
    lines = @get('lines')
    lines[0].line.append(
      Date.now()
      @getPercentage(data.CPU[0].usage_percentage)
    )

    limiter = @get('limiter')
    if limiter is 5
      lines[1].get('line').append(
        Date.now()
        parseFloat(data.Load['5min']) * 100
      )
      @set('limiter', 0)
    else
      @set('limiter', limiter + 1)
  )

  last: null,
  getPercentage: (currentLine) ->
    current = currentLine.split(' ')
    @set 'last', current if not @get('last')?

    sumCurrent = current.reduce((a, b) -> return parseInt(a) + parseInt(b))
    sumPast = @get('last').reduce((a, b) -> return parseInt(a) + parseInt(b))
    sumDiff = sumCurrent - sumPast

    emptyDiff = parseInt(current[3]) - parseInt(@get('last')[3])
    percentage = 1 - parseFloat(emptyDiff) / parseFloat(sumDiff)

    @set 'last', current
    return percentage * 100

`export default ChartsCpuChartComponent`
