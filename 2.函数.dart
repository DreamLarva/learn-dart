import 'package:meta/meta.dart';

/**
 * 每个app 想要可执行 就必须要有一个 main 函数
 * main 函数 返回类型 一定是 void
 * 可以使用 args 库 给main 传入一个参数 void main(List<String> arguments) {}
 * */
bool topLevel = true;
void main() {
  /**
   * dart 中函数 和 js 相同 都是一等公民 且是 对象
   * */
  {
    var _nobleGases = {};

    bool isNoble(int atomicNumber) {
      return _nobleGases[atomicNumber] != null;
    }

    // 能够自动推断 返回值为 bool
    isNoble_1(atomicNumber) {
      return _nobleGases[atomicNumber] != null;
    }

    // 箭头函数 依然类似
    bool isNoble_2(int atomicNumber) => _nobleGases[atomicNumber] != null;

    // 同样可以推断 返回值的类型
    isNoble_3(int atomicNumber) => _nobleGases[atomicNumber] != null;
  }

  /**
   * 参数
   * 老样子  必须的参数 在前 可选参数 在后
   *
   * 可选参数 只能是 基于位置 或者 命名的(二选一)
   * */
  /** 命名参数 */
  {
    // 使用 命名参数 需要大括号包裹
    void enableFlags({bool bold, bool hidden}) {}
    enableFlags(bold: true, hidden: false);

    // 使用了命名参数 就不能再有任何额外的参数
    // foo({bool a},b){ // error

    // 可以 先必选参数 后使用 命名参数
    foo_1(a, {b, c}) {}
    foo_1(1, b: 1, c: 2);

    /**
     * flutter 会经常用到 命名参数
     * 使用 @required 关键字 表明 某个命名参数 为必须
     * 需要 meta 库的依赖
     * import 'package:meta/meta.dart';
     * */
    Scrollbar({bool key, @required bool child}) {}
  }
  /**
   * 可选基于位置的参数
   * 使用 中括号
   * 由于 可选参数 之后 只能是可选参数 所以 必须只用一个 中括号 全部括起来
   * */
  {
    String say(String from, String msg, [String device]) {
      var result = '$from says $msg';
      if (device != null) {
        result = '$result with a $device';
      }
      return result;
    }

    // 可选参数 之后不能有任何参数(包括另一个可选参数)
    // foo([bool a], [bool b]){}; // error
    foo_1([bool a, bool b]) {}

    assert(say('Bob', 'Howdy') == 'Bob says Howdy');
    assert(say('Bob', 'Howdy', 'smoke signal') ==
        'Bob says Howdy with a smoke signal');
  }
  /**
   * 默认参数值
   * 使用 = 默认参数值
   * 默认值只能是编译时常量
   * 如果没有提供默认值，则默认值为 null。
   * */
  {
    /// Sets the [bold] and [hidden] flags ...
    void enableFlags({bool bold = false, bool hidden = false}) {}

    // bold will be true; hidden will be false.
    enableFlags(bold: true);

    // 可选参数 默认值
    String say(String from, String msg,
        [String device = 'carrier pigeon', String mood]) {
      var result = '$from says $msg';
      if (device != null) {
        result = '$result with a $device';
      }
      if (mood != null) {
        result = '$result (in a $mood mood)';
      }
      return result;
    }

    assert(say('Bob', 'Howdy') == 'Bob says Howdy with a carrier pigeon');

    // foo(bool a,[bool b = a]){} // error 默认值必须是常量


    // 可以是用 各种类型的参数
    void doStuff({List<int> list = const [1, 2, 3],
      Map<String, String> gifts = const {
        'first': 'paper',
        'second': 'cotton',
        'third': 'leather'
      }}) {
      print('list:  $list');
      print('gifts: $gifts');
    }
  }

  /**
   * 函数是 一等公民
   * 可以作为 参数
   * */
  {
    void printElement(int element) {
      print(element);
    }

    var list = [1, 2, 3];

    // Pass printElement as a parameter.
    list.forEach(printElement);

    var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
    assert(loudify('hello') == '!!! HELLO !!!');
  }
  /**
   * 匿名函数(又为 lambda 或 闭包(closure))
   * 和 js 完全相同
   * */
  {
    var list = ['apples', 'bananas', 'oranges'];
    list.forEach((item) {
      print('${list.indexOf(item)}: $item');
    });

    list.forEach((item) => print('${list.indexOf(item)}: $item'));
  }
  /**
   * 作用域
   * 和 js 完全相同
   * */
  {
    var insideMain = true;

    void myFunction() {
      var insideFunction = true;

      void nestedFunction() {
        var insideNestedFunction = true;

        assert(topLevel);
        assert(insideMain);
        assert(insideFunction);
        assert(insideNestedFunction);
      }
    }
    myFunction();
  }
  /**
   * 闭包
   * 和js 相同
   * */
  {
    // 函数的返回值 为一个函数
    Function makeAdder(num addBy) {
      return (num i) => addBy + i;
    }
    // Create a function that adds 2.
    var add2 = makeAdder(2);

    // Create a function that adds 4.
    var add4 = makeAdder(4);

    assert(add2(3) == 5);
    assert(add4(3) == 7);
  }
  /**
   * 测试函数是否相等
   * */
  {
    void foo() {}

    var x;

    x = foo;
    assert(foo == x);

    // Comparing static methods.
    x = A.bar;
    assert(A.bar == x);


    var v = A(); // Instance #1 of A
    var w = A(); // Instance #2 of A
    var y = w;
    x = w.baz;

    // These closures refer to the same instance (#2),
    // so they're equal.
    assert(y.baz == x);

    // 对比相同原型的不同实例上的方法
    // 不相等(不基于原型链? js 中是相等的)
    assert(v.baz != w.baz);
  }
  /**
   * 返回值
   * 所有函数的 隐式返回 默认值是 null
   * */
  {
    foo() {}

    assert(foo() == null);
  }

}

class A {
  static void bar() {} // A static method
  void baz() {} // An instance method
}

