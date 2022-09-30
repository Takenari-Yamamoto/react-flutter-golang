import { useCallback, useEffect, useState } from 'react';
import axios from 'axios';
import { todoRepo } from '../api/todoRepo';
import { Todo } from '../model/Todo';

export const useTodo = () => {
  const [todoList, setTodoList] = useState<Todo[]>([]);
  const [selected, setSelectedTodo] = useState<Todo | null>(null);

  const handleSelect = useCallback((item: Todo) => {
    setSelectedTodo(item);
  }, []);

  const fetchTodo = async () => {
    try {
      const res = await todoRepo.getAll();
      setTodoList(res);
    } catch (e) {
      if (axios.isAxiosError(e)) {
        console.error(e, 'HTTP通信に失敗しました。');
      }
      console.error(e);
    }
  };

  useEffect(() => {
    fetchTodo();
  }, []);

  return {
    todoList,
    selected,
    handleSelect,
  };
};
