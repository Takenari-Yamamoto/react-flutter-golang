import React, { memo, ReactNode } from 'react';
import style from './modal.module.css';

type Props = {
  handleClose: () => void;
  children: ReactNode;
};

const Modal = (props: Props) => {
  const { children, handleClose } = props;
  // オーバーレイがクリックされたとき、
  // もしくは閉じるボタンが押されたときに
  // 閉じる処理
  return (
    <div className={style.overlayContainer}>
      <div className={style.modalContainer}>
        <div>{children}</div>
        <button onClick={handleClose}>閉じる！</button>
      </div>
    </div>
  );
};

export default memo(Modal);
