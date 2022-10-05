import React, { useState } from 'react';
import Modal from './components/base/modal/Modal';
import { MobilePage } from './components/page/MobilePage';
import PcPage from './components/page/PcPage';
import style from './styles/button.module.css';

function App() {
  const [isOpenModal, showModal] = useState(false);
  return (
    <div className="App">
      <button onClick={() => showModal(true)}>モーダル表示</button>
      {isOpenModal && (
        <Modal handleClose={() => showModal(false)}>
          <p>モーダルAデス。Hogeほげ</p>
        </Modal>
      )}
    </div>
  );
}

export default App;
