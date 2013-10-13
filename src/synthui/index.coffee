$ = require("jquery-browserify")
hogan = require("hogan.js")

class SynthUI
    constructor: (selector) ->
        @container = $(selector)
        if not @container.length
            throw new Error("Container not found: " + selector)
        @container.text("HI!")

    add: (module) ->
        console.log(module)
        module_template = hogan.compile(@module_template)
        partials =
            control: @control_template
            list: @list_template
            range: @range_template
        @container.append(module_template.render(module, partials))

    module_template: """
        <div class="synth-module synth-module-{{name}}">
            <h2>{{name}}</h2>
            <ul class="synth-control">
                {{#controls}}
                    {{>control}}
                {{/controls}}
            </ul>
        </div>
        """

    control_template: """
        <li class="synth-control synth-control-{{name}}">
            <label>{{name}}</label>
            {{#list}}
                {{>list}}
            {{/list}}
            {{#range}}
                {{>range}}
            {{/range}}
        </li>
        """

    list_template: """
        <select>
            {{#values}}
                {{#label}}
                    <option value="{{key}}">{{label}}</option>
                {{/label}}
                {{^label}}
                    <option value="{{key}}">{{key}}</option>
                {{/label}}
            {{/values}}
        </select>
        """

    range_template: """
        <input type="range" max="{{max}}" min="{{min}}">
        """

module.exports = SynthUI
