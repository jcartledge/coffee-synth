class Synth

    constructor: ->
        @context = new webkitAudioContext()
        @modules = []

    add_module: (module) ->
        @modules.push(module)

    create: (type) ->
        return @context['create' + type[0].toUpperCase() + type[1..-1]]()

    trigger: ->
        module.trigger() for module in @modules

    speaker: ->
        @context.destination

module.exports = Synth
