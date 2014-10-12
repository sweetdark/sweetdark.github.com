---
layout: post
title: "java 风格指南"
date: 2014-10-09 21:07:38 +0800
comments: true
tags: programming
---
[TOC]
# Java Programming Guide
{% blockquote Steve McConnel, Code Complete %}
 软件首要的技术革命是管理复杂度 
{% endblockquote %}
{% blockquote Biggie Smalls %}
 代码越多，问题也就越多
{% endblockquote %}
> 代码被阅读的次数远远多于写的次数
> 任何一个傻瓜都会写出能够让机器理解的代码，只有好的程序员才能写出人类可以理解的代码

编码规范的目的是在团队中达成一种共识，从而编写出易于阅读和维护的代码。值得庆幸的是Java中有现成的规范和代码风格工具，以及风格检查工具。
<!-- 使用github MarkdDown扩展的语法 -->
## 通用命名规范
* 包命名规范
> 包名统一用小写 mypackage, cn.ritu.cn
* 类型名用大小写混合的方式，第一个字母大写. UserInfo 
* 变量名也用大小写混合的方式，第一个字母小写 lineCount
* 常量全部大写，多个单词之间用\_下划线隔开
> 常量是指那些它的内容一直不会改变的量,而不只是声明为final就可以了,如
``` java
 static final int MIN_TIMES = 30;
 static final ImmutableList< String > NAMES = ImmutableList.of("Ed");
 //下面的不是常量
 final String nonStatic = "non-static"; 
 static String nonFinal = "non-final";
 static final Set< String > mutableCollection = new HashSet< String >();
 static final ImmutableSet< SomeMutableType > mutableElements = ImmutableSet.of(mutable);
``` 
* 方法名用动名词结合的方式，第一个字母小写，大小写混合的方式。不要出现模糊不清的命名情况，如search();
``` java
getName();
vertex.findNearestVertex();
```
* 在名字中如果有缩写也要使用大小写混合的方式
``` java
 exportHtmlSource(); //而不是exportHTMLSource();
 openDvdPlayer(); //而不是openDvdPlayer();
``` 
* 类中的私有变量要单独用一种方式来表示，在名字后面用\_下划线,或者用m\_开头，有待讨论。 如：
``` java
 class Person
 {
	private String name_;
 }
``` 

* 通用的常量的名字应该和它的类型保持一致
``` java
 void setTopic(Topic topic) // NOT: void setTopic(Topic value)
                            // NOT: void setTopic(Topic aTopic)
                            // NOT: void setTopic(Topic t)
 
 void connect(Database database) // NOT: void connect(Database db)
                                 // NOT: void connect(Database oracleDB)
// 更具体一点，可以用角色加类型组合的方式来表达
 Point startingPoint, centerPoint
``` 

* 作用域大的变量必须使用具体的长名字来表示，很小范围的可以用缩写如循环中的循环变量i,j,k 如果是多层嵌套则要考虑使用更具体的名字来命名循环变量，如bookIndex
* 尽量给临时变量起一个更好的名字，不要用temp。
* 不要把对象的名字或类的名字包含在方法名中
``` java
 line.getLength(); //NOT：line.getLineLength();

``` 
### 特定的命名规范
* get/set 用于访问成员的属性
* is前缀的用于布尔变量和返回布尔的方法，有时用has和can前缀更加合适
``` java
 isSet, isVisible, isFinished, isFound, isOpen
 void setFound(boolean isFound);
 boolean hasLicense();
``` 

* *compute*可以被用于那些表示计算的方法
``` java
 valueSet.computeAverage();
``` 
* *find*用于查找的方法
``` java
vertex.findNearestVertex();
matrix.findSmallestElement();
node.findShortestPath(Node destinationNode);
```
* _initialize_ 术语用在对象初始化的时候，不要使用_init_
> printer.initializeFontSet();
* GUI控件的命名应该包含控件的类型
> widthScale, nameTexField, leftScrollbar
* 复数用于表示集合对象
``` java
Collection< Point > points;
int[] values;
```
* _n_前缀可以用于表示若干个对象，这种情况下num不应该被使用
> nPoints, nLines
* _No_或者_total_后缀表示对象的总数，而且仅仅使用其中一种方式来表示，不要同时使用
* _Min_, _Total_, _Sum_, _Max_，_Average_ 这些表示数量,总量，平均值，最大值，总额的限定词统一作为后缀
不要出现前后都有的情况，revenueTotal和totalRevenue这会产生迷惑
> revenueTotal（总收入），expanseTotal（总支出）

* 使用对仗词语来命名，如果出现了其中一个，通常情况下也要有另外一个。常见的对仗词有
> get/set, add/remove, create/destroy, start/stop, insert/delete,
> increment/decrement, old/new, begin/end, first/last, up/down, min/max,
> next/previous, old/new, open/close, show/hide, suspend/resume, etc.
* 不要使用缩写，除了那些领域中的专业词汇。如：html, cpu
> 下列的缩写是不可取的:
> cmd 代替 command
> comp 代替 compute,compare
> cp 代替 copy
> init 代替 initialize
* 不要使用否定的布尔变量
> bool isError; // NOT: isNoError
> bool isFound; // NOT: isNotFound
* 常量要加上类型的前缀
``` java
final int  COLOR\_RED   = 1;
final int  COLOR\_GREEN = 2;
final int  COLOR\_BLUE  = 3;
//或者使用
interface Color
{
 final int RED   = 1;
 final int GREEN = 2;
 final int BLUE  = 3;
}
```
* 异常类后缀应该加上Exception
* 接口的默认实现应该加上前缀Default
* Singleton 单例类通过getInstance方法来获取单例
* 工厂类创建对象使用new[类名]的方法来创建
``` java
class PointFactory
{
	public Point newPoint()
	{...}
}
```
* 函数在名称中应该包含它要返回的类型信息，过程的名称则应该具体的描述它做了什么

## 文件规范
* Java文件名首字母大写如Point.java
* 每个类单独为一个文件，并且和文件名一样。私有的类可以声明为内部的嵌套类
* 每一行的长度应该控制在80列以内
* 统一使用2个空格作用缩进，TAB要转换为缩进
* 未完成的行应该明显的表示出来。
``` java
totalSum = a + b + c +
		   d + e;
method(param1, param2,
	   param3);
for (int tableNo = 0; tableNo < nTables;
	 tableNo += tableStep)
/*
* 在逗号，分号和操作符等断开,然后下一行的开始与上一行表达式的开始平行
*/
```
## 语句
### package和import语句
* package语句必须在文件的第一句，import语句跟在package语句的后面。 按照功能进行分组，每个组之间用空行分开。按照字典顺序进行排序。
``` java
import java.io.IOException;
import java.net.URL;

import java.rmi.RmiServer;
import java.rmi.server.Server;

import javax.swing.JPanel;
import javax.swing.event.ActionEvent;

import org.linux.apache.server.SoapServer;

``` 
* 引入的类要列出来，不要使用整个包引入的方式java.util.\* 来引入整个包;
### 类和接口
* 类和接口的声明顺序
> 1. 类和接口的文档说明
> 2. 类和接口的语句 class 或者 interface
> 3. 类和接口的变量（包括静态变量）按照public, protected, package,private的顺序列出
> 4. 构造函数
> 5. 方法
### 方法
* 方法修饰符的顺序
> 访问权限( public, protected, private ) static abstract synchronized final native的顺序
* 类型转换
### 类型
* 类型转换必须强制声明,强制转换的前后要留空格 int length = (int) getLength();
* 数组的声明[]应该紧跟着类型名 String[] names; int[] values;
### 变量
* 变量应该的定义的时候初始化，定义在最小的作用域范围内，在要使用的地方进行定义
* 一个变量名不应该有双重含义, 如变量 x的第一位来表示某个标志位，后面的倍数来表示坐标
* 类变量不应该被声明为pulibc，除非这个类是作为结构体使用
* 变量的生命周期应该保持最短，资源用完应该及时释放
### 循环
* 只有循环控制语句应该被放在for()结构中
``` java
sum = 0;
for (i = 0; i < 100; i++) 
  sum += value[i];
  sum += value[i];
// NOT: for (i = 0, sum = 0; i < 100; i++)
```
* 循环变量应该紧挨着循环结构
``` java
isDone = false;           // NOT: bool isDone = false;
while (!isDone) {         //      :
  :                       //      while (!isDone) {
}                         //        :
                          //      }

```
* 在循环中避免使用do-while语句
* 在循环中尽量避免使用continue和break语句

### 条件
* 避免复杂的条件判断语句，可以引用临时的布尔变量来降低复杂度
* 正常情况应该被放在if语句中，异常情况放在else语句中
``` java
if (isOK) {
	doSomething();
}
else {
	exception();
}
```
* 条件语句应该写在单独一行，后面不要接其它的语句了
* 不要在判断中去执行语句
``` java
InputStream stream = File.open(fileName, "w");
if (stream != null) {
  :
}

// NOT:
if (File.open(fileName, "w") != null)) {
  :
}
```
* 不要使用魔数，使用具名常量代替
* 浮点数的书写至少要有一个小数位
* 静态方法要使用类名来调用，不要使用对象。
``` java
 Thread.sleep(1000); //NOT: thread.sleep(1000); getThread().sleep(1000);
``` 
## 布局和注释
### 布局
* 缩进为两个空格，TAB符要设置转换为空格
* 块布局可以是下面的两种
``` java
 while (!done) {
   doSomething();
   done = moreToDo();
 }
 
 while (!done)
 {
   doSomething();
   done = moreToDo();
 }
``` 
* 类的布局如下
``` java
 class Rectangle extends Shape
   implements Cloneable, Serializable
 {
   ...
 }
``` 
* 方法的布局如下
``` java
 public void someMethod()
   throws SomeException
 {
   ...
 }
``` 
* 条件语句的布局如下，判断条件要另起一行不要跟}在一行
``` java
 if (condition) {
   statements;
 }
 
 if (condition) {
   statements;
 }
 else {
    statements;
 }
 
 if (condition) {
   statements;
 }
 else if (condition) {
   statements;
 }
 else {
   statements;
 }
``` 
 
* for语句和while语句的布局如下
``` java
 for (initialization; condition; update) {
   statements;
 }
 空循环如下：
 for (initialization; condition; update)
 ;
``` 
* switch语句的布局如下，switch语句一定要有default:即使是空的
``` java
 switch (condition) {
   case ABC :
     statements;
     // Fallthrough
 
   case DEF :
     statements;
     break;
 
   case XYZ :
     statements;
     break;
 
   default :
     statements;
     break;
 }
``` 
* try-catch语句布局如下
``` java
 try {
   statements;
 }
 catch (Exception exception) {
   statements;
 }
 
 try {
   statements;
 }
 catch (Exception exception) {
   statements;
 }
 finally {
   statements;
 }
``` 
### 空格
* 操作符两边要有空格
* Java保留字后面要跟空格 如 while () , if ()
* 逗号后面要有空格
* 冒号两边都要有空格
* 在for语句中的分号后面要有空格
``` java
 a = (b + c) * d; // NOT: a=(b+c)*d
 
 while (true) {   // NOT: while(true){
   ...
 
 doSomething(a, b, c, d);  // NOT: doSomething(a,b,c,d);
 
 case 100 :  // NOT: case 100:
 
 for (i = 0; i < 10; i++) {  // NOT: for(i=0;i<10;i++){
   ...
``` 
* 逻辑单元之间要隔一行空行
``` java
 // Create a new identity matrix
 Matrix4x4 matrix = new Matrix4x4();
 
 // Precompute angles for efficiency
 double cosAngle = Math.cos(angle);
 double sinAngle = Math.sin(angle);
 
 // Specify matrix as a rotation transformation
 matrix.setElement(1, 1,  cosAngle);
 matrix.setElement(1, 2,  sinAngle);
 matrix.setElement(2, 1, -sinAngle);
 matrix.setElement(2, 2,  cosAngle);
 
 // Apply rotation
 transformation.multiply(matrix);
``` 
* 类中的每个方法之间前后要有空行
* 变量的声明要左对齐
``` java
 TextFile  file;
 int       nPoints;
 double    x, y;
``` 
* 语句之间也要对齐
``` java
 if      (a == lowValue)    compueSomething();
 else if (a == mediumValue) computeSomethingElse();
 else if (a == highValue)   computeSomethingElseYet();
 
 value = (potential        * oilDensity)   / constant1 +
         (depth            * waterDensity) / constant2 +
         (zCoordinateValue * gasDensity)   / constant3;
 
 minPosition     = computeDistance(min,     x, y, z);
 averagePosition = computeDistance(average, x, y, z);
 
 switch (phase) {
   case PHASE_OIL   : text = "Oil";   break;
   case PHASE_WATER : text = "Water"; break;
   case PHASE_GAS   : text = "Gas";   break;
 }
``` 
### 注释
* 代码应该能够自我解释。复杂的代码要考虑重写
* Javadoc的注释使用下面的格式，可以通过工具生成,块注释每行的开头要有\*号
``` java
/**
 * Return lateral location of the specified position.
 * If the position is unset, NaN is returned.
 *
 * @param x    X coordinate of position.
 * @param y    Y coordinate of position.
 * @param zone Zone of position.
 * @return     Lateral location.
 * @throws IllegalArgumentException  If zone is <= 0.
 */
public double computeLocation(double x, double y, int zone)
  throws IllegalArgumentException
{
  ...
}
``` 
* 在注释后面要有空格，注释要跟着代码缩进
``` java
// This is a comment    NOT: //This is a comment

/**                     NOT: /**
 * This is a javadoc          *This is a javadoc
 * comment                    *comment
 */                           */

while (true) {       // NOT:  while (true) { 
  // Do something             // Do something
  something();                  something();
}   
``` 
* 所有公开的类和接口应该使用Javadoc的注释规范

### References
[1] Code Complete, Steve McConnel - Microsoft Press

[2] Java Code Conventions
http://java.sun.com/docs/codeconv/html/CodeConvTOC.doc.html

[3] Netscape's Software Coding Standards for Java 
http://developer.netscape.com/docs/technote/java/codestyle.html

[4] C / C++ / Java Coding Standards from NASA 
http://v2ma09.gsfc.nasa.gov/coding_standards.html

[5] Coding Standards for Java from AmbySoft 
http://www.ambysoft.com/javaCodingStandards.html


