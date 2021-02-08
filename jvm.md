
|        运行时数据区                          |
| Method Area | VM Stack | Native Method Stack | 
| Heap        |  Program Counter Register      |

*** Program Counter Register 当前线程所执行的字节码的行号指示器。
- 为了线程切换后能恢复到正确到执行位置，每条线程都需要一个独立到程序计数器。
- Java 方法PC记录字节码指令地址，如果正在执行的时Native方法则计数器则为Undefined。
- 唯一没有OOM的区域

*** 方法区（Method Area）
- GC Roots 从GC Roots开始向下搜索，如果某个对象到GC Roots没有任何引用链，那就是不可达

*** 哪些是GC Roots对象
- 虚拟机栈中引用到对象
- 方法区中静态属性引用对象
- 方法区中常量引用到对象
- 方法方法栈中JNI
- Java 虚拟机内部的引用
- 所有被同步锁持有的对象
- 反应Java虚拟机内部情况的JMXBean， JVMTI中注册的回掉、本地代码缓存等

*** 引用类型
- 强引用
- 软引用 内存不足是回收
- 弱引用 GC回收时一定会回收
- 需引用 获取不到引用，对象回收做通知用

*** finalize
重写finalize的对象会放到一个F-Queue中，JVM只会触发执行，不会等待执行完成，
可在finalize方法中拯救自己


* 
