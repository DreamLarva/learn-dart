void main() {
  /**
   * 见 运算符优先级.md 表格
   * */
  /**
   * 值得注意的 与 js 表现不同 或者 独有的运算符
   * dart 中没有 !=== 和 === 运算符
   * */
  {
    // ~/ 运算符 或 将 / 运算的结果向下 取整
    assert(5 ~/ 2 == 2); // Result is an integer

    /**
     * 类型断言运算符
     *  as	  类型声明 (还用于指定库的前缀)
     *  is	  如果对象 是 目标类型 就返回 true
     *  is!	  如果对象 是 目标类型 就返回 false
     *  只有当 obj 实现了 T 的接口， obj is T 才是 true。例如 obj is Object 总是 true。
     * */
    assert(1 is Object);
    assert("string" is Object);
    assert(new Male() is Male);
    assert(new Male() is Human);
    assert(new Male() is! Female);

    /**
     * 使用 as 操作符把对象转换为特定的类型。 一般情况下，你可以把它当做用 is 判定类型然后调用 所判定对象的函数的缩写形式。例如下面的 示例：
     * */
    final emp = new Male();
    if (emp is Human) {
      // Type check
      emp.name = 'Bob';
    }
    // 使用 as 操作符可以简化上面的代码：

    (emp as Human).name = 'Bob'; // IDE 显示 这个as 完全没有必要 不知道是搞毛线的

    /**
     * 条件表达式  ??
     * 判断  ?? 左侧值 是不是 null 值如果 不是 则返回左侧表达式的值 否则 返回右侧表达式的值
     * A ?? B
     * 相当于
     * A != null ? A : B
     * */
    var canBeNull;
    var someVar = canBeNull ?? "defaultData";
    assert(someVar == "defaultData");

    /**
     * 级联运算符 ..
     * 级联操作符 (..) 可以在同一个对象上 连续调用多个函数以及访问成员变量。
     * 使用级联操作符可以避免创建 临时变量， 并且写出来的代码看起来 更加流畅：
     *
     * 注意 级联运算符 操作的都是 最上层的对象 并且没句操作完 都忽略返回值
     * */
    new ObjectForCascade()
      ..someProperty = "someData"
      ..someMethod();

    /**
     * 级联也可以嵌套多层
     * */
    new ObjectForCascade()
      ..nest = (new ObjectForCascade()..someProperty = "someData")
      ..someMethod();

    /**
     * 在方法上使用级联操作符需要非常小心，级联的最上层 不能返回 如 void 类型的就会报错
     * */

    /**
     * ?.	条件成员访问	和 . 类似，但是左边的操作对象不能为 null，例如 foo?.bar 如果 foo 为 null 则返回 null，否则返回 bar 成员
     * */
   var o1 = new Human();

    assert(o1?.name == null);
  }
}

class Human {
  String name;
}

class Male implements Human {
  String gender = "male";

  @override
  String name;
}

class Female implements Human {
  String gender = "female";

  @override
  String name;
}

class ObjectForCascade {
  String someProperty;
  ObjectForCascade nest;

  void someMethod() {}
}
