class Synth

    constructor: (@ui = false) ->
        @context = new webkitAudioContext()
        @modules = []

    add_module: (module) ->
        @modules.push(module)
        @ui.add(module) if @ui

    create: (type) ->
        return @context['create' + type[0].toUpperCase() + type[1..-1]]()

    trigger: (f)->
        module.trigger(f) for module in @modules

    speaker: ->
        @context.destination

module.exports = Synth
