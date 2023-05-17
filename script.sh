#!/bin/bash

# Определяем начальные значения переменных
input_file=""
output_file=""
operation=""

# Цикл, который рассматривает все возможные аргументы и сохраняет соответствующие значения в переменных
while getopts "i:o:d:" opt; do
  case ${opt} in
    i ) input_file="$OPTARG";; # в конце входного файла должна быть пустая строка!
    o ) output_file="$OPTARG";;
    d ) operation="$OPTARG";;
    \? ) echo "Недопустимый аргумент: $OPTARG"; exit 1;;
    : ) echo "Аргумент $OPTARG требует значения"; exit 1;;
  esac
done

# Функция для подсчета количества четных чисел
function count_numbers() {
  count=0
  while read num; do
    if [[ $num =~ [0-9]+ ]] && [[ $1 == even ]] && (( $num % 2 == 0 )); then # если число четное то увелич счетчик
      count=$((count + 1))
    elif [[ $num =~ [0-9]+ ]] && [[ $1 == odd ]] && (( $num % 2 == 1 )); then # если число нечетное то увелич счетчик
      count=$((count + 1))
    fi
  done < "$input_file"
  if [[ $1 == even ]]; then
    echo "Количество четных чисел: $count" >> "$output_file"
  else
    echo "Количество нечетных чисел: $count" >> "$output_file"
  fi
}

# Проверяем, существуют ли файлы входных данных и файла вывода
if [[ ! -f "$input_file" ]]; then
  echo "Файл входных данных не найден: $input_file"
  exit 1
fi

if [[ ! -f "$output_file" ]]; then
  echo "Файл вывода не найден, создаем файл: $output_file"
  touch "$output_file"
fi

# Проверяем третий аргумент и вызываем соответствующую функцию
case "$operation" in
  even ) count_numbers even;; # в аргументе передается, что считаем: четные или нечетные
  odd ) count_numbers odd;;
  * ) echo "Неизвестная операция: $operation"; exit 1;;
esac

