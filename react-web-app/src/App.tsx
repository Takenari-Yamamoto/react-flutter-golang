import React, { useEffect, useState } from 'react';
import { TodoRepo } from './api/todoRepo';
import Header from './components/common/Header';
import Add from './components/todo/Add';
import Detail from './components/todo/Detail';
import Item from './components/todo/Item';
import { Todo } from './model/Todo';
import style from './styles/todo.module.css';

function App() {
  const [todoList, setTodoList] = useState<Todo[]>([]);
  const [selected, setSelectedTodo] = useState<Todo>({
    id: 'a',
    title: 'a',
    detail: 'a',
    createdAt: 'a',
  });
  const { fetchTodo } = TodoRepo();
  useEffect(() => {
    const fetch = async () => {
      // TODO: エラーハンドリング
      const res = await fetchTodo();
      console.log(res);
      setTodoList(res);
    };

    fetch();
  }, []);

  return (
    <div className="App">
      <Header />
      <div className={style.container}>
        {/* Side Bar */}
        <div className={style.sideBar}>Side Bar</div>
        <div className={style.todoListContainer}>
          <div className={style.list}>
            <Add />
            <h1>Todo Lists</h1>
            {todoList.map((todo, index) => {
              return <Item title={todo.title} key={index.toString()} />;
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
