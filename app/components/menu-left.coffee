`import Ember from 'ember'`
`import config from '../config/environment'`

MenuLeftComponent = Ember.Component.extend
  servers: ( ->
    return config.APP.servers;
  ).property()

`export default MenuLeftComponent`
