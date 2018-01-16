import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';


import ExamplePanel from '../Panels/ExamplePanel';
import Footer from '../Helpers/Footer';
import PageTitle from '../Helpers/PageTitle';
import Sidebar from '../Helpers/Sidebar';
import Toolbar from '../Helpers/Toolbar';
import { NotificationContainer } from 'react-notifications';
import ContactPanel from '../Panels/ContactPanel';
import OpportunityPanel from '../Panels/OpportunityPanel';
import AccountPanel from '../Panels/AccountPanel';
import {actionCreators} from "../../actions";

class Backend extends Component {
    componentWillMount() {
        this.props.dispatch(actionCreators.fetchContactCustomFields());
        this.props.dispatch(actionCreators.fetchOpportunityCustomFields());
        this.props.dispatch(actionCreators.fetchAccountCustomFields());
    }

    render() {
        return(
            <div className="page-inner">
                <Toolbar />
                <Sidebar />

                <div className="main">
                    <PageTitle />

                    <div className="content">
                        {this.props.children}
                    </div>

                    <Footer />
                </div>
                <ExamplePanel/>
                <NotificationContainer />
                <ContactPanel />
                <OpportunityPanel />
                <AccountPanel />
            </div>
        );
    }
}

Backend.propTypes = {
  children: PropTypes.node.isRequired
}

export default connect()(Backend);