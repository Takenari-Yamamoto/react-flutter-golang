import React, { memo } from 'react';
import { Todo } from '../../model/Todo';
import style from '../../styles/todo/detail.module.css';
import { formatDate } from '../../utils/util';

type Props = {
  detail: Todo | null;
};

const Detail = (props: Props) => {
  if (!props.detail) {
    return <></>;
  }

  const { id, title, detail, createdAt } = props.detail;

  return (
    <div className={style.container}>
      <p>id: {id}</p>
      <p className={style.title}>
        {title}
        <span className={style.createdAt}>
          作成日時 {formatDate(createdAt)}
        </span>
      </p>
      <p>{detail}</p>
    </div>
  );
};

export default memo(Detail);
