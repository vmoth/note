# Schema
schema 类似名空间的功能，Object名称在不同schemas下可以复用。
public schema是从template1中继承下来的默认名空间，public名空间
主要的作用是方便无schemas数据库之间的迁移。

schemas在多用户多数据库情况下推荐使用，
管理员应主动REVOKE CREATE ON SCHEMA public FROM PUBLIC;防止在public下
创建Object

# Schema usagesv
* 管理权限：使用schema对Object来分组（根据roles）
* 根据业务逻辑来多Object分组：例如审计和历史的数据可以在同一个组中
* 管理三方sql代码：位于多个schema中的三方库可以更加便利的被重用和更新

# Object
* Range
* Table
* View
* Index
* Function
* Type
* Domain

# Tables
类型
* Ordinary table: 生命周期 create -> drop
* Temporary table: 生命周期 user session， 通常和存储过程一起使用服务于业务逻辑
* Unlogged table: 比一般表快，非crash-safe，无法被replicate因为不将data写入WAL
* Child table：一般表，继承自一个或者多个正常表。一般用于表的物理磁盘分割来提高效率
  
[crate table](http://www.postgresql.org/docs/current/static/sql-createtable.html)语法繁杂
```sql
CREATE TEMP TABLE tmp as SELECT 1 as one
```
创建一个临时表，表中有一行一列。

# PostgreSQL 原生数据类型
数据类型是表设计的重中之重，因为上线后修改表成本巨大，成本通常来自于锁表。
设计表通常可以考虑一下三点
* 可扩展性：长度是否可伸缩，在不重写和全表扫描的情况下
* Data type size：越大的类型消耗的资源也越多
* Support：富文本类型需要考虑驱动的支持，如果jdbc不支持json或者xml，我们需要手动编写序列化代码

PostgreSQL 三大数据类型
* Number
* Character
* Date and time
此三中类型足够应付日常的程序需求

# Serial types and identity columns
推荐使用 identity columns，原因一下几点
* 兼容性：与sql标准兼容，方便移植
* 权限：容易忘记给sequence对于设置合适的权限，由于sequence对象的权限是单独管理的
* Sequence value and user data precedence：用户可控制是否使用自增值
* Managing table structure：管理identity更加容易
两者底层都使用sequence object，identity用于克服serial的显示，主要限制是权限和可比较性

create table check list
* 主键
* 列默认值
* 列类型
* 列限制
* 权限是否设置正确，在schema，table，sequence
* 外键是否设置正确
* 数据的生命周期
* 对于数据的允许操作