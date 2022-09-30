import React, { memo } from 'react';
import style from '../../styles/todo.module.css';

interface Props {
  handleInput: (e: string) => void;
  clickAdd: () => void;
}

const Add = (props: Props) => {
  const { handleInput, clickAdd } = props;
  return (
    <div className={style.add}>
      <input
        className={style.input}
        onChange={(e) => handleInput(e.target.value)}
      />
      <button className={style.addButton} onClick={clickAdd}>
        追加
      </button>
    </div>
  );
};

export default memo(Add);
