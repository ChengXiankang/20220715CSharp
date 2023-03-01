select * from AccountInfo
select * from BankCard
--exp1:关羽的银行卡号为"6225547858741263"，查询出余额比关羽多的银行卡信息，
--显示卡号，身份证，姓名，余额
--方案一：
declare @gyBalance money
select @gyBalance = (select CardMoney from BankCard where CardNo='6225547858741263')
select CardNo 卡号,AccountCode 身份证,RealName 姓名,CardMoney 余额 from BankCard 
left join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
where CardMoney > @gyBalance
--方案二:
select CardNo 卡号,AccountCode 身份证,RealName 姓名,CardMoney 余额 from BankCard 
left join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
where CardMoney > 
(select CardMoney from BankCard where CardNo='6225547858741263')

----------------------------------------------------------------------------------------------------
--exp2:从所有账户信息中查询出余额最高的交易明细(存钱取钱信息)
--方案一：
select * from CardExchange where CardNo in 
(select CardNo from BankCard where CardMoney = 
  (select MAX(CardMoney) from BankCard)
)
--方案二：（如果有多个银行卡余额相等并且最高，此方案只能求出其中一个人的明细）
select * from CardExchange where CardNo = 
(select top 1 CardNo from BankCard order by CardMoney desc)
---------------------------------------------------------------------------------------------------

--exp3:查询有取款记录的银行卡及账户信息，显示卡号，身份证，姓名，余额
select CardNo 卡号,AccountCode 身份证,RealName 姓名,CardMoney 余额 from BankCard 
left join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
where CardNo in
(select CardNo from CardExchange where MoneyOutBank <> 0)

--exp4:查询出没有存款记录的银行卡及账户信息，显示卡号，身份证，姓名，余额
select CardNo 卡号,AccountCode 身份证,RealName 姓名,CardMoney 余额 from BankCard 
left join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
where CardNo not in
(select CardNo from CardExchange where MoneyInBank <> 0)
-----------------------------------------------------------------------------------------------------


--exp5:关羽的银行卡号为"6225547858741263",查询当天是否有收到转账
if exists(select * from CardTransfer where CardNoIn = '6225547858741263'
and convert(varchar(10),TransferTime, 120) = convert(varchar(10),getdate(), 120)
)
	print '有转账记录'
else
	print '没有转账记录'
--备注：上述例子也可以使用not exists来实现，表示不不存在记录
--------------------------------------------------------------------------------------------------------


--exp6:查询出交易次数（存款取款操作）最多的银行卡账户信息，
--显示：卡号，身份证，姓名，余额，交易次数
--方案一
select top 1 BankCard.CardNo 卡号,AccountCode 身份证,RealName 姓名,CardMoney 余额,
exchangeCount 交易次数 from BankCard 
inner join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
inner join
(select CardNo,COUNT(*) exchangeCount from CardExchange group by CardNo) CarcExchageTemp
on BankCard.CardNo = CarcExchageTemp.CardNo
order by exchangeCount desc


--方案二(如果有多个人交易次数相同，都是交易次数最多，则使用以下方案)
--select  BankCard.CardNo 卡号,AccountCode 身份证,RealName 姓名,CardMoney 余额,交易次数 
--from AccountInfo
--inner join BankCard on AccountInfo.AccountId = BankCard.AccountId
--inner join
--(select CardNo,COUNT(*) 交易次数 from CardExchange group by CardNo) Temp 
--on BankCard.CardNo = Temp.CardNo
--where 交易次数 = (select max(交易次数) from
--(select CardNo,COUNT(*) 交易次数 from CardExchange group by CardNo) Temp )


--exp7:查询出没有转账交易记录的银行卡账户信息
--显示卡号，身份证，姓名，余额
--select CardNo 卡号,AccountCode 身份证,RealName 姓名,CardMoney 余额 from BankCard 
--left join AccountInfo on BankCard.AccountId = AccountInfo.AccountId
--where BankCard.CardNo not in (select CardNoIn from CardTransfer)
--and BankCard.CardNo not in (select CardNoOut from CardTransfer)



--exp8:分页
create table Student
(
	StuId int primary key identity(1,2), --自动编号
	StuName varchar(20),
	StuSex varchar(4)
)
insert into Student(StuName,StuSex) values('刘备','男')
insert into Student(StuName,StuSex) values('关羽','男')
insert into Student(StuName,StuSex) values('张飞','男')
insert into Student(StuName,StuSex) values('赵云','男')
insert into Student(StuName,StuSex) values('马超','男')
insert into Student(StuName,StuSex) values('黄忠','男')
insert into Student(StuName,StuSex) values('魏延','男')
insert into Student(StuName,StuSex) values('简雍','男')
insert into Student(StuName,StuSex) values('诸葛亮','男')
insert into Student(StuName,StuSex) values('徐庶','男')
insert into Student(StuName,StuSex) values('周仓','男')
insert into Student(StuName,StuSex) values('关平','男')
insert into Student(StuName,StuSex) values('张苞','男')
insert into Student(StuName,StuSex) values('曹操','男')
insert into Student(StuName,StuSex) values('曹仁','男')
insert into Student(StuName,StuSex) values('曹丕','男')
insert into Student(StuName,StuSex) values('曹植','男')
insert into Student(StuName,StuSex) values('曹彰','男')
insert into Student(StuName,StuSex) values('典韦','男')
insert into Student(StuName,StuSex) values('许褚','男')
insert into Student(StuName,StuSex) values('夏侯敦','男')
insert into Student(StuName,StuSex) values('郭嘉','男')
insert into Student(StuName,StuSex) values('荀彧','男')
insert into Student(StuName,StuSex) values('贾诩','男')
insert into Student(StuName,StuSex) values('孙权','男')
insert into Student(StuName,StuSex) values('孙坚','男')
insert into Student(StuName,StuSex) values('孙策','男')
insert into Student(StuName,StuSex) values('太史慈','男')
insert into Student(StuName,StuSex) values('大乔','女')
insert into Student(StuName,StuSex) values('小乔','女')

--方案一：使用row_number分页
declare @PageSize int = 5
declare @PageIndex int = 1
select * from (select ROW_NUMBER() over(order by StuId) RowId,Student.* from Student) TempStu
where RowId between (@PageIndex-1)*@PageSize+1 and @PageIndex*@PageSize

--方案二：使用top分页
declare @PageSize int = 5
declare @PageIndex int = 1
select top(@PageSize) * from Student
where StuId not in (select top((@PageIndex-1)*@PageSize) StuId from Student)

