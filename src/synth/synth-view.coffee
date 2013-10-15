Backbone = require('backbone')

class SynthView extends Backbone.View

    constructor: (@el) ->

    initialize: ->
        super

    render: ->
        @el.text('LOADED')

module.exports = SynthView
