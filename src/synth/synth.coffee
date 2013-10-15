Backbone = require('backbone')
SynthModule = require('./module.coffee')
views = require('./views.coffee')

class Synth

    constructor: (el) ->
        @modules = new SynthModules()
        @context = new webkitAudioContext()
        @view = new views.SynthView(el)

    create: (type) ->
        return @context['create' + type[0].toUpperCase() + type[1..-1]]()

    add_module: (module) ->
        @modules.add(module)
        @render()

    render: ->
        @view.render(@modules)

    start: (f) ->
        module.start(f) for module in @modules.models

    speaker: ->
        @context.destination

class SynthModules extends Backbone.Collection
    model: SynthModule

module.exports = Synth
