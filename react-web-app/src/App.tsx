import React from 'react';
import Header from './components/common/Header';
import Add from './components/todo/Add';
import Detail from './components/todo/Detail';
import Item from './components/todo/Item';
import List from './components/todo/List';
import style from './styles/todo.module.css';

function App() {
  return (
    <div className="App">
      <Header />
      <div className={style.container}>
        {/* Side Bar */}
        <div className={style.sideBar}>Side Bar</div>
        <div className={style.todoListContainer}>
          <div className={style.list}>
            <h1>Todo Lists</h1>
            {[1, 2, 3, 4, 5].map((todo, index) => {
              return <Item />;
            })}
            <Add />
          </div>
          <div className={style.detail}>
            <Detail />
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
