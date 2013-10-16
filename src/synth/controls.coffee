$ = require('jquery-browserify')

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
        @el = $("<div class='synth-control synth-cotnrol-#{@control.name}'>")
        @el.append("<h3>#{@control.name}</h3>")

    render: ->
        @el

class RangeControlView extends ControlView
    constructor: (@control) ->
        super
        slider = $("""<input
            type="range"
            min="#{@control.min}"
            max="#{@control.max}"
            value="#{@control.get()}"
        >""")
        @el.append(slider)

class SelectControlView extends ControlView
    constructor: (@control) ->
        super
        select = $("<select>")
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
