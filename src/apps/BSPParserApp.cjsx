React = require('react')
Reflux = require('reflux')

BSPStore = require('../stores/BSPStore')

{Row, Col} = require('react-bootstrap')

EntityList = require('../components/bsp/EntityList')
ClassnameList = require('../components/bsp/ClassnameList')
EntityInfoPanel = require('../components/bsp/EntityInfoPanel')
BSPDropzone = require('../components/bsp/BSPDropzone')
BSPHeading = require('../components/bsp/BSPHeading')
BSPErrorPanel = require('../components/bsp/BSPErrorPanel')
ServerCommandWarning = require('../components/bsp/ServerCommandWarning')



BSPParserApp = React.createClass
    mixins: [Reflux.connect(BSPStore)]

    render: ->
        # if @state.loading
        #     content = (
        #         'Loading...'
        #     )
        if @state.fileName
                # <ClassnameList {...@state} />
            content = (
                <BSPDropzone className="bsp-inner-container" noStyle>
                    <EntityList {...@state} />
                    <EntityInfoPanel {...@state} />
                </BSPDropzone>
            )
        else
            content = <BSPDropzone className="bsp-inner-container" />
        <div className="inherit-height bsp-app-container">
            <BSPErrorPanel />
            <BSPHeading fileName={@state.fileName} />
            {content}
            <ServerCommandWarning classnameTally={@state.classnameTally} />
        </div>



module.exports = BSPParserApp
