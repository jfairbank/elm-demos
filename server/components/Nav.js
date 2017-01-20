import React from 'react';
import { Nav as BsNav, Navbar, NavItem } from 'react-bootstrap';
import Link from 'react-router/Link';
import NavItemLink from 'components/NavItemLink';
import Icon from 'components/Icon';

const {
  Header: NavbarHeader,
  Brand: NavbarBrand,
} = Navbar;

const Nav = () => (
  <Navbar>
    <NavbarHeader>
      <NavbarBrand>
        <Link to="/">
          Elm Demos
        </Link>
      </NavbarBrand>
    </NavbarHeader>

    <BsNav>
      <NavItemLink to="/">
        Home
      </NavItemLink>

      <NavItemLink to="/01-getting-started">
        01 - Getting Started
      </NavItemLink>
    </BsNav>

    <BsNav pullRight>
      <NavItem href="https://github.com/jfairbank/elm-demos" target="_blank" rel="noopener">
        <Icon name="github" size="lg" />
      </NavItem>
    </BsNav>
  </Navbar>
);

export default Nav;
