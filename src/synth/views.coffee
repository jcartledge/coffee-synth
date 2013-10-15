Backbone = require('backbone')

class SynthView extends Backbone.View

    constructor: (@el) ->

    render: (modules) ->
        @el.html('')
        @el.append(module.render()) for module in modules.models

class ModuleView extends Backbone.View

    constructor: (@module) ->

    render: ->
        "<h2>#{@module.name}</h2>"

module.exports =
    SynthView: SynthView
    ModuleView: ModuleView
