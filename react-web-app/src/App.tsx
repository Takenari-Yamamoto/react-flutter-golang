import React, { useState } from 'react';
import { MobilePage } from './components/page/MobilePage';
import PcPage from './components/page/PcPage';
import style from './styles/button.module.css';

function App() {
  const [screenType, setType] = useState<'pc' | 'mobile'>('mobile');
  const changeType = (type: 'pc' | 'mobile') => {
    if (type === 'pc') {
      setType('mobile');
      return;
    }
    setType('pc');
  };
  return (
    <div className="App">
      {screenType === 'pc' && <PcPage />}
      {screenType === 'mobile' && <MobilePage />}
      {/* <button className={style.button} onClick={() => changeType(screenType)}>
        {screenType}
      </button> */}
    </div>
  );
}

export default App;
