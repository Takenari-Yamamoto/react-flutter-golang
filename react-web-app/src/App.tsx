import React from 'react';
import Header from './components/common/Header';
import Add from './components/todo/Add';
import Detail from './components/todo/Detail';
import List from './components/todo/List';
import style from './styles/todo.module.css';

function App() {
  return (
    <div className="App">
      <Header />
      <div className={style.container}>
        <div className={style.todoContainer}>
          <List />
          <Detail />
        </div>
        <Add />
      </div>
    </div>
  );
}

export default App;
