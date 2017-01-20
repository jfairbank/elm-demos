import React, { PropTypes } from 'react';
import Link from 'react-router/Link';

const NavItemLink = ({ to, children }) => (
  <li>
    <Link to={to}>
      {children}
    </Link>
  </li>
);

NavItemLink.propTypes = {
  to: PropTypes.string.isRequired,
  children: PropTypes.node.isRequired,
};

export default NavItemLink;
