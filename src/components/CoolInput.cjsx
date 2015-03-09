React = require('react')

CoolInput = React.createClass
    render: ->
        <div className="form-horizontal">
            <div className="form-group">
                <div className="col-lg-3 control-label">
                    <label>{@props.title}:</label>
                </div>
                <div className="col-lg-9">
                    <input type="text" className="form-control"
                        placeholder={@props.placeholder}
                        valueLink={@props.valueLink}
                        defaultValue={@props.defaultValue} />
                </div>
            </div>
        </div>

module.exports = CoolInput
