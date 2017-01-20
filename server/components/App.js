import React from 'react';
import { Grid } from 'react-bootstrap';
import Router from 'react-router/BrowserRouter';
import Match from 'react-router/Match';
import IndexPage from 'pages/IndexPage';
import GettingStartedPage from 'pages/GettingStartedPage';
import Nav from 'components/Nav';

const App = () => (
  <Router>
    <div>
      <Nav />

      <Grid>
        <Match exactly pattern="/" component={IndexPage} />
        <Match pattern="/01-getting-started" component={GettingStartedPage} />
      </Grid>
    </div>
  </Router>
);

export default App;
