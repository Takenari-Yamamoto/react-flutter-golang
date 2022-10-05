import { RefObject, useEffect } from 'react';

// 参考: https://usehooks.com/useOnClickOutside/
export const useClickOutside = (
  ref: RefObject<HTMLDivElement>,
  clickOutside: (func: Function) => void,
  clickInside?: () => void
) => {
  useEffect(() => {
    const listener = (event: any) => {
      if (!ref.current || ref.current.contains(event.target)) {
        if (clickInside) {
          clickInside();
        }
        return;
      }
      clickOutside(event);
    };

    document.addEventListener('mousedown', listener);
    document.addEventListener('touchstart', listener);

    return () => {
      document.removeEventListener('mousedown', listener);
      document.removeEventListener('touchstart', listener);
    };
  }, [ref, clickOutside]);
};
