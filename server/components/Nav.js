import React from 'react';
import { Nav as BsNav, Navbar } from 'react-bootstrap';
import NavItem from 'components/NavItem';

const {
  Header: NavbarHeader,
  Brand: NavbarBrand,
} = Navbar;

const Nav = () => (
  <Navbar>
    <NavbarHeader>
      <NavbarBrand>
        Elm Demos
      </NavbarBrand>
    </NavbarHeader>

    <BsNav>
      <NavItem to="/">
        Home
      </NavItem>

      <NavItem to="/01-getting-started">
        01 - Getting Started
      </NavItem>
    </BsNav>
  </Navbar>
);

export default Nav;
