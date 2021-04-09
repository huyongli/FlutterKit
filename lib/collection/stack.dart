class Stack<E> {
  final List<E> _stack = List<E>.empty(growable: true);

  Stack();

  bool get isEmpty => size == 0;

  int get size => _stack.length;

  void push(E e) {
    _stack.add(e);
  }

  E pop() {
    if (isEmpty) {
      throw EmptyStackException();
    }
    return removeAt(size - 1);
  }

  E peek() {
    if (isEmpty) {
      throw EmptyStackException();
    }
    return _stack[size - 1];
  }

  E removeAt(int index) {
    if (index < 0 || index >= size) {
      throw ArrayIndexOutOfBoundsException('Stack index out of range: index is $index, but size is $size');
    }
    return _stack.removeAt(index);
  }

  void forEach(void f(E element)) {
    _stack.forEach(f);
  }
}

class EmptyStackException implements Exception {}

class ArrayIndexOutOfBoundsException implements Exception {
  final String message;

  ArrayIndexOutOfBoundsException(this.message);

  @override
  String toString() {
    return message;
  }
}
