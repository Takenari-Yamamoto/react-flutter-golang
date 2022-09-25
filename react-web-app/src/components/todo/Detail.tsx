import React, { memo } from 'react';
import { Todo } from '../../model/Todo';
import style from '../../styles/todo/detail.module.css';

type Props = {
  detail: Todo;
};

const Detail = (props: Props) => {
  const { id, title, detail, createdAt } = props.detail;
  return (
    <div>
      <p>{id}</p>
      <p className={style.title}>
        {title}
        <span className={style.createdAt}>作成日時{String(createdAt)}</span>
      </p>
      <p>{detail}</p>
    </div>
  );
};

export default memo(Detail);
