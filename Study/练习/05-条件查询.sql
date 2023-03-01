--比较运算符（=  !=  >  <  >=  <= (IS NULL)  in  like  (BETWEEN...AND...)）
--逻辑运算符（and or not ）

--根据指定列（姓名，性别，月薪，电话）查询性别为女的员工信息,并自定义中文列名

--查询月薪大于等于10000 的员工信息( 单条件 )

--查询月薪大于等于10000 的女员工信息(多条件)

--显示出出身年月在1980-1-1之后，而且月薪大于等于10000的女员工信息。

--显示出月薪大于等于15000 的员工,或者月薪大于等于8000的女员工信息。

--查询月薪在10000-20000 之间员工信息( 多条件 ) 

--查询出地址在北京或者上海的员工信息

--查询所有员工信息(根据工资排序，降序排列) order by: 排序  asc: 正序  desc: 倒序

--显示所有的员工信息，按照名字的长度进行倒序排列

--查询工资最高的5个人的信息

--查询工资最高的10%的员工信息


--查询出地址没有填写的员工信息

--查询出地址已经填写的员工信息


--查询所有的80后员工信息


--查询年龄在30-40 之间，并且工资在15000-30000 之间的员工信息(between and)

--查询出巨蟹 6.22--7.22 的员工信息
--查询工资比赵云高的人

--查询出和赵云在同一个城市的人

--查询出生肖为鼠的人员信息

--查询所有员工信息，添加一列显示属相(鼠,牛,虎,兔,龙,蛇,马,羊,猴,鸡,狗,猪)
select PeopleName 姓名,PeopleSex 性别,PeopleSalary 工资,PeoplePhone 电话,PEOPLEBIRTH 生日,
case
	when year(PeopleBirth) % 12 = 4 then '鼠'
	when year(PeopleBirth) % 12 = 5 then '牛'
	when year(PeopleBirth) % 12 = 6 then '虎'
	when year(PeopleBirth) % 12 = 7 then '兔'
	when year(PeopleBirth) % 12 = 8 then '龙'
	when year(PeopleBirth) % 12 = 9 then '蛇'
	when year(PeopleBirth) % 12 = 10 then '马'
	when year(PeopleBirth) % 12 = 11 then '羊'
	when year(PeopleBirth) % 12 = 0 then '猴'
	when year(PeopleBirth) % 12 = 1 then '鸡'
	when year(PeopleBirth) % 12 = 2 then '狗'
	when year(PeopleBirth) % 12 = 3 then '猪'
	ELSE ''
end 生肖
from People

select PeopleName 姓名,PeopleSex 性别,PeopleSalary 工资,PeoplePhone 电话,PEOPLEBIRTH 生日,
case year(PeopleBirth) % 12
	when 4 then '鼠'
	when 5 then '牛'
	when 6 then '虎'
	when 7 then '兔'
	when 8 then '龙'
	when 9 then '蛇'
	when 10 then '马'
	when 11 then '羊'
	when 0 then '猴'
	when 1 then '鸡'
	when 2 then '狗'
	when 3 then '猪'
	ELSE ''
end 生肖
from People

