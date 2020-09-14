function minesweeper(matrix) {
  const n = matrix.length;
  const m = matrix[0].length;

  const output = new Array(n);
  for (var i = 0; i < n; i++) {
    output[i] = new Array(m);
  }

  for (var i = 0; i < n; i++) {
    for (var j = 0; j < m; j++) {
      if (matrix[i][j] == "X") {
        output[i][j] = "X";
        continue;
      }

      var counter = 0;
      for (var p = i - 1; p < i + 2; p++) {
        if (p < 0 || p == n) {
          continue;
        }
        for (var q = j - 1; q < j + 2; q++) {
          if (q < 0 || q == m) {
            continue;
          }
          if (matrix[p][q] == "X") {
            counter++;
          }
        }
      }
      output[i][j] = counter;
    }
  }

  for (var i = 0; i < n; i++) {
    console.log(`${output[i]}`);
  }
  console.log("--------");
}

minesweeper(["XOO", "OOO", "XXO"]);
test1 = [
  "XOOXXXOO",
  "OOOOXOXX",
  "XXOXXOOO",
  "OXOOOXXX",
  "OOXXXXOX",
  "XOXXXOXO",
  "OOOXOXOX",
  "XOXXOXOX",
];
minesweeper(test1);
test2 = ["OOOXXXOXX", "XXXXXXOXX", "XOOXXXXXX", "OOXXOXOXX", "XXXXXXXXX"];
minesweeper(test2);
