--T-SQL中使用的运算符分为7种
--算数运算符：加（+）、减（-）、乘（*）、除（/）、模（%） 
--逻辑运算符：AND、OR、LIKE、BETWEEN、IN、EXISTS、NOT、ALL、ANY、 
--赋值运算符：= 
--字符串运算符：+ 
--比较运算符：=、>、<、>=、<=、<> 
--位运算符：|、&、^ 
--复合运算符：+=、-=、/=、%=、*=
-----------------------------------------------------------------------------------------------------

--算术运算符
--exp:已知长方形的长和宽，求长方形的周长和面积
--declare @c int = 5
--declare @k int = 10
--declare @zc int
--declare @mj int
--set @zc = (@c+@k)*2
--set @mj = @c * @k
--print '周长为:' + Convert(varchar(20),@zc)
--print '面积为:' + Convert(varchar(20),@mj)
-----------------------------------------------------------------------------------------------------------


--逻辑运算符
--exp1:查询银行卡状态为冻结，并且余额超过1000000的银行卡信息
--select * from BankCard where CardState = 3 and CardMoney > 1000000
--exp2:查询出银行卡状态为冻结或者余额等于0的银行卡信息
--select * from BankCard where CardState = 3 or CardMoney = 0
--exp3:查询出姓名中含有'刘'的账户信息以及银行卡信息
--select * from AccountInfo left join BankCard on AccountInfo.AccountId = BankCard.AccountId
--where RealName like '%刘%'
--exp4:查询出余额在2000-5000之间的银行卡信息
--select * from BankCard where CardMoney between 2000 and 5000
--exp5:查询出银行卡状态为冻结或者注销的银行卡信息
--select * from BankCard where CardState in(3,4)


--刘备身份证：420107198905064135
--关羽身份证：420107199507104133
--张飞身份证：420107199602034138
--exp5:关羽到银行来开户，查询身份证在账户表是否存在，
--不存在则进行开户开卡，存在则不开户直接开卡
--declare @AccountId int
--if exists(select * from AccountInfo where AccountCode = '420107199507104133')
--	begin		
--		select @AccountId = (select AccountId from AccountInfo where AccountCode = '420107199507104133')
--		insert into BankCard(CardNo,AccountId,CardPwd,CardMoney,CardState)
--		values('6225456875357896',@AccountId,'123456',0,1)				
--	end
--else
--	begin
--		insert into AccountInfo(AccountCode,AccountPhone,RealName,OpenTime)
--		values('420107199507104133','13335645213','关羽',GETDATE())
--		set @AccountId = @@identity
--		insert into BankCard(CardNo,AccountId,CardPwd,CardMoney,CardState)
--		values('6225456875357896',@AccountId,'123456',0,1)		
--	end
--select * from AccountInfo
--select * from BankCard
--上述代码也可以使用not exists进行判断，表示不存在

--扩展：上面需求添加一个限制即一个人最多只能开3张银行卡。
--declare @AccountId int
--declare @count int
--if exists(select * from AccountInfo where AccountCode = '420107199507104133')
--	begin		
--		select @AccountId = (select AccountId from AccountInfo where AccountCode = '420107199507104133')
--		select @count = (select COUNT(*) from BankCard where AccountId = @AccountId)
--		if @count <= 2
--			begin
--				insert into BankCard(CardNo,AccountId,CardPwd,CardMoney,CardState)
--				values('6225456875357898',@AccountId,'123456',0,1)	
--			end	
--		else
--			begin
--				print '一个人最多只能办理三张银行卡'
--			end		
--	end
--else
--	begin
--		insert into AccountInfo(AccountCode,AccountPhone,RealName,OpenTime)
--		values('420107199507104133','13335645213','关羽',GETDATE())
--		set @AccountId = @@identity
--		insert into BankCard(CardNo,AccountId,CardPwd,CardMoney,CardState)
--		values('6225456875357898',@AccountId,'123456',0,1)		
--	end
	
--select * from AccountInfo
--select * from BankCard


--exp6:查询银行卡账户余额，是不是所有的账户余额都超过了3000
--if 3000 < ALL(select CardMoney from BankCard) 
--	print '所有账户余额都超过了3000'
--else
--	print '存在有余额不超过3000的账户'

--exp7:查询银行卡账户余额，是否含有账户余额超过30000000的信息
--if 30000000 < ANY(select CardMoney from BankCard) 
--	print '存在账户余额超过30000000的账户'
--else
--	print '不存在账户余额超过30000000的账户'
----------------------------------------------------------------------------------------------------------










