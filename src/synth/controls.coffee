$ = require('jquery-browserify')

uid = 0

class SynthControl

    constructor: (props) ->
        @[key] = value for key, value of props

    render: ->
        @view.render()

class RangeControl extends SynthControl
    constructor: (props) ->
        super(props)
        @view = new RangeControlView(@)

class SelectControl extends SynthControl
    constructor: (props) ->
        super(props)
        @view = new SelectControlView(@)

class ControlView
    constructor: (@control) ->
        @el = $("<div class='synth-control synth-control-#{@control.name}'>")
        @el.append("<h3>#{@control.name}</h3>")

    render: ->
        @el

    bind_to_control: (el) ->
        id = @unique_id(el).attr('id')
        $('body').on('change', "##{id}", (e) =>
            @control.set(e.target.value)
        )
        el

    unique_id: (el) ->
        uid += 1
        el.attr('id', "synth-control-#{uid}")

class RangeControlView extends ControlView
    constructor: (@control) ->
        super
        slider = @bind_to_control($("""<input
            type="range"
            step="0.01"
            min="#{@control.min}"
            max="#{@control.max}"
            value="#{@control.get()}"
        >"""))
        @el.append(slider)

class SelectControlView extends ControlView
    constructor: (@control) ->
        super
        select = @bind_to_control($("<select>"))
        select.append(@option(value)) for value in @control.values
        @el.append(select)

    option: (value) ->
        option = $("<option value='#{value}'>#{value}</option>")
        option.attr('selected', 'selected') if value is @control.get()
        option

module.exports =
    SynthControl: SynthControl
    RangeControl: RangeControl
    SelectControl: SelectControl
