import React, { memo } from 'react';
import style from '../../styles/todo.module.css';
import checkBoxStyle from '../../styles/checkBox.module.css';

type Props = {
  title: string;
  onClick: () => void;
};

const Item = ({ title, onClick }: Props) => {
  return (
    <div className={style.todoItem} onClick={onClick}>
      <label className={checkBoxStyle.ECM_CheckboxInput}>
        <input
          className={checkBoxStyle.ECM_CheckboxInput_Input}
          type="checkbox"
        />
        <span className={checkBoxStyle.ECM_CheckboxInput_DummyInput}></span>
        <span className={checkBoxStyle.ECM_CheckboxInput_LabelText}>
          {title}
        </span>
      </label>
    </div>
  );
};

export default memo(Item);
