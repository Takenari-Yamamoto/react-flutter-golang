import React, { memo } from 'react';
import style from '../../styles/todo.module.css';

const Add = () => {
  return (
    <div className={style.add}>
      <input className={style.input} />
      <button className={style.addButton}>追加</button>
    </div>
  );
};

export default memo(Add);
