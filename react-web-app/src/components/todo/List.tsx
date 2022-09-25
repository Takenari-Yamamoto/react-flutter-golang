import React, { memo } from 'react';
import style from '../../styles/todo.module.css';
import TodoItem from './Item';

const List = () => {
  return (
    <div>
      <p className={style.title}>Todo List</p>
      {[1, 2, 3, 4, 5].map((todo, index) => {
        return <TodoItem />;
      })}
    </div>
  );
};

export default memo(List);
