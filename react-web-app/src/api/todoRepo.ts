import { Todo } from '../model/Todo';

interface TodoApi {
  createTodo: (title: string) => Promise<void>;
  fetchTodo: () => Promise<Todo[]>;
}

export const TodoRepo = (): TodoApi => {
  const createTodo = async (title: string) => {
    await fetch('');
  };

  const fetchTodo = async (): Promise<Todo[]> => {
    return [
      {
        id: 'dsjfsdf',
        title: 'ご飯',
        detail: '美味しいもの',
        createdAt: new Date(),
      },
      {
        id: 'dsjfsdf',
        title: '酒',
        detail: '美味しいもの',
        createdAt: new Date(),
      },
      {
        id: 'dsjfsdf',
        title: 'ラーメン食べる',
        detail: '美味しいもの',
        createdAt: new Date(),
      },
    ];
  };

  return { createTodo, fetchTodo };
};
