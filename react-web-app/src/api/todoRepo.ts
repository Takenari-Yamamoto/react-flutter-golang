import { Todo } from '../model/Todo';

interface TodoApi {
  create: (title: string) => Promise<void>;
  getAll: () => Promise<Todo[]>;
}

export const todoRepo: TodoApi = {
  create: async () => {
    await fetch('');
  },
  getAll: async () => {
    return [
      {
        id: 'ddhyrgthrghdf',
        title: 'ご飯',
        detail: '美味しいもの',
        createdAt: new Date(),
      },
      {
        id: '34534534dsjfeyetyteyesdf',
        title: '酒',
        detail: 'ハイボールかな〜',
        createdAt: new Date(),
      },
      {
        id: 'trtwrtg45345tf',
        title: 'ラーメン食べる',
        detail: '豚骨がいいね',
        createdAt: new Date(),
      },
    ];
  },
};
