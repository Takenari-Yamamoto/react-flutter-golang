import React, { memo } from 'react';
import style from '../../styles/header.module.css';

const Header = () => {
  return <header className={style.header}>Sample Todo App</header>;
};

export default memo(Header);
