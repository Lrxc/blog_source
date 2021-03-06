---
title: Java 接口 抽象类 枚举
date: 2019-07-01 16:01:33
categories: Java
tags: java
---

<meta name="referrer" content="no-referrer" />


## 接口

**使用接口对行为进行抽象**

接口：

```
可以含有 变量和方法。但是要注意，接口中的变量会被隐式地指定为public static final变量（并且只能是public static final变量，用private修饰会报编译错误），而方法会被隐式地指定为public abstract方法且只能是public abstract方法（用其他关键字，比如private、protected、static、final等修饰会报编译错误），并且接口中所有的方法不能有具体的实现，也就是说，接口中的方法必须都是抽象方法。从这里可以隐约看出接口和抽象类的区别，接口是一种极度抽象的类型，它比抽象类更加“抽象”，并且一般情况下不在接口中定义变量
```

## 抽象类

**抽象类是用来捕捉子类的通用特性的，包括属性及行为**。

抽象类:

```
如果一个类含有抽象方法，则称这个类为抽象类，抽象类必须在类前用abstract关键字修饰。因为抽象类中含有无具体实现的方法，所以不能用抽象类创建对象。抽象方法是一种特殊的方法：它只有声明，而没有具体的实现。因为抽象类中含有无具体实现的方法，所以不能用抽象类创建对象。如果一个类继承抽象类，那么就必须为基类中的抽象方法提供定义。如果不这么做，那导出类也为抽象类。
```

抽象类和普通类的主要有三点区别：

```
1、抽象方法必须为public或者protected（因为如果为private，则不能被子类继承，子类便无法实现该方法），缺省情况下默认为public。
2、抽象类不能用来创建对象；
3、如果一个类继承于一个抽象类，则子类必须实现父类的抽象方法。如果子类没有实现父类的抽象方法，则必须将子类也定义为abstract类
```

## 枚举

默认继承Enum,不是Object，所以不可继承其他类

由于构造方法私有化，而子类初始化需要调用父类初始化方法，所以不可被继承

## 异同点

抽象类和接口相同点：

```
1、都是上层的抽象层
2、都不能被实例化
3、都能包含抽象的方法
```

抽象类和接口不同点：

```
1、在抽象类中可以写非抽象的方法，接口中只能有抽象的方法
```

