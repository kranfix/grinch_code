function solution(A) {
  const data = { val: 1, next: 2 };
  const output = split(data, A, 1000000);
  console.log(output.val);
  return output.val;
}

function split(data, array, max) {
  const n = array.len || array.length;
  if (n === 0) {
    return data;
  }

  const pivot = half(data.val + max);

  const left = new Array(n);
  left.len = 0;
  left.low = pivot - 1;
  left.big = data.val;

  const right = new Array(n);
  right.len = 0;
  right.big = pivot;
  right.low = max;

  for (var i = 0; i < n; i++) {
    if (array[i] < data.val) continue;

    if (data.next === array[i]) {
      data.next++;
      continue;
    } else if (data.val === array[i]) {
      data.val = data.next;
      data.next++;
      continue;
    }
    append(array[i] < pivot ? left : right, array[i]);
  }

  if (data.val > right.big || data.val < left.low) {
    return data;
  } else if (data.val >= right.low) {
    return split(data, right, right.big);
  } else if (data.val > left.big) {
    return data;
  } else {
    data = split(data, left, left.big);
    if (data.val < right.low || right.length === 0) {
      return data;
    }
    return split(data, right, right.big);
  }
}

function half(n) {
  return (n - (n % 2)) / 2;
}

function append(array, val) {
  array[array.len] = val;
  array.len++;
  if (val > array.big) {
    array.big = val;
  }
  if (val < array.low) {
    array.low = val;
  }
}

solution([1, 3, 6, 1, 2]);
solution([-1, -3]);
solution([60000, 50000, 9, 5, 6, 8, 4, 1000, 3, 2, 1]);
solution([9, 5, 6, 8, 4, 3, 2, 1]);
solution([20, 2, 17, 4, 15, 6, 13, 8, 11, 10, 9, 12, 7, 14, 5, 16, 3, 19, 1]);
