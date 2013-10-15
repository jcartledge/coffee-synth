Backbone = require('backbone')
SynthModule = require('./module.coffee')

class Synth extends Backbone.Model

    view: null

    constructor: (@view) ->
        @modules = new SynthModules()
        @context = new webkitAudioContext()
        @view.render()

    create: (type) ->
        return @context['create' + type[0].toUpperCase() + type[1..-1]]()

    add: (module) ->
        @modules.add(module)

    start: (f) ->
        module.start(f) for module in @modules.models

    speaker: ->
        @context.destination

class SynthModules extends Backbone.Collection
    model: SynthModule

module.exports = Synth
