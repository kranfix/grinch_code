function numberOfCarryOperations(num1, num2) {
  var digits1 = convertToDigits(num1);
  var digits2 = convertToDigits(num2);

  digits1 = completeDigits(digits1, digits2.length);
  digits2 = completeDigits(digits2, digits1.length);

  var counter = 0;
  var carry = 0;
  for (var i = 0; i < digits1.length; i++) {
    var sum = digits1[i] + digits2[i] + carry;
    if (sum > 9) {
      counter++;
      carry = parseInt(sum / 10);
    } else {
      carry = 0;
    }
  }
  return counter;
}

function convertToDigits(number) {
  const digits = [];
  while (number > 0) {
    var r = number % 10;
    number = (number - r) / 10;
    digits.push(parseInt(r));
  }
  return digits;
}

function completeDigits(digits, n) {
  if (n > digits.length) {
    const temp = new Array(n);
    for (var i = 0; i < n; i++) {
      temp[i] = digits[i];
    }
    for (var i = digits.length; i < n; i++) {
      temp[i] = 0;
    }
    return temp;
  }
  return digits;
}

console.log(numberOfCarryOperations(123, 456)); // 0
console.log(numberOfCarryOperations(555, 555)); // 3
console.log(numberOfCarryOperations(900, 11)); // 0
console.log(numberOfCarryOperations(145, 55)); // 2
console.log(numberOfCarryOperations(0, 0)); // 0
console.log(numberOfCarryOperations(1, 99999)); // 5
console.log(numberOfCarryOperations(999045, 1055)); // 5
console.log(numberOfCarryOperations(101, 809)); // 1
console.log(numberOfCarryOperations(189, 209)); // 1
