$ = require('jquery-browserify')
controls = require('./controls.coffee')

class Module

    subscribers: []

    constructor: (@synth) ->
        @controls = []
        @view = new ModuleView(@)
        @synth.add_module(this)

    add_param_list_control: (param_name, values) ->
        @add_select_control(
            'name': param_name
            'values': values
            'set': (n) => @wrapped[param_name] = n
            'get': => @wrapped[param_name]
        )

    add_param_range_control: (param_name, min, max) ->
        @add_range_control(
            'name': param_name
            'min': min
            'max': max
            'set': (n) => @wrapped[param_name].value = n
            'get': => @wrapped[param_name].value
        )

    add_range_control: (props) ->
        control = new controls.RangeControl(props)
        @_add_control(control)

    add_select_control: (props) ->
        @_add_control(new controls.SelectControl(props))

    _add_control: (control) ->
        @controls.push(control)
        @render

    input: (param, target = @wrapped) ->
        if param
            target[param]
        else
            target

    # shorthand for synth.connect(src, target)
    connect: (target, input, options) ->
        @synth.connect(@, target, input, options)

    connect_trigger: (subscriber) ->
        @subscribers.push(subscriber)

    # internal - called by synth.connect
    incoming: (src, param) ->
        src.connect(@input(param))

    # internal - called by synth.connect
    outgoing: (target) ->
        @wrapped.connect(target)

    render: ->
        @view.render(@controls)

    trigger: (f) ->
        subscriber.trigger(f) for subscriber in @subscribers

    release: (f) ->
        subscriber.release(f) for subscriber in @subscribers

class ModuleView

    constructor: (@module) ->
        @el = $("<div class='synth-module synth-module-#{@module.name}'>")

    render: (controls) ->

        @el.html("<h2>#{@module.name}</h2>")
        @el.append(control.render()) for control in controls

module.exports = Module
