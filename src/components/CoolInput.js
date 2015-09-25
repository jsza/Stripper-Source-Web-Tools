import React from 'react'


export default class CoolInput extends React.Component {
  render() {
    return (
      <div className="form-horizontal">
        <div className="form-group">
          <div className="col-lg-3 control-label">
            <label>{this.props.title}:</label>
          </div>
          <div className="col-lg-9">
            <input type="text" className="form-control"
              placeholder={this.props.placeholder}
              valueLink={this.props.valueLink}
              defaultValue={this.props.defaultValue} />
          </div>
        </div>
      </div>
    )
  }
}
