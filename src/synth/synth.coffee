Backbone = require('backbone')
SynthModule = require('./module.coffee')

class Synth extends Backbone.Collection

    model: SynthModule

    constructor: ->
        super
        @context = new webkitAudioContext()

    create: (type) ->
        return @context['create' + type[0].toUpperCase() + type[1..-1]]()

    start: (f)->
        module.start(f) for module in @models

    speaker: ->
        @context.destination

module.exports = Synth
