export const formatDate = (date: string | Date) => {
  if (typeof date === 'string') {
    return date;
  }

  const y = date.getFullYear();
  const m = date.getMonth() + 1;
  const d = date.getDate();

  const yyyy = y.toString();
  const mm = ('00' + m).slice(-2);
  const dd = ('00' + d).slice(-2);

  return `${yyyy}/${mm}/${dd}`;
};
