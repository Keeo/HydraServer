`import Ember from 'ember'`

ChartLine = Ember.Object.extend
  line: null
  options:
    lineWidth: 1.1
    strokeStyle: '#0ce3ac'
    fillStyle: '#007053'
  init: ->
    @_super()
    @set('line', new TimeSeries())

`export default ChartLine`
