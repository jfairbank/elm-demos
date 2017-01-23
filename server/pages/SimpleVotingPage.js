import React from 'react';
import Elm from 'react-elm-components';
import { Main } from '02-voting/src/exports';

const SimpleVotingPage = () => (
  <div>
    <h1 style={{ textAlign: 'center' }}>
      02 - Simple Voting App
    </h1>

    <Elm src={Main} />
  </div>
);

export default SimpleVotingPage;
