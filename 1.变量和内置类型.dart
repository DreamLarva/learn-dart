void main() {
  // 声明 + 初始化
  var name = 'Bob';
  /** Default value（默认值） */
  // 声明 不初始化 当然要声明类型啦
  int lineCount;
  assert(lineCount == null);

  /** Optional types（可选的类型声明）*/
  {
    String name = 'Bob'; // 可以手动在初始化的时候声明对应的类型虽然没有任何必要
  }

  /**
   * Final and const
   * 一个 final 变量只能赋值一次
   * 一个 const 变量是编译时常量
   * */
  {
    final name = "bob"; // Or: final String name = 'Bob';
    // name = 'Alice';  // Uncommenting this causes an error

    /**
     *  const 变量为编译时常量。 如果 const 变量在类中，请定义为 static const。
     * 可以直接定义 const 和其值，
     * 也可以定义一个 const 变量使用其他 const 变量的值来初始化其值。
     * */
    const bar = 1000000; // Unit of pressure (dynes/cm2)
    const atm = 1.01325 * bar; // Standard atmosphere

    /**
     * const 关键字不仅仅只用来定义常量。 有可以用来创建不变的值，
     * 还能定义构造函数为 const 类型的，
     * 这种类型 的构造函数创建的对象是不可改变的。任何变量都可以有一个不变的值。
     * */
    {
      // Note: [] creates an empty list.
      // const [] 创建一个空且不可变的队列 (EIA).
      var foo = const []; // foo is currently an EIA.
      final bar = const []; // bar will always be an EIA.
      const baz = const []; // baz is a compile-time constant EIA.

      // You can change the value of a non-final, non-const variable,
      // even if it used to have a const value.
      foo = [];

      // You can't change the value of a final or const variable.
      // bar = []; // Unhandled exception.
      // baz = []; // Unhandled exception.
      // baz = [42]; // error
    }
  }
  /**
   * Built-in types(内建的类型)
   *
   * numbers
   * strings
   * booleans
   * lists
   * sets
   * maps
   * runes (用于在字符串中表示 Unicode 字符)
   * symbols
   * */
  /**
   * Numbers（数值）
   * Dart 支持两种类型的数字：
   * int
   * 整数值，其取值通常位于 -253 和 253 之间。
   *
   * double
   * 64-bit (双精度) 浮点数，符合 IEEE 754 标准。
   * */
  {
    // 整数
    var x = 1;
    var hex = 0xDEADBEEF;
    // var bigInt = 34653465834652437659238476592374958739845729; // error

    // 浮点数
    var y = 1.1;
    var exponents = 1.42e5;
  }
  // 下面是字符串和数字之间转换的方式
  {
    var one = int.parse('1');
    assert(one == 1);

    var onePointOne = double.parse('1.1');
    assert(onePointOne == 1.1);

    String oneAsString = 1.toString();
    assert(oneAsString == '1');

    String piAsString = 3.1415926.toStringAsFixed(2);
    assert(piAsString == '3.14');
  }

  // 整数类型支持传统的位移操作符，(<<, >>), AND (&), 和 OR (|) 。例如：
  {
    assert((3 << 1) == 6); // 0011 << 1 == 0110
    assert((3 >> 1) == 1); // 0011 >> 1 == 0001
    assert((3 | 4) == 7); // 0011 | 0100 == 0111
    assert(3 ^ 4 == 7);
    assert(3 & 4 == 0);
  }

  // 数字字面量为编译时常量。 很多算术表达式 只要其操作数是常量，则表达式结果 也是编译时常量。
  {
    var a = 1;
    const msPerSecond = 1000;
    const secondsUntilRetry = 5;
    const msUntilRetry = secondsUntilRetry * msPerSecond;
    // const b = msPerSecond + a; // 果然error 编译时 const 中的变量 必须都是const 初始化的的
  }
  /**
   * string
   * Dart 字符串是 UTF-16 编码的字符序列。 可以使用单引号或者双引号来创建字符串
   * */
  {
    var s1 = 'Single quotes work well for string literals.';
    var s2 = "Double quotes work just as well.";
    var s3 = 'It\'s easy to escape the string delimiter.';
    var s4 = "It's even easier to use the other delimiter.";
  }
  // 和 js 一样的 拼接字符串语法 和 模板用法(不用``)
  {
    var s = 'string interpolation';

    // $ + 变量名 模板 直接引用
    assert('Dart has $s, which is very handy.' ==
        'Dart has string interpolation, ' + 'which is very handy.');

    // ${变量名} 模板
    assert('That deserves all caps. ' + '${s.toUpperCase()} is very handy!' ==
        'That deserves all caps. ' + 'STRING INTERPOLATION is very handy!');
  }

  // 可以使用 + 操作符来把多个字符串链接为一个，也可以把多个 字符串放到一起来实现同样的功
  // 放一起
  {
    var s1 = 'String '
        'concatenation'
        " works even over line breaks.";
    assert(s1 ==
        'String concatenation works even over '
            'line breaks.');
    // 用 + 关键字 拼接
    var s2 = 'The + operator ' + 'works, as well.';
    assert(s2 == 'The + operator works, as well.');
  }

  // 使用三个单引号或者双引号也可以 创建多行字符串对象
  {
    var s1 = '''
You can create
multi-line strings like this one.
''';
    var s2 = """This is also a
multi-line string.""";
  }
  // 通过提供一个 r 前缀可以创建一个 “原始 raw” 字符串
  {
    var s = r"In a raw string, even \n isn't special.";
    print(s);
    var t = "In a raw string, even \n isn't special.";
    print(t);
  }
  // 在 Dart 中，runes 代表字符串的 UTF-32 code points。
  // 由于 Dart 字符串是 UTF-16 code units 字符序列， 所以在字符串中表达 32-bit Unicode 值就需要 新的语法了。
  // 通常使用 \uXXXX 的方式来表示 Unicode code point
  //  对于非 4 个数值的情况， 把编码值放到大括号中即可。 例如，笑脸 emoji (😆) 是 \u{1f600}
  {
    var clapping = '\u{1f44f}';
    print(clapping);
    print(clapping.codeUnits);
    print(clapping.runes.toList());

    Runes input = new Runes(
        '\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}');
    print(new String.fromCharCodes(input));
  }

  /**
   * 字符串字面量是编译时常量， 带有字符串插值的字符串定义，
   * 若干插值表达式引用的为编译时常量则其结果也是编译时常量。
   * */
  {
    // These work in a const string.
    const aConstNum = 0;
    const aConstBool = true;
    const aConstString = 'a constant string';

    // These do NOT work in a const string.
    var aNum = 0;
    var aBool = true;
    var aString = 'a string';
    const aConstList = const [1, 2, 3];

    const validConstString = '$aConstNum $aConstBool $aConstString';
    // const invalidConstString = '$aNum $aBool $aString $aConstList'; // error
  }
  /**
   * 布尔值
   * 为了代表布尔值，Dart 有一个名字为 bool 的类型。 只有两个对象是布尔类型的：
   * */
  {
    print(0 == false); // false
    print(0 == true); // false
    print("" == false); // false
    print("" == true); // false
    print(null == false); // false
    print(null == true); // false

    var name = 'Bob';
    // if (name) {} // error 现在规定 if 判断的条件必须是 bool 类型
    if (name == true) {
      // ok
      // 不会执行到此处
    }

    // 正确的 判断条件的使用方法
    // Check for an empty string.
    var fullName = '';
    assert(fullName.isEmpty);

    // Check for zero.
    var hitPoints = 0;
    assert(hitPoints <= 0);

    // Check for null.
    var unicorn;
    assert(unicorn == null);

    // Check for NaN.
    var iMeantToDoThis = 0 / 0;
    assert(iMeantToDoThis.isNaN);
  }

  /**
   * Lists 列表
   * 类似于 js 的array
   * */
  {
    var list = [1, 2, 3]; // List<int>
    // 如果用字面量初始化 那么 Dart 能推断出正确的 类型
    list[1] = 2;
    // list[1] = "2";// error
    assert(list.length == 3);
    assert(list[1] == 2);

    var constantList = const [1, 2, 3];
    // constantList[1] = 1; // Uncommenting this causes an error.

    const list_1 = [1, 2, 3];
    // list_1[1] = 2; // 运行时错误
    // list_1[4] = 2; // 运行时错误
    final list_2 = const [1, 2, 3];
    // list_2[1] = 2; // 运行时错误
    // list_2[4] = 2; // 运行时错误

    // 和 js 一样 list[0] 为 头元素 list[list.length -1 ] 为尾元素
  }
  /**
   * Dart 2.3 新增的  spread operator (...) and the null-aware spread operator (...?)
   * 类似 js 的拓展运算符
   * */
  {
    var list = [1, 2, 3];
    var list2 = [0, ...list]; // 展开
    assert(list2.length == 4);
  }
  {
    var list;
    var sample1 = [];
    // 能够在 list 拓展运算符 后的 只能是 list null 和未初始化变量(dynamic) 类型
    var list2 = [0, ...?list, ...?[], ...?null]; // 有才展开
    assert(list2.length == 1);
  }

  /**
   * Dart 2.3 集合推导 collection if and collection for
   * */
  {
    // if
    var promoActive = true;
    var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];

    // for
    var listOfInts = [1, 2, 3];
    var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
    assert(listOfStrings[1] == '#1');
  }

  /**
   * Sets 集合
   * >=  Dart 2.2 版本
   * */
  {
    // 使用 {} 字面量 生成 集合
    var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
    // 能够自动推断类型s

    // 初始化一个 空的集合
    var names = <String>{}; // 空集合
    Set<String> names1 = {}; // This works, too.
    var names2 = {}; // Creates a map, not a set.

    /**
     * set or map ? set 的语法 和 map 的语法相似. 因为 map的字面量先被实现,所以{} 默认为Map 类型.
     * 如果你忘了 {}上的类型声明,Dart 则生成一个对象类型为 Map<dynamic, dynamic>.
     * */

    var elements = <String>{};
    elements.add('fluorine');
    elements.addAll(halogens); // addAll 方法参数 必须是 一个 Iterable 类型

    /**
     * length 属性 显示集合中 元素的数量
     * */
    assert(elements.length == 5);

    /**
     * 使用 const 生成 一个 编译时 的常量
     * */
    final constantSet = const {
      'fluorine',
      'chlorine',
      'bromine',
      'iodine',
      'astatine',
    };
    // constantSet.add('helium'); // 运行时报错
    /**
     * Dart 2.3版本后 set 也能使用
     * ...
     * ...?
     * 推导(if,for)
     * */
    {
      var isIf;
      var set_1 = {"1"};
      var list_1 = ["4"];
      var set_2 = {...set_1, "2", ...?isIf, if (isIf == null) "3", ...list_1};
      print(set_2); // {1, 2, 3, 4}
    }
  }

  /**
   * Map
   * 一般而言 map 是一个对象 关联 键和值
   * 键 和  值可以是任何对象
   * 同样的键 只能有一个 但可以多个键有相同的值
   * */
  {
    var gifts = {
      // Key:    Value
      'first': 'partridge',
      'second': 'turtledoves',
      'fifth': 'golden rings'
    };

    var nobleGases = {
      2: 'helium',
      10: 'neon',
      18: 'argon',
    };

//    nobleGases[1] = 1; // error
//    nobleGases["2"] = "1"; // error
    /**
     * Dart 推断 gifts 类型为 Map<String, String>
     * nobleGases 类型为 Map<int, String>
     *   初始化后 给予 错误类型的 键 或 值 都会报错
     * Dart 初始化 Map 时 new 关键字 为可选
     * */
    {
      var gifts = Map();
      gifts['first'] = 'partridge';
      gifts['second'] = 'turtledoves';
      gifts['fifth'] = 'golden rings'; // type Map<dynamic,dynamic>
      gifts[1] = 1; // ok

      var nobleGases = Map();
      nobleGases[2] = 'helium';
      nobleGases[10] = 'neon';
      nobleGases[18] = 'argon';
    }
    /**
     * length 属性 键值对的数量
     * */
    {
      var gifts = {'first': 'partridge'}; // key 上的 '' 为必须
      gifts['fourth'] = 'calling birds'; // 添加一个键值对

      assert(gifts.length == 2);
    }
    /**
     * 使用const 生成 map 常量
     * */
    {
      final constantMap = const {
        2: 'helium',
        10: 'neon',
        18: 'argon',
      };
    }
    /**
     * 同set 和 list 一样 迭代器能用的 他也能用
     * */
    {
      var unInitialized;
      var map_1 = {1: 1};
      var map_2 = {
        ...map_1,
        2: 2,
        ...?unInitialized,
        if (unInitialized == null) 3: 3
      };
    }
  }

  /**
   * Runes(符文) 类型
   * Dart 中 runes 代表  UTF-32 编码的
   * Dart 字符串 是 UTF-16 的 要使用  32-bit Unicode 需要一个新的语法 也就是 rune
   *
   * 通常 表示 Unicode 使用\uXXXX(一个4位16进制的值)
   * 如果要使用 一个多余4位的  或者 小于四位 就需要 加上 { }
   * 如 \u{1f600}
   *
   * string 类型 有几个属性 能够得到 确切的 rune 信息
   * codeUnitAt codeUnit 属性返回 16位 代码单元
   * */
  {
    var clapping = '\u{1f44f}';
    print(clapping);
    print(clapping.codeUnits); // [55357, 56399]
    print(clapping.runes.toList()); // [128079]

    Runes input = new Runes(
        '\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}');
    print(new String.fromCharCodes(input));
  }
}
