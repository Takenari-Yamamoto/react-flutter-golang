import React from 'react';
import Header from './components/common/Header';
import Add from './components/todo/Add';
import Detail from './components/todo/Detail';
import Item from './components/todo/Item';
import { useTodo } from './hooks/useTodo';
import style from './styles/todo.module.css';

function App() {
  const { todoList, selected, handleSelect } = useTodo();

  return (
    <div className="App">
      <Header />
      <div className={style.container}>
        <div className={style.sideBar}>Side Bar</div>
        <div className={style.todoListContainer}>
          <div className={style.list}>
            <Add />
            <h1>Todo Lists</h1>
            {todoList.map((todo, index) => {
              return (
                <Item
                  title={todo.title}
                  onClick={() => handleSelect(todo)}
                  key={index.toString()}
                />
              );
            })}
          </div>
          <div className={style.detail}>
            <Detail detail={selected} />
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
