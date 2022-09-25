/** @jsxImportSource @emotion/react */
import { memo } from 'react';
import { css } from '@emotion/react';

const style = {
  header: css`
    display: flex;
    align-items: center;
    height: 52px;
    padding: 0 12px;
    font-weight: bold;
    background-color: rgb(251, 203, 60);
    border-bottom: 1px solid rgb(218, 218, 218);
  `,
};

const Header = () => {
  return <header css={style.header}>Sample Todo App</header>;
};

export default memo(Header);
