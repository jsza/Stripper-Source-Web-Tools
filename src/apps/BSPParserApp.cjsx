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



BSPParserApp = React.createClass
    mixins: [Reflux.connect(BSPStore)]

    render: ->
        console.log @state.loading
        if @state.loading
            content = (
                'Loading...'
            )
        else if @state.fileName
            content = (
                <Row>
                    <Col lg={2}>
                        <ClassnameList {...@state} />
                    </Col>
                    <Col lg={2}>
                        <EntityList {...@state} />
                    </Col>
                    <Col lg={4}>
                        <EntityInfoPanel {...@state} />
                    </Col>
                </Row>
            )
        else
            content = <BSPDropzone />
        <div>
            <BSPErrorPanel />
            <BSPHeading fileName={@state.fileName} />
            {content}
        </div>



module.exports = BSPParserApp
