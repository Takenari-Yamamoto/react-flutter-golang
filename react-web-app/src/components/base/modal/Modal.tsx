import React, { memo, ReactNode, useEffect, useRef } from 'react';
import { useClickOutside } from '../../../hooks/useClickOutside';
import style from './modal.module.css';

type Props = {
  handleClose: () => void;
  children: ReactNode;
};

const Modal = (props: Props) => {
  const { children, handleClose } = props;
  const modalRef = useRef<HTMLDivElement>(null);
  useClickOutside(
    modalRef,
    () => handleClose(),
    () => console.log('内側')
  );

  return (
    <div className={style.overlayContainer}>
      <div ref={modalRef} className={style.modalContainer}>
        <div>{children}</div>
        <button onClick={handleClose}>閉じる！</button>
      </div>
    </div>
  );
};

export default memo(Modal);
