import React from 'react';
import { Grid } from 'react-bootstrap';
import Router from 'react-router/BrowserRouter';
import Match from 'react-router/Match';
import IndexPage from 'pages/IndexPage';
import CounterPage from 'pages/CounterPage';
import SimpleVotingPage from 'pages/SimpleVotingPage';
import Nav from 'components/Nav';

const App = () => (
  <Router>
    <div>
      <Nav />

      <Grid>
        <Match exactly pattern="/" component={IndexPage} />
        <Match pattern="/01-counter" component={CounterPage} />
        <Match pattern="/02-simple-voting" component={SimpleVotingPage} />
      </Grid>
    </div>
  </Router>
);

export default App;
