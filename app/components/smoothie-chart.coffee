`import Ember from 'ember'`

SmoothieChartComponent = Ember.Component.extend
  width: 900
  height: 200

  _canvas: null
  smoothie: null
  chartLines: null

  minValue: null
  maxValue: null
  refreshRate: null
  delay: 900

  _destroyCanvas: ->
    @get('_canvas').remove() if @get('_canvas')?

  _buildCanvas: ->
    @_destroyCanvas()
    canvas = Ember.$('<canvas height="' + @get('height') + '" width="' + @get('width') + '"></canvas>')
    @$().append(canvas)
    @set '_canvas', canvas

  _dataReloaded: Ember.observer('chartLines', ->
    @_buildCanvas()
    @_buildSmoothie()
  )

  _buildSmoothie: ->
    smoothie = new SmoothieChart
      millisPerPixel: 84
      maxValueScale: 1
      grid:
        strokeStyle: 'transparent'
        millisPerLine: 5000
      labels:
        precision: 0
      minValue: @get('minValue')
      maxValue: @get('maxValue')

    smoothie.streamTo @get('_canvas')[0], @get('delay')

    @get('chartLines').forEach((chartLine)->
      smoothie.addTimeSeries(
        chartLine.get('line')
        chartLine.get('options')
      )
    )

    @set 'smoothie', smoothie

  didInsertElement: ->
    @_buildCanvas()
    @_buildSmoothie()

  _register: ( ->
    @set 'register-as', @
  ).on('init')

`export default SmoothieChartComponent`
